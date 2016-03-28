From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 19:16:28 +0300
Message-ID: <56F958DC.5010203@mentor.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com>
 <56F6D083.1020402@denx.de> <56F6D1E9.3050606@mentor.com>
 <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
 <56F6EFFD.9070007@denx.de> <1459157818.4785.5.camel@synopsys.com>
 <56F908A1.3070701@samsung.com> <56F9287F.1020707@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:61901 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbcC1QQe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2016 12:16:34 -0400
In-Reply-To: <56F9287F.1020707@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On 28.03.2016 15:50, Marek Vasut wrote:
> On 03/28/2016 12:34 PM, Jaehoon Chung wrote:
>> Hi,
> 
> Hi,
> 
> [...]
> 
>>>>>>>>> That said, I would rather prefer to see "snps,dw-mshc" prefix on description
>>>>>>>>> of an MMC controller found on SoCFPGA series, "altr,socfpga-dw-mshc" seems
>>>>>>>>> to be redundant.
>>
>> Yes..it's redundant..i should be combined to "snps,dw-mshc".
> 
> Should the compat string be
>   compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> or just
>   compatible = "snps,dw-mshc";
> ?
> 
> I am under the impression that a soc-specific identifier in addition to
> a generic one (used by the driver compat table) is a good idea, because
> it can help discerning the IP block from a generic one if needed at some
> future point in time. It will also not break the DT for systems
> which may depend on the non-generic compat, like *BSDs and such.
> 
> What do you think ? (btw this is very much my question in this thread)

IMO just 'compatible = "snps,dw-mshc"' is good enough, if it completely
describes the IP block on SoCFGPA --- and from what I get it is the case.
You can add a SoC-specific compatible if it is needed later on, and to my
taste only if SoC specific features can not be covered by properties.

The same sole "snps,dw-mshc" compatible is specified for NXP LPC18xx/43xx,
ZTE ZX and HiSilicon ARM SoCs.

Another similar example is ARM PrimeCell PLxxx IP blocks, as far as
I know there is no SoC-specific compatibles/aliases for PrimeCell IP blocks.

Rob, please correct me.

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
>>>
>>> Sorry for not following that discussion during my weekend but I'll try
>>> to address all questions now.
>>
>> SDMMC_CMD_USE_HOLD_REG didn't come with new revision..It's using continuously.
>> But it's difficult to use the generic feature..because it's considered the below things.
>>
>> If Card is SDR50/SDR104/DDR50 mode..
>> 	1) and phase shift of cclk_in_drv is 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 0,
>> 	2) and phase shift of cclk_in_drv > 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 1,
>> If Card is SDR12/SDR25 mode, then this bit is set to 1.
>>
>> We need to check phase shift scheme..but as i knew, each SoC have been implemented differently for phase shift.
>> (Phase shift have dependency to SoC.)
>>
>> And it have to check HCON register..there is IMPLEMENT_HOLD_REG(bit[22]).
>> (It described whether IP have hold register or not)
>>
>> I didn't read this thread entirely.
>> I'm not sure what you have discussed..but my understanding is right..i recommend to use "snps,dw-mshc" for ARC compat string.
>> Otherwise it need to add "dw_mmc-<SoC>.c". dw_mmc-pltfm.c should provide the basic dw-mmc controller functionality.
>>
>> After read this thread entirely, i will check more detailed what you discussed.
>> If i missed something, let me know, plz.
> 
> Thanks for the clarification, linux-next indeed contains changes which
> make snps,dw-mshc and altr,socfpga-dw-mshc equal.
> 
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> DW Mobile Storage databook says:
>>> --------------------->8-----------------------
>>> To meet the relatively high Input Hold Time requirement for SDR12, SDR25,
>>> and other MMC speed modes, you should program bit[29]use_hold_Reg of the
>>> CMD register to 1'b1.
>>> --------------------->8-----------------------
>>>
>>> So I'd say this specific setting has nothing to do with a particular IP block
>>> but instead it is related to card's mode of operation. More precisely bus clock.
>>> SDR12 stands for 12.5 MByte/s, SDR25 stands for 25 MByte/s. I.e. we probably need
>>> so set that bit just for certain cases and regardless board that uses DW MMC.
>>>
>>> I'm adding DW MMC maintainer as well as linux-mmc mailing list so people who
>>> understands that stuff better may comment here as well.
>>>
>>> -Alexey--
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
> 
> 

--
With best wishes,
Vladimir
