###############################################################################
#                              FILE INFORMATION                               #
###############################################################################
meta:
  id: tes5
  title: Elder Scrolls Plugin/Master
  application: The Elder Scrolls V (Skyrim)
  file-extension:
    - esp
    - esm
    - esl
  endian: le
  
###############################################################################
#                            ROOT FILE STRUCTURE                              #
###############################################################################
seq:
  - id: header
    type: file_header
    doc: ESP/ESM header form
  - id: top_groups
    type: esp_groups
    doc: Top level groups

###############################################################################
#                               ENUMERATIONS                                  #
###############################################################################
enums:
  group_type:
    0: top
    1: world_children
    2: interior_cell_block
    3: interior_cell_sub_block
    4: exterior_cell_block
    5: exterior_cell_sub_block
    6: cell_children
    7: topic_children
    8: cell_persistent_children
    9: cell_temporary_children
    10: cell_visible_distant_children
    
  glob_fnam_type:
    0x73: short
    0x6C: long
    0x66: float

  fact_xnam_combat:
    0: neutral
    1: enemy
    2: ally
    3: friend

  fact_plvd_specification_type:
    0: near_reference
    1: in_cell
    2: near_package_start_location
    3: near_editor_location
    6: linked_reference
    12: near_self

  ctda_operator:
    0: equal_to
    1: not_equal_to
    2: greater_than
    3: greater_than_or_equal_to
    4: less_than
    5: less_than_or_equal_to

  ctda_run_on_type:
    0: subject
    1: target
    2: reference
    3: combat_target
    4: linked_reference
    5: quest_alias
    6: package_data
    7: event_data

  hdpt_option:
    0: generic_default
    1: default
    2: char_gen

  race_data_size:
    0: small
    1: medium
    2: large
    4: extra_large
    
###############################################################################
#                             TYPE DEFINITIONS                                #
###############################################################################
types:

###############################################################################
#                            GLOBAL/COMMON TYPES                              #
###############################################################################
  lstring:
    params:
      - id: data_size
        type: u2
        doc: Size of string
    seq:
      - id: index
        type: u4
        if: _root.header.header.flags.localized
        doc: Index of localized string (stored in *STRINGS file)
      - id: string
        type: strz
        encoding: UTF-8
        size: data_size
        if: not _root.header.header.flags.localized
        doc: Full string if file is not localized
        
  actor_value_skills:
    seq:
      - id: one_handed
        type: u1
        doc: One handed skill
      - id: two_handed
        type: u1
        doc: Two handed skill
      - id: marksman
        type: u1
        doc: Archery skill
      - id: block
        type: u1
        doc: Block skill
      - id: smithing
        type: u1
        doc: Smithing skill
      - id: heavy_armor
        type: u1
        doc: Heavy armor skill 
      - id: light_armor
        type: u1
        doc: Light armor skill
      - id: pickpocket
        type: u1
        doc: Pickpocket skill
      - id: lockpicking
        type: u1
        doc: Lockpicking skill
      - id: sneak
        type: u1
        doc: Sneak skill
      - id: alchemy
        type: u1
        doc: Alchemy skill
      - id: speechcraft
        type: u1
        doc: Speechcraft skill
      - id: alteration
        type: u1
        doc: Alteration skill
      - id: conjuration
        type: u1
        doc: Conjuration skill
      - id: destruction
        type: u1
        doc: Destruction skill
      - id: illusion
        type: u1
        doc: Illusion skill
      - id: restoration
        type: u1
        doc: Restoration skill
      - id: enchanting
        type: u1
        doc: Enchanting skill

###############################################################################
#                              FILE HEADER (TES4)                             #
###############################################################################  
  file_header:
    seq:
      - id: header
        type: tes4_header
        doc: TES4 form-specific header
      - id: fields
        type: tes4_fields
        size: header.data_size
        doc: TES4 form-specific fields  

  tes4_header:
    seq:
      - id: type
        type: str
        size: 4
        encoding: UTF-8
        doc: Form type code
      - id: data_size
        type: u4
        doc: Size, in bytes, of form (minus header)
      - id: flags
        type: file_header_flags
        doc: Form-specific bitflags
      - id: form_id
        type: u4
        doc: Unique form ID
      - id: revision
        type: u4
        doc: Used for revision control by the CK
      - id: version
        type: u2
        doc: Version number
      - id: unknown
        type: u2
        doc: Unknown purpose

  file_header_flags:
    seq:
      - id: localized
        type: b1
        doc: Localized strings flag
      - type: b6
      - id: master
        type: b1
        doc: Master (ESM) file flag
      - type: b1
      - id: light_master
        type: b1
        doc: Light master (ESL) file flag
      - type: b22
  
  tes4_fields:
    seq:
      - id: fields
        type: tes4_field
        repeat: eos
        doc: TES4 form-specific fields
  
  tes4_field:
    seq:
      - id: type
        type: str
        size: 4
        encoding: UTF-8
        doc: Field type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type: 
          switch-on: type
          cases:
            '"HEDR"': tes4_hedr_field
            '"CNAM"': tes4_cnam_field
            '"SNAM"': tes4_snam_field
            '"MAST"': tes4_mast_field
            '"DATA"': tes4_data_field
            '"ONAM"': tes4_onam_field
            '"INTV"': tes4_intv_field
        doc: Field data
        
  tes4_hedr_field:
    seq:
      - id: version
        type: f4
        doc: Version number
      - id: num_records
        type: s4
        doc: Number of forms
      - id: next_object_id
        type: u4
        doc: Next form ID
  
  tes4_cnam_field:
    seq:
      - id: author
        type: str
        size: _parent.data_size
        encoding: UTF-8
        doc: Author of file (optional)
        
  tes4_snam_field:
    seq:
      - id: description
        type: str
        size: _parent.data_size
        encoding: UTF-8
        doc: Description of file (optional)
        
  tes4_mast_field:
    seq:
      - id: master
        type: str
        size: _parent.data_size
        encoding: UTF-8
        doc: Master filename
        
  tes4_data_field:
    seq:
      - id: file_size
        type: u8
        doc: Master filesize
  
  tes4_onam_field:
    seq:
      - id: overrides
        type: u4
        repeat: expr
        repeat-expr: _parent.data_size / 4
        doc: Overriden form IDs
        
  tes4_intv_field:
    seq:
      - id: intv
        type: u4
        doc: Internal version (?)
        
  tes4_incc_field:
    seq:
      - id: incc
        type: u4
        doc: Unknown purpose, introduced in Skyrim 1.6 - Update.esm

###############################################################################
#                                 GROUPS (GRUP)                               #
###############################################################################
  esp_groups:
    seq: 
      - id: groups
        type: esp_group
        repeat: eos
        doc: Top level groups

  esp_group:
    seq:
      - id: type
        contents: "GRUP"
        doc: Type code
      - id: group_size
        type: u4
        doc: Size, in bytes, of group (including header)
      - id: label
        type: u4
        doc: Group label (depends on group type)
      - id: group_type
        type: s4
        enum: group_type
        doc: Group type enumeration
      - id: stamp
        type: u2
        doc: Date stamp
      - type: u2
      - id: version
        type: u2
        doc: Unknown purpose
      - type: u2
      - id: data
        type: esp_forms
        size: group_size - 24
        doc: Forms and sub-groups belonging to group

  subgroup:
    seq:
      - id: header
        type: group_header
        doc: Group header information
      - id: group_data
        size: header.group_size - 24
        doc: Forms belonging to subgroup

  group_header:
    seq:
      - id: group_size
        type: u4
        doc: Size, in bytes, of group (including header)
      - id: label
        type: u4
        doc: Group label (depends on group type)
      - id: group_type
        type: s4
        enum: group_type
        doc: Group type enumeration
      - id: stamp
        type: u2
        doc: Date stamp
      - type: u2
      - id: version
        type: u2
        doc: Unknown purpose
      - type: u2

###############################################################################
#                        COMMON FORM (RECORD) ELEMENTS                        #
###############################################################################
  esp_forms:
    seq:
      - id: forms
        type: esp_form
        repeat: eos
        doc: Form list held by group/subgroup

  form_header:
    seq:
      - id: data_size
        type: u4
        doc: Size, in bytes, of form (minus header)
      - id: flags
        type: form_header_flags
        doc: Form-specific bitflags
      - id: form_id
        type: u4
        doc: Unique form ID
      - id: revision
        type: u4
        doc: Used for revision control by the CK
      - id: version
        type: u2
        doc: Version number
      - id: unknown
        type: u2
        doc: Unknown purpose

  form_header_flags:
    seq:
      - type: b18
      - id: compressed
        type: b1
        doc: Indicates form data compression (zlib)
      - type: b13

  esp_form:
    seq:
      - id: type
        type: str
        size: 4
        encoding: UTF-8
        doc: Form type code
      - id: subgroup
        type: subgroup
        if: type == 'GRUP'
        doc: Special subgroup (contained in CELL, WRLD and DIAL top groups)
      - id: form
        type: form
        if: type != 'GRUP'
        doc: Form data

  form:
    seq:
      - id: header
        type: form_header
        doc: Form header information
      - id: form_data
        size: header.data_size
        doc: Size, in bytes, of form (minus header)
        type:
          switch-on: _parent.type
          cases:
            '"GMST"': gmst_form
            '"KYWD"': kywd_form
            '"LCRT"': lcrt_form
            '"AACT"': aact_form
            '"TXST"': txst_form
            '"GLOB"': glob_form
            '"CLAS"': clas_form
            '"FACT"': fact_form
            '"HDPT"': hdpt_form
            '"EYES"': eyes_form
            '"RACE"': race_form
            '"SOUN"': soun_form
            '"ASPC"': aspc_form
            '"LTEX"': ltex_form
            _: unknown_form_data
        doc: Fields contained by form

  unknown_form_data:
    seq:
      - id: data
        type: str
        encoding: UTF-8
        size: _parent.header.data_size
        doc: Used for undefined forms

###############################################################################
#                                COMMON FIELDS                                #
###############################################################################
  edid_field:        
    params:
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
    seq:
      - id: editor_id
        type: strz
        encoding: UTF-8
        size: data_size
        doc: Form name displayed in CK
        
  color:
    seq:
      - id: r
        type: u1
        doc: Red value
      - id: g
        type: u1
        doc: Green value
      - id: b
        type: u1
        doc: Blue value
      - id: a
        type: u1
        doc: Alpha (?) value

  obnd_field:
    seq:
      - id: x1
        type: u2
        doc: X-coordinate 1
      - id: y1
        type: u2
        doc: Y-coordinate 1
      - id: z1
        type: u2
        doc: Z-coordinate 1
      - id: x2
        type: u2
        doc: X-coordinate 2
      - id: y2
        type: u2
        doc: Y-coordinate 2
      - id: z2
        type: u2
        doc: Z-coordinate 2

  citc_field:
    seq:
      - id: condition_item_count
        type: u4
        doc: Count of following CTDA fields

  cis1_field:
    params:
      - id: data_size
        type: u2
        doc: Size of zstring
    seq:
      - id: variable
        type: strz
        encoding: UTF-8
        size: data_size
        doc: Variable represented as string

  cis2_field:
    params:
      - id: data_size
        type: u2
        doc: Size of zstring
    seq:
      - id: variable
        type: strz
        encoding: UTF-8
        size: data_size
        doc: Variable represented as string

  ctda_field:
    seq:
      - id: operator_info
        type: ctda_operator_info
        doc: Condition operator information
      - id: unknown
        size: 3
        doc: Unknown purpose (padding?)
      - id: glob_comparison_value
        type: u4
        if: operator_info.use_global
        doc: Value against which the function result is compared (GLOB)
      - id: comparison_value
        type: f4
        if: not operator_info.use_global
        doc: Value against which the function result is compared
      - id: function_index
        type: u2
        doc: Function index (map to number+4096)
      - id: padding
        type: u2
        doc: Padding, unused bytes
      - id: parameters
        type: ctda_parameters
        doc: Function parameters
        if: function_index != 576
      - id: parameters_get_event_data
        type: ctda_parameters_get_event_data
        doc: Function paramaters (for GetEventData function)
        if: function_index == 576
      - id: run_on_type
        type: u4
        enum: ctda_run_on_type
        doc: How to apply the condition
      - id: reference
        type: u4
        doc: Function reference
      - id: unknown_2
        type: s4
        doc: Unknown purpose (always -1)

  ctda_operator_info:
    seq:
      - id: operator
        type: b3
        enum: ctda_operator
        doc: Function operator
      - id: or
        type: b1
        doc: OR multiple conditions (default is AND)
      - id: parameters_use_aliases
        type: b1
        doc: Parameters use quest alias data
      - id: use_global
        type: b1
        doc: Use global
      - id: use_pack_data
        type: b1
        doc: Parameters use pack data
      - id: swap_target
        type: b1
        doc: Swap subject and target

  ctda_parameters:
    seq:
      - id: param_1
        size: 4
        doc: 1st parameter (refer to function index for type)
      - id: param_2
        size: 4
        doc: 2nd parameter (refer to function index for type)

  ctda_parameters_get_event_data:
    seq:
      - id: param_1
        type: u2
        doc: Event function
      - id: param_2
        type: str
        encoding: UTF-8
        size: 2
        doc: Event member
      - id: param_3
        type: u4
        doc: 3rd parameter

  generic_modt:
    params:
      - id: data_size
        type: u2
        doc: Size, in bytes, of data
      - id: version
        type: u4
        doc: Version of MODT field
    seq:
      - id: modt
        type: modt_field(data_size)
        if: version < 40
      - id: modt_v40
        type: modt_v40_field
        if: version >= 40


  modt_field:
    params:
      - id: data_size
        type: u2
        doc: Size, in bytes, of data
    seq:
      - id: hashes
        type: modt_texture_hash
        repeat: expr
        repeat-expr: data_size / 12

  modt_texture_hash:
    seq:
      - id: file_hash
        type: u4
        doc: Hash of file name
      - id: unknown
        type: str
        encoding: UTF-8
        size: 4
        doc: Unknown bytes
      - id: folder_hash
        type: u4
        doc: Hash of folder

  modt_v40_field:
    seq:
      - id: num_headers
        type: u4
      - id: texture_count
        type: u4
      - id: unused
        type: str
        encoding: UTF-8
        size: 4
      - id: unique_tex_count
        type: u4
      - id: materials_count
        type: u4
      - id: hashes
        type: modt_v40_texture_hash
        repeat: eos

  modt_v40_texture_hash:
    seq:
      - id: flags
        type: u4
      - id: type
        type: u4
      - id: texture_hash
        type: u4

  bodt_field:
    params:
      - id: data_size
        type: u2
        doc: Size, in bytes, of data
    seq:
      - id: node_flags
        type: u4
        doc: Body part node flags (TODO)
      - id: flags
        type: u4
        doc: Further flags
      - id: skill
        type: u4
        doc: Corresponding skill (heavy or light armor)
        if: data_size == 12

###############################################################################
#                           GMST (GAME SETTING) FORM                          #
###############################################################################
  gmst_form:
    seq:
      - id: fields
        type: gmst_field
        repeat: expr
        repeat-expr: 2
        doc: GMST fields (EDID, DATA)
        
  gmst_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"DATA"': gmst_data_field
        doc: Fields contained by GMST form
            
  gmst_data_field:
    seq:
      - id: value
        type: u4
        doc: Game setting value (TODO, conditional type switching)
        
###############################################################################
#                             KYWD (KEYWORD) FORM                             #
###############################################################################        
  kywd_form:
    seq:
      - id: fields
        type: kywd_field
        repeat: eos
        doc: Fields contained by KYWD form
        
  kywd_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type: 
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"CNAM"': color
        doc: Fields contained by KYWD form

###############################################################################
#                      LCRT (LOCATION REFERENCE TYPE) FORM                    #
###############################################################################   
  lcrt_form:
    seq:
      - id: fields
        type: lcrt_field
        repeat: eos
        doc: Fields contained by LCRT form
        
  lcrt_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"CNAM"': color
        doc: Fields contained by LCRT form

###############################################################################
#                               AACT (ACTOR) FORM                             #
###############################################################################              
  aact_form:
    seq:
      - id: fields
        type: aact_field
        repeat: eos
        doc: Fields contained by AACT form
        
  aact_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"CNAM"': color
        doc: Fields contained by AACT form
            
###############################################################################
#                           TXST (TEXTURE SET) FORM                           #
###############################################################################              
  txst_form:
    seq:
      - id: fields
        type: txst_field
        repeat: eos
        doc: Fields contained by TXST form
        
  txst_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of form (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"OBND"': obnd_field
            '"TX00"': txst_tx_field
            '"TX01"': txst_tx_field
            '"TX02"': txst_tx_field
            '"TX03"': txst_tx_field
            '"TX04"': txst_tx_field
            '"TX05"': txst_tx_field
            '"TX06"': txst_tx_field
            '"TX07"': txst_tx_field
            '"DODT"': txst_dodt_field
            '"DNAM"': txst_dnam_field
        doc: Fields contained by TXST form
  
  txst_tx_field:
    seq:
      - id: path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: | 
          Path to texture, types as follows
          TX00 (required) - Color map
          TX01 - Normal map (tangent or model-space)
          TX02 - Environment mask
          TX03 - Tone map (skin) or glow map
          TX04 - Detail map (roughness, complexion, age)
          TX05 - Environment map
          TX06 - Unknown (does not occur in Skyrim.esm)
          TX07 - Specularity map (for bodies)
                    
  txst_dodt_field:
    seq:
      - id: min_width
        type: f4
        doc: Decal minimum width
      - id: max_width
        type: f4
        doc: Decal maximum width
      - id: min_height
        type: f4
        doc: Decal minimum height
      - id: max_height
        type: f4
        doc: Decal maximum height
      - id: depth
        type: f4
        doc: Decal depth
      - id: shininess
        type: f4
        doc: Decal shininess
      - id: parallax_scale
        type: f4
        doc: Decal parallax scale
      - id: parallax_passes
        type: u1
        doc: Decal parallax passes
      - id: flags
        type: txst_dodt_flags
        doc: Decal flags
      - id: unknown
        type: u2
        doc: Unknown purpose
      - id: rgb
        type: color
        doc: Decal color
        
  txst_dodt_flags:
    seq:
      - id: parallax
        type: b1
        doc: Parallax (enables "parallax scale" and "parallax passes" in CK)
      - id: alpha_blending
        type: b1
        doc: Alpha blending
      - id: alpha_testing
        type: b1
        id: Alpha testing
      - id: not_4_subtextures
        type: b1
      - type: b4
        doc: Padding
      
  txst_dnam_field:
    seq:
      - id: flags
        type: txst_dnam_flags
        doc: Texture set flags
        
  txst_dnam_flags:
    seq:
      - id: not_has_specular_map
        type: b1
        doc: Texture does not have a specular map
      - id: facegen_textures
        type: b1
        doc: Textures for facegen
      - id: has_model_space_normal_map
        type: b1
        doc: Normal map is model-space
      - type: b13
        doc: Padding
  
###############################################################################
#                          GLOB (GLOBAL VARIABLE) FORM                        #
###############################################################################  
  glob_form:
    seq:
      - id: fields
        type: glob_field
        repeat: eos
        doc: Fields contained by GLOB form
  
  glob_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FNAM"': glob_fnam_field
            '"FLTV"': glob_fltv_field
        doc: Fields contained by GLOB form

  glob_fnam_field:
    seq:
      - id: value_type
        type: u1
        enum: glob_fnam_type
        doc: Type of value (in FLTV field)
        
  glob_fltv_field:
    seq:
      - id: value
        type: f4
        doc: Global variable value (always stored as float)
        
###############################################################################
#                               CLAS (CLASS) FORM                             #
###############################################################################         
  clas_form:
    seq:
      - id: fields
        type: clas_field
        repeat: eos
        doc: Fields contained by CLAS form
  
  clas_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FULL"': clas_full_field
            '"DESC"': clas_desc_field
            '"ICON"': clas_icon_field
            '"DATA"': clas_data_field
        doc: Fields contained by CLAS form
  
  clas_full_field:
    seq:
      - id: name
        type: lstring(_parent.data_size)
        doc: Class name
        
  clas_desc_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: Class description
        
  clas_icon_field:
    seq:
      - id: icon
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to menu image
        
  clas_data_field:
    seq:
      - id: unknown
        type: u4
        doc: Unknown purpose
      - id: training_skill
        type: u1
        doc: Trainer classes hold a skill (actor value index)
      - id: training_level
        type: u1
        doc: Level to which NPC will provide training
      - id: skill_weights
        type: actor_value_skills
        doc: Skill weights, increase by this value each level
      - id: bleedout_default
        type: f4
        doc: Bleedout default
      - id: voice_points
        type: u4
        doc: Voice points
      - id: health_weight
        type: u1
        doc: Health weight, increase attribute each level
      - id: magicka_weight
        type: u1
        doc: Magicka weight, increase attribute each level
      - id: stamina_weight
        type: u1
        doc: Staminca weight, increase attribute each level
      - id: flags
        type: clas_data_flags
        doc: Class flags
        
  clas_data_flags:
    seq:
      - id: guard
        type: b1
        doc: Inidicates Guard
      - type: b7
        doc: Padding
      
###############################################################################
#                              FACT (FACTION) FORM                            #
###############################################################################  
  fact_form:
    seq:
      - id: fields
        type: fact_field
        repeat: eos
        doc: Fields contained by FACT form

  fact_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type: 
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FULL"': fact_full_field
            '"XNAM"': fact_xnam_field
            '"DATA"': fact_data_field
            '"JAIL"': fact_jail_field
            '"WAIT"': fact_wait_field
            '"STOL"': fact_stol_field
            '"PLCN"': fact_plcn_field
            '"CRGR"': fact_crgr_field
            '"JOUT"': fact_jout_field
            '"CRVA"': fact_crva_field
            '"RNAM"': fact_rnam_field
            '"MNAM"': fact_mnam_field
            '"FNAM"': fact_fnam_field
            '"VEND"': fact_vend_field
            '"VENC"': fact_venc_field
            '"VENV"': fact_venv_field
            '"PLVD"': fact_plvd_field
            '"CITC"': citc_field
            '"CIS1"': cis1_field(data_size)
            '"CIS2"': cis2_field(data_size)
            '"CTDA"': ctda_field
        doc: Fields contained by FACT form

  fact_full_field:
    seq:
      - id: full_name
        type: lstring(_parent.data_size)
        doc: Faction full name

  fact_xnam_field:
    seq:
      - id: faction_form_id
        type: u4
        doc: Faction form ID (inter-faction relations)
      - id: mod
        type: u4
        doc: Unused, not editable in CK
      - id: combat
        type: u4
        enum: fact_xnam_combat
        doc: Combat behaviour with faction

  fact_data_field:
    seq:
      - id: flags
        type: fact_data_flags
        doc: Faction flags

  fact_data_flags:
    seq:
      - id: hidden_from_pc
        type: b1
      - id: special_combat
        type: b1
      - type: b4
      - id: track_crime
        type: b1
      - id: ignore_murder
        type: b1
      - id: ignore_assault
        type: b1
      - id: ignore_stealing
        type: b1
      - id: ignore_trespass
        type: b1
      - id: do_not_report_crimes_against_members
        type: b1
      - id: crime_gold_use_defaults
        type: b1
      - id: ignore_pickpocket
        type: b1
      - id: vendor
        type: b1
      - id: can_be_owner
        type: b1
      - id: ignore_werewolf
        type: b1
      - type: b15

  fact_jail_field:
    seq:
      - id: jail_exterior_marker
        type: u4
        doc: Exterior marker for faction prison (REFR)
  
  fact_wait_field:
    seq:
      - id: follower_wait_marker
        type: u4
        doc: Marker that faction player followers are assigned to wait at (REFR)
  
  fact_stol_field:
    seq:
      - id: evidence_chest
        type: u4
        doc: Stolen goods chest (REFR)
  
  fact_plcn_field:
    seq:
      - id: belongings_chest
        type: u4
        doc: Player inventory chest (REFR)

  fact_crgr_field:
    seq:
      - id: crime_group
        type: u4
        doc: Crime factions list (FLST)

  fact_jout_field:
    seq:
      - id: jail_outfit
        type: u4
        doc: Jail outifit for player (OTFT)

  fact_crva_field:
    seq:
      - id: arrest
        type: u1
      - id: attack_on_sight
        type: u1
      - id: murder
        type: u2
      - id: assault
        type: u2
      - id: trespass
        type: u2
      - id: pickpocket
        type: u2
      - id: unused
        type: u2
      - id: steal_multiplier
        type: f4
        if: _parent.data_size == 16 or _parent.data_size == 20
      - id: escape
        type: u2
        if: _parent.data_size == 20
      - id: werewolf
        type: u2
        if: _parent.data_size == 20

  fact_rnam_field:
    seq:
      - id: rank_id
        type: u4
        doc: Rank ID

  fact_mnam_field:
    seq:
      - id: male_title
        type: lstring(_parent.data_size)
        doc: Male rank title

  fact_fnam_field:
    seq:
      - id: female_title
        type: lstring(_parent.data_size)
        doc: Female rank title

  fact_vend_field:
    seq:
      - id: vendor_list
        type: u4
        doc: Merchandise list (FLST)

  fact_venc_field:
    seq:
      - id: vendor_chest
        type: u4
        doc: Vendor chest (REFR)

  fact_venv_field:
    seq:
      - id: start_hour
        type: u2
        doc: Trading start hour
      - id: end_hour
        type: u2
        doc: Trading end hour
      - id: radius
        type: u4
        doc: Radius
      - id: buys_stolen
        type: u1
        doc: Buys stolen items
      - id: not_sell_or_buy
        type: u1
        doc: Causes vendor to buy/sell everything except what is in Vendor List (VEND/FLST)
      - id: unused
        type: u2
        doc: Unknown purpose

  fact_plvd_field:
    seq:
      - id: specification_type
        type: u4
        enum: fact_plvd_specification_type
        doc: Where to sell goods
      - id: form_id
        type: u4
        doc: Meaning depends on specification type enum
      - id: unused
        type: u4
        doc: Unknown purpose

###############################################################################
#                             HEAD PART (HDPT) FORM                           #
############################################################################### 
  hdpt_form:
    seq:
      - id: fields
        type: hdpt_field
        repeat: eos
        doc: Fields contained by HDPT form

  hdpt_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FULL"': hdpt_full_field
            '"MODL"': hdpt_modl_field
            '"MODT"': generic_modt(data_size, _parent._parent.header.version)
            '"DATA"': hdpt_data_field
            '"PNAM"': hdpt_pnam_field
            '"HNAM"': hdpt_hnam_field
            '"NAM0"': hdpt_nam0_field
            '"NAM1"': hdpt_nam1_field
            '"TNAM"': hdpt_tnam_field
            '"RNAM"': hdpt_rnam_field
            '"CNAM"': color

  hdpt_full_field:
    seq:
      - id: name
        type: lstring(_parent.data_size)
        doc: Head part name (almost always the same as EDID)

  hdpt_modl_field:
    seq:
      - id: nif_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Relative path to .nif (from Models directory)

  hdpt_data_field:
    seq:
      - id: flags
        type: hdpt_flags
        doc: Flags - unknown purpose (TODO)

  hdpt_flags:
    seq:
      - type: b8

  hdpt_pnam_field:
    seq:
      - id: part_count
        type: u4
        doc: Unknown purpose - maybe part count?

  hdpt_hnam_field:
    seq:
      - id: additional_part
        type: u4
        doc: Form ID of attached HDPT

  hdpt_nam0_field:
    seq:
      - id: option
        type: u4
        enum: hdpt_option
        doc: Option type

  hdpt_nam1_field:
    seq:
      - id: tri_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to .tri file

  hdpt_tnam_field:
    seq:
      - id: base_texture_set
        type: u4
        doc: Form ID of related TXST form
  
  hdpt_rnam_field:
    seq:
      - id: resource_list
        type: u4
        doc: Form ID of attached fixed resource list (FLST)

###############################################################################
#                                EYES (EYES) FORM                             #
############################################################################### 
  eyes_form:
    seq:
      - id: fields
        type: eyes_field
        repeat: eos
        doc: Fields contained by EYES form

  eyes_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FULL"': eyes_full_field
            '"ICON"': eyes_icon_field
            '"DATA"': eyes_data_field
        doc: Fields contained by EYES form

  eyes_full_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: Item description

  eyes_icon_field:
    seq:
      - id: icon_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Relative path to .dds from Textures directory
  
  eyes_data_field:
    seq:
      - id: flags
        type: eyes_flags
        doc: Eyes flags

  eyes_flags:
    seq:
      - id: playable
        type: b1
      - id: not_male
        type: b1
      - id: not_female
        type: b1
      - type: b5

###############################################################################
#                                RACE (RACE) FORM                             #
###############################################################################
  race_form:
    seq:
      - id: fields
        type: race_field
        repeat: eos
        doc: Fields contained by RACE formk

  race_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"FULL"': race_full_field
            '"DESC"': race_desc_field
            '"SPCT"': race_spct_field
            '"SPLO"': race_splo_field
            '"WNAM"': race_wnam_field
            '"BODT"': bodt_field(data_size)
            '"KSIZ"': race_ksiz_field
            '"KWDA"': race_kwda_field
            '"DATA"': race_data_field
            '"ANAM"': race_anam_field
            '"MODT"': generic_modt(data_size, _parent._parent.header.version)
            '"MTNM"': race_mtnm_field
            '"VTCK"': race_vtck_field
            '"DNAM"': race_dnam_field
            '"HCLF"': race_hclf_field

  race_full_field:
    seq:
      - id: full_name
        type: lstring(_parent.data_size)
        doc: Full race name (as it appears in-game)

  race_desc_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: Race description (as it appears in-game)

  race_spct_field:
    seq:
      - id: spell_count
        type: u4
        doc: Number of SPLO fields in RACE form

  race_splo_field:
    seq:
      - id: racial_spell
        type: u4
        doc: FormID of associated race-specific SPEL or SHOU form

  race_wnam_field:
    seq:
      - id: skin
        type: u4
        doc: FormID of associated ARMO form

  race_ksiz_field:
    seq:
      - id: keyword_count
        type: u4
        doc: Count of KYWD formIDs in following KWDA field

  race_kwda_field:
    seq:
      - id: keyword
        type: u4
        repeat: expr
        repeat-expr: _parent.data_size / 4
        doc: KYWD formIDs

  race_data_field:
    seq:
      - id: racial_skill
        type: race_data_skill
        repeat: expr
        repeat-expr: 7
        doc: Racial skill bonuses
      - type: u2
      - id: height_male
        type: u4
        doc: Male height
      - id: height_female
        type: u4
        doc: Female height
      - id: weight_male
        type: u4
        doc: Male weight
      - id: weight_female
        type: u4
        doc: Female weight
      - id: flags
        type: race_data_flags
        doc: Racial flags
      - id: start_health
        type: f4
        doc: Starting health
      - id: start_magicka
        type: f4
        doc: Starting magicka
      - id: start_stamina
        type: f4
        doc: Starting stamina
      - id: carry_weight
        type: f4
        doc: Base carry weight
      - id: mass
        type: f4
        doc: Base mass
      - id: acceleration
        type: f4
        doc: Acceleration rate
      - id: deceleration
        type: f4
        doc: Deceleration rate
      - id: size
        type: u4
        enum: race_data_size
        doc: Size information
      - id: head_biped_obj
        type: u4
        doc: Head biped object
      - id: hair_biped_obj
        type: u4
        doc: Hair biped object
      - id: injured_health_pc
        type: f4
        doc: Injured health percentage
      - id: shield_biped_obj
        type: u4
        doc: Shield biped object
      - id: health_regen
        type: f4
        doc: Health regeneration
      - id: magicka_regen
        type: f4
        doc: Magicka regeneration
      - id: stamina_regen
        type: f4
        doc: Stamina regeneration
      - id: unarmed_damage
        type: f4
        doc: Unarmed damage
      - id: unarmed_reach
        type: f4
        doc: Unarmed reach
      - id: body_biped_obj 
        type: u4
        doc: Body biped object
      - id: aim_angle_tolerance
        type: f4
        doc: Aim angle tolerance
      - type: u4
      - id: angular_acc_rate
        type: f4
        doc: Angular acceleration rate
      - id: angular_tolerance
        type: f4
        doc: Angular tolerance
      - id: hostile_flags
        type: race_data_hostile_flags
        doc: Hostility flags
      - id: unknown_ints
        type: u4
        repeat: expr
        repeat-expr: 9
        doc: Unknown integers
      - id: unknown_floats
        type: f4
        repeat: expr
        repeat-expr: 9
        doc: Unknown floats (only version 43 of form)
        if: _parent._parent.header.version == 43

  race_data_skill:
    seq:
      - id: index
        type: u1
        doc: Index to skill in Actor Value list
      - id: bonus
        type: u1
        doc: Racial bonus to indexed skill

  race_data_flags:
    seq:
      - id: flags
        type: u4
        doc: Racial flags (TODO)

  race_data_hostile_flags:
    seq:
      - type: b1
      - id: non_hostile
        type: b1
        doc: Indicates non hostile race
      - type: b30  

  race_anam_field:
    seq:
      - id: nif_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Relative path to .nif from Models directory

  race_mtnm_field:
    seq:
      - id: movement_type
        type: str
        encoding: UTF-8
        size: 4
        doc: Movement type code (WALK, RUN1, SNEK, BLD0, SWIM)

  race_vtck_field:
    seq:
      - id: voice_type
        type: u4
        repeat: expr
        repeat-expr: 2
        doc: FormIDs of associated male/female VTYP

  race_dnam_field:
    seq:
      - id: decapitation_armor
        type: u4
        repeat: expr
        repeat-expr: 2
        doc: FormIDs of assocated male/female ARMO

  race_hclf_field:
    seq:
      - id: hair_color
        type: u4
        repeat: expr
        repeat-expr: 2
        doc: FormIDs of associated male/female CLFM

###############################################################################
#                               SOUND (SOUN) FORM                             #
###############################################################################
  soun_form:
    seq:
      - id: fields
        type: soun_field
        repeat: eos
        doc: Fields contained by SOUN form

  soun_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"OBND"': obnd_field
            '"FNAM"': soun_fnam_field
            '"SNDD"': soun_sndd_field
            '"SNDC"': soun_sndc_field
        doc: Fields contained by SOUN form

  soun_fnam_field:
    seq:
      - id: file_name
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to .wav file

  soun_sndd_field:
    seq:
      - id: unknown
        size: 36
        doc: Unknown SNDD struct (no longer used)

  soun_sndc_field:
    seq:
      - id: sound_ref_form_id
        type: u4
        doc: Form ID of corresponding SNDR form

###############################################################################
#                          ACOUSTIC SPACE (ASPC) FORM                         #
###############################################################################
  aspc_form:
    seq:
      - id: fields
        type: aspc_field
        repeat: eos
        doc: Fields contained by ASPC form
  
  aspc_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"OBND"': obnd_field
            '"SNAM"': aspc_snam_field
            '"RDAT"': aspc_rdat_field
            '"BNAM"': aspc_bnam_field
        doc: Fields contained by ASPC form

  aspc_snam_field:
    seq:
      - id: ambient_sound
        type: u4
        doc: Form ID of associated ambient SNDR form

  aspc_rdat_field:
    seq:
      - id: region_data
        type: u4
        doc: Form ID of associated region sound REGN form
  
  aspc_bnam_field:
    seq:
      - id: reverb
        type: u4
        doc: Form ID of associated reverb REVB form

###############################################################################
#                            LAND TEXTURE (LTEX) FORM                         #
###############################################################################
  ltex_form:
    seq:
      - id: fields
        type: ltex_field
        repeat: eos
        doc: Fields contained by LTEX form

  ltex_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"TNAM"': ltex_tnam_field
            '"MNAM"': ltex_mnam_field
            '"HNAM"': ltex_hnam_field
            '"SNAM"': ltex_snam_field
            '"GNAM"': ltex_gnam_field
        doc: Fields contained by LTEX form

  ltex_tnam_field:
    seq:
      - id: texture_set
        type: u4
        doc: Form ID of associated TXST form
  
  ltex_mnam_field:
    seq:
      - id: material
        type: u4
        doc: Form ID of associated MATT form

  ltex_hnam_field:
    seq:
      - id: friction
        type: u1
        doc: Havok friction data
      - id: restitution
        type: u1
        doc: Havok restitution data

  ltex_snam_field:
    seq:
      - id: specular_exponent
        type: u1
        doc: Texture specular exponent (always 0x1E)

  ltex_gnam_field:
    seq:
      - id: grass
        type: u4
        doc: Form ID of associated GRAS form
