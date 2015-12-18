From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: restore behavior when setting VDD via
 external regulator
Date: Fri, 18 Dec 2015 10:55:19 +0100
Message-ID: <CAPDyKFqf=L=dwjLx5G7oU0_YLE3Ow39_b2+H7z0Gu_Lh-T+3Dg@mail.gmail.com>
References: <1449840989-563-1-git-send-email-jszhang@marvell.com>
	<CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
	<20151218081138.GB15968@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34891 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbLRJzU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 04:55:20 -0500
Received: by mail-yk0-f179.google.com with SMTP id v6so51709839ykc.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2015 01:55:19 -0800 (PST)
In-Reply-To: <20151218081138.GB15968@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 18 December 2015 at 09:11, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Hi Ulf, Jisheng,
>
> On Fri, Dec 11, 2015 at 03:48:04PM +0100, Ulf Hansson wrote:
>> + Ludovic (We had some discussions around this code recently as well)
>>
>> On 11 December 2015 at 14:36, Jisheng Zhang <jszhang@marvell.com> wrote:
>> > After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
>> > support"), for the VDD is supplied via external regulators, we ignore
>> > the code to convert a VDD voltage request into one of the standard
>> > SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
>> > brings two issues:
>> >
>> > 1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
>> > more.
>> >
>> > 2. What's more, once SDHCI_POWER_ON bit is set, some controllers such
>> > as the sdhci-pxav3 used in marvell berlin SoCs require the voltage
>> > levels programming in the SDHCI_POWER_CONTROL register, even the VDD
>> > is supplied by external regulator. So the host in marvell berlin SoCs
>> > still works fine after the commit. However, commit 3cbc6123a93d ("mmc:
>> > sdhci: Set SDHCI_POWER_ON with external vmmc") sets the SDHCI_POWER_ON
>> > bit, this would make the host in marvell berlin SoCs won't work any
>> > more with external vmmc.
>> >
>> > This patch restores the behavior when setting VDD through external
>> > regulator by moving the call of mmc_regulator_set_ocr() to the end
>> > of sdhci_set_power() function.
>> >
>> > After this patch, the sdcard on Marvell Berlin SoC boards work again.
>> >
>> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>> > Fixes: 52221610dd84 ("mmc: sdhci: Improve external VDD ...")
>
> Reviewed-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Even if the patch sounds good for me, I wanted to test it. As planned,
> with this patch, I can describe my vcc regulator without breaking the
> behavior of my sdhci controller.
>

Okay! According to the reasoning and testing, this change seems like a
good idea!

I have now queued the v2 for next.

Thanks!

Kind regards
Uffe
