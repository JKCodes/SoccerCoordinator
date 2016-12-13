
func selectNextTeamFrom(avgHeights heightList: [String: Double], teamSharks sharks: [[String: String]],
    teamDragons dragons: [[String: String]], teamRaptors raptors: [[String: String]]) -> String {
    
    // this function finds the index of the team that meets either the least number of members or the smallest average height criteria
    
    let lengthArray = [sharks.count, dragons.count, raptors.count]
    let lengthSum = sharks.count + dragons.count + raptors.count
    let minLength = lengthArray.min()!
    let minLengthIndex = lengthArray.index(of: minLength)!
    let heightArray = [heightList["sharks"]!, heightList["dragons"]!, heightList["raptors"]!]
    let minHeight = heightArray.min()!
    let minHeightIndex = heightArray.index(of: minHeight)!
    
    // Chooses the next team to insert a member into.. only uses average height for consideration IF
    // 1) member is not the very first player according to the originating loop
    // 2) there are equal number of members in each of the three teams
    
    if lengthSum == 0 ||  (sharks.count, dragons.count) != (dragons.count , raptors.count) {
        if minLengthIndex == 0 {
            return "sharks"
        } else if minLengthIndex == 1 {
            return "dragons"
        } else {
            return "raptors"
        }
    } else {
        if minHeightIndex == 0 {
            return "sharks"
        } else if minHeightIndex == 1 {
            return "dragons"
        } else {
            return "raptors"
        }
    }
}

func sortTeam(for team: [(index: Int, height: Int)]) -> [(index: Int, height: Int)] {
    
    // sorts descendingly - I looked into the documentation and found the .sort method for arrays.  I hope this is okay.
    // It was either this, or writing a sort algorithm.  If this isn't okay, let me know and I'll convert it into a bubble sort algorithm.
    
    return team.sorted( by: {
        player1, player2 in
        return player2.height < player1.height
    })
}

func generateLettersFor(teamArray team: [[String: String]], capitalizedTeamName name: String) -> [String] {
    
    // Generates, prints, and returns letters for a specified team
    
    var letters: [String] = []
    var letter = ""
    var iterator = 0
    var firstPractice = ""
    
    if name == "Sharks" {
        firstPractice = "March 17 at 3 PM"
    } else if name == "Dragons" {
        firstPractice = "March 17 at 1 PM"
    } else if name == "Raptors" {
        firstPractice = "March 18 at 1 PM"
    } else {
        
        // If invalid team name is found, it just returns an array with a single element
        
        letters = ["INVALID TEAM NAME DETECTED!!!"]
        return letters
    }
    
    while iterator < team.count {
        letter = "Hello, \(team[iterator]["guardian"]!).  "
        letter += "\(team[iterator]["name"]!) has been placed on Team \(name).  "
        letter += "The first scheduled practice is on \(firstPractice).  "
        letter += "Thank you, and I hope you have a great day."
        print(letter)
        letters.append(letter)
        iterator += 1
    }
    return letters
}

// The full roster - feel free to swap the members around to test
let players = [
                ["name": "Joe Smith", "height": "42", "experience": "YES", "guardian": "Jim and Jan Smith"],
                ["name": "Jill Tanner", "height": "36", "experience": "YES", "guardian": "Clara Tanner"],
                ["name": "Bill Bon", "height": "43", "experience": "YES", "guardian": "Sara and Jenny Bon"],
                ["name": "Eva Gordon", "height": "45", "experience": "NO", "guardian": "Wendy and Mike Gordon"],
                ["name": "Matt Gill", "height": "40", "experience": "NO", "guardian": "Charles and Sylvia Gill"],
                ["name": "Kimmy Stein", "height": "41", "experience": "NO", "guardian": "Bill and Hillary Stein"],
                ["name": "Sammy Adams", "height": "45", "experience": "NO", "guardian": "Jeff Adams"],
                ["name": "Karl Saygan", "height": "42", "experience": "YES", "guardian": "Heather Bledsoe"],
                ["name": "Suzane Greenberg", "height": "44", "experience": "YES", "guardian": "Henrietta Dumas"],
                ["name": "Sal Dali", "height": "41", "experience": "NO", "guardian": "Gala Dali"],
                ["name": "Joe Kavalier", "height": "39", "experience": "NO", "guardian": "Sam and Elaine Kavalier"],
                ["name": "Ben Finkelstein", "height": "44", "experience": "NO", "guardian": "Aaron and Jill Finkelstein"],
                ["name": "Diego Soto", "height": "41", "experience": "YES", "guardian": "Robin and Sarika Soto"],
                ["name": "Chloe Alaska", "height": "47", "experience": "NO", "guardian": "David and Jamie Alaska"],
                ["name": "Arnold Willis", "height": "43", "experience": "NO", "guardian": "Claire Willis"],
                ["name": "Phillip Helm", "height": "44", "experience": "YES", "guardian": "Thomas Helm and Eva Jones"],
                ["name": "Les Clay", "height": "42", "experience": "YES", "guardian": "Wynonna Brown"],
                ["name": "Herschel Krustofski", "height": "45", "experience": "YES", "guardian": "Hyman and Rachel Krustofski"]
            ]

// Initialization of the teams and letters
var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []
var letters: [String] = []

// Initialization of other variables such as iterators and intial values
var loopIterator = 0
var lowestHeightTeam = ""
var averageHeights: [String: Double] = ["sharks": 0.0, "dragons": 0.0, "raptors": 0.0]
var experiencedPlayers: [(index: Int, height: Int)] = []
var inexperiencedPlayers: [(index: Int, height: Int)] = []
var combinedPlayers: [(index: Int, height: Int)] = []
var sumHeightSharks: Int = 0
var sumHeightDragons: Int = 0
var sumHeightRaptors: Int = 0

// Separates experienced players and inexperienced players into two separate arrays using only name and height attributes

while loopIterator < players.count {
    if players[loopIterator]["experience"] == "YES" {
        experiencedPlayers.append((index: loopIterator, height: Int(players[loopIterator]["height"]!)!))
    }
    else {
        inexperiencedPlayers.append((index: loopIterator, height: Int(players[loopIterator]["height"]!)!))
    }
    loopIterator += 1
}

//  Sorts experiencedPlayers and inexperiencedPlayers in descending height order

experiencedPlayers = sortTeam(for: experiencedPlayers)
inexperiencedPlayers = sortTeam(for: inexperiencedPlayers)


//  Combines the two above players lists into one, simplified, players list

combinedPlayers = experiencedPlayers + inexperiencedPlayers

// Separates players into the three teams

loopIterator = 0

while loopIterator < combinedPlayers.count {
    lowestHeightTeam = selectNextTeamFrom(avgHeights: averageHeights, teamSharks: teamSharks, teamDragons: teamDragons, teamRaptors: teamRaptors)
    if lowestHeightTeam == "sharks" {
        teamSharks.append(players[combinedPlayers[loopIterator].index])
        sumHeightSharks += combinedPlayers[loopIterator].height
        averageHeights["sharks"] = Double(sumHeightSharks) / Double(teamSharks.count)
    } else if lowestHeightTeam == "dragons" {
        teamDragons.append(players[combinedPlayers[loopIterator].index])
        sumHeightDragons += combinedPlayers[loopIterator].height
        averageHeights["dragons"] = Double(sumHeightDragons) / Double(teamDragons.count)
        
    } else {
        teamRaptors.append(players[combinedPlayers[loopIterator].index])
        sumHeightRaptors += combinedPlayers[loopIterator].height
        averageHeights["raptors"] = Double(sumHeightRaptors) / Double(teamRaptors.count)
    }
    loopIterator += 1
}

// Prints Information about average team heights

print("------------------------------------------------")
print("Sorting and placement of players complete.")
print("The average height for Team Sharks = \(averageHeights["sharks"]!) inches.")
print("The average height for Team Dragons = \(averageHeights["dragons"]!) inches.")
print("The average height for Team Raptors = \(averageHeights["raptors"]!) inches.")
print("------------------------------------------------\n\n")


// Letters
print("-----------------   Letters   -----------------\n")
letters += generateLettersFor(teamArray: teamSharks, capitalizedTeamName: "Sharks")
letters += generateLettersFor(teamArray: teamDragons, capitalizedTeamName: "Dragons")
letters += generateLettersFor(teamArray: teamRaptors, capitalizedTeamName: "Raptors")
