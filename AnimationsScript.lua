-- AnimationsScript.lua

-- Variables for the pulsing effect
local minAlpha = 0
local maxAlpha = 255
local pulseSpeed = 0.01
local currentAlpha = minAlpha
local increasing = true
local pulsingEnabled = false

-- Variables for Glitch Animation
math.randomseed(os.time())

local glitchCharacters = { "_", "`", "@", "#", "$", "%", "&", "*", "!", "?" }
local glitchProbability = 0.05         -- Lower probability for glitch
local glitchCycle = 0
local glitchEvery = 10                 -- Glitch every 10 updates
local glitchEnabled = false
local originalText = "Md Mehadi Hasan" -- Default text

-- Variables for Bounce Animation
local bounceSpeed = 0.05 -- Speed of the bounce
local bounceHeight = 10  -- Height of the bounce
local bouncePhase = 0    -- Initial phase for the bounce effect
local bounceEnabled = false


function Initialize()
    -- Retrieve configuration variables
    pulsingEnabled = SKIN:GetVariable("PulseAnimation", "") == "1"
    glitchEnabled = SKIN:GetVariable("GlitchAnimation", "") == "1"
    bounceEnabled = SKIN:GetVariable("BounceAnimation", "") == "1"

    -- Retrieve the 'Text' variable from the [Variables] section
    originalText = SKIN:GetVariable("Text", originalText)

    -- Debugging: Log the originalText to check if it's retrieved correctly
    SKIN:Bang('!Log', 'Original text retrieved: ' .. originalText)
end

function Update()
    if pulsingEnabled then
        PulseAnimation()
    end

    if glitchEnabled then
        GlitchAnimation()
    end

    if bounceEnabled then
        BounceAnimation()
    end
end

function PulseAnimation()
    -- Adjust the alpha value for the pulsing effect
    if increasing then
        currentAlpha = currentAlpha + pulseSpeed * 255
        if currentAlpha >= maxAlpha then
            currentAlpha = maxAlpha
            increasing = false
        end
    else
        currentAlpha = currentAlpha - pulseSpeed * 255
        if currentAlpha <= minAlpha then
            currentAlpha = minAlpha
            increasing = true
        end
    end

    -- Set the meter's alpha value dynamically
    SKIN:Bang("!SetOption", "TextMeter", "FontColor", string.format("255,255,255,%d", currentAlpha))
    SKIN:Bang("!UpdateMeter", "TextMeter")
end

function GlitchAnimation()
    glitchCycle = (glitchCycle + 1) % glitchEvery

    if glitchCycle == 0 and originalText ~= "" then
        local glitchedText = ""

        for i = 1, #originalText do
            local currentChar = originalText:sub(i, i)
            if currentChar ~= " " and math.random() < glitchProbability then
                -- Replace with a random character for glitch effect
                glitchedText = glitchedText .. glitchCharacters[math.random(#glitchCharacters)]
            else
                -- Keep the original character or space
                glitchedText = glitchedText .. currentChar
            end
        end

        -- Set the glitched text to the meter dynamically
        SKIN:Bang('!SetOption', 'TextMeter', 'Text', glitchedText)
        SKIN:Bang('!UpdateMeter', 'TextMeter')
        SKIN:Bang('!Redraw')
    end

    -- Restore the original text periodically
    if glitchCycle == glitchEvery / 2 then
        SKIN:Bang('!SetOption', 'TextMeter', 'Text', originalText)
        SKIN:Bang('!UpdateMeter', 'TextMeter')
        SKIN:Bang('!Redraw')
    end
end

function BounceAnimation()
    -- Update bounce phase
    bouncePhase = (bouncePhase + bounceSpeed) % (2 * math.pi)

    -- Calculate the vertical offset using a sine wave
    local bounceOffset = math.sin(bouncePhase) * bounceHeight

    -- Set the meter's Y position dynamically
    SKIN:Bang("!SetOption", "TextMeter", "Y", tostring(100 + bounceOffset)) -- Adjust the base Y position as needed
    SKIN:Bang("!UpdateMeter", "TextMeter")
end

