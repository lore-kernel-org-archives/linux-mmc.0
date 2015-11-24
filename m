From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
Date: Tue, 24 Nov 2015 16:17:15 +0100
Message-ID: <CAPDyKFoCVOF1dPGMXH0ui8MWRLgn=c2aFWckQ3+H_NFVxpmnGA@mail.gmail.com>
References: <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
	<20151109132305.GC15706@odux.rfo.atmel.com>
	<CAPDyKFrTTEnSFNvmx3e__Ap9gOGpA2-bz+yrq7ibz0wXGSWCXA@mail.gmail.com>
	<20151109144030.GD15706@odux.rfo.atmel.com>
	<CAPDyKFquZ+_Rf07gX+i-=_bzSa7KJ5+xQ8N21kK2mvfMGdVQMw@mail.gmail.com>
	<20151109163026.GE15706@odux.rfo.atmel.com>
	<20151124092341.GA2228@odux.rfo.atmel.com>
	<CAPDyKFp4U5vG_UswnLe1L2Vq1VwdkptThSdzhPYoP+hhGFTaQA@mail.gmail.com>
	<20151124131213.GB2228@odux.rfo.atmel.com>
	<CAPDyKFqr1=EytbC0hUyCk4Lb8GWJx0=Xg+ZmDoPJFp5L7G2nrQ@mail.gmail.com>
	<20151124140831.GC2228@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36600 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbKXPRQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2015 10:17:16 -0500
Received: by ykdr82 with SMTP id r82so21706853ykd.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2015 07:17:15 -0800 (PST)
In-Reply-To: <20151124140831.GC2228@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

[...]

>> > This one to not write an invalid voltage in the power control register
>> > even if we have an external regulator for vmmc.
>> >
>>
>> As I stated earlier, according to the SDHCI spec in the section for
>> the Power Control Register. Bit 0 needs to be set when communicating
>> with the card as it will for
>> example enable the clock.
>>
>
> I am okay with bit 0. I don't want to change this part, it will be done
> later in sdhci_set_power(). My concern is only about bit 3-1, I want to
> go through the switch statement.

For those variants that have a VMMC and don't care about the other
bits (1->3), it means executing code that isn't needed.

Instead, as I have been telling people several times by now, let's
convert the "sdhci core" into a library, so each variant can pick and
do what suite them best.

>
>> I suspect if I apply your patch several sdhci variants would break,
>> don't you think?
>
> I wouldn't sign it with my blood but I don't think so. It seems they
> don't care about the SD bus Voltage since they work with an unsupported
> voltage.

You may very well be right, that it doesn't break anything. But in
this case I really don't want to take the risk.

As stated above, the proper solution would be that sdhci_set_power()
should be split up in smaller pieces, where each piece may become a
library function. Each host variant can then decide what to use.

Future wise, that would mean when changing a library function, it will
affect the subset of the sdhci variants that actually use it and not
*all* sdhci variants. Moreover it will lead to optimized code.

Kind regards
Uffe
