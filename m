From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: davinci_mmc: add warnings for edma failures
Date: Fri, 28 Nov 2014 12:20:11 +0100
Message-ID: <CAPDyKFoqMdViQDRZfLyciq5LK0QN1ts2_UFFmmgs-WgeTQ_-1Q@mail.gmail.com>
References: <546FD21C.7010208@sysam.it>
	<CAPDyKFrBgv9OTzwNfiOSn58Ai7QTbrZm4pKgLrzrM1MgD4=zAA@mail.gmail.com>
	<5476FA88.6070105@sysam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:41127 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbaK1LUM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 06:20:12 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so4663647qgd.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2014 03:20:11 -0800 (PST)
In-Reply-To: <5476FA88.6070105@sysam.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 27 November 2014 at 11:18, Angelo Dureghello <angelo@sysam.it> wrote:
> Hi Uffe,
>
> many hanks for the reply,
>
>>> Add warnings in case the edma engine driver fails to allocate slots or
>>> channels requested from the davinci_mmc driver.
>>>
>>> Some ti-davinci based boards (i.e. board-da850-evm.c) are asking for
>>> some reserved chans / slots at board init stage. Later, the mmc driver
>>> results in a silent locked state.
>>
>> So why does davinci_acquire_dma_channels() succeed then? Isn't that
>> real problem you should be looking into?
>
> i explain with more details,
>
> my custom am1808 board initialization, based on
> arch/arm/mach-davinci/board-da850-evm.c, reserves some dma chans / slots for
> the audio at
> early boot.
>
> While on kernel 3.5.1 mmc was working properly, moving to kernel
> 3.17.0, due to the dma-engine wrapper introduction (to be selected
> into menuconfig), the mmc host driver locks silently. System cannot
> even "reboot" after the failed attempt to reserve the dma slots.
>
> I hardly found out the reason due to missing of clear warnings.
>
> So there is nothing to fix in any other place. Simply, i am suggesting
> a more visible warning so the driver, instead of lock-up silently,
> throws a problem.

I understand, thanks for clarifying.

So apparently the error handling for this path isn't working. I think
we should fix that instead of just WARN about it.

Kind regards
Uffe
