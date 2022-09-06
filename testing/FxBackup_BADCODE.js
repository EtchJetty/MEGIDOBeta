// Yes I used Javascript for this, fuck you

let text = document.getElementById("input").value
document.getElementById("output").value = ""

let ani = text.split("}").map(x => x + "}")
ani.pop()

let ManualGodAssign = {
  Lightning: "Zeus"
}

let ManualValueAssign = {
  BoonDissipateGlow: 2,
  BoonDissipateVertical: 2,
  BoonDissipateB: 2,
  BoonDissipateA: 2,
  
  BoonDropGOD: 0,
  "BoonDropA-GOD": 2,
  "BoonDropB-GOD": 2,
  "BoonDropC-GOD": 0,
  "BoonDropGODIcon": 1,
}

let ManualValueIgnore = [
  "BoonDropGODIcon"
]

let red = [255, 0, 0]

let head = "{\n  Animations = {\n    \"_sequence\" = true\n    \/* if a table has the name of the god in it's Name, it has already been converted */"
let tail = "\n  }\n}"

let hsLookup = {
  Aphrodite: [ // Roxy
    [241, 65, 239], // Text
    [0, 19, 75], // Symbol
    [3, 52, 118], // BG
  ],
  Artemis: [ // Jane
    [0, 213, 242], // Text
    [118, 195, 78], // Symbol
    [204, 195, 180], // BG
  ],
  Ares: [ // Dirk
    [242, 164, 0], // Text
    [189, 24, 100], // Symbol
    [85, 20, 42], // BG
  ],
  Athena: [ // Rose
    [181, 54, 218], // Text
    [247, 250, 78], // Symbol
    [240, 132, 12], // BG
  ],
  Chaos: [ // Eridan
    [106, 0, 106], // Text
    [155, 77, 173], // Symbol
    [82, 12, 97], // BG
  ],
  Demeter: [ // Dave
    [224, 7, 7], // Text
    [255, 35, 6], // Symbol
    [183, 13, 14], // BG
  ],
  Dionysus: [ // Jake
    [31, 148, 0], // Text
    [255, 224, 148], // BG
    [253, 253, 253], // Symbol
  ],
  Hermes: [ // June
    [7, 21, 205], // Text
    [16, 223, 255], // Symbol
    [67, 121, 230], // BG
  ],
  Poseidon: [ // Vriska
    [0, 86, 130], // Text
    [0, 86, 130], // Symbol
    [0, 86, 130], // BG
  ],
  Zeus: [ // Jade
    [0, 0, 0], // BG
    [74, 201, 37], // Text
    [0, 0, 0], // BG
  ]
}

let rgb = ["Red", "Green", "Blue"]
let rgbPrefix = ["Start", "", "End"]

let convertToJSON = string => string.replace(/^(.|\n)+?{/, "{").replace(/</g, '"ResetMe"').replace(/ =/g, "\":").replace(">", "").replace(/\n/g, ",\"").replace("{,", "{").replace(",\"}", "}")

let convertToSJSON = string => {
  string = string.replace(/"(?<key>[^,]+?)":/g, '$<key> = ').replace(/"(?<key>[\d.]+?)"/g, '$<key>').replace(/,/g, ",\n").replace("{", "{\n")
  if (string.includes('"ResetMe"')) {
    string = string.replace('"ResetMe",', "{") + "\n}"
  }
  return string
}

ani.forEach((e, i)=> {
  let god = ""
  for (const [key, value] of Object.entries(hsLookup)) {
    god = e.includes(key) ? key : god
  }
  if (!god) {
    for (const [key, value] of Object.entries(ManualGodAssign)) {
      god = e.includes(key) && !god ? value : god
    }
  }
  
  let number = i
  e = convertToJSON(e)
  let jsonFormat = JSON.parse(e)
  //console.log(jsonFormat.Name)
  
  if (god) {   
    let colors = hsLookup[god]

    let Basecolors = colors

    for (const [key, value] of Object.entries(ManualValueAssign)) {
      if (jsonFormat["Name"].includes(key.replace("GOD", god))) {

        let newColors = 
          god == "Zeus" ? [Basecolors[0], Basecolors[2].fill(255), Basecolors[1]] 
          : god == "Dionysus" ? [Basecolors[0], Basecolors[2], Basecolors[1]] 
          : Basecolors

        colors = value == 4 ? [red,red,red] : [newColors[value], newColors[value], newColors[value]]
        console.log("Vriska " + key)
      }
    }

    if (!ManualValueIgnore.map(e => e.replace("GOD", god)).includes(jsonFormat["Name"])) {
      colors.forEach((rgbSet, i) => {
        rgbSet.forEach((colour, j) => {
            jsonFormat[rgbPrefix[i] + rgb[j]] = ("" + (colour / 255)).substring(0,4)
          })
      })
    }

  }
  
  if (Object.keys(jsonFormat).length > 1) {
    let output = convertToSJSON(JSON.stringify(jsonFormat))
  	document.getElementById("output").value += "\n" + number + " = " + output
  }
})

document.getElementById("output").value = head + document.getElementById("output").value + tail