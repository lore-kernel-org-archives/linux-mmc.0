From: Brian Swetland <swetland@google.com>
Subject: Re: [RFC] MMC: error handling improvements
Date: Fri, 18 Feb 2011 08:04:34 -0800
Message-ID: <AANLkTin7UaKPgvmPC0+cJf5nBWuUmuUreAjDZxQGNB2j@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
	<AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
	<AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:55725 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1BRQEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 11:04:43 -0500
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id p1IG4Zaq028612
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 08:04:36 -0800
Received: from gxk20 (gxk20.prod.google.com [10.202.11.20])
	by kpbe17.cbf.corp.google.com with ESMTP id p1IG4FYE008399
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 08:04:34 -0800
Received: by gxk20 with SMTP id 20so346059gxk.21
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 08:04:34 -0800 (PST)
In-Reply-To: <AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: David Brown <davidb@codeaurora.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

On Fri, Feb 18, 2011 at 5:03 AM, Linus Walleij <linus.walleij@linaro.or=
g> wrote:
> 2011/2/17 Brian Swetland <swetland@google.com>:
>> On Wed, Feb 16, 2011 at 1:01 PM, Linus Walleij <linus.walleij@linaro=
=2Eorg> wrote:
>>> 2011/2/16 David Brown <davidb@codeaurora.org>:
>
>>>> The SDCC block is shared between
>>>> the modem processor and the processor running Linux. =C2=A0If the =
driver
>>>> doesn't go through the DMA engine, which coordinates this, the reg=
isters
>>>> will be stomped on by the other CPU whenever it decides to access =
it's
>>>> parts of the flash device.
>>> (...)
>>>
>>> At the same time what you're saying sounds very weird:
>>> the ios handler in mmc_sdcc does not request any DMA
>>> channel before messing with the hardware, it simply just write
>>> into registers very much in the style of mmci.c. Wouldn't that
>>> disturb any simultaneous access to the MMC from another
>>> CPU?
>>
>> (...)
>> The way register access for the SDCC is synchronized between these t=
wo
>> cores is by using a locking primitive built into the MSM DMA
>> controller. =C2=A0If you don't use this indirect access model (via D=
MA
>> transactions to the registers), you end up tripping over the baseban=
d
>> or the other way 'round. =C2=A0It's not fun.
>
> Wherever is that synchronized in the DMA controller?
> I don't get it because the code is so very similar.
>
> When the ios does this:
> msmsdcc_writel(host, clk, MMCICLOCK);

Sorry, I'm wrong.  I was thinking of the MSM NAND driver which does
have a funky DMA interlock access control scheme where the DMA engine
is use to arbitrate register access between the apps and modem cores.
You are correct -- there's no special magic in the SDCC driver.

If this can be handled by a common driver with a quirks flag for
msm-specific oddities, that sounds quite sane to me.

Brian
