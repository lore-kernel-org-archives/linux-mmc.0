From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 07:43:21 -0500
Message-ID: <CAL_JsqKwVxX-qbLqSEjOuoNJLVLgwUd3mvdDbCgczP6k7bz4wg@mail.gmail.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com> <56F6D083.1020402@denx.de>
 <56F6D1E9.3050606@mentor.com> <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
 <56F6EFFD.9070007@denx.de> <1459157818.4785.5.camel@synopsys.com> <56F908A1.3070701@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57360 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbcC1Mnq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Mar 2016 08:43:46 -0400
In-Reply-To: <56F908A1.3070701@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "marex@denx.de" <marex@denx.de>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Mar 28, 2016 at 5:34 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> On 03/28/2016 06:37 PM, Alexey Brodkin wrote:
>> Hi Marek, Vladimir,
>>
>> On Sat, 2016-03-26 at 21:24 +0100, Marek Vasut wrote:
>>> On 03/26/2016 09:12 PM, Vladimir Zapolskiy wrote:
>>>>
>>>> On 26.03.2016 21:52, Marek Vasut wrote:
>>>>>
>>>>> On 03/26/2016 07:16 PM, Vladimir Zapolskiy wrote:
>>>>>>
>>>>>> On 26.03.2016 20:10, Marek Vasut wrote:
>>>>>>>
>>>>>>> On 03/26/2016 06:52 PM, Vladimir Zapolskiy wrote:
>>>>>>>>
>>>>>>>> Hi Marek,
>>>>>>>>
>>>>>>>> On 26.03.2016 19:30, Marek Vasut wrote:
>>>>>>>>>
>>>>>>>>> On 03/26/2016 06:26 PM, Vladimir Zapolskiy wrote:
>>>>>>>>>>
>>>>>>>>>> On 26.03.2016 12:14, Marek Vasut wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi!
>>>>>>>>>>>
>>>>>>>>>>> I noticed that arch/arc/boot/dts/axs10x_mb.dtsi uses "altr," prefix in
>>>>>>>>>>> the DT compatible string:
>>>>>>>>>>>
>>>>>>>>>>> mmc@0x15000 {
>>>>>>>>>>>         compatible = "altr,socfpga-dw-mshc";
>>>>>>>>>>>         reg = < 0x15000 0x400 >;
>>>>>>>>>>>         num-slots = < 1 >;
>>>>>>>>>>>         fifo-depth = < 16 >;
>>>>>>>>>>>         card-detect-delay = < 200 >;
>>>>>>>>>>>         clocks = <&apbclk>, <&mmcclk>;
>>>>>>>>>>>         clock-names = "biu", "ciu";
>>>>>>>>>>>         interrupts = < 7 >;
>>>>>>>>>>>         bus-width = < 4 >;
>>>>>>>>>>> };
>>>>>>>>>>>
>>>>>>>>>>> I don't think this is OK, since ARC is unrelated to Altera, which is
>>>>>>>>>>> what the "altr," prefix stands for. I think the socfpga-dw-mshc shim
>>>>>>>>>>> should be extended with another compatibility string, something like
>>>>>>>>>>> "snps,arc-dw-mshc" and the axs10x_mb.dtsi should be adjusted
>>>>>>>>>>> accordingly. What do you think ?
>>>>>>>>>>>
>>>>>>>>>> There is "snps,dw-mshc" described in
>>>>>>>>>> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt and supported by
>>>>>>>>>> dw_mmc host controller driver.
>>>>>>>>> Thanks, that's even better.
>>>>>>>>>
>>>>>>>>> btw what do you think of using altr, prefix on non-altera system, that
>>>>>>>>> doesn't seem ok, right ?
>>>>>>>> according to ePAPR the prefix should represent a device (IP block here
>>>>>>>> I believe) manufacturer, so it should be okay to use "altr" prefix on
>>>>>>>> non-Altera system, if Altera provides  another hardware vendor with
>>>>>>>> some own IP block.
>>>>>>> In this case, it's Synopsys who provides the SD/MMC/MS core to other
>>>>>>> chip makers (Altera etc).
>>>>>> Correct.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> That said, I would rather prefer to see "snps,dw-mshc" prefix on description
>>>>>>>> of an MMC controller found on SoCFPGA series, "altr,socfpga-dw-mshc" seems
>>>>>>>> to be redundant.
>
> Yes..it's redundant..i should be combined to "snps,dw-mshc".

socfpga is done correctly, IMO.

>>>>>>> According to drivers/mmc/host/dw_mmc-pltfm.c , the Altera SoCFPGA one
>>>>>>> "altr,socfpga-dw-mshc" and also Imagination Technology Pistacio one
>>>>>>> "img,pistachio-dw-mshc" need specialty bit (SDMMC_CMD_USE_HOLD_REG),
>>>>>>> while the stock one "snps,dw-mshc" does not. I am not sure if the ARC
>>>>>>> one needs it as well, but most likely yes.
>>>>>>>
>>>>>>> I wonder if that bit is needed on some particular version of the DWMMC
>>>>>>> core. In that case, should we have "snps,dw-mshc" and "snps,dw-mshc-vN"
>>>>>>> binding ? Or should we use DT property to discern the need for this bit ?
>>>>>>>
>>>>>> That's the most common way to take into account peculiarities, add
>>>>>> a property and handle it from the driver.
>>>>> And by "that" you mean which of those two I listed , the
>>>>> "snps,dw-mshc-vN" or adding new DT prop ?
>>>>>
>>>> I meant to add a new property, not a new compatible, but that's just
>>>> my experience.
>>>>
>>>> Let me say it __might__ happen that a particular change you need is
>>>> specific to a particular version of the DWMMC IP (query Synopsys
>>>> by the way), but more probably it might be e.g. the same IP version with
>>>> a different reduced or extended configuration or a minor fix/improvement
>>>> to the IP block without resulting version number bump.
>>>>
>>>> For example I don't remember that errata fixes in IP blocks result in
>>>> a new compatible, instead there are quite common optional "quirk"
>>>> properties for broken IPs -- e.g. check bindings/usb/dwc3.txt :)
>>> Right, this very much matches how I see it as well. Thanks for confirming.
>>>
>>> Alexey, can you tell us if the requirement for setting
>>> SDMMC_CMD_USE_HOLD_REG came with some new revision of the core or
>>> disappeared with some revision OR if this is some configuration
>>> option of the core during synthesis ?
>>
>> Sorry for not following that discussion during my weekend but I'll try
>> to address all questions now.
>
> SDMMC_CMD_USE_HOLD_REG didn't come with new revision..It's using continuously.
> But it's difficult to use the generic feature..because it's considered the below things.
>
> If Card is SDR50/SDR104/DDR50 mode..
>         1) and phase shift of cclk_in_drv is 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 0,
>         2) and phase shift of cclk_in_drv > 0 then SDMMC_CMD_USE_HOLD_REG bit is set to 1,
> If Card is SDR12/SDR25 mode, then this bit is set to 1.
>
> We need to check phase shift scheme..but as i knew, each SoC have been implemented differently for phase shift.
> (Phase shift have dependency to SoC.)
>
> And it have to check HCON register..there is IMPLEMENT_HOLD_REG(bit[22]).
> (It described whether IP have hold register or not)
>
> I didn't read this thread entirely.
> I'm not sure what you have discussed..but my understanding is right..i recommend to use "snps,dw-mshc" for ARC compat string.
> Otherwise it need to add "dw_mmc-<SoC>.c". dw_mmc-pltfm.c should provide the basic dw-mmc controller functionality.

You should use "snps,dw-mshc", but there should also be an SoC
specific compatible string. There are always integration differences
and even using just versions of IP blocks is not specific enough. This
should not require another driver file.

Rob
