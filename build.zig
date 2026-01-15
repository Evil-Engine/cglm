const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    lib_mod.addCMacro("CGLM_STATIC", "1");
    lib_mod.addCMacro("CGLM_ALL_UNALIGNED", "1");
    lib_mod.addCSourceFiles(.{
        .files = &[_][]const u8{
            "src/euler.c",
            "src/affine.c",
            "src/io.c",
            "src/quat.c",
            "src/cam.c",
            "src/vec2.c",
            "src/ivec2.c",
            "src/vec3.c",
            "src/ivec3.c",
            "src/vec4.c",
            "src/ivec4.c",
            "src/mat2.c",
            "src/mat2x3.c",
            "src/mat2x4.c",
            "src/mat3.c",
            "src/mat3x2.c",
            "src/mat3x4.c",
            "src/mat4.c",
            "src/mat4x2.c",
            "src/mat4x3.c",
            "src/plane.c",
            "src/noise.c",
            "src/frustum.c",
            "src/box.c",
            "src/aabb2d.c",
            "src/project.c",
            "src/sphere.c",
            "src/ease.c",
            "src/curve.c",
            "src/bezier.c",
            "src/ray.c",
            "src/affine2d.c",
            "src/clipspace/ortho_lh_no.c",
            "src/clipspace/ortho_lh_zo.c",
            "src/clipspace/ortho_rh_no.c",
            "src/clipspace/ortho_rh_zo.c",
            "src/clipspace/persp_lh_no.c",
            "src/clipspace/persp_lh_zo.c",
            "src/clipspace/persp_rh_no.c",
            "src/clipspace/persp_rh_zo.c",
            "src/clipspace/view_lh_no.c",
            "src/clipspace/view_lh_zo.c",
            "src/clipspace/view_rh_no.c",
            "src/clipspace/view_rh_zo.c",
            "src/clipspace/project_no.c",
            "src/clipspace/project_zo.c",
        },
        .flags = &[_][]const u8{
            "-std=c99",
            "-Wall",
            "-Wextra",
            "-Wpedantic",
            "-Wconversion",
            "-DCGLM_ALL_UNALIGNED=1",
        },
    });
    lib_mod.addIncludePath(b.path("include"));
    lib_mod.addIncludePath(b.path("src"));

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "cglm",
        .root_module = lib_mod,
    });

    lib.linkLibC();

    b.installArtifact(lib);
}
