# Devskiller programming task sample - Puppet

## Introduction

With [devskiller.com](https://devskiller.com) you can assess candidates'
programming skills during your recruitment process. Programming tasks are the
best way to test candidates programming skills. The candidate is asked to
modify source code of an existing project.

During the test, the candidate is allowed to edit the source code of the
project with our browser-based code editor and can build the project inside
the browser at any time. Candidate can also download the project code and edit
it locally with the favorite IDE.

Check out how the test looks from [candidate's perspective](https://help.devskiller.com/candidate-documentation/how-the-devskiller-test-looks-like-from-the-candidate-perspective).

This repo contains an example project for Puppet, below you can find a
detailed guide for creating your own programming project.

**Please make sure to read our [Getting started with programming
projects](https://docs.devskiller.com/programming_tasks/index.html) guides
first**

## Technical details for Puppet project

Every Puppet module in your project will be tested with following commands:

```sh
bundle install
bundle exec rake spec_clean
bundle exec rake ci:setup:rspec spec
```

We use [rspec-puppet](http://rspec-puppet.com/) for testing Puppet code
together with [CI:Reporter](https://github.com/ci-reporter/ci_reporter).

Please check the provided [Gemfile](modules/directory_creator/Gemfile) for the
list of dependencies.

**When you will be creating a ZIP package with project contents, please skip
`reports/`, `spec/fixtures/` and `.bundle/` directories.**

## Automatic assessment

It is possible to automatically assess solution posted by the candidate.
Automatic assessment is based on Unit Tests results and Code Quality
measurements.

There are two kinds of unit tests:

1. **Candidate tests** - unit tests that are visible for the candidate during
   the test. Should be used to do only the basic verification and help the
   candidate to understand the requirements. Candidate tests WILL NOT be used
   to calculate the final score.
2. **Verification tests** - unit tests that are hidden from the candidate
   during the test. Files containing verification tests will be added to the
   project after the candidate finishes the test and will be executed during
   verification phase. Verification tests result will be used to calculate the
   final score.

After candidate finishes the test, our platform builds the project posted by
the candidate and executes verification tests and static code analysis.

## Devskiller project descriptor

Programming task can be configured with the Devskiller project descriptor
file. Just create a `devskiller.json` file and place it in the root directory
of your project. Here is an example project descriptor:

```json
{
    "verification" : {
        "testNamePatterns" : [ ".*Verification.*" ],
        "pathPatterns" : [ "**/spec/**_verify_**" ]
    }
}
```

You can find more details about `devskiller.json` descriptor in our
[documentation](https://docs.devskiller.com/programming_tasks/project_descriptor.html).

## Automatic verification with verification tests

To enable automatic verification of candidates' solution, you need to define
which tests should be treated as verification tests.

All files classified as verification tests will be removed from a project
prepared for the candidate.

To define verification tests, you need to set two configuration properties in
`devskiller.json` project descriptor:

- `testNamePatterns` - an array of RegEx patterns which should match all the
  test names of verification tests. In our sample project all verification
  tests' names starts with `[module_name] Verification` prefix, so the
  following pattern will be sufficient:

```json
"testNamePatterns" : [ ".*Verification.*" ]
```

- `pathPatterns` - an array of GLOB patterns which should match all the files
  containing verification tests. All the files that match defined patterns
  will be deleted from candidates' projects and will be added to the projects
  during the verification phase. These files will not be visible for candidate
  during the test.

```json
"pathPatterns" : [ "**/spec/**/**_verify_**" ]
```

