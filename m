From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Fri, 18 Feb 2011 14:03:29 +0100
Message-ID: <AANLkTin64W=VQP+EomU3PK-Ye=Nz_SP+DOLxgT__4fkQ@mail.gmail.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	<8ya8vxf4w4w.fsf@huya.qualcomm.com>
	<AANLkTimQqGVTwUv4ywQnmd4Z1Ur4vWk2sK5+ZLa4mmTs@mail.gmail.com>
	<AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51979 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1BRND3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 08:03:29 -0500
Received: by pwj3 with SMTP id 3so582747pwj.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 05:03:29 -0800 (PST)
In-Reply-To: <AANLkTikDxOeW9Nfaew_mZLnVJ6e7pyzQTNs139g_AehW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: David Brown <davidb@codeaurora.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

2011/2/17 Brian Swetland <swetland@google.com>:
> On Wed, Feb 16, 2011 at 1:01 PM, Linus Walleij <linus.walleij@linaro.=
org> wrote:
>> 2011/2/16 David Brown <davidb@codeaurora.org>:

>>> The SDCC block is shared between
>>> the modem processor and the processor running Linux. =A0If the driv=
er
>>> doesn't go through the DMA engine, which coordinates this, the regi=
sters
>>> will be stomped on by the other CPU whenever it decides to access i=
t's
>>> parts of the flash device.
>> (...)
>>
>> At the same time what you're saying sounds very weird:
>> the ios handler in mmc_sdcc does not request any DMA
>> channel before messing with the hardware, it simply just write
>> into registers very much in the style of mmci.c. Wouldn't that
>> disturb any simultaneous access to the MMC from another
>> CPU?
>
> (...)
> The way register access for the SDCC is synchronized between these tw=
o
> cores is by using a locking primitive built into the MSM DMA
> controller. =A0If you don't use this indirect access model (via DMA
> transactions to the registers), you end up tripping over the baseband
> or the other way 'round. =A0It's not fun.

Wherever is that synchronized in the DMA controller?
I don't get it because the code is so very similar.

When the ios does this:
msmsdcc_writel(host, clk, MMCICLOCK);

This magic macro does the trick?

static inline void
msmsdcc_writel(struct msmsdcc_host *host, u32 data, unsigned int reg)
{
        writel(data, host->base + reg);
        /* 3 clk delay required! */
        udelay(1 + ((3 * USEC_PER_SEC) /
               (host->clk_rate ? host->clk_rate : msmsdcc_fmin)));
}

What is so hard about renaming this mmci_writel() and putting
the udelay() weirdness inside #ifdef ARCH_MSM? Wrapping
all the writes in the mmci driver inside an inline function is hardly
a big problem.

Yours,
Linus Walleij
