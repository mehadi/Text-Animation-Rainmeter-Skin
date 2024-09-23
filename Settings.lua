function Initialize()
    text = SKIN:GetVariable('Text')
    -- Get the state of the Glitch Animation
    gs = SKIN:GetVariable('GlitchAnimation')
    ip = gs == "1" and "images/checkbox.png" or "images/unchecked.png"
    SKIN:Bang("!SetOption", 'GlitchAnimationCheckbox', "ImageName", ip)
    -- Get the state of the Pulse Animation
    ps = SKIN:GetVariable('PulseAnimation')
    ipPulse = ps == "1" and "images/checkbox.png" or "images/unchecked.png"
    SKIN:Bang("!SetOption", 'PulseAnimationCheckbox', "ImageName", ipPulse)
    -- Get the state of the Bounce Animation
    bs = SKIN:GetVariable('BounceAnimation')
    ipBounce = bs == "1" and "images/checkbox.png" or "images/unchecked.png"
    SKIN:Bang("!SetOption", 'BounceAnimationCheckbox', "ImageName", ipBounce)

    -- Update the skin to reflect changes
    SKIN:Bang("!UpdateMeter", "*")
    SKIN:Bang("!Redraw")

end

function Update()
    return text
end

function ChangeText(value)
    key = "Text"
    print("User Input Received: " .. value)
    if value then
        text = value
        -- Update the Config.ini file
        SKIN:Bang('!WriteKeyValue', 'Variables', key, text, 'Config.ini')
        SKIN:Bang('!Refresh')
    end
end

function saveSettings(value, fontFace)
    -- Set the new value to the MyVariable variable
    print("User Input Received: " .. value)
    print("User Input Received: " .. fontFace)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'Text', value, 'Config.ini')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'FontFace', fontFace, 'Config.ini')
    SKIN:Bang('!SetVariable', 'UserInput', value)
    SKIN:Bang('!SetVariable', 'FontInput', fontFace)
    SKIN:Bang('!Refresh')
end

function toggleAnimation(animationName, checkboxImageMeter)
    -- Read the current value of the variable
    local animationValue = SKIN:GetVariable(animationName)

    -- Toggle the value (if 1, change to 0; if 0, change to 1)
    if animationValue == "1" then
        animationValue = "0"
    else
        animationValue = "1"
    end

    -- Update the variable in Rainmeter
    SKIN:Bang("!SetVariable", animationName, animationValue)

    -- Write the updated value to Config.ini for persistence
    SKIN:Bang("!WriteKeyValue", "Variables", animationName, animationValue, "Config.ini")

    -- Update the checkbox image based on the new value (checked vs faded)
    local imagePath = animationValue == "1" and "images/checkbox.png" or "images/unchecked.png"
    SKIN:Bang("!SetOption", checkboxImageMeter, "ImageName", imagePath)

    -- Update the skin to reflect changes
    SKIN:Bang("!UpdateMeter", "*")
    SKIN:Bang("!Redraw")
end

