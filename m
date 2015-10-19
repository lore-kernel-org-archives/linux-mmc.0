From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Mon, 19 Oct 2015 16:39:45 +0800
Message-ID: <5624AC51.9060907@rock-chips.com>
References: <1441961698-10516-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpwgZSkE+TNehZ1Un=5CfjoEtfvELfrS6t-ZHZPscy3Yg@mail.gmail.com>
 <56243E85.2040202@rock-chips.com>
 <CAPDyKFpkH00roc=Nn067PufmQL59wqsi1c58tdv_UyP-7Gs-vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpkH00roc=Nn067PufmQL59wqsi1c58tdv_UyP-7Gs-vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, S?ren Brinkmann <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2015/10/19 15:50, Ulf Hansson wrote:
> [...]
>
>>> I understand the phy is optional, but you still need to handle the
>>> EPROBE_DEFER case.
>>>
>>> Perhaps you should also use devm_phy_optional_get() instead!?
>>
>>
>> I already changed it in version-2 [1]. :)
>> phy is mandatory for sdhci-arasan,5.1.
>>
>> [1]: https://patchwork.kernel.org/patch/7173251/
>
> Oh, apologize for reviewing the old version!
>
>>
>>>
>>>> +               ret = phy_power_on(sdhci_arasan->phy);
>>>
>>>
>>> This looks a bit weird. Shouldn't you do phy_init() prior phy_power_on()?
>>>
>>> Similar comment applies to phy_exit() and phy_power_off().
>>
>>
>> Both are okay. It depends how the phy-driver implement the four interfaces.
>>  From my case, power_on for arasan's phy driver firstly enable phy's clk and
>> open power-domain, then programme phy internal registers to activate phy.
>> Without enabling phy's clk and power-domain, we cannot do phy_init since phy
>> can't be accessed by CPU.
>>
>> But here, I think you are right. It does look a bit weird.
>> I think the better way is to remove phy_power_on here, and let phy-driver do
>> power_on in phy_init internally. Similarly in the remove call.
>
> That makes sense to me! I think it would also follow other phy clients
> use of the phy API.
>
> What makes me wonder though is from a power management point of view.
> *When* do you need to have phy initialized and powered?
>

Whenever controller need to communicate with card, must init/power_on 
phy firstly.

> 1) For a removable card can leave the phy uninitialised or powered
> off, but still detect card insertion/removal via GPIO? Is that a valid
> scenario for you?
>

Theoretically, it is.  Although my soc don't use phy for removable card, 
I also consider how to handle this case. Should we add a hook
for sdhci_get_cd, and initialize phy if it's non-removeable device or 
removeable card in slot ? Doesn't seem like a good idea.

Also seems not always work if we just use SDHCI_PRESENT_STATE to detect 
card insertion/removal without phy in active state.

> 2) Considering the runtime PM case for the sdhci device. Typically you
> can gate clocks etc at runtime suspend to save power, but what about
> the phy? Can you power off it in runtime suspend?

yes, we can power off it in runtime suspend. So we can append some 
patches later to introduce runtime pm for sdhci-of-arasan?

>
> [...]
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin
