From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Mon, 7 Mar 2011 02:16:29 -0600
Message-ID: <AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:38634 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab1CGIQc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 03:16:32 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p278FE7l006829
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 03:15:14 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2786RBv003949
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 03:15:14 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so4680785vws.15
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2011 00:16:30 -0800 (PST)
In-Reply-To: <AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Mar 6, 2011 at 3:20 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/3/6 Linus Walleij <linus.walleij@linaro.org>:
>> 2011/3/5 Andrei Warkentin <andreiw@motorola.com>:
>>
>>> Quirks are card-specific workarounds. Usually they involve
>>> tuning mmcblk parameters at mmc_blk_probe time.
>>
>> Can't you just drop off all the *block* and *blk* pre- and
>> suffixes off filenames and functions?
>>
>> It's inevitably going to be used for all kind of card quirks
>> soon enough, not just those relating to block issues
>> (could be power quirks etc) won't it?
>>
>> "Card quirks" is more intuitive to me.
>
> Or rather - if you check out Chris latest tree or the next
> tree - you will find the new quirks.c file that Pierre Tardy
> created for some SDIO quirks.
>
> Can you re-use this infrastructure and refactor/expand
> with the quirks you need for the block stuff?
>
> Yours,
> Linus Walleij
>

I'll check it out. I wish I looked earlier :-).

A
