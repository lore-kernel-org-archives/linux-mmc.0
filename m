From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 11:54:00 +0200
Message-ID: <CACRpkdY6rzYsYQW+GACL6Ux8o=Eo-3wn62O0YZxJZ=F2WbE4DQ@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<20111024093632.GH9893@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49711 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab1JXJyA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:54:00 -0400
Received: by iaby12 with SMTP id y12so1162616iab.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 02:54:00 -0700 (PDT)
In-Reply-To: <20111024093632.GH9893@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 24, 2011 at 11:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 23, 2011 at 02:31:39AM +0200, Sebastian Rasmussen wrote:
>> I guess the patch would appeal more to Russell if mmci_runtime_suspend()
>> only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
>> MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
>> bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
>> this on my Snowball dev board yet.
>
> There's also the issue that the specs call for the clock to run after
> a command has completed for a certain number of cycles, and that the
> clock must continue to run until the card reports not-busy after a
> programming or erase cycle has completed - that can be long after the
> previous command has 'completed'.

It's 8 cycles on MCLK required.

I think that is taken care of by this:
pm_runtime_set_autosuspend_delay(mmc->parent, 50);

50 ms is >> 8 MCLK in any practical case, but if we want to
be really, really sure we can always:

#define DEFAULT_DELAY 50
int delay;
delay = DIV_ROUND_UP((1000 * 8), host->mclk); /* 8 MCLK in ms */
delay = max(DEFAULT_DELAY, min_delay);
pm_runtime_set_autosuspend_delay(mmc->parent, delay);

So we have encoded all assumptions.

Yours,
Linus Walleij
