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

  race_tinp_mask_type:
    0: none
    1: lip_color
    2: cheek_color
    3: eyeliner
    4: eye_socket_upper
    5: eye_socket_lower
    6: skin_tone
    7: paint
    8: laugh_lines
    9: cheek_color_lower
    10: nose
    11: chin
    12: neck
    13: forehead
    14: dirt
    15: unknown

  bodt_skill:
    0: light_armor
    1: heavy_armor
    2: none

  spgd_data_shader_type:
    0: rain
    1: snow_dust_fog

  clfm_fnam_playable:
    0: non_playable
    1: playable

  equp_data_enum:
    0: false
    1: true

  gras_data_distance_application:
    1: above_at_least
    2: above_at_most
    3: below_at_least
    4: below_at_most
    5: either_at_least
    6: either_at_most
    7: either_at_most_above
    8: either_at_most_below

  effect_cast_type:
    0: constant_effect
    1: fire_and_forget
    2: concentration

  effect_delivery:
    0: self
    1: touch
    2: aimed
    3: target_actor
    4: target_location

  ench_enit_enchant_type:
    0x06: enchantment
    0x0C: staff_enchantment

  spel_spit_spell_type:
    0x00: spell
    0x01: disease
    0x02: power
    0x03: lesser_power
    0x04: ability
    0x05: poison
    0x0A: addiction
    0x0B: voice

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
            '"ENCH"': ench_form
            '"SCRL"': scrl_form
            '"SPEL"': spel_form
            '"STAT"': stat_form
            '"GRAS"': gras_form
            '"TREE"': tree_form
            '"LVLN"': lvln_form
            '"IDLM"': idlm_form
            '"COBJ"': cobj_form
            '"HAZD"': hazd_form
            '"CLMT"': clmt_form
            '"SPGD"': spgd_form
            '"RFCT"': rfct_form
            '"LSCR"': lscr_form
            '"EFSH"': efsh_form
            '"FLST"': flst_form
            '"SHOU"': shou_form
            '"EQUP"': equp_form
            '"OTFT"': otft_form
            '"CLFM"': clfm_form
            '"REVB"': revb_form
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
  unknown_field_data:
    params:
      - id: data_size
        type: u2
    seq:
      - type: u1
        repeat: expr
        repeat-expr: data_size

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

  full_field:
    params:
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
    seq:
      - id: full
        type: lstring(data_size)
        doc: Full in-game text

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
        type: u2
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
        if: _parent.data_size >= 16
      - id: materials_count
        type: u4
        if: _parent.data_size >= 20
      - id: hashes
        type: modt_v40_texture_hash
        repeat: expr
        repeat-expr: (_parent.data_size - 20) / 12
        if: (_parent.data_size > 20)
      - id: unknown
        type: u4
        doc: Unknown
        if: _parent.data_size > 20

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
        type: bodt_node_flags
        doc: Body part node flags
      - id: flags
        type: bodt_flags
        doc: Further flags
      - id: skill
        type: u4
        enum: bodt_skill
        doc: Corresponding skill (heavy or light armor)
        if: data_size == 12

  bodt_node_flags:
    seq:
      - id: head
        type: b1
      - id: hair
        type: b1
      - id: body
        type: b1
      - id: hands
        type: b1
      - id: forearms
        type: b1
      - id: amulet
        type: b1
      - id: ring
        type: b1
      - id: feet
        type: b1
      - id: calves
        type: b1
      - id: shield
        type: b1
      - id: tail
        type: b1
      - id: long_hair
        type: b1
      - id: circlet
        type: b1
      - id: ears
        type: b1
      - id: body_addon_3
        type: b1
      - id: body_addon_4
        type: b1
      - id: body_addon_5
        type: b1
      - id: body_addon_6
        type: b1
      - id: body_addon_7
        type: b1
      - id: body_addon_8
        type: b1
      - id: decapitate_head
        type: b1
      - id: decapitate
        type: b1
      - id: body_addon_9
        type: b1
      - id: body_addon_10
        type: b1
      - id: body_addon_11
        type: b1
      - id: body_addon_12
        type: b1
      - id: body_addon_13
        type: b1
      - id: body_addon_14
        type: b1
      - id: body_addon_15
        type: b1
      - id: body_addon_16
        type: b1
      - id: body_addon_17
        type: b1
      - id: fx01
        type: b1

  bodt_flags:
    seq:
      - id: modulate_voice
        type: b1
      - type: b3
      - id: non_playable
        type: b1
      - type: b27

  modl_field:
    params:
      - id: data_size
        type: u2
    seq:
      - id: model_path
        type: strz
        encoding: UTF-8
        size: data_size
        doc: Model path

  mods_field:
    seq:
      - id: remaining_textures
        type: u4
      - id: alternate_textures
        type: mods_alternate_texture
        repeat: expr
        repeat-expr: remaining_textures

  mods_alternate_texture:
    seq:
      - id: string_length
        type: u4
        doc: Length of 3D name string
      - id: three_d_name
        type: str
        encoding: UTF-8
        size: string_length
        doc: 3D name
      - id: texture_id
        type: u4
        doc: Texture set (TXST) FormID
      - id: three_d_index
        type: u4
        doc: 3D index

  efid_field:
    seq:
      - id: effect_id
        type: u4
        doc: Magic effect MGEF FormID

  efit_field:
    seq:
      - id: magnitude
        type: f4
        doc: Magnitude
      - id: area_of_effect
        type: u4
        doc: Area of Effect
      - id: duration
        type: u4
        doc: Duration (0 = instant)

  coed_field:
    seq:
      - id: owner
        type: u4
        doc: Owner FACT or NPC_ FormID
      - id: value
        type: u4
        doc: NPC_ form, GLOB - FACT form, int32 value
      - id: item_condition
        type: f4
        doc: Item condition

  dest_field:
    seq:
      - id: destruction_data
        size: 8
        doc: Destruction Data


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
        doc: Alpha testing
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
            '"FULL"': full_field(data_size)
            '"DESC"': clas_desc_field
            '"ICON"': clas_icon_field
            '"DATA"': clas_data_field
        doc: Fields contained by CLAS form

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
            '"FULL"': full_field(data_size)
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
            '"FULL"': full_field(data_size)
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
        doc: Fields contained by HDPT form

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
            '"FULL"': full_field(data_size)
            '"ICON"': eyes_icon_field
            '"DATA"': eyes_data_field
        doc: Fields contained by EYES form

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
            '"FULL"': full_field(data_size)
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
            '"TINL"': race_tinl_field
            '"PNAM"': race_pnam_field
            '"UNAM"': race_unam_field
            '"ATKR"': race_atkr_field
            '"ATKD"': race_atkd_field
            '"ATKE"': race_atke_field
            '"INDX"': race_indx_field
            '"MODL"': race_modl_field
            '"GNAM"': race_gnam_field
            '"NAM4"': race_nam4_field
            '"NAM5"': race_nam5_field
            '"NAM7"': race_nam7_field
            '"ONAM"': race_onam_field
            '"LNAM"': race_lnam_field
            '"NAME"': race_name_field
            '"MTYP"': race_mtyp_field
            '"SPED"': race_sped_field
            '"VNAM"': race_vnam_field
            '"QNAM"': race_qnam_field
            '"UNES"': race_unes_field
            '"PHTN"': race_phtn_field
            '"PHWT"': race_phwt_field
            '"WKMV"': race_wkmv_field
            '"RNMV"': race_rnmv_field
            '"SWMV"': race_swmv_field
            '"FLMV"': race_flmv_field
            '"SNMV"': race_snmv_field
            '"SPMV"': race_spmv_field
            '"INDX"': race_indx_field
            '"HEAD"': race_head_field
            '"MPAI"': race_morph_information
            '"RPRM"': race_rprm_field
            '"AHCM"': race_ahcm_field
            '"FTSM"': race_ftsm_field
            '"DFTM"': race_dftm_field
            '"RPRF"': race_rprf_field
            '"AHCF"': race_ahcf_field
            '"FTSF"': race_ftsf_field
            '"DFTF"': race_dftf_field
            '"TINI"': race_tini_field
            '"TINT"': race_tint_field
            '"TINP"': race_tinp_field
            '"TIND"': race_tind_field
            '"TINC"': race_tinc_field
            '"TINV"': race_tinv_field
            '"TIRS"': race_tirs_field
            '"NAM8"': race_nam8_field
            '"RNAM"': race_rnam_field
            _: unknown_field_data(data_size)
        doc: Fields contained by RACE form

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
        repeat-expr: _parent.data_size - 128

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
        doc: Racial flags

  race_data_flags:
    seq:
      - id: playable
        type: b1
      - id: facegen_head
        type: b1
      - id: child
        type: b1
      - id: tilt_front_back
        type: b1
      - id: tilt_left_right
        type: b1
      - id: no_shadow
        type: b1
      - id: swims
        type: b1
      - id: flies
        type: b1
      - id: walks
        type: b1
      - id: immobile
        type: b1
      - id: not_pushable
        type: b1
      - id: no_combat_in_water
        type: b1
      - id: no_rotating_to_head_track
        type: b1
      - id: dont_show_blood_spray
        type: b1
      - id: dont_show_blood_decal
        type: b1
      - id: uses_head_track_anims
        type: b1
      - id: spells_align_with_magic_node
        type: b1
      - id: use_world_raycasts_for_foot_ik
        type: b1
      - id: allow_ragdoll_collision
        type: b1
      - id: regen_hp_in_combat
        type: b1
      - id: cant_open_doors
        type: b1
      - id: allow_pc_dialogue
        type: b1
      - id: no_knockdowns
        type: b1
      - id: allow_pickpocket
        type: b1
      - id: always_use_proxy_controller
        type: b1
      - id: dont_show_weapon_blood
        type: b1
      - id: overlay_head_part_list
        type: b1
      - id: override_head_part_list
        type: b1
      - id: can_pick_up_items
        type: b1
      - id: allow_multiple_membrane_shaders
        type: b1
      - id: can_dual_weild
        type: b1
      - id: avoids_roads
        type: b1

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

  race_tinl_field:
    seq:
      - id: tint_count
        type: u2
        doc: Number of tints available to race

  race_pnam_field:
    seq:
      - id: facegen_main_clamp
        type: f4
        doc: Facegen main clamp

  race_unam_field:
    seq:
      - id: facegen_face_clamp
        type: f4
        doc: Facegen face clamp

  race_atkr_field:
    seq:
      - id: attack_race
        type: u4
        doc: FormID

  race_atkd_field:
    seq:
      - id: damage_multiplier
        type: f4
        doc: Attack damage multiplier
      - id: attack_change
        type: f4
        doc: Attack chance
      - id: attack_spell
        type: u4
        doc: FormID of associated attack spell
      - id: flags
        type: race_atkd_flags
        doc: Attack flags (Identifies attacks)
      - id: attack_angle
        type: f4
        doc: Attack angle
      - id: strike_angle
        type: f4
        doc: Strike angle
      - id: stagger
        type: f4
        doc: Stagger chance
      - id: attack_type
        type: u4
        doc: FormID of associated attack
      - id: knockdown
        type: f4
        doc: Knockdown chance
      - id: recovery_time
        type: f4
        doc: Recovery time
      - id: fatigue_multiplier
        type: f4
        doc: Fatigue multiplier

  race_atkd_flags:
    seq:
      - id: ignore_weapon
        type: b1
      - id: bash_attack
        type: b1
      - id: power_attack
        type: b1
      - id: left_attack
        type: b1
      - id: rotating_attack
        type: b1
      - type: b27

  race_atke_field:
    seq:
      - id: attack_name
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Attack name

  race_indx_field:
    seq:
      - id: unknown
        type: u4
        doc: Unknown purpose, always 0 (precedes .egt models)

  race_modl_field:
    seq:
      - id: lighting_model
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to model (.egt or .hkx)

  race_gnam_field:
    seq:
      - id: body_part_data
        type: u4
        doc: FormID of associated BPTD

  race_nam4_field:
    seq:
      - id: material_type
        type: u4
        doc: FormID of associated MATT

  race_nam5_field:
    seq:
      - id: impact_data_set
        type: u4
        doc: FormID of associated unarmed IDPS

  race_nam7_field:
    seq:
      - id: decapitation_fx
        type: u4
        doc: FormID of associated blood fx ARTO (if race can be decapitated)

  race_onam_field:
    seq:
      - id: open_loot_sound
        type: u4
        doc: FormID of associated SNDR for opening as loot

  race_lnam_field:
    seq:
      - id: close_loot_sound
        type: u4
        doc: FormID of associated SNDR for closing as loot

  race_name_field:
    seq:
      - id: biped_object_name
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Name of biped object, can be set in CK

  race_mtyp_field:
    seq:
      - id: movement_type
        type: u4
        doc: FormID of associated MOVT form

  race_sped_field:
    seq:
      - id: left_walk
        type: f4
        doc: Left walk speed override
      - id: left_run
        type: f4
        doc: Left run speed override
      - id: right_walk
        type: f4
        doc: Right walk speed override
      - id: right_run
        type: f4
        doc: Right run speed override
      - id: forward_walk
        type: f4
        doc: Forward walk speed override
      - id: forward_run
        type: f4
        doc: Forward run speed override
      - id: back_walk
        type: f4
        doc: Back walk speed override
      - id: back_run
        type: f4
        doc: Back run speed override
      - id: rotate_walk_1
        type: f4
        doc: Rotate walk speed override
      - id: rotate_walk_2
        type: f4
        doc: Rotate walk speed override
      - id: unknown
        type: f4
        doc: Unknown floating point value

  race_vnam_field:
    seq:
      - id: equipment_flags
        type: race_vnam_equipment_flags
        doc: Race equipment flags

  race_vnam_equipment_flags:
    seq:
      - id: hand_to_hand
        type: b1
      - id: one_h_sword
        type: b1
      - id: one_h_dagger
        type: b1
      - id: one_h_axe
        type: b1
      - id: one_h_mace
        type: b1
      - id: two_h_sword
        type: b1
      - id: two_h_axe
        type: b1
      - id: bow
        type: b1
      - id: staff
        type: b1
      - id: spell
        type: b1
      - id: shield
        type: b1
      - id: torch
        type: b1
      - id: crossbow
        type: b1
      - type: b19

  race_qnam_field:
    seq:
      - id: equip_slot
        type: u4
        doc: FormID of associated EQUP

  race_unes_field:
    seq:
      - id: unarmed_equip_slot
        type: u4
        doc: FormID of associated EQUP for unarmed

  race_phtn_field:
    seq:
      - id: phoneme_target_name
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Phoneme target name

  race_phwt_field:
    seq:
      - id: phoneme_weights_dragon
        type: race_phwt_weights_dragon
        if: _parent.data_size == 32
        doc: Dragon-unique phoneme weights
      - id: phoneme_weights
        type: race_phwt_weights
        if: _parent.data_size == 64
        doc: Phoneme weights

  race_phwt_weights_dragon:
    seq:
      - id: lip_big_aah
        type: f4
        doc: Lip big aah
      - id: lip_dst
        type: f4
        doc: Lip D/S/T
      - id: lip_eee
        type: f4
        doc: Lip eee
      - id: lip_fv
        type: f4
        doc: Lip F/V
      - id: lip_k
        type: f4
        doc: Lip K
      - id: lip_l
        type: f4
        doc: Lip L
      - id: lip_r
        type: f4
        doc: Lip R
      - id: lip_th
        type: f4
        doc: Lip Th

  race_phwt_weights:
    seq:
      - id: aah
        type: f4
        doc: Aah
      - id: big_aah
        type: f4
        doc: Big aah
      - id: bmp
        type: f4
        doc: B/M/P
      - id: ch_j_sh
        type: f4
        doc: Ch/J/Sh
      - id: dst
        type: f4
        doc: D/S/T
      - id: eee
        type: f4
        doc: Eee
      - id: eh
        type: f4
        doc: Eh
      - id: fv
        type: f4
        doc: F/V
      - id: i
        type: f4
        doc: I
      - id: k
        type: f4
        doc: K
      - id: n
        type: f4
        doc: N
      - id: oh
        type: f4
        doc: Oh
      - id: ooh_q
        type: f4
        doc: Ooh/Q
      - id: r
        type: f4
        doc: R
      - id: th
        type: f4
        doc: Th
      - id: w
        type: f4
        doc: W

  race_wkmv_field:
    seq:
      - id: default_walk
        type: u4
        doc: FormID of associated MOVT form for walk behaviour

  race_rnmv_field:
    seq:
      - id: default_run
        type: u4
        doc: FormID of associated MOVT form for run behaviour

  race_swmv_field:
    seq:
      - id: default_swim
        type: u4
        doc: FormID of associated MOVT form for swim behaviour

  race_flmv_field:
    seq:
      - id: default_fly
        type: u4
        doc: FormID of associated MOVT form for fly behaviour

  race_snmv_field:
    seq:
      - id: default_sneak
        type: u4
        doc: FormID of associated MOVT form for sneak behaviour

  race_spmv_field:
    seq:
      - id: default_sprint
        type: u4
        doc: FormID of associated MOVT form for sprint behaviour

  race_indx_field:
    seq:
      - id: index
        type: u4
        if: _parent.data_size > 0
        doc: List index

  race_head_field:
    seq:
      - id: default_head_part
        type: u4
        doc: FormID of associated default HDPT form

  race_morph_information:
    seq:
      - id: mpai_nose
        type: race_mpai_field(1)
        doc: MPAI field 1 (nose)
      - id: mpav_nose
        type: race_mpav_field(1)
        doc: MPAV field 1 (nose)
      - id: mpai_brow
        type: race_mpai_field(0)
        doc: MPAI field 2 (brow)
      - id: mpav_brow
        type: race_mpav_field(2)
        doc: MPAV field 2 (brow)
      - id: mpai_eyes
        type: race_mpai_field(0)
        doc: MPAI field 3 (eyes)
      - id: mpav_eyes
        type: race_mpav_field(3)
        doc: MPAV field 3 (eyes)
      - id: mpai_lip
        type: race_mpai_field(0)
        doc: MPAI field 4 (lips)
      - id: mpav_lip
        type: race_mpav_field(4)
        doc: MPAV field 4 (lip)

  race_mpai_field:
    params:
      - id: first_field
        type: u1
        doc: Indicates first appearance of this field
    seq:
      - id: type
        contents: "MPAI"
        doc: MPAI type code
        if: first_field == 0
      - id: data_size
        type: u2
        doc: Size, in bytes, of MPAI field data (minus header)
        if: first_field == 0
      - id: available_morph_index
        type: u4
        doc: Available morph index

  race_mpav_field:
    params:
      - id: occurence
        type: u1
        doc: Number of field occurence
    seq:
      - id: type
        contents: "MPAV"
        doc: MPAV type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of MPAV field (minus header)
      - id: flags
        type:
          switch-on: occurence
          cases:
            1: mpav_nose_flags
            2: mpav_brow_flags
            3: mpav_eye_flags
            4: mpav_lip_flags
        doc: Morph flags

  mpav_nose_flags:
    seq:
      - id: nose_type_0
        type: b1
      - id: nose_type_1
        type: b1
      - id: nose_type_2
        type: b1
      - id: nose_type_3
        type: b1
      - id: nose_type_4
        type: b1
      - id: nose_type_5
        type: b1
      - id: nose_type_6
        type: b1
      - id: nose_type_7
        type: b1
      - id: nose_type_8
        type: b1
      - id: nose_type_9
        type: b1
      - id: nose_type_10
        type: b1
      - id: nose_type_11
        type: b1
      - id: nose_type_12
        type: b1
      - id: nose_type_13
        type: b1
      - id: nose_type_14
        type: b1
      - id: nose_type_15
        type: b1
      - id: nose_type_16
        type: b1
      - id: nose_type_17
        type: b1
      - id: nose_type_18
        type: b1
      - id: nose_type_19
        type: b1
      - id: nose_type_20
        type: b1
      - id: nose_type_21
        type: b1
      - id: nose_type_22
        type: b1
      - id: nose_type_23
        type: b1
      - id: nose_type_24
        type: b1
      - id: nose_type_25
        type: b1
      - id: nose_type_26
        type: b1
      - id: nose_type_27
        type: b1
      - id: nose_type_28
        type: b1
      - id: nose_type_29
        type: b1
      - id: nose_type_30
        type: b1
      - id: nose_type_31
        type: b1
      - id: unknown
        type: u4
        repeat: expr
        repeat-expr: 7

  mpav_brow_flags:
    seq:
      - id: brow_type_0
        type: b1
      - id: brow_type_1
        type: b1
      - id: brow_type_2
        type: b1
      - id: brow_type_3
        type: b1
      - id: brow_type_4
        type: b1
      - id: brow_type_5
        type: b1
      - id: brow_type_6
        type: b1
      - id: brow_type_7
        type: b1
      - id: brow_type_8
        type: b1
      - id: brow_type_9
        type: b1
      - id: brow_type_10
        type: b1
      - id: brow_type_11
        type: b1
      - id: brow_type_12
        type: b1
      - id: brow_type_13
        type: b1
      - id: brow_type_14
        type: b1
      - id: brow_type_15
        type: b1
      - id: brow_type_16
        type: b1
      - id: brow_type_17
        type: b1
      - id: brow_type_18
        type: b1
      - id: brow_type_19
        type: b1
      - id: brow_type_20
        type: b1
      - type: b11
      - id: unknown
        type: u4
        repeat: expr
        repeat-expr: 7

  mpav_eye_flags:
    seq:
      - id: eye_type_0
        type: b1
      - id: eye_type_1
        type: b1
      - id: eye_type_2
        type: b1
      - id: eye_type_3
        type: b1
      - id: eye_type_4
        type: b1
      - id: eye_type_5
        type: b1
      - id: eye_type_6
        type: b1
      - id: eye_type_7
        type: b1
      - id: eye_type_8
        type: b1
      - id: eye_type_9
        type: b1
      - id: eye_type_10
        type: b1
      - id: eye_type_11
        type: b1
      - id: eye_type_12
        type: b1
      - id: eye_type_13
        type: b1
      - id: eye_type_14
        type: b1
      - id: eye_type_15
        type: b1
      - id: eye_type_16
        type: b1
      - id: eye_type_17
        type: b1
      - id: eye_type_18
        type: b1
      - id: eye_type_19
        type: b1
      - id: eye_type_20
        type: b1
      - id: eye_type_21
        type: b1
      - id: eye_type_22
        type: b1
      - id: eye_type_23
        type: b1
      - id: eye_type_24
        type: b1
      - id: eye_type_25
        type: b1
      - id: eye_type_26
        type: b1
      - id: eye_type_27
        type: b1
      - id: eye_type_28
        type: b1
      - id: eye_type_29
        type: b1
      - id: eye_type_30
        type: b1
      - id: eye_type_31
        type: b1
      - id: eye_type_32
        type: b1
      - id: eye_type_33
        type: b1
      - id: eye_type_34
        type: b1
      - id: eye_type_35
        type: b1
      - id: eye_type_36
        type: b1
      - id: eye_type_37
        type: b1
      - id: eye_type_38
        type: b1
      - type: b25
      - id: unknown
        type: u4
        repeat: expr
        repeat-expr: 6

  mpav_lip_flags:
    seq:
      - id: lip_type_0
        type: b1
      - id: lip_type_1
        type: b1
      - id: lip_type_2
        type: b1
      - id: lip_type_3
        type: b1
      - id: lip_type_4
        type: b1
      - id: lip_type_5
        type: b1
      - id: lip_type_6
        type: b1
      - id: lip_type_7
        type: b1
      - id: lip_type_8
        type: b1
      - id: lip_type_9
        type: b1
      - id: lip_type_10
        type: b1
      - id: lip_type_11
        type: b1
      - id: lip_type_12
        type: b1
      - id: lip_type_13
        type: b1
      - id: lip_type_14
        type: b1
      - id: lip_type_15
        type: b1
      - id: lip_type_16
        type: b1
      - id: lip_type_17
        type: b1
      - id: lip_type_18
        type: b1
      - id: lip_type_19
        type: b1
      - id: lip_type_20
        type: b1
      - id: lip_type_21
        type: b1
      - id: lip_type_22
        type: b1
      - id: lip_type_23
        type: b1
      - id: lip_type_24
        type: b1
      - id: lip_type_25
        type: b1
      - id: lip_type_26
        type: b1
      - id: lip_type_27
        type: b1
      - id: lip_type_28
        type: b1
      - id: lip_type_29
        type: b1
      - id: lip_type_30
        type: b1
      - id: lip_type_31
        type: b1
      - id: unknown
        type: u4
        repeat: expr
        repeat-expr: 7

  race_rprm_field:
    seq:
      - id: preset_male_npc
        type: u4
        doc: FormID of associated NPC_ form

  race_ahcm_field:
    seq:
      - id: available_hair_color_male
        type: u4
        doc: FormID of associated CLFM form

  race_ftsm_field:
    seq:
      - id: face_details_textureset_male
        type: u4
        doc: FormID of associated TXST form

  race_dftm_field:
    seq:
      - id: default_face_texture_male
        type: u4
        doc: FormID of associated TXST form

  race_rprf_field:
    seq:
      - id: preset_npc_female
        type: u4
        doc: FormID of associated NPC_ form

  race_ahcf_field:
    seq:
      - id: available_hair_color_female
        type: u4
        doc: FormID of associated CLFM form

  race_ftsf_field:
    seq:
      - id: face_details_textureset_female
        type: u4
        doc: FormID of associated TXST form

  race_dftf_field:
    seq:
      - id: default_face_texture_female
        type: u4
        doc: FormID of associated TXST form

  race_tini_field:
    seq:
      - id: tint_index
        type: u2
        doc: Ascending record index

  race_tint_field:
    seq:
      - id: tint_mask
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to tint mask .dds

  race_tinp_field:
    seq:
      - id: mask_type
        type: u2
        enum: race_tinp_mask_type
        doc: Tint mask type

  race_tind_field:
    seq:
      - id: preset_default
        type: u4
        doc: Default preset default color FormID (CLFM)

  race_tinc_field:
    seq:
      - id: preset
        type: u4
        doc: Preset color FormID (CLFM)

  race_tinv_field:
    seq:
      - id: default_value
        type: f4
        doc: Default value of preceding TINC field

  race_tirs_field:
    seq:
      - id: index
        type: u2
        doc: Number of tint

  race_nam8_field:
    seq:
      - id: morph_race
        type: u4
        doc: Morph RACE FormID

  race_rnam_field:
    seq:
      - id: armor_race
        type: u4
        doc: Armor race FormID

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

###############################################################################
#                            ENCHANTMENT (ENCH) FORM                          #
###############################################################################
  ench_form:
    seq:
      - id: fields
        type: ench_field
        repeat: eos
        doc: Fields contained by ENCH form

  ench_field:
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
            '"FULL"': full_field(data_size)
            '"ENIT"': ench_enit_field
            '"EFID"': efid_field
            '"EFIT"': efit_field
            '"CIS2"': cis2_field(data_size)
            '"CTDA"': ctda_field
        doc: Fields contained by ENCH form

  ench_enit_field:
    seq:
      - id: enchantment_cost
        type: u4
        doc: Enchantment cost
      - id: flags
        type: ench_enit_flags
        doc: Enchantment flags
      - id: cast_type
        type: u4
        enum: effect_cast_type
        doc: Cast type enumeration
      - id: enchantment_amount
        type: u4
        doc: Fully charged value
      - id: delivery
        type: u4
        enum: effect_delivery
        doc: Effect delivery method
      - id: enchant_type
        type: u4
        enum: ench_enit_enchant_type
        doc: Enchantment type
      - id: charge_time
        type: f4
        doc: Charge time
      - id: base_enchantment
        type: u4
        doc: Base enchantment ENCH formID
      - id: worn_restrictions
        type: u4
        doc: FLST of enchantable slots
        if: _parent.data_size == 36

  ench_enit_flags:
    seq:
      - id: manual_calc
        type: b1
      - type: b1
      - id: extend_duration_on_recast
        type: b1
      - type: b29

###############################################################################
#                               SCROLL (SCRL) FORM                            #
###############################################################################
  scrl_form:
    seq:
      - id: fields
        type: scrl_field
        repeat: eos
        doc: Fields contained by SCRL form

  scrl_field:
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
            '"FULL"': full_field(data_size)
            '"KSIZ"': scrl_ksiz_field
            '"KWDA"': scrl_kwda_field
            '"MDOB"': scrl_mdob_field
            '"ETYP"': scrl_etyp_field
            '"DESC"': scrl_desc_field
            '"MODL"': modl_field(data_size)
            '"YNAM"': scrl_ynam_field
            '"ZNAM"': scrl_znam_field
            '"DATA"': scrl_data_field
            '"SPIT"': scrl_spit_field
            '"DEST"': dest_field
            '"EFID"': efid_field
            '"EFIT"': efit_field
            '"CTDA"': ctda_field
        doc: Fields contained by SCRL form

  scrl_ksiz_field:
    seq:
      - id: keyword_count
        type: u4
        doc: Count of KYWD formIDs in following KWDA field

  scrl_kwda_field:
    seq:
      - id: keyword
        type: u4
        repeat: expr
        repeat-expr: _parent.data_size / 4
        doc: KYWD formIDs

  scrl_mdob_field:
    seq:
      - id: menu_icon
        type: u4
        doc: Menu display object STAT FormID

  scrl_etyp_field:
    seq:
      - id: equip_type
        type: u4
        doc: Equip slot EQUP formID

  scrl_desc_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: In-game description

  # TODO: Produce the YNAM and ZNAM fields from SNDR

  scrl_ynam_field:
    seq:
      - id: pickup_sound
        type: u4
        doc: Pickup sound

  scrl_znam_field:
    seq:
      - id: drop_sound
        type: u4
        doc: Drop sound

  scrl_data_field:
    seq:
      - id: value
        type: u4
        doc: Scroll value
      - id: weight
        type: f4
        doc: Scroll weight

  scrl_spit_field:
    seq:
      - id: spell_cost
        type: u4
        doc: Spell Cost
      - id: flags
        type: scrl_spit_flags
        doc: Scrl item flags
      - id: unknown_1
        type: u4
        doc: Unknown - Always 0?
      - id: charge_time
        type: f4
        doc: Charge time
      - id: unknown_2
        type: u4
        doc: Unknown - Always 0x03 or 0x02
      - id: target_type
        type: u4
        enum: effect_delivery   # Uses the same enum as effect_delivery
        doc: Target type
      - id: unknown_3
        type: u4
        doc: Unknown - Always 0?
      - id: unknown_4
        type: u4
        doc: Unknown - Always 0?
      - id: unknown_5
        type: u4
        doc: Unknown - Always 0?

  scrl_spit_flags:
    seq:
      - id: manual_calc
        type: b1
      - type: b18
      - id: area_effect_ignores_los
        type: b1
      - id: script_effect_always_applies
        type: b1
      - id: no_absorb_reflect
        type: b1
      - id: force_touch_explode
        type: b1
      - type: b2

###############################################################################
#                               SPELL (SPEL) FORM                             #
###############################################################################
  spel_form:
    seq:
      - id: fields
        type: spel_field
        repeat: eos
        doc: Fields contained by SPEL form

  spel_field:
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
            '"FULL"': full_field(data_size)
            '"MDOB"': spel_mdob_field
            '"ETYP"': spel_etyp_field
            '"DESC"': spel_desc_field
            '"SPIT"': spel_spit_field
            '"EFID"': efid_field
            '"EFIT"': efit_field
            '"CIS2"': cis2_field(data_size)
            '"CTDA"': ctda_field
        doc: Fields contained by SPEL form

  spel_mdob_field:
    seq:
      - id: menu_icon
        type: u4
        doc: Menu display object STAT FormID

  spel_etyp_field:
    seq:
      - id: equip_type
        type: u4
        doc: Equip slot EQUP FormID

  spel_desc_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: In-game description

  spel_spit_field:
    seq:
      - id: spell_cost
        type: u4
        doc: Spell cost
      - id: flags
        type: spel_spit_flags
        doc: Spell item flags
      - id: spell_type
        type: u4
        enum: spel_spit_spell_type
        doc: Spell type
      - id: charge_time
        type: f4
        doc: Charge time
      - id: cast_type
        type: u4
        enum: effect_cast_type
        doc: Cast type enumeration
      - id: delivery
        type: u4
        enum: effect_delivery
        doc: Spell delivery method
      - id: cast_duration
        type: f4
        doc: Minimum duration of a concentrated spell
      - id: range
        type: f4
        doc: Range
      - id: perk
        type: u4
        doc: PERK FormID

  spel_spit_flags:
    seq:
      - id: not_auto_calibrate
        type: b1
      - type: b15
      - id: unknown_1
        type: b1
      - id: pc_start_spell
        type: b1
      - id: unknown_2
        type: b1
      - id: area_effect_ignores_los
        type: b1
      - id: ignore_resistance
        type: b1
      - id: disallow_spell_absorb_reflect
        type: b1
      - id: unknown_3
        type: b1
      - id: no_dual_cast_modifications
        type: b1
      - type: b8

###############################################################################
#                               STATIC (STAT) FORM                            #
###############################################################################
  stat_form:
    seq:
      - id: fields
        type: stat_field
        repeat: eos
        doc: Fields contained by STAT form

  stat_field:
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
            '"MODL"': modl_field(data_size)
            '"MODT"': modt_field(data_size)
            '"MODS"': mods_field
            '"DNAM"': stat_dnam_field
            '"MNAM"': stat_mnam_field
        doc: Fields contained by STAT form

  stat_dnam_field:
    seq:
      - id: max_angle
        type: f4
        doc: Max angle (30-120 degrees)
      - id: directional_material
        type: u4
        doc: FormID of directional material MATO form

  stat_mnam_field:
    seq:
      - id: lod_model_1
        type: str
        encoding: UTF-8
        size: 260
        doc: LOD model 1 (High Detail)
      - id: load_model_2
        type: str
        encoding: UTF-8
        size: 260
        doc: LOD model 2
      - id: lod_model_3
        type: str
        encoding: UTF-8
        size: 260
        doc: LOD model 3
      - id: load_model_4
        type: str
        encoding: UTF-8
        size: 260
        doc: LOD model 4 (Low Detail)

###############################################################################
#                               GRASS (GRAS) FORM                             #
###############################################################################
  gras_form:
    seq:
      - id: fields
        type: gras_field
        repeat: eos
        doc: Fields contained by GRAS form

  gras_field:
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
            '"MODL"': modl_field(data_size)
            '"MODT"': modt_field(data_size)
            '"DATA"': gras_data_field
        doc: Fields contained by GRAS form

  gras_data_field:
    seq:
      - id: density
        type: u1
        doc: Density
      - id: min_slope
        type: u1
        doc: Min slope
      - id: max_slope
        type: u1
        doc: Max slope
      - id: unused_1
        type: u1
        doc: Unused byte
      - id: distance_from_water
        type: u2
        doc: Distance from water
      - id: unused_2
        type: u2
        doc: Unused short
      - id: distance_application
        type: u4
        enum: gras_data_distance_application
        doc: How to apply distance from water
      - id: position_range
        type: f4
        doc: Position range
      - id: height_range
        type: f4
        doc: Height range
      - id: color_range
        type: f4
        doc: Color range
      - id: wave_period
        type: f4
        doc: Wave period
      - id: flags
        type: gras_data_flags

  gras_data_flags:
    seq:
      - id: vertex_lighting
        type: b1
      - id: uniform_scaling
        type: b1
      - id: fit_to_slope
        type: b1
      - type: b29


###############################################################################
#                                TREE (TREE) FORM                             #
###############################################################################
  tree_form:
    seq:
      - id: fields
        type: tree_field
        repeat: eos
        doc: Fields contained by TREE form

  tree_field:
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
            '"MODL"': modl_field(data_size)
            '"MODT"': modt_field(data_size)
            '"PFIG"': tree_pfig_field
            '"SNAM"': tree_snam_field
            '"PFPC"': tree_pfpc_field
            '"FULL"': full_field(data_size)
            '"CNAM"': tree_cnam_field
        doc: Fields contained by TREE form

  tree_pfig_field:
    seq:
      - id: result_item
        type: u4
        doc: FormID of resultant INGR/ALCH object

  tree_snam_field:
    seq:
      - id: activation_sound
        type: u4
        doc: FormID of activation SNDR

  tree_pfpc_field:
    seq:
      - id: percent_chance
        size: 4
        doc: Always 100 with PFIG or 0 without

  tree_cnam_field:
    seq:
      - id: trunk_flex
        type: f4
        doc: Trunk flexibility
      - id: branch_flex
        type: f4
        doc: Branch flexibility
      - id: unknown_float
        type: f4
        repeat: expr
        repeat-expr: 8
        doc: Unknown floats
      - id: leaf_amplitude
        type: f4
        doc: Leaf amplitude
      - id: leaf_frequency
        type: f4
        doc: Leaf frequency

###############################################################################
#                            LEVELED ACTOR (LVLN) FORM                        #
###############################################################################
  lvln_form:
    seq:
      - id: fields
        type: lvln_field
        repeat: eos
        doc: Fields contained by LVLN form

  lvln_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: Unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"OBND"': obnd_field
            '"LVLD"': lvln_lvld_field
            '"LVLF"': lvln_lvlf_field
            '"LLCT"': lvln_llct_field
            '"LVLO"': lvln_lvlo_field
            '"COED"': coed_field
            '"MODL"': modl_field(data_size)
        doc: Fields contained by LVLN field

  lvln_lvld_field:
    seq:
      - id: chance_none
        type: u1
        doc: Chance for item not to spawn (not in CK, always 0)

  lvln_lvlf_field:
    seq:
      - id: flags
        type: lvln_lvlf_flags
        doc: Leveled actor flags

  lvln_lvlf_flags:
    seq:
      - id: all_levels
        type: b1
      - id: each
        type: b1
      - type: b6

  lvln_llct_field:
    seq:
      - id: list_count
        type: u1
        doc: Number of LVLO entries

  lvln_lvlo_field:
    seq:
      - id: level
        type: u4
        doc: Entry level set
      - id: entry
        type: u4
        doc: NPC_ or LVLN FormID
      - id: enemy_spawn_count
        type: u4
        doc: Number of enemies to spawn (always 1, not editable in CK)

###############################################################################
#                             IDLE MARKER (IDLM) FORM                         #
###############################################################################
  idlm_form:
    seq:
      - id: fields
        type: idlm_field
        repeat: eos
        doc: Fields contained by IDLM form

  idlm_field:
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
            '"IDLF"': idlm_idlf_field
            '"IDLC"': idlm_idlc_field
        doc: Fields contained by IDLM form

  idlm_idlf_field:
    seq:
      - id: flags
        type: idlm_idlf_flags
        doc: Flags

  idlm_idlf_flags:
    seq:
      - id: in_sequence
        type: b1
      - type: b1
      - id: do_once
        type: b1
      - id: edited
        type: b1
        doc: Editing in CK sets this flag
      - id: ignored_by_sandbox
        type: b1
      - type: b3

  idlm_idlc_field:
    seq:
      - id: animation_count
        type: u8
        doc: Animation count
      - id: idle_timer_setting
        type: f4
        doc: Idle timer setting
      - id: idle_animation
        type: u4
        repeat: eos
        doc: Idle animation (IDLE) FormID

###############################################################################
#                        CONSTRUCTIBLE OBJECT (COBJ) FORM                     #
###############################################################################
  cobj_form:
    seq:
      - id: fields
        type: cobj_field
        repeat: eos
        doc: Fields contained by COBJ form

  cobj_field:
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
            '"COCT"': cobj_coct_field
            '"CNTO"': cobj_cnto_field
            '"COED"': coed_field
            '"CTDA"': ctda_field
            '"CNAM"': cobj_cnam_field
            '"BNAM"': cobj_bnam_field
            '"NAM1"': cobj_nam1_field
        doc: Fields contained by COBJ form

  cobj_coct_field:
    seq:
      - id: object_count
        type: u4
        doc: Number of input objects (CNTO fields) required

  cobj_cnto_field:
    seq:
      - id: item
        type: u4
        doc: FormID of INGR required to craft
      - id: quantity
        type: u4
        doc: Quantity needed of linked INGR object

  cobj_cnam_field:
    seq:
      - id: output_object
        type: u4
        doc: FormID of resulting output object

  cobj_bnam_field:
    seq:
      - id: bench_keyword
        type: u4
        doc: KYWD FormID

  cobj_nam1_field:
    seq:
      - id: output_quantity
        type: u2
        doc: Quantity of output object created by recipe

###############################################################################
#                               HAZARD (HAZD) FORM                            #
###############################################################################
  hazd_form:
    seq:
      - id: fields
        type: hazd_field
        repeat: eos
        doc: Fields contained by HAZD form

  hazd_field:
    seq:
      - id: type
        type: str
        encoding: UTF-8
        size: 4
        doc: unique type code
      - id: data_size
        type: u2
        doc: Size, in bytes, of field (minus header)
      - id: data
        type:
          switch-on: type
          cases:
            '"EDID"': edid_field(data_size)
            '"OBND"': obnd_field
            '"FULL"': full_field(data_size)
            '"MODL"': modl_field(data_size)
            '"MODT"': modt_field(data_size)
            '"MNAM"': hazd_mnam_field
            '"DATA"': hazd_data_field
        doc: Fields contained by HAZD form

  hazd_mnam_field:
    seq:
      - id: image_space_modifier
        type: u4
        doc: Linked IMAD FormID

  hazd_data_field:
    seq:
      - id: limit
        type: u4
        doc: Limit
      - id: radius
        type: f4
        doc: Radius
      - id: lifetime
        type: f4
        doc: Lifetime
      - id: image_space_radius
        type: f4
        doc: Image space radius
      - id: target_interval
        type: f4
        doc: Target interval
      - id: flags
        type: hazd_data_flags
        doc: Flags
      - id: spell
        type: u4
        doc: Linked SPEL FormID
      - id: light
        type: u4
        doc: Linked LIGH FormID
      - id: impact_data_set
        type: u4
        doc: Linked IPDS FormID
      - id: sound
        type: u4
        doc: Linked SNDR FormID

  hazd_data_flags:
    seq:
      - id: affects_player_only
        type: b1
      - id: inherit_duration_from_spawn_spell
        type: b1
      - id: align_to_impact_normal
        type: b1
      - id: inherit_radius_from_spawn_spell
        type: b1
      - id: drop_to_ground
        type: b1
      - type: b27

###############################################################################
#                               CLIMATE (CLMT) FORM                           #
###############################################################################
  clmt_form:
    seq:
      - id: fields
        type: clmt_field
        repeat: eos
        doc: Fields contained by CLMT form

  clmt_field:
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
            '"WLST"': clmt_wlst_field
            '"FNAM"': clmt_fnam_field
            '"GNAM"': clmt_gnam_field
            '"TNAM"': clmt_tnam_field
            '"MODL"': modl_field(data_size)
            '"MODT"': modt_field(data_size)
        doc: Fields contained by CLMT form

  clmt_wlst_field:
    seq:
      - id: weather
        type: u4
        doc: Weather (WTHR) FormID
      - id: percent_chance
        type: u4
        doc: Chance of weather in percent
      - id: global_variable
        type: u4
        doc: Global variable (GLOB) FormID

  clmt_fnam_field:
    seq:
      - id: sun_texture
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to sun texture

  clmt_gnam_field:
    seq:
      - id: glare_texture
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to glare texture

  clmt_tnam_field:
    seq:
      - id: sunrise_begin
        type: u1
        doc: Sunrise begin (times 10 minutes)
      - id: sunrise_end
        type: u1
        doc: Sunrise end (times 10 minutes)
      - id: sunset_begin
        type: u1
        doc: Sunset begin (times 10 minutes)
      - id: sunset_end
        type: u1
        doc: Sunset end (times 10 minutes)
      - id: volatility
        type: u1
        doc: Volatility
      - id: moon_phase
        type: b6
        doc: Moon phase length in days
      - id: masser_flag
        type: b1
        doc: Masser present flag
      - id: secunda_flag
        type: b1
        doc: Secunda_present_flag

###############################################################################
#                      SHADER PARTICLE GEOMETRY (SPGD) FORM                   #
###############################################################################
  spgd_form:
    seq:
      - id: fields
        type: spgd_field
        repeat: eos
        doc: Fields contained by SPGD form

  spgd_field:
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
            '"DATA"': spgd_data_field
            '"ICON"': spgd_icon_field
        doc: Fields contained by SPGD form

  spgd_data_field:
    seq:
      - id: gravity_velocity
        type: f4
        doc: Gravity velocity
      - id: rotation_velocity
        type: f4
        doc: Rotation velocity
      - id: particle_size_x
        type: f4
        doc: Particle size X
      - id: particle_size_y
        type: f4
        doc: Particle size Y
      - id: center_offset_min
        type: f4
        doc: Center offset min
      - id: center_offset_max
        type: f4
        doc: Center offset max
      - id: initial_rotation_range
        type: f4
        doc: Initial rotation range
      - id: n_subtextures_x
        type: u4
        doc: Number of subtextures (X)
      - id: n_subtextures_y
        type: u4
        doc: Number of subtextures (Y)
      - id: shader_type
        type: u4
        enum: spgd_data_shader_type
        doc: Shader type
      - id: box_size
        type: u4
        if: _parent.data_size > 40
        doc: Box size
      - id: particle_density
        type: f4
        if: _parent.data_size > 40
        doc: Particle density

  spgd_icon_field:
    seq:
      - id: texture_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to particle texture

###############################################################################
#                            VISUAL EFFECT (RFCT) FORM                        #
###############################################################################
  rfct_form:
    seq:
      - id: fields
        type: rfct_field
        repeat: eos
        doc: Fields contained by RFCT form

  rfct_field:
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
            '"DATA"': rfct_data_field

  rfct_data_field:
    seq:
      - id: effect_art
        type: u4
        doc: Effect art object (ARTO) FormID
      - id: shader
        type: u4
        doc: Effect shader (EFSH) FormID
      - id: flags
        type: rfct_data_flags
        doc: Effect flags

  rfct_data_flags:
    seq:
      - id: rotate_to_face_target
        type: b1
      - id: attach_to_camera
        type: b1
      - id: inherit_rotation
        type: b1
      - type: b29

###############################################################################
#                           EFFECT SHADER (EFSH) FORM                         #
###############################################################################
  efsh_form:
    seq:
      - id: fields
        type: efsh_field
        repeat: eos
        doc: Fields contained by EFSH form

  efsh_field:
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
            '"ICON"': efsh_icon_field
            '"ICO2"': efsh_ico2_field
            '"NAM7"': efsh_nam7_field
            '"NAM8"': efsh_nam8_field
            '"NAM9"': efsh_nam9_field
            '"DATA"': unknown_field_data(data_size)        #TODO (look at TES5Edit for this one)

  efsh_icon_field:
    seq:
      - id: start_effect
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to start effect .dds

  efsh_ico2_field:
    seq:
      - id: looped_effect
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to looped effect .dds

  efsh_nam7_field:
    seq:
      - id: post_effect
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to post effect .dds

  efsh_nam8_field:
    seq:
      - id: looped_gradient
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to looped gradient .dds

  efsh_nam9_field:
    seq:
      - id: end_gradient
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to end_gradient .dds

###############################################################################
#                            LOAD SCREEN (LSCR) FORM                          #
###############################################################################
  lscr_form:
    seq:
      - id: fields
        type: lscr_field
        repeat: eos
        doc: Fields contained by LSCR form

  lscr_field:
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
            '"DESC"': lscr_desc_field
            '"CTDA"': ctda_field
            '"NNAM"': lscr_nnam_field
            '"SNAM"': lscr_snam_field
            '"RNAM"': lscr_rnam_field
            '"ONAM"': lscr_onam_field
            '"XNAM"': lscr_xnam_field
            '"MOD2"': lscr_mod2_field
        doc: Fields contained by LSCR form

  lscr_desc_field:
    seq:
      - id: screen_text
        type: lstring(_parent.data_size)
        doc: Text displayed on load screen

  lscr_nnam_field:
    seq:
      - id: screen_model
        type: u4
        doc: Static model (STAT) FormID

  lscr_snam_field:
    seq:
      - id: initial_scale
        type: f4
        doc: Initial scale of screen model

  lscr_rnam_field:
    seq:
      - id: initial_rotation_x
        type: u2
        doc: Initial model rotation X
      - id: initial_rotation_y
        type: u2
        doc: Initial model rotation Y
      - id: initial_rotation_z
        type: u2
        doc: Initial model rotation Z

  lscr_onam_field:
    seq:
      - id: min_rotation
        type: u2
        doc: Minimum model rotation
      - id: max_rotation
        type: u2
        doc: Maximum model rotation

  lscr_xnam_field:
    seq:
      - id: initial_offset_x
        type: u2
        doc: Initial model offset X
      - id: initial_offset_y
        type: u2
        doc: Initial model offset Y
      - id: initial_offset_z
        type: u2
        doc: Initial model offset Z

  lscr_mod2_field:
    seq:
      - id: camera_path
        type: strz
        encoding: UTF-8
        size: _parent.data_size
        doc: Path to camera .nif

###############################################################################
#                             FORM LIST (FLST) FORM                           #
###############################################################################
  flst_form:
    seq:
      - id: fields
        type: flst_field
        repeat: eos
        doc: Fields contained by FLST form

  flst_field:
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
            '"LNAM"': flst_lnam_field
        doc: Fields contained by FLST form

  flst_lnam_field:
    seq:
      - id: object
        type: u4
        doc: FormID belonging to form list

###############################################################################
#                                SHOUT (SHOU) FORM                            #
###############################################################################
  shou_form:
    seq:
      - id: fields
        type: shou_field
        repeat: eos
        doc: Fields contained by SHOU form

  shou_field:
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
            '"FULL"': full_field(data_size)
            '"MDOB"': shou_mdob_field
            '"DESC"': shou_desc_field
            '"SNAM"': shou_snam_field
        doc: Fields contained by SHOU form

  shou_mdob_field:
    seq:
      - id: model
        type: u4
        doc: FormID of STAT model shown in inventory

  shou_desc_field:
    seq:
      - id: description
        type: lstring(_parent.data_size)
        doc: Description (0 if none)

  shou_snam_field:
    seq:
      - id: word_of_power
        type: u4
        doc: Associated WOOP FormID
      - id: spell_effect
        type: u4
        doc: Associated SPEL FormID
      - id: recovery_time
        type: f4
        doc: Shout recovery time

###############################################################################
#                             EQUIP SLOT (EQUP) FORM                          #
###############################################################################
  equp_form:
    seq:
      - id: fields
        type: equp_field
        repeat: eos
        doc: Fields contained by EQUP form

  equp_field:
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
            '"PNAM"': equp_pnam_field
        doc: Fields contained by EQUP form

  equp_pnam_field:
    seq:
      - id: parent
        type: u4
        repeat: eos
        doc: FormIDs of EQUP parents

  equp_data_field:
    seq:
      - id: use_all_parents
        type: u4
        enum: equp_data_enum
        doc: Use all parents in PNAM

###############################################################################
#                               OUTFIT (OTFT) FORM                            #
###############################################################################
  otft_form:
    seq:
      - id: fields
        type: otft_field
        repeat: eos
        doc: Fields contained by OTFT form

  otft_field:
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
            '"INAM"': otft_inam_field
        doc: Fields contained by OTFT form

  otft_inam_field:
    seq:
      - id: inventory_form
        type: u4
        repeat: eos
        doc: Form in inventory list (either ARMO or LVLI)

###############################################################################
#                                COLOR (CLFM) FORM                            #
###############################################################################
  clfm_form:
    seq:
      - id: fields
        type: clfm_field
        repeat: eos
        doc: Fields contained by CLFM form

  clfm_field:
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
            '"FULL"': full_field(data_size)
            '"CNAM"': color
            '"FNAM"': clfm_fnam_field
        doc: Fields contained by CLFM form

  clfm_fnam_field:
    seq:
      - id: playable
        enum: clfm_fnam_playable
        type: u4
        doc: Playable enum

###############################################################################
#                               REVERB (REVB) FORM                            #
###############################################################################
  revb_form:
    seq:
      - id: fields
        type: revb_field
        repeat: eos
        doc: Fields contained by REVB form

  revb_field:
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
            '"DATA"': revb_data_field
        doc: Fields contained by REVB form

  revb_data_field:
    seq:
      - id: decay_time
        type: u2
        doc: Decay time (ms)
      - id: hf_reference
        type: u2
        doc: HF reference (Hz)
      - id: room_filter
        type: s1
        doc: Room filter
      - id: room_hf_filter
        type: s1
        doc: Room HF filter
      - id: reflections
        type: s1
        doc: Reflections
      - id: reverb_amp
        type: s1
        doc: Reverb amplitude
      - id: decay_hf_ratio
        type: u1
        doc: Decay HF ratio (x100)
      - id: scaled_reflect_delay
        type: u1
        doc: Scaled reflect delay (scaled by ~0.83)
      - id: reverb_delay
        type: u1
        doc: Reverb delay (ms)
      - id: diffusion_pct
        type: u1
        doc: Diffusion percentage
      - id: density_pct
        type: u1
        doc: Density percentage
      - id: unknown
        type: u1
        doc: Unknown integer (usually zero)
