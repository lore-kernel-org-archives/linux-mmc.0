From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc:sdhci:add support to request/free pins for
 controllers sharing hardware bus
Date: Tue, 26 Apr 2011 08:28:10 -0700
Message-ID: <89D3A89E-40C7-4938-9B58-24AA8E63DB8C@marvell.com>
References: <5EB3BFCD089AD643B9BB63439F5FD5E9A127@SHAASIEXM01.ASIA.ROOT.PRI>
 <BANLkTinj4pnDG=cCJY3JGYGXOYoVPHtA9A@mail.gmail.com>
 <m3d3k9u0yy.fsf@pullcord.laptop.org>
 <BANLkTimXXirF6zqx9h9DMRSpx+o8_vb=3w@mail.gmail.com>
 <20110426065851.GA14534@pengutronix.de>
 <BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38097 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755916Ab1DZPan convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 11:30:43 -0400
In-Reply-To: <BANLkTineayh539zJx6GfxnpgCJwJdxYy0Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Binghua.Duan@csr.com" <Binghua.Duan@csr.com>, "andreiw@motorola.com" <andreiw@motorola.com>


Barry,

How are interrupts from SDIO devices handled ?   SDIO devices use one of the pins to signal a interrupt to the host when data is availabe.

Philip

On Apr 26, 2011, at 12:27 AM, Barry Song wrote:

> Hi Wolfram,
> 
> 2011/4/26 Wolfram Sang <w.sang@pengutronix.de>:
>>>> * Where is the patch that implements the get_shared_pins() hook in
>>>>  your driver?
>>> We send the common level patch ahead to get the upstream agreement so
>>> that we can maintain our bottom level sdhci codes better. We will send
>>> the special driver patch after some time.
>> 
>> Hmm, why should be there a functionality if there is no user for it? A
>> reference user helps people understand how it is intended to be used.
> 
> completely right. Of course this patch is based on real applications
> and SoCs. We are using ARASAN sd controller IP, it can be configurated
> to use shared pins mode in SoC design. And it looks like it is a
> common requirement to save chip footprint by sharing data bus between
> multi-controllers.
> 
> Just because Our SoCs are still on the way to opensource and mainline.
> Even our arch/arm/mach-xxx hasn't been merged yet. Our target is
> syncing our codes with mainline. So as a modification to sdhci common
> level, we just get upstream's opinion for local maintaining earlier.
> 
> Anyway, this patch may be applied later after our others are ready. Or
> it can be now so that other SoC companies can use this feature.
> 
>> 
>> Regards,
>> 
>>   Wolfram
>> 
>> --
>> Pengutronix e.K.                           | Wolfram Sang                |
>> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>> 

