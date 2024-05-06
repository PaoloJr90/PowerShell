# ----------------------------------------------
# Begin Process End
# ----------------------------------------------

function Get-PipelineBeginEnd {
    param (
        [string]$SomeInput
    )
    begin { # will initialize some steps at the start
        "Begin: The input is $SomeInput"
    }
    process { # will process each object as received
        "The value is: $_"
    }
    end { # can perform cleanup
        "End:   The input is $SomeInput"
    }
}#Get-PipelineBeginEnd

1, 2, 3 | Get-PipelineBeginEnd -SomeInput 'Test'