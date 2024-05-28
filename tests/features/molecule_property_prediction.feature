Feature: Property prediction

  Scenario Outline: Predicting a molecular property
    Given a list of <num_molecules> random molecules, where <num_none> entries are None
    And the input type is '<input_type>'
    And the representations of the molecules
    And an example model predicting molecular weight, version <version>
    And a prediction parameter 'multiplier' set to <multiplier>

    When the model is used on the molecules given as <input_type>
    And the subset of the result where the input was not None is considered

    Then the result should be a pandas DataFrame
    And the result should contain the same number of rows as the input
    And the result should contain the columns:
          mol_id
          name
          input_mol
          preprocessed_mol
          input_type
          errors
          weight
    And the input type column should be '<input_type>'
    And the name column should contain valid names
    And the weight column should contain the (multiplied) molecule weights
    And the input column should contain the input representation
    And the errors column should be a list of problem instances

    Examples:
    | input_type | version   | num_molecules | multiplier | num_none |
    | rdkit_mol  | no_ids    | 10            | 3          | 0        |
    | smiles     | no_ids    | 10            | 3          | 0        |
    | mol_block  | no_ids    | 10            | 3          | 0        |
    | rdkit_mol  | no_ids    | 10            | 3          | 5        |
    | smiles     | no_ids    | 10            | 3          | 5        |
    | mol_block  | no_ids    | 10            | 3          | 5        |
    | rdkit_mol  | no_ids    | 0             | 3          | 0        |
    | smiles     | no_ids    | 0             | 3          | 0        |
    | mol_block  | no_ids    | 0             | 3          | 0        |
    | rdkit_mol  | with_ids  | 10            | 3          | 0        |
    | smiles     | with_ids  | 10            | 3          | 0        |
    | mol_block  | with_ids  | 10            | 3          | 0        |
    | rdkit_mol  | with_ids  | 10            | 3          | 5        |
    | smiles     | with_ids  | 10            | 3          | 5        |
    | mol_block  | with_ids  | 10            | 3          | 5        |
    | rdkit_mol  | with_ids  | 0             | 3          | 0        |
    | smiles     | with_ids  | 0             | 3          | 0        |
    | mol_block  | with_ids  | 0             | 3          | 0        |
    | rdkit_mol  | with_mols | 10            | 3          | 0        |
    | smiles     | with_mols | 10            | 3          | 0        |
    | mol_block  | with_mols | 10            | 3          | 0        |
    | rdkit_mol  | with_mols | 10            | 3          | 5        |
    | smiles     | with_mols | 10            | 3          | 5        |
    | mol_block  | with_mols | 10            | 3          | 5        |
    | rdkit_mol  | with_mols | 0             | 3          | 0        |
    | smiles     | with_mols | 0             | 3          | 0        |
    | mol_block  | with_mols | 0             | 3          | 0        |