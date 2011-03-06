From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Sun, 6 Mar 2011 22:20:07 +0100
Message-ID: <AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54168 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab1CFVUH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2011 16:20:07 -0500
Received: by pxi15 with SMTP id 15so625994pxi.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 Mar 2011 13:20:07 -0800 (PST)
In-Reply-To: <AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

2011/3/6 Linus Walleij <linus.walleij@linaro.org>:
> 2011/3/5 Andrei Warkentin <andreiw@motorola.com>:
>
>> Quirks are card-specific workarounds. Usually they involve
>> tuning mmcblk parameters at mmc_blk_probe time.
>
> Can't you just drop off all the *block* and *blk* pre- and
> suffixes off filenames and functions?
>
> It's inevitably going to be used for all kind of card quirks
> soon enough, not just those relating to block issues
> (could be power quirks etc) won't it?
>
> "Card quirks" is more intuitive to me.

Or rather - if you check out Chris latest tree or the next
tree - you will find the new quirks.c file that Pierre Tardy
created for some SDIO quirks.

Can you re-use this infrastructure and refactor/expand
with the quirks you need for the block stuff?

Yours,
Linus Walleij
