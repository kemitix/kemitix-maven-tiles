# kemitix-maven-tiles

Maven Tiles for preconfiguring plugins. Uses the [io.repaint.maven:tiles-maven-plugin](https://github.com/repaint-io/maven-tiles).

![GitHub release (latest by date)](
https://img.shields.io/github/v/release/kemitix/kemitix-maven-tiles?style=for-the-badge)
![GitHub Release Date](
https://img.shields.io/github/release-date/kemitix/kemitix-maven-tiles?style=for-the-badge)

[![Nexus](
https://img.shields.io/nexus/r/https/oss.sonatype.org/net.kemitix.tiles/kemitix-maven-tiles.svg?style=for-the-badge)](
https://oss.sonatype.org/content/repositories/releases/net/kemitix/tiles/)
[![Maven-Central](
https://img.shields.io/maven-central/v/net.kemitix.tiles/kemitix-maven-tiles.svg?style=for-the-badge)](
https://search.maven.org/search?q=g:net.kemitix.tiles)

With `tiles-maven-plugin`:
![GitHub tag (semver)](https://img.shields.io/github/v/tag/repaint-io/maven-tiles?sort=semver&style=for-the-badge)

## Usage

Given:

```xml
<project>
    <properties>
        <tiles-maven-plugin.version>${LATEST-PLUGIN-VERSION}</tiles-maven-plugin.version>
        <kemitix-tiles.version>${LATEST-TILES-VERSION}</kemitix-tiles.version>
    </properties>
    <build>
        <plugins>
            <plugin>
                <groupId>io.repaint.maven</groupId>
                <artifactId>tiles-maven-plugin</artifactId>
                <version>${tiles-maven-plugin.version}</version>
                <extensions>true</extensions>
                <configuration>
                  <tiles>
                    <tile>net.kemitix.tiles:maven-plugins:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:compiler-jdk-8:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:compiler-jdk-lts:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:compiler-jdk-latest:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:compiler-jdk-next:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:pmd:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:testing:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:spotbugs:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:coverage:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:pitest:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:pmd-strict:${kemitix-tiles.version}</tile>
                    <tile>net.kemitix.tiles:frontend:${kemitix-tiles.version}</tile>
                  </tiles>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

## Tiles

### maven-plugins

Specifies up-to-date versions of the following `org.apache.maven.plugins`:

- `maven-clean-plugin`
- `maven-resources-plugin`
- `maven-install-plugin`
- `maven-site-plugin`
- `maven-jxr-plugin`

The `maven-jxr-plugin` is configured to execute its `jxr` goal during the
Maven `compile` phase.

In addition, the following non-Apache plugin is included with this tile:

- `versions-maven-plugin`

Adds an updated version of the `org.codehaus.mojo:versions-maven-plugin`
plugin. It is configured to produce the `dependency-updates-report`,
`plugin-updates-report` and the `property-updates-report`

### Compiler JDK Tiles

Select the `compiler-jdk-*` tile to select your Java compiler.

|Tile|JDK
|---|---
|8|8
|lts|11
|latest|16
|next|17

All `compiler-jdk-*` tiles configure the 
[maven-compiler-plugin](https://maven.apache.org/plugins/maven-compiler-plugin/)
with the following options:

- display unchecked cast warnings
- show source locations where deprecated APIs are used
- show compilation warnings
- use source encoding UTF-8

### spotbugs

The
[Spotbugs Maven Plugin](https://spotbugs.github.io)
performs a static code analysis and will make the build failed if it finds any
bugs.

It will perform this analysis during the `verify` phase.

It includes the
[Find Security Bugs](https://find-sec-bugs.github.io)
and
[fb-contrib](https://github.com/mebigfatguy/fb-contrib)
spotbugs plugins.

### PMD Tiles

There are two PMD tiles: `pmd` and `pmd-strict`.

The 
[PMD Maven Plugin]([[https://maven.apache.org/plugins/maven-pmd-plugin/)
performs the PMD static code analysis and copy-paste detection during the
`verify` phase.

When the `maven-plugins` tile is also used, then the error reports will include 
links to the `maven-jxr-plugin` generated source code HTML pages.

#### pmd

Checks the source code against the rules in the
[kemitix-pmd-ruleset](https://github.com/kemitix/kemitix-pmd-ruleset)
file
[java.xml](https://github.com/kemitix/kemitix-pmd-ruleset/blob/master/src/main/resources/net/kemitix/pmd/java.xml)
.

Creates HTML reports in `target/site/pmd.html` and `target/site/cpd.html`.

#### pmd-strict

Requires the `pmd` tile.

Not included in the `all` tile.

Unlike the `pmd` tile, if there are any violations of the ruleset then the
build will fail.

### testing

#### Maven Surefire Plugin

The
[Maven Surefire Plugin](http://maven.apache.org/surefire/maven-surefire-plugin/index.html)
runs your Unit Tests during the `test` phase.

#### Maven Failsafe Plugin

The
[Maven Failsafe Plugin](http://maven.apache.org/surefire/maven-failsafe-plugin/index.html)
runs your Integration Tests during the `verify` phase.

### coverage

#### Jacoco Maven Plugin

The
[Jacoco Maven Plugin](http://www.eclemma.org/jacoco/trunk/doc/maven.html)
verifies that the test suite meets the required coverage ratios.

The defaults require that all classes, lines and branches be covered by
tests. i.e. 100% code coverage.

Set the following properties to set less strict targets:

- `jacoco-class-line-covered-ratio` - default = 1 (i.e. 100%)
- `jacoco-class-instruction-covered-ratio` - default = 1 (i.e. 100%)
- `jacoco-class-missed-count-maximum` - default = 0 (i.e. #classes with no tests <= 0)

Classes with names that end in the following are excluded from these limits:

- `Test`
- `IT`
- `Main`
- `Application`
- `Configuration`
- `Immutable`

### pitest

#### Mutation Testing

The
[Pitest Maven Plugin](http://pitest.org/quickstart/maven/)
perform mutation test coverage checks during the `verify` phase.

Code coverage must by 100%, see `pitest.coverage`. The build will
fail if any mutation does not result in test failing.

Set `pitest.skip` to avoid running the mutation testing.

Set `pitest.coverage` to a value between 0 and 1 to set the allowed ratio
of uncovered code. i.e. 0 = 100% code coverage, 0.2 = 80% code coverage
(default is 0)

Set `pitest.mutation` to a value between 0 and 1 to set the allowed
mutations to survive the test suite. i.e. 0 = 100% mutations caught, 0.2 =
80% mutations caught (default is 0)

### frontend

Configures the `frontend-maven-plugin` to install `node` and `yarn` then to run
`yarn install` and `yarn build` during the maven build lifecycle.

It expects to find the source files in `src/main/web` and installs
the packaged result into `META-INF/resources` within the jar or war file.
The destination location can be customised by setting the following property:

- `frontend-output` - default: `META-INF/resources`

The `frontend-maven-plugin` will not run if the file `src/main/web/package.json` is not present.
