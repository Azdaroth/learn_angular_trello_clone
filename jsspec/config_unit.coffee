# Karma configuration
# Generated on Wed Apr 09 2014 10:14:57 GMT+0200 (CEST)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '..'


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']


    # list of files / patterns to load in the browser
    files: [
      'vendor/assets/components/angular/angular.js',
      'vendor/assets/components/angular-resource/angular-resource.js',
      'vendor/assets/components/angular-route/angular-route.js',
      'vendor/assets/components/angular-ui-sortable/sortable.js',
      'vendor/assets/components/angular-xeditable/dist/js/xeditable.js'
      'jsspec/support/*.js'
      'app/assets/javascripts/main.js.coffee',
      'app/assets/javascripts/**/*.js*',
      'jsspec/controllers/*.coffee'
      'jsspec/**/*.coffee'
    ]


    # list of files to exclude
    exclude: [
      'jsspec/support/angular-scenario.js',
      'jsspec/acceptance/*.coffee'
    ]


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
       '**/*.coffee': ['coffee']
    }


    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress']


    # web server port
    port: 9876


    # enable / disable colors in the output (reporters and logs)
    colors: true


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS']

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false
