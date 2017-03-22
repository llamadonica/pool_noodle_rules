# Copyright 2016 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Dart rules targeting web clients."""

load("//dart/build_rules/internal:dart_web_application.bzl", "dart_web_application_outputs", "dart_web_application_impl")
load("//dart/build_rules/internal:ddc.bzl", "dart_ddc_bundle_impl", "dart_ddc_bundle_outputs")
load(":vm.bzl", "dart_vm_binary")

dart_web_application = rule(
    attrs = {
        "script_file": attr.label(
            allow_files = True,
            single_file = True,
            mandatory = True,
        ),
        "srcs": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "data": attr.label_list(
            allow_files = True,
            cfg = "data",
        ),
        "deps": attr.label_list(providers = ["dart"]),
        "create_packages_dir": attr.bool(default = True),
        "output_js": attr.string(),
        # compiler flags
        "checked": attr.bool(default = False),
        "csp": attr.bool(default = False),
        "dump_info": attr.bool(default = False),
        "emit_tar": attr.bool(default = True),
        "fast_startup": attr.bool(default = False),
        "minify": attr.bool(default = True),
        "preserve_uris": attr.bool(default = False),
        "trust_primitives": attr.bool(default = False),
        "trust_type_annotations": attr.bool(default = False),
        # tools
        "_dart2js": attr.label(
            allow_files = True,
            single_file = True,
            executable = True,
            cfg = "host",
            default = Label("@dart_sdk//:dart2js"),
        ),
        "_dart2js_support": attr.label(
            allow_files = True,
            default = Label("@dart_sdk//:dart2js_support"),
        ),
        "_dart2js_helper": attr.label(
            allow_files = True,
            single_file = True,
            executable = True,
            cfg = "host",
            default = Label("//dart/build_rules/tools:dart2js_helper"),
        ),
    },
    outputs = dart_web_application_outputs,
    implementation = dart_web_application_impl,
)
