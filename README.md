KEMITIX-MAVEN-TILES
===================

Maven Tiles for preconfigured plugins.

### Usage

For Java 9 and Maven 3.5.0+ applications:

```xml
<project>
    <properties>
        <tiles-maven-plugin.version>2.10</tiles-maven-plugin.version>
        <kemitix-tiles.version>0.8.0-SNAPSHOT</kemitix-tiles.version>
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
                         <tile>net.kemitix.tiles:all:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:pmd-strict:${kemitix-tiles.version}</tile>

                         <!-- or -->

                         <tile>net.kemitix.tiles:maven-plugins:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:enforcer:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:compiler:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:huntbugs:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:pmd:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:digraph:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:testing:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:coverage:${kemitix-tiles.version}</tile>

                         <!-- Java 8 only - not compatible with Java 9+ -->
                         <tile>net.kemitix.tiles:pitest:${kemitix-tiles.version}</tile>
                         <tile>net.kemitix.tiles:huntbugs:${kemitix-tiles.version}</tile>

                   </tiles>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

Where Maven 3.3.9 is required, e.g. IntelliJ, set the `required-maven.version` property.

Where Java 1.8 is required set the `java.version` property to `1.8`.

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
* `require-java.version`
* `require-maven.version`
* `versions-maven-plugin.version`
* `pitest-maven-plugin.version`
* `highwheel-maven-plugin.version`

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

Required Maven Version is set by the `required-maven.version` property. Default is 3.5.0.

```shell
./mvnw validate -Drequired-maven.version=3.3.9
```

### Compiler Tile

#### Maven Compiler Plugin

The [Maven Compiler Plugin](https://maven.apache.org/plugins/maven-compiler-plugin/) compiles your sources.

Compilation targets Java 9 by default. Set the `java.version` property to 1.8 to use Java 8.

Ref: [compile:compile](https://maven.apache.org/plugins/maven-compiler-plugin/compile-mojo.html)

* showDeprecation: true
* showWarnings: true
* source: ${java.version}
* target: ${java.version}
* encoding: ${project.build.sourceEncoding}

### Checkstyle Tile

This tile has been deprecated and replaced by the tile `net.kemitix.checkstyle:tile:$VERSION` from the [kemitix-checkstyle-ruleset](https://github.com/kemitix/kemitix-checkstyle-ruleset) project.

### Huntbugs Tile

The plugin in this tile are only enabled when using a 1.8 JDK.

The [Huntbugs Maven Plugin](https://github.com/amaembo/huntbugs) performs a static analysis of the compiled bytecode for common bug patterns during the `verify` phase.

Trying to use the 0.0.11 version of the Huntbugs Maven Plugin with JDK 9 will result in the error:
```
[ERROR] Failed to execute goal one.util:huntbugs-maven-plugin:0.0.11:huntbugs (default-cli) on project foo:
    Execution default-cli of goal one.util:huntbugs-maven-plugin:0.0.11:huntbugs failed:
        A required class was missing while executing one.util:huntbugs-maven-plugin:0.0.11:huntbugs:
            sun/misc/URLClassPath
```

### PMD Tiles

The [PMD Maven Plugin](https://maven.apache.org/plugins/maven-pmd-plugin/) performs the PMD static code analysis and copy-paste detection during the `verify` phase.

Uses PMD version `6.0.1`. This can be overridden by setting the `pmd.version` property.

Include the `maven-plugins` tile to get source code cross-referencing in the error reports.

#### pmd

Checks the source code against the rules in the [kemitix-pmd-ruleset](https://github.com/kemitix/kemitix-pmd-ruleset) 
file [java.xml](https://github.com/kemitix/kemitix-pmd-ruleset/blob/master/src/main/resources/net/kemitix/pmd/java.xml).

Creates HTML reports in `target/site/pmd.html` and `target/site/cpd.html`.

#### pmd-strict

Requires the `pmd` tile.

Not included in the `all` tile.

If there are any violations of the ruleset then the build will fail. 

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

### Pitest Tile

The plugins in this tile are only enabled when using a 1.8 JDK.

#### Mutation Testing

The [Pitest Maven Plugin](http://pitest.org/quickstart/maven/) perform mutation test coverage checks during the `verify` phase.

Code coverage must by 100% and all mutations must result in a test from the test suite failing.

Set `pitest.skip` to avoid running the mutation test.

Set `pitest.coverage` to a value between 0 and 1 to set the allowed ratio of uncovered code. i.e. 0 = 100% code coverage, 0.2 = 80% code coverage

Set `pitest.mutation` to a value between 0 and 1 to set the allowed mutations to survive the test suite. i.e. 0 = 100% mutations caught, 0.2 = 80% mutations caught

#### Maven Source Plugin

The [Maven Source Plugin](https://maven.apache.org/plugins/maven-source-plugin/) bundles your sources into a jar file ready for deployment.

Runs its [jar-no-fork](https://maven.apache.org/plugins/maven-source-plugin/jar-no-fork-mojo.html) goal during the `verify` phase.

#### Maven Javadoc Plugin

The [Maven Javadoc Plugin](https://maven.apache.org/plugins/maven-javadoc-plugin/) generates your html javadocs and bundles them into a jar file ready for deployment.

Runs its [jar](https://maven.apache.org/plugins/maven-javadoc-plugin/jar-mojo.html) goal during the `verify` phase.

#### Maven GPG Plugin

The [Maven GPG Plugin](https://maven.apache.org/plugins/maven-gpg-plugin/) digitally signs the generated artifacts ready for uploading to the Sonatype Nexus repository.

Runs its [sign](https://maven.apache.org/plugins/maven-gpg-plugin/sign-mojo.html) goal during the `package` phase.

#### Maven Deploy Plugin

The [Maven Deploy Plugin](https://maven.apache.org/plugins/maven-deploy-plugin/) uploads your artifacts to a remote repository.
