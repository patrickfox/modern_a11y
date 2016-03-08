var gulp = require('gulp'),
	markdown = require('gulp-markdown'),
	wiredep = require('wiredep').stream,
	concat = require('gulp-concat'),
	sass = require('gulp-sass'),
	uglify = require('gulp-uglifyjs'),
	mincss = require('gulp-minify-css'),
	clean = require('gulp-clean'),
	bower = require('wiredep')({}),
	runSequence = require('run-sequence'),
	browserSync = require('browser-sync'),
	reload      = browserSync.reload,
	jade = require('gulp-jade'),
	watch = require('gulp-watch'),
	coffee = require('gulp-coffee'),
	plumber = require('gulp-plumber'),
	gutil = require('gulp-util'),
	data = require('gulp-data'),
	fm = require('front-matter'),
	front_matter = require('gulp-front-matter'),
	fs = require('fs'),
	/* utility vars */
	json_output = [],
	is_production = false,
	sass_style = 'expanded',
	source_map = true,
	paths = {
		/* register 3rd party vendor script files */
		'vendor_js':[
			'bower_components/angular/angular.js',
			'bower_components/angular-route/angular-route.js',
			'bower_components/jquery/dist/jquery.js',
			'bower_components/a11y_kit/dist/a11y_kit.jquery.js'
		],
		/* register custom literate coffeescript files */
		'litcoffee':[
			'src/coffeescript/app.litcoffee',
			'src/coffeescript/modal.litcoffee',
			// 'src/coffeescript/carousel.litcoffee',
			'src/coffeescript/tooltip.litcoffee',
			'src/coffeescript/dropdown.litcoffee',
			// 'src/coffeescript/accordion.litcoffee',
			'src/coffeescript/helpers.litcoffee'
		]
	};

if (gulp.env.prod) {
	is_production = true;
	sass_style = 'compress';
	source_map = false;
}


var onError = function (err) {
	gutil.beep();
	console.log(err);
};

var change_event = function(evt) {
    gutil.log('File', gutil.colors.cyan(evt.path.replace(new RegExp('/.*(?=/' + basePaths.src + ')/'), '')), 'was', gutil.colors.magenta(evt.type));
};

gulp.task('clean', function () {
	return gulp.src('build')
		.pipe(clean({}));
});

gulp.task('libs', function() {
	return gulp.src(bower.js)
		.pipe(uglify('libs.min.js'))
		.pipe(gulp.dest('build/js'));
});

gulp.task('templates', function() {

	return gulp.src('src/templates/*.jade')
		.pipe(plumber(onError))
		.pipe(jade({pretty: true, locals: json_output}))
		.pipe(gulp.dest('build/'))
		.pipe(reload({stream:true}));
});

gulp.task('vendor_js', function () {
	return gulp.src(paths.vendor_js)
		.pipe(concat('vendor.js'))
		.pipe(is_production? uglify('vendor.js') : gutil.noop())
		.pipe(gulp.dest('build/js/vendor'))
		.pipe(reload({stream:true}));
});

gulp.task('coffee', function () {
	return gulp.src(paths.litcoffee)
		.pipe(plumber(onError))
		.pipe(coffee())
		.pipe(concat('app.js'))
		.pipe(is_production? uglify('app.js') : gutil.noop())
		.pipe(gulp.dest('build/js'))
		.pipe(reload({stream:true}));
});

gulp.task('sass', function () {
	return gulp.src('./src/sass/*.sass')
		.pipe(plumber(onError))
		.pipe(sass({sourcemap: true}))
		.pipe(concat('main.css'))
		.pipe(is_production? mincss() : gutil.noop())
		.pipe(gulp.dest('build/css'))
		.pipe(reload({stream:true}));
});

gulp.task('markdown', function () {
	return gulp.src('./src/articles/*.md')
		.pipe(front_matter({property:'front_matter', remove: true}))
		.pipe(data(function(file) {
			json_output.push(file.front_matter);
		}))
		.pipe(markdown())
		.pipe(gulp.dest('build/articles/'))
		.pipe(reload({stream:true}));
});

var output_json = function () {
	return fs.writeFile('posts.json', JSON.stringify(json_output), function(err) {
		console.log(err? err : "The file was saved!");
	});
};

gulp.task('copy', function() {
	gulp.src('src/img/**/*')
		.pipe(gulp.dest('build/img'));

	gulp.src('src/fonts/**')
		.pipe(gulp.dest('build/fonts'));

	gulp.src('src/json/**')
		.pipe(gulp.dest('build/json'));

	gulp.src('src/feed/**')
		.pipe(gulp.dest('build/feed'));

	gulp.src('src/js/vendor/**')
		.pipe(gulp.dest('build/js/vendor'));

	gulp.src('src/index.html')
		.pipe(gulp.dest('build/'));

	gulp.src('src/css/**')
		.pipe(gulp.dest('build/css'));
});

gulp.task('_build',['sass','coffee','templates','vendor_js',/*'libs',*/'copy']); //Because 'clean' is async runSequence forces sync

gulp.task('browser-sync', function() {
	browserSync({
			server: {
					baseDir: "./build"
			}
	});
});


/* command line entry points */

gulp.task('build', function(cb) {
	runSequence('clean','markdown','_build',cb);
});

gulp.task('run', function(cb){
	runSequence('build','browser-sync',cb);
	gulp.watch('./src/sass/**/*.sass', ['sass']);
	gulp.watch('./src/sass/**/*.scss', ['sass']);
	gulp.watch('./src/templates/**/*.jade', ['templates']);//.on('change', function (evt) {change_event(evt);});
	gulp.watch('./src/articles/*.md', ['markdown']);
	gulp.watch('./src/coffeescript/*.litcoffee', ['coffee']);
	gulp.watch('./src/js/vendor/*.js', ['vendor_js']);
	gulp.watch('./src/json/*.json', ['copy']);
	gulp.watch('./src/img/*.png', ['copy']);
	gulp.watch('./src/img/*.jpg', ['copy']);
	gulp.watch('./src/img/*.svg', ['copy']);
});
