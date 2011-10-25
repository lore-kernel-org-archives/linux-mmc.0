From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Tue, 25 Oct 2011 09:12:25 +0200
Message-ID: <CAKnu2MppySzpE5SxtqW_yV7KNEWw+tQ658i0pyfoUiwQCL2CGA@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
	<20111024090432.GA9893@n2100.arm.linux.org.uk>
	<4EA53181.2050700@stericsson.com>
	<20111024094203.GI9893@n2100.arm.linux.org.uk>
	<4EA538A3.9070501@stericsson.com>
	<20111024101416.GK9893@n2100.arm.linux.org.uk>
	<4EA55076.2010701@stericsson.com>
	<CACRpkdb7FwW=Qa2MiJkbezkBO3F+Y0j6-RWSiL8dfJXkbd4pHw@mail.gmail.com>
	<4EA58368.6050704@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55766 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab1JYHMZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2011 03:12:25 -0400
Received: by gyb13 with SMTP id 13so210525gyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2011 00:12:25 -0700 (PDT)
In-Reply-To: <4EA58368.6050704@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

2011/10/24 Ulf Hansson <ulf.hansson@stericsson.com>:

> Could we assume that all boards which utilizes the ARM PL180 are using the
> MMCIPWR register to control power the card? Or should we add a new amba mmci
> platform member so this is configurable for each board?

I think we should take entire variants, like currently U300 and Ux500.
In those designs the MMCIPWR signal is left dangling on the chip,
so no-one electronics designer can use that signal for anything even
if s/he would have wanted to.

> An option could also be if we might want to simplify code to just skip the
> entire runtime_suspend|idle|resume function (ie stubb it or something) for
> these kind of boards?

I think the clk_disable()/clk_enable() pair in runtime suspend/resume
is still valuable for all other variants too. That has nothing to do with
MMCIPWR.

> By the way, there is also another option. In the runtime_suspend function
> for ARM PL180 block we can use mmc_power_save_host (and then also
> disable vcore etc) and vice verse in runtime_resume with
> mmc_power_restore_host.

This is what the OMAP driver does right?

> Of course, these kind of operations takes quite some time to execute and
> therefore we use a much bigger timeout than 50 ms (for example 10 s
> instead) for ARM PL180.

Can we do both?

1) Break out mmci_state_save_restore() from the runtime PM hooks.

2) I.e. have a short time-out that will runtime-suspend the external
  regulator variants quickly with finer granularity.

3) Have a long time-out that will runtime-suspend the MMCIPWR
  variants using mmc_power_save_host() with a longer delay?
  Since mmc_power_save_host() calls .set_ios() to really shut
  down the power to the card we should be on the safe side.

Looks like a nice silver bullet to me :-)

I volunteer to test the long time-out code path on the Integrator
PB1176 to verify this works.

Yours,
Linus Walleij
