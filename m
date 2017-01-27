From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 27 Jan 2017 09:36:27 +0100
Message-ID: <CAPDyKFrx+mLNH-DEt90g9tutgpHUoTYzv3-Zt8GoSFEuPeqM+A@mail.gmail.com>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
 <20170121030604.7672-3-chris.brandt@renesas.com> <20170123165523.fnavkx263ifvss4p@rob-hp-laptop>
 <SG2PR06MB1165F465C5802912ED62820C8A720@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAL_Jsq+uit6rVcqsJjxmbtYfYdCvyRLCgDbp9RZd-B8SJo0+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36059 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbdA0IhI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2017 03:37:08 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so146218226itd.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2017 00:36:28 -0800 (PST)
In-Reply-To: <CAL_Jsq+uit6rVcqsJjxmbtYfYdCvyRLCgDbp9RZd-B8SJo0+yg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Chris Brandt <Chris.Brandt@renesas.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

On 26 January 2017 at 15:39, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jan 23, 2017 at 11:56 AM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> Hello Rob,
>>
>>
>> On Monday, January 23, 2017, Rob Herring wrote:
>>> > --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>>> > +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>>> > @@ -25,8 +25,32 @@ Required properties:
>>> >             "renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
>>> >             "renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
>>> >
>>> > +- clocks: Most controllers only have 1 clock source per channel.
>>> However, on
>>> > +     some variations of this controller, the internal card detection
>>>
>>> This should be explicit as to which compatible strings have 2 clocks and
>>> which have 1 clock.
>>
>> OK. I'll make a list like I did for sh_mmcif:
>>
>> https://patchwork.kernel.org/patch/9512091/
>>
>>
>>
>>> > +
>>> > +Example showing 2 clocks:
>>> > +   sdhi0: sd@e804e000 {
>>>
>>> mmc@...
>>
>> I'm confused. I see that for all SDHI controllers, it either "sd@" or "sdhci@".
>>
>> $ grep sdhi $(find arch/arm/boot/dts -name "*.dtsi")
>>
>> $ grep sdhci $(find arch/arm/boot/dts -name "*.dtsi")
>
> Yes, there's lots of variation. Node names are supposed to be generic
> for their class of device (e.g. ethernet, pci, usb,
> interrupt-controller, etc.). I'd be fine with "sd", but think "mmc" is
> more common. Either way, we should pick one moving forward. "sdhci"
> should not be used as that's a specific implementation.

I think we discussed this earlier. The problem with these devices is
that it covers several type of devices, so it's hard to find a generic
node name.

The devices are: MMC, eMMC, SD, SDIO. I don't have strong opinions on
whether to chose a generic node name, and perhaps "mmc" is the best we
can get?

Whatever we decide, we should update all mmc DTS docs, to avoid future
confusion.

Kind regards
Uffe
