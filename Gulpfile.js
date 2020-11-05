var resume = require('gulp-resume');
var rename = require('gulp-rename');
var gulp = require('gulp');
var watch = require('gulp-watch');

gulp.task('resume', function() {
  return gulp.src('resume.json')
    .pipe(watch('*.json'))
    .pipe(resume({
      format: 'html',
      theme: 'onepage'
    }))
    .pipe(rename('resume.html'))
    .pipe(gulp.dest('.'));
});
