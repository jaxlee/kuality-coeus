Feature: Permissions in a Proposal

  As a Proposal Aggregator, I want to be able to assign others permissions to a proposal,
  to allow them to work on the proposal with me, and to control what actions
  they are capable of performing with it.

  Background: A proposal creator user initiates a proposal
    Given a User exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
    And   initiate a Proposal

  Scenario: The proposal initiator is automatically an aggregator
    When  I visit the Proposal's Permissions page
    Then  the Proposal Creator user is listed as an Aggregator in the proposal permissions

  Scenario Outline: A Proposal Aggregator can assign various roles to a proposal documents permissions
    Given a User exists with the system role: 'Unassigned'
    When  I assign the Unassigned user as a <Role> in the proposal permissions
    Then  the Unassigned user can access the Proposal
    And   their proposal permissions allow them to <Permissions>

    Examples:
    | Role                 | Permissions                          |
    | Aggregator           | edit all parts of the proposal       |
    | Budget Creator       | update the budget, not the narrative |
    | Delete Proposal      | delete the proposal                  |
    | Viewer               | only read the proposal               |

  Scenario: Narrative Writers can't edit budget details
    Given I create a Budget Version for the Proposal
    And   a User exists with the system role: 'Unassigned'
    When  I assign the Unassigned user as a Narrative Writer in the proposal permissions
    Then  the Unassigned user can access the Proposal
    And   their proposal permissions do not allow them to edit budget details

  Scenario Outline: Proposal permissions are not passed onto future proposals initiated by the same creator
    Given a User exists with the system role: 'Unassigned'
    And   I assign the Unassigned user as a <Role> in the proposal permissions
    When  I initiate a second Proposal
    Then  the Unassigned user should not be listed as a <Role> in the second Proposal

  Examples:
    | Role             |
    | Viewer           |
    | Budget Creator   |
    | Narrative Writer |
    | Aggregator       |
    | approver         |
    | Delete Proposal  |

  Scenario Outline: Users who are assigned the Aggregator role cannot be assigned additional roles
    Given a User exists with the system role: '<Role>'
    And   I assign the <Role> user as an aggregator in the proposal permissions
    When  I attempt to add an additional proposal role to the <Role> user
    Then  there should be an error message that says not to select other roles alongside aggregator

  Examples:
    | Role             |
    | Unassigned       |
    | Proposal Creator |

  Scenario Outline: Visit a recalled proposal as users with the permissions necessary to edit the document in varying ways
    Given a User exists with the system role: 'Unassigned'
    And   assign the Unassigned user as a <Role> in the proposal permissions
    And   complete the Proposal
    And   submit the Proposal
    When  I recall the Proposal
    Then  the Unassigned user can access the Proposal
    And   their proposal permissions allow them to <Permissions>

  Examples:
    | Role                | Permissions                                    |
    | Aggregator          | edit all parts of the proposal                 |
    | Budget Creator      | only update the budget                         |
    | Delete Proposal     | delete the proposal                            |
    | Viewer              | only read the proposal                         |