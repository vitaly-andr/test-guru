// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PasswordMatchController from "./password_match_controller"
application.register("password-match", PasswordMatchController)

import ProgressController from "./progress_controller"
application.register("progress", ProgressController)

import SortController from "./sort_controller"
application.register("sort", SortController)
