//
//  ModelEnums.swift
//  StravaSwift
//
//  Created by MATTHEW CLARKSON on 23/05/2016.
//  Copyright © 2016 Matthew Clarkson. All rights reserved.
//


/**
 Athlete's gender
**/
public enum Sex: String {
    case Mail = "M", Female = "F"
}

/**
 Following status of the athlete
 **/
public enum FollowingStatus: String {
    case Pending = "pending", Accepted = "accepted", Blocked = "Blocked"
}

/**
 Athlete type (cyclist or runner)
 **/
public enum AthleteType: Int {
    case Cyclist, Runner
}

/**
 Measurement units (meters or feet)
 **/
public enum Units: String {
    case Feet = "feet", Meters = "meters"
}

/**
 Resource state (i.e. the level of detail of the response)
 **/
public enum ResourceState: Int {
    case Meta = 1, Summary = 2, Detailed = 3
}

/**
 The workout type
 **/
public enum WorkoutType: Int {
    case Run = 0, RaceRun = 1, LongRun = 3, WorkoutRun = 4
    case Ride = 10, RaceRide = 11, WorkoutRide = 12
}

/**
 Activity type
 **/
public enum ActivityType: String {
    case
    Ride, Run, Swim, Hike, Walk, AlpineSki, BackcountrySki, Canoeing, Crossfit, EBikeRide, Elliptical,
    IceSkate, InlineSkate, Kayaking, Yoga, Kitesurf, NordicSki, RockClimbing, RollerSki, Rowing,
    Snowboard, Snowshoe, StairStepper, StandUpPaddling, Surfing, VirtualRide, WeightTraining, Windsurf, Workout
}

/**
Sport type
 **/
public enum SportType: String {
    case Cycling = "cycling", Running = "running", Triathlon = "triathlon", Other = "other"
}

/**
 Club type
 **/
public enum ClubType: String {
    case CasualClub = "casual_club", RacingTeam = "racing_team", Shop = "shop", Company = "company", Other = "other"
}

/**
 Frame type (cycling only)
 **/
public enum FrameType: Int {
    case MTB = 1, Cross = 2, Road = 3, TimeTrial = 4
}

/**
 Resolution type
 **/
public enum ResolutionType: String {
    case Low = "low", Medium = "medium", High = "High"
}

/**
 Stream type (ie the data type)
 **/
public enum StreamType: String {
    case Time = "time",
    LatLng = "latlng",
    Distance = "distance",
    Altitude = "altitude",
    VelocitySmooth = "velocity_smooth",
    HeartRate = "heartrate",
    Cadence = "cadence",
    Watts = "watts",
    Temp = "temp",
    Moving = "moving",
    GradeSmooth = "grade_smooth"
    
    /**
     Description of the units associated with the stream
     **/
    var unit: String {
        switch self {
        case Time:
            return "integer seconds"
        case LatLng:
            return	"floats [latitude, longitude]"
        case Distance:
            return	"float meters"
        case Altitude:
            return "float meters"
        case VelocitySmooth:
            return "float meters per second"
        case HeartRate:
            return "integer BPM"
        case Cadence:
            return "integer RPM"
        case Watts:
            return "integer watts"
        case Temp:
            return "integer degrees Celsius"
        case Moving:
            return "boolean"
        case GradeSmooth:
            return "float percent"
        }
    }
}

/**
 Skill level
 **/
public enum SkillLevel: Int {
    case Casual = 1, Tempo = 2, Hammerfest = 4
}

/**
 Terrain description
 **/
public enum Terrain: Int {
    case MostlyFlat = 0, RollingHills = 1, KillerClimbs = 2
}

/**
 Photo source
 **/
public enum PhotoSource: Int {
    case Strava = 1, Instagram = 2
}

/**
 Achievement type
 **/
public enum AchievementType: String {
    case Overall = "overall", PR = "pr", YearOverall = "year_overall"
}




