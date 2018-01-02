KEMITIX-MAVEN-TILES
===================

Maven Tiles for preconfigured plugins.

### Usage

```xml
<project>
    <properties>
        <tiles-maven-plugin.version>2.10</tiles-maven-plugin.version>
        <kemitix-tiles.version>0.1.1</kemitix-tiles.version>
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
                         <tile>net.kemitix.tiles:all-tiles:${kemitix-tiles.version}</tile>

                         <!-- or -->

                         <tile>net.kemitix.tiles:maven-plugins-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:enforcer-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:compiler-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:checkstyle-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:huntbugs-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:pmd-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:digraph-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:testing-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:coverage-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:pitest-tile:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:release-tile:${kemitix-tiles.version}</tile>
                   </tiles>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### Properties

If you want to override the version or configuration values of any of the plugins configured by the tiles, you can set the following properties to the desired value.

* `project.build.sourceEncoding`
* `maven-javadoc-plugin.version`
* `maven-source-plugin.version`
* `maven-gpg-plugin.version`
* `maven-deploy-plugin.version`
* `maven-compiler-plugin.version`
* `maven-surefire-plugin.version`
* `maven-failsafe-plugin.version`
* `maven-jxr-plugin.version`
* `java.version`
* `versions.version`
* `coveralls-maven-plugin.version`

### Maven Plugins Tile

Sets updated versions for the following `org.apache.maven.plugins`:

* `maven-clean-plugin`
* `maven-install-plugin`
* `maven-site-plugin`

Adds an updated version of the `org.codehaus.mojo:versions-maven-plugin` plugin.

#### Maven JXR Plugin

The [Maven JXR Plugin](http://maven.apache.org/jxr/maven-jxr-plugin/index.html) produces cross-referenced HTML pages of your source code as part of the `compile` phase in `target/site/xref/`.

### Enforcer Tile

Provides the `maven-enforcer-plugin`, performing the `display-info` and `enforce` goals during the `validate` phase.

Required Maven Version is set by the `required-maven.version` property.

Required Java Version is set by the `java.version` property.

### Compiler Tile

#### Maven Compiler Plugin

The [Maven Compiler Plugin](https://maven.apache.org/plugins/maven-compiler-plugin/) compiles your sources.

Ref: [compile:compile](https://maven.apache.org/plugins/maven-compiler-plugin/compile-mojo.html)

* showDeprecation: true
* showWarnings: true
* source: ${java.version}
* target: ${java.version}
* encoding: ${project.build.sourceEncoding}

### Checkstyle Tile

The [Maven Checkstyle Plugin](https://maven.apache.org/plugins/maven-checkstyle-plugin/) verifies the source code against a Checkstyle ruleset file.

The default ruleset is the level `5-complexity` ruleset from [`kemitix-checkstyle-ruleset`](https://github.com/kemitix/kemitix-checkstyle-ruleset).

To use another level within `kemitix-checkstyle-ruleset`, set the `ruleset.level` property. e.g. `4-tweaks`.

To use a different checkstyle ruleset completely, set the `checkstyle.ruleset.location` property.


### Huntbugs Tile

The [Huntbugs Maven Plugin](https://github.com/amaembo/huntbugs) performs a static analysis of the compiled bytecode for common bug patterns during the `verify` phase.

### PMD Tile

The [PMD Maven Plugin](https://maven.apache.org/plugins/maven-pmd-plugin/) performs the PMD static code analysis during the `verify` phase.

Has a transitive dependency upon the `maven-plugins-tile` and includes it automatically.

### Digraph Tile

The [Digraph Maven Plugin](https://github.com/kemitix/digraph-dependency-maven-plugin/) creates a graphviz diagram of the package dependencies within the source code during the `verify` phase.

Set the property `digraph-dependency.basePackage` to the base of the project to be graphed. The default value is `net.kemitix`.

### Testing Tile

#### Maven Surefire Plugin

The [Maven Surefire Plugin](http://maven.apache.org/surefire/maven-surefire-plugin/index.html) runs your Unit Tests during the `test` phase.

### Maven Failsafe Plugin

The [Maven Failsafe Plugin](http://maven.apache.org/surefire/maven-failsafe-plugin/index.html) runs your Integration Tests during the `verify` phase.

### Coverage Tile

#### Jacoco

The [Jacoco Maven Plugin](http://www.eclemma.org/jacoco/trunk/doc/maven.html) verifies that the test suite meets the required coverage ratios.

The defaults require that all classes, lines and branches be covered by tests. i.e. 100% code coverage.

Set the following properties to set less strict targets:

* `jacoco-class-line-covered-ratio` - default = 1 (i.e. 100%)
* `jacoco-class-instruction-covered-ratio` - default = 1 (i.e. 100%)
* `jacoco-class-missed-count-maximum` - default = 0 (i.e. #classes with no tests <= 0)

Classes with names that end in the following are excluded from these limits:

* `Test`
* `IT`
* `Main`
* `Application`
* `Configuration`
* `Immutable`

#### Coveralls

The [Coveralls Maven Plugin](https://github.com/trautonen/coveralls-maven-plugin) publishes coverage data to coveralls.io.

The plugin is not configured to run automatically. It must be initiated manually, and requires the `release` profile to be enabled:

```shell
mvn -P release test jacoco:report coveralls:report
```

This runs the tests, creates the jacoco report from the tests then uploads the results to http://coveralls.io.

### Pitest Tile

#### Mutation Testing

The [Pitest Maven Plugin](http://pitest.org/quickstart/maven/) perform mutation test coverage checks during the `verify` phase.

Code coverage must by 100% and all mutations must result in a test from the test suite failing.

Set `pitest.skip` to avoid running the mutation test.

Set `pitest.coverage` to a value between 0 and 1 to set the allowed ratio of uncovered code. i.e. 0 = 100% code coverage, 0.2 = 80% code coverage

Set `pitest.mutation` to a value between 0 and 1 to set the allowed mutations to survive the test suite. i.e. 0 = 100% mutations caught, 0.2 = 80% mutations caught

#### Highwheel Cyclic Analysis

The [Highwheel Maven Plugin](https://github.com/hcoles/highwheel) detects and visualises class and package cyclic dependencies during the `verify` phase. It also reports on tests that appear to have been orphaned during refactoring.

The generated report is created in `target/highwheel/`.

### Release Tile

The plugins in this Tile are only activated when the `release` profile is enabled.

#### Maven Source Plugin

The [Maven Source Plugin](https://maven.apache.org/plugins/maven-source-plugin/) bundles your sources into a jar file ready for deployment.

Runs its [jar-no-fork](https://maven.apache.org/plugins/maven-source-plugin/jar-no-fork-mojo.html) goal during the `verify` phase.

#### Maven Javadoc Plugin

The [Maven Javadoc Plugin](https://maven.apache.org/plugins/maven-javadoc-plugin/) generates your html javadocs and bundles them into a jar file ready for deployment.

Runs its [jar](https://maven.apache.org/plugins/maven-javadoc-plugin/jar-mojo.html) goal during the `verify` phase.

#### Maven Deploy Plugin

The [Maven Deploy Plugin](https://maven.apache.org/plugins/maven-deploy-plugin/) uploads your artifacts to a remote repository.
