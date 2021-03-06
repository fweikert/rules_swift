# Copyright 2018 The Bazel Authors. All rights reserved.
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

"""Helper functions for working with Bazel features."""

# We use the following constants within the rule definitions to prevent the possibility of typos
# when referring to them as part of the implementation, but we explicitly do not export them since
# it's not a common practice to use them that way in BUILD files; the expectation is that the actual
# string literals would be used there. (There is also no good way to generate documentation yet for
# constants since they don't have "doc" attributes, so exposing them in a more structured way
# doesn't provide a benefit there either.)

# If enabled, `swift-autolink-extract` will be invoked on the object files generated for a library
# or binary, generating a response file that will be passed automatically to the linker containing
# the libraries corresponding to modules that were imported. This is used to simulate the
# autolinking behavior of Mach-O on platforms with different binary formats.
SWIFT_FEATURE_AUTOLINK_EXTRACT = "swift.autolink_extract"

# If enabled, the `swift_test` rule will output an `.xctest` bundle for Darwin targets instead of a
# standalone binary. This is necessary for XCTest-based tests that use runtime reflection to locate
# test methods. This feature can be explicitly disabled on a per-target or per-package basis if
# needed to make `swift_test` output just a binary.
SWIFT_FEATURE_BUNDLED_XCTESTS = "swift.bundled_xctests"

# If enabled, debug builds will use the `-debug-prefix-map` feature to remap the current working
# directory to `.`, which permits debugging remote or sandboxed builds.
SWIFT_FEATURE_DEBUG_PREFIX_MAP = "swift.debug_prefix_map"

# If enabled, Swift compilation actions will use batch mode by passing `-enable-batch-mode` to
# `swiftc`. This is a new compilation mode as of Swift 4.2 that is intended to speed up
# non-incremental non-WMO builds by invoking a smaller number of frontend processes and passing
# them batches of source files.
SWIFT_FEATURE_ENABLE_BATCH_MODE = "swift.enable_batch_mode"

# If enabled, the compilation action for a target will produce an index store.
SWIFT_FEATURE_INDEX_WHILE_BUILDING = "swift.index_while_building"

# If enabled, compilation actions and module map generation will assume that the header paths in
# module maps are relative to the current working directory (i.e., the workspace root); if disabled,
# header paths in module maps are relative to the location of the module map file.
SWIFT_FEATURE_MODULE_MAP_HOME_IS_CWD = "swift.module_map_home_is_cwd"

# If enabled, the compilation action for a library target will not generate an Objective-C header
# for the module. This feature also implies `swift.no_generated_module_map`.
SWIFT_FEATURE_NO_GENERATED_HEADER = "swift.no_generated_header"

# If enabled, the compilation action for a library target will not generate a module map for the
# Objective-C generated header. This feature is ignored if `swift.no_generated_header` is not
# present.
SWIFT_FEATURE_NO_GENERATED_MODULE_MAP = "swift.no_generated_module_map"

# If enabled, builds using the "opt" compilation mode will invoke `swiftc` with the
# `-whole-module-optimization` flag (in addition to `-O`).
SWIFT_FEATURE_OPT_USES_WMO = "swift.opt_uses_wmo"

# If enabled, Swift compilation actions will use the same global Clang module cache used by
# Objective-C compilation actions. This is disabled by default because under some circumstances
# Clang module cache corruption can cause the Swift compiler to crash (sometimes when switching
# configurations or syncing a repository), but disabling it also causes a noticeable build time
# regression so it can be explicitly re-enabled by users who are not affected by those crashes.
SWIFT_FEATURE_USE_GLOBAL_MODULE_CACHE = "swift.use_global_module_cache"

# If enabled, actions invoking the Swift driver or frontend may write argument lists into response
# files (i.e., "@args.txt") to avoid passing command lines that exceed the system limit. Toolchains
# typically set this automatically if using a sufficiently recent version of Swift (4.2 or higher).
SWIFT_FEATURE_USE_RESPONSE_FILES = "swift.use_response_files"
