name: Pull Request
description: Submit changes to skills, scripts, or docs
title: ""
labels: []
body:
  - type: textarea
    id: summary
    attributes:
      label: Summary
      description: What does this PR change?
    validations:
      required: true
  - type: textarea
    id: checklist
    attributes:
      label: Checklist
      value: |
        - [ ] `make validate-all` passes
        - [ ] CATALOG.md updated if new skill
        - [ ] dev-rules references updated if new skill
        - [ ] Links verified
