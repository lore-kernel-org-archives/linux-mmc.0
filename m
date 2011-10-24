From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 11:14:21 +0200
Message-ID: <CACRpkdaz7OGeTsvMkNtK_t6t3Wcog=U9Oq9dkumW52H8R+ws0Q@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61096 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab1JXJOV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 05:14:21 -0400
Received: by iaby12 with SMTP id y12so1133187iab.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2011 02:14:21 -0700 (PDT)
In-Reply-To: <4EA51C4A.7040802@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Oct 24, 2011 at 10:05 AM, Ulf Hansson
<ulf.hansson@stericsson.com> wrote:

> The hole idea with this PM patch is to make sure the vcore regulator and the
> clock are disabled in runtime_suspend to be able to save a huge amount of
> current in "idle" mode.
>
> Disabling the vcore regulator will sooner or later (depending on your
> regulator tree) mean that that power to the controller is actually cut,
> which then means that all registers will be "cleared" including the MCIPWR.

I guess since this means writing power-off to bits 1 and 0 of
of MCIPower meaning "power off"  it should not be done unless the MMC
core has first issued mmci_set_ios() with MMC_POWER_OFF set in
ios->power_mode. Which means mmc_power_off() must have
been called.

That in turn is called by mmc_power_save_host() or
mmc_suspend_host().

mmc_power_save_host() is in turn called by
mmc_runtime_suspend() in drivers/mmc/bus.c!

So if that is called *before* the driver-local runtime suspend
calls, you're actually on the safe side, and you can
proceed to cut the power.

So these need to be zero before we enter runtime suspend.
This could then be assured by:

if (readl(host->base + MMCIPOWER) & 3)
  return -EBUSY;

If this has already been done we are on the green and can
runtime suspend the controller I guess?

So what this code

> +             /* Save registers for POWER, CLOCK and IRQMASK0 */
> +             host->irqmask0_reg = readl(host->base + MMCIMASK0);
> +             host->pwr_reg = readl(host->base + MMCIPOWER);
> +             host->clk_reg = readl(host->base + MMCICLOCK);

In the end does is save the contents of the other 30 bits.
(MCI_OD, MCI_ROD, and the ST-specific bits)

So can we first:

- Assure that mmc_power_save_host() has already been
  done (MMCI_POWER_OFF)

- Make this variable a prerequiste for cutting the power in
  runtime_pm?

Yours,
Linus Walleij
