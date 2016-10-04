From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Tue, 4 Oct 2016 15:03:56 +0530
Message-ID: <c12ab329-f3cb-b346-45c6-e5603aeb5fc8@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
 <20160825222747.GU19826@codeaurora.org>
 <1a44bb54-d88c-737d-7fb1-e7c3597ac03b@codeaurora.org>
 <20160907161428.GY12510@codeaurora.org>
 <f40ac4e7-7e12-26e2-254a-99b6e5d25cd3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcJDJeG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2016 05:34:06 -0400
In-Reply-To: <f40ac4e7-7e12-26e2-254a-99b6e5d25cd3@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org

Hi Stephen/Adrian,

Let me give a little background on this. We would need more suggestions 
and opinion on this. Sorry for the delay it took.


Background -
Below change adds clk-rates DT entry since sdhci-msm driver uses this 
clk-rates table to find the nearest *floor* value of clock (this clock 
request comes will come from core layer) supported by msm platform.

Currently we don't have an API from clock driver which we can use it 
here to find these values(supported by msm platforms) and call for 
clk_set_rate. Hence the custom DT entry to have a table.

Please let us know if there is an API to find the floor value of clock 
from clock driver. I tried clk_set_max_rate, but it is not giving 
expected output (at least for msm platforms).


Comment-
The request from Stephen was to check if we could utilize OppV2 
framework since it provides an API - dev_pm_opp_find_freq_floor.
Also to check if we could get it done from existing clock driver APIs.
Please correct me I am missing anything.


Concern and opinion?
1. What about if there are more clocks getting added to sdhci DT node?
I see the Oppv2 framework taking device pointer as 1st argument. In 
cases where we have more than 1 clocks per device, how will Oppv2 handle 
this?
2. Here the concern is that shifting to Oppv2 framework only for use of 
this 1 API does not seems very useful. In case if there exist a clock 
driver API to do this, we may not have anything to be populated in DT.


Opinion and suggestions please?
Is it ok to continue to use clk-rates DT entry here for this case?


Regards
Ritesh


On 9/12/2016 11:47 AM, Ritesh Harjani wrote:
> Hi Stephen,
>
>
> On 9/7/2016 9:44 PM, Stephen Boyd wrote:
>> On 08/30, Ritesh Harjani wrote:
>>> On 8/26/2016 3:57 AM, Stephen Boyd wrote:
>>>> On 08/24, Ritesh Harjani wrote:
>>>>> This adds support for sdhc-msm controllers to get supported
>>>>> clk-rates from DT. sdhci-msm would need it's own set_clock
>>>>> ops to be implemented. For this, supported clk-rates needs
>>>>> to be populated in sdhci_msm_pltfm_data.
>>>>>
>>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>>> ---
>>>>
>>>> Please include the DT binding review list in binding updates.
> Sure, will do it.
>
>>>>
>>>>> .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
>>>>> drivers/mmc/host/sdhci-msm.c                       | 60
>>>>> ++++++++++++++++++++++
>>>>> 2 files changed, 61 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> index 485483a..6a83b38 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> @@ -17,6 +17,7 @@ Required properties:
>>>>>     "iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock)
>>>>> (required)
>>>>>     "core"    - SDC MMC clock (MCLK) (required)
>>>>>     "bus"    - SDCC bus voter clock (optional)
>>>>> +- clk-rates: Array of supported GCC clock frequencies for sdhc,
>>>>> Units - Hz.
>>>>>
>>>>
>>>> Why not use OPPv2 binding for this? We already have a way to
>>>> express frequencies for devices with that binding, and we'll need
>>>> to attach voltages to those frequencies at some point in the
>>>> future if we want to handle DVFS on these devices.
>>>>
>>> OPPv2 may not work out in this case. This was also discussed at [1].
>>> These clk-rates are not as per voltage points(or any OPP) but as per
>>> bus speed mode request from higher layer.
>>>
>>
>> That post you link to had a response from Andy that echoed the
>> same sentiment and then no reply.
>>
>> Are they a set of frequencies the device can operate at? Yes. Do
>> they have associated voltages that aren't expressed in this
>> patch? Yes.
>>
>> Perhaps I've missed something though and the index of the array
>> of rates corresponds to some bus speed mode? That isn't clearly
>> expressed in the binding. Do the frequencies come from some spec
>> for those bus speed modes? Either way, I'd like to understand why
>> we need to put frequency tables into DT (hint: the commit text
>> should explain that).
>>
> As discussed offline, I will get back on this.
>
> Regards
> Ritesh
