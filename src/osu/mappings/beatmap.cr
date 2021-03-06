module Osu
  struct Beatmap
    JSON.mapping({
      id:               {key: "beatmap_id", type: UInt32?, converter: StringConverter::UInt32},
      beatmapset_id:    {type: UInt32?, converter: StringConverter::UInt32},
      approval:         {key: "approved", type: API::Approval, converter: ApprovalConverter},
      total_length:     {type: UInt32?, converter: StringConverter::UInt32},
      hit_length:       {type: UInt32?, converter: StringConverter::UInt32},
      version:          String,
      md5:              {key: "file_md5", type: String},
      diff_size:        {type: Float32?, converter: StringConverter::Float32, getter: false, setter: false},
      diff_overall:     {type: Float32?, converter: StringConverter::Float32, getter: false, setter: false},
      diff_approach:    {type: Float32?, converter: StringConverter::Float32, getter: false, setter: false},
      diff_drain:       {type: UInt32?, converter: StringConverter::UInt32, getter: false, setter: false},
      mode:             {type: API::Mode, converter: ModeConverter},
      approved_date:    {type: Time?, converter: MaybeTimeConverter},
      last_update:      {type: Time, converter: TIME_FORMAT},
      artist:           String,
      title:            String,
      creator:          String,
      bpm:              {type: UInt32?, converter: StringConverter::UInt32},
      source:           String,
      tags:             {type: Array(String), converter: TagsConverter},
      genre_id:         {type: UInt32?, converter: StringConverter::UInt32},
      language_id:      {type: UInt32?, converter: StringConverter::UInt32},
      favourite_count:  {type: UInt32?, converter: StringConverter::UInt32},
      playcount:        {type: UInt32?, converter: StringConverter::UInt32},
      passcount:        {type: UInt32?, converter: StringConverter::UInt32},
      max_combo:        {type: UInt32?, converter: StringConverter::UInt32},
      difficultyrating: {type: Float32?, converter: StringConverter::Float32, getter: false, setter: false},
    })

    # The difficulty properties of this map, as a Difficulty struct
    def difficulty
      @difficulty ||= Difficulty.new(
        @diff_size,
        @diff_overall,
        @diff_approach,
        @diff_drain,
        @difficultyrating
      )
    end

    # URL to this beatmap
    def url
      "#{API::BASE_URL}/b/#{id}"
    end

    # URL to this beatmap's set
    def beatmap_set_url
      "#{API::BASE_URL}/s/#{beatmapset_id}"
    end
  end

  # Record representing a beatmap's difficulty properties
  record(
    Difficulty,
    size : Float32?,
    overall : Float32?,
    approach : Float32?,
    drain : UInt32?,
    rating : Float32?
  )
end
