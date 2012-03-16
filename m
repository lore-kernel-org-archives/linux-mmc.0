From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Fri, 16 Mar 2012 10:01:34 +0100
Message-ID: <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
	<201203151532.44363.arnd@arndb.de>
	<CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
	<201203152058.31398.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45712 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab2CPJBf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 05:01:35 -0400
Received: by yhmm54 with SMTP id m54so4004822yhm.19
        for <linux-mmc@vger.kernel.org>; Fri, 16 Mar 2012 02:01:35 -0700 (PDT)
In-Reply-To: <201203152058.31398.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Per Forlin <per.forlin@stericsson.com>, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Thu, Mar 15, 2012 at 9:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> [Per]
>> The stedma40 filter function is not really specific for ux500. ux500
>> use stedma40 but it should be possible to replace this DMA.IP with
>> some other DMA-controller. This is board specific configuration. You
>> should not need to change the mmci-driver just because the dma-driver
>> has changed, right?
>> Or will the board-configuration now be placed in mmci-ux500?
>
> Right, the DMA configuration does not really belong in there, but
> the voltage setup might (unless we convert that to the regulator
> setup).

The voltage to power the card is already using the regulator
framework with the MMC-specific helpers in the MMCI driver.

But I guess you're after modelling the levelshifter as a regulator?

Basically the level shifter is a separate device has two voltage
inputs A and B (from other regulators) that is controlled by a
simple GPIO to select voltage A or B to drive the signals to
the card.

That could probably be modelled as a regulator with two
volategs for sure, but then we should maybe create a more
generic "struct level_shifter_regulator" (or whatever) for the
concept as a whole.

Let's page Mark about what to do with levelshifters and whether
they are regulators of sorts in his book.

Yours,
Linus Walleij
