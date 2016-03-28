From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 20:44:48 +0900
Message-ID: <56F91930.7020902@samsung.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com>
 <56F6D083.1020402@denx.de> <56F6D1E9.3050606@mentor.com>
 <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
 <56F6EFFD.9070007@denx.de> <1459157818.4785.5.camel@synopsys.com>
 <56F908A1.3070701@samsung.com> <1459162537.4785.45.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459162537.4785.45.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "marex@denx.de" <marex@denx.de>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 03/28/2016 07:55 PM, Alexey Brodkin wrote:
> Hi Jaehoon,
> 
> On Mon, 2016-03-28 at 19:34 +0900, Jaehoon Chung wrote:
>> Hi,
> 
> [snip]
> 
>>>>>>>>>
>>>>>>>>> That said, I would rather prefer to see "snps,dw-mshc" prefix on description
>>>>>>>>> of an MMC controller found on SoCFPGA series, "altr,socfpga-dw-mshc" seems
>>>>>>>>> to be redundant.
>> Yes..it's redundant..i should be combined to "snps,dw-mshc".
> 
> So for socfpga platform compat string should be something like "snps,dw-mshc-socfpga" then?

i think yes..since there is no SoC specific feature, isn't?

> 
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> According to drivers/mmc/host/dw_mmc-pltfm.c , the Altera SoCFPGA one
>>>>>>>> "altr,socfpga-dw-mshc" and also Imagination Technology Pistacio one
>>>>>>>> "img,pistachio-dw-mshc" need specialty bit (SDMMC_CMD_USE_HOLD_REG),
>>>>>>>> while the stock one "snps,dw-mshc" does not. I am not sure if the ARC
>>>>>>>> one needs it as well, but most likely yes.
>>>>>>>>
>>>>>>>> I wonder if that bit is needed on some particular version of the DWMMC
>>>>>>>> core. In that case, should we have "snps,dw-mshc" and "snps,dw-mshc-vN"
>>>>>>>> binding ? Or should we use DT property to discern the need for this bit ?
>>>>>>>>
>>>>>>> That's the most common way to take into account peculiarities, add
>>>>>>> a property and handle it from the driver.
>>>>>> And by "that" you mean which of those two I listed , the
>>>>>> "snps,dw-mshc-vN" or adding new DT prop ?
>>>>>>
>>>>> I meant to add a new property, not a new compatible, but that's just
>>>>> my experience.
>>>>>
>>>>> Let me say it __might__ happen that a particular change you need is
>>>>> specific to a particular version of the DWMMC IP (query Synopsys
>>>>> by the way), but more probably it might be e.g. the same IP version with
>>>>> a different reduced or extended configuration or a minor fix/improvement
>>>>> to the IP block without resulting version number bump.
>>>>>
>>>>> For example I don't remember that errata fixes in IP blocks result in
>>>>> a new compatible, instead there are quite common optional "quirk"
>>>>> properties for broken IPs -- e.g. check bindings/usb/dwc3.txt :)
>>>> Right, this very much matches how I see it as well. Thanks for confirming.
>>>>
>>>> Alexey, can you tell us if the requirement for setting
>>>> SDMMC_CMD_USE_HOLD_REG came with some new revision of the core or
>>>> disappeared with some revision OR if this is some configuration
>>>> option of the core during synthesis ?
>>> Sorry for not following that discussion during my weekend but I'll try
>>> to address all questions now.
>> SDMMC_CMD_USE_HOLD_REG didn't come with new revision..It's using continuously.
>> But it's difficult to use the generic feature..because it's considered the below things.
>>
>> If Card is SDR50/SDR104/DDR50 mode..
>> 	1) and phase shift of cclk_in_drv is 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 0,
>> 	2) and phase shift of cclk_in_drv > 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 1,
>> If Card is SDR12/SDR25 mode, then this bit is set to 1.
> 
> So card type is also important here and for certain card type we don't need to
> set SDMMC_CMD_USE_HOLD_REG, right?

If you means card-type is card's speed mode, right..it's important.
In IP Databook, not mentioned about HS200 or HS400, but i thinks it doesn't need to set USE_HOLD_REG.
Because higher speed mode than 50MHz should be required the lowest input hold time. (~0.8ns)

> 
>> We need to check phase shift scheme..but as i knew, each SoC have been implemented differently for phase shift.
>> (Phase shift have dependency to SoC.)
> 
> Given my assumption above we need to check 2 things:
>  * Card type
>  * SoC-specific implementation detail (phase shift scheme)

In Exynos's case, there is CLKSEL register in DWMMC IP register.(as Vendor specific register.)
On other hands, rockchip is handling the phase sfiht with "clk_set_phase()"(as CMU.)

I can't know everything how they're implementing for shifting phase..

> 
>> And it have to check HCON register..there is IMPLEMENT_HOLD_REG(bit[22]).
>> (It described whether IP have hold register or not)
> 
> Ah actually 3 things
>  + IMPLEMENT_HOLD_REG

Almost all have IMPLEMENT_HOLD_REG...?

If i will implement... in dw-mmc.c

switch (ios->timing) {
case SDR50/DDR50/.../
	if (check cclk_in_drv > 0 for each SoC) {
		SDMMC_CMD_USE_HOLD_REG is set to 1
		break;
	}
case SDR12/SD25
	SDMMC_CMD_USE_HOLD_REG is set to 1
default:
	SDMMC_CMD_USE_HOLD_REG is set to 0.
}


> 
>> I didn't read this thread entirely.
>> I'm not sure what you have discussed..but my understanding is right..i recommend to use "snps,dw-mshc" for ARC compat
>> string.
>> Otherwise it need to add "dw_mmc-<SoC>.c". dw_mmc-pltfm.c should provide the basic dw-mmc controller functionality.
> 
> Hm, interesting looks like you already made some changes here:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=aaaaeb7a933471f6413ca44dd36efd57f2fa9429
> 
> So now driver checks if SoC has HOLD REG then SDMMC_CMD_USE_HOLD_REG will be set
> (regardless card type).

Yes, it's used by default..
Except exynos, other SoCs need to set this bit until now..otherwise it will be occurred CRC error. (Rockchip, Socfpga..)

> 
> And what's interesting and connected to this discussion since mentioned commit
> there's no point in having both "altr,socfpga-dw-mshc" and "img,pistachio-dw-mshc"
> compat strings because the do nothing now. I.e. it's time to replace both mentioned
> compat strings with generic "snps,dw-mshc".
> 
> Anybody volunteers for that .dts* cleanup?

If have spare time to do cleanup, i will do for mshc compatible.

Best Regards,
Jaehoon Chung

> 
> -Alexey--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
