From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
Date: Thu, 4 Oct 2018 18:43:17 +0530
Message-ID: <3bbb160d-6963-ba97-710f-41247cff53b6@codeaurora.org>
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
 <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com>
 <8f26b82c-b966-11d3-4fb6-0137a0a8cd4a@codeaurora.org>
 <CAE=gft52RWSibZRPukRX_L7ACOSUnqHc0FbsoCSvzAr=My-1kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft52RWSibZRPukRX_L7ACOSUnqHc0FbsoCSvzAr=My-1kA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, linux-mmc@vger.kernel.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, Doug Anderson <dianders@google.com>, vviswana@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 9/22/2018 1:36 AM, Evan Green wrote:
> On Fri, Sep 21, 2018 at 3:32 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> Hi Evan,
>>
>>
>> On 9/21/2018 5:45 AM, Evan Green wrote:
>>> On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
>>> <vbadigan@codeaurora.org> wrote:
>>>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>>>
>>>> The load a particular sdhc controller should request from a regulator
>>>> is device specific and hence each device should individually vote for
>>>> the required load.
>>>>
>>>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>>>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> index 502b3b8..3720385 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>> @@ -26,6 +26,11 @@ Required properties:
>>>>           "cal"   - reference clock for RCLK delay calibration (optional)
>>>>           "sleep" - sleep clock for RCLK delay calibration (optional)
>>>>
>>>> +Optional properties:
>>>> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
>>>> +                                       BUS_OFF states in power irq. Should be specified in
>>>> +                                       pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>>>> +                                       Units uA.
>>>>    Example:
>>>>
>>>>           sdhc_1: sdhci@f9824900 {
>>>> @@ -37,6 +42,7 @@ Example:
>>>>
>>>>                   vmmc-supply = <&pm8941_l20>;
>>>>                   vqmmc-supply = <&pm8941_s3>;
>>>> +               qcom,vqmmc-current-level-microamp = <200 22000>;
>>>>
>>>>                   pinctrl-names = "default";
>>>>                   pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
>>>> --
>>>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>>>
>>> Aren't the regulator load levels pretty coarse? Would it be safe to
>>> say that pretty much all sd/mmc devices need the high powered mode, or
>>> are there really some devices that can get by with LPM all the time?
>>> -Evan
>> The load levels here are min and max supported by the regulator. To
>> cover all devices
>> we do set it to max load. We can't make any assumptions on this,  as
>> peak current may vary
>> from device to device.
> Hi Veera,
> If it were up to me, I would just assume all devices need high power
> mode for BUS_ON and low power mode for BUS_OFF, and skip adding this
> binding until you actually came up with a device that needed lower
> power mode for BUS_ON, or high power mode for BUS_OFF (when would that
> be, anyway?) Are there any actual use cases you've seen that need
> different values in here?
> -Evan

Hi Evan,
With the present implementation if these load values are not supplied in 
dt, its not setting
any load at all. Without setting  load, I'm observing CRC/timeout/tuning 
errors.
I can update the code to fallback to default values when these are not 
supplied in dt, but these values
will be different from SD card and eMMC devices.
So, this dt binding is needed.

Thanks
Veera
