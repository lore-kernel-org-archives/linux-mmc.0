From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Fri, 16 Mar 2012 12:36:35 +0000
Message-ID: <201203161236.36088.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <201203152058.31398.arnd@arndb.de> <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60193 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab2CPMgj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 08:36:39 -0400
In-Reply-To: <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Per Forlin <per.forlin@stericsson.com>, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Friday 16 March 2012, Linus Walleij wrote:
> On Thu, Mar 15, 2012 at 9:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > [Per]
> >> The stedma40 filter function is not really specific for ux500. ux500
> >> use stedma40 but it should be possible to replace this DMA.IP with
> >> some other DMA-controller. This is board specific configuration. You
> >> should not need to change the mmci-driver just because the dma-driver
> >> has changed, right?
> >> Or will the board-configuration now be placed in mmci-ux500?
> >
> > Right, the DMA configuration does not really belong in there, but
> > the voltage setup might (unless we convert that to the regulator
> > setup).
> 
> The voltage to power the card is already using the regulator
> framework with the MMC-specific helpers in the MMCI driver.
> 
> But I guess you're after modelling the levelshifter as a regulator?
> 
> Basically the level shifter is a separate device has two voltage
> inputs A and B (from other regulators) that is controlled by a
> simple GPIO to select voltage A or B to drive the signals to
> the card.
> 
> That could probably be modelled as a regulator with two
> volategs for sure, but then we should maybe create a more
> generic "struct level_shifter_regulator" (or whatever) for the
> concept as a whole.

Ok, thanks for the explanation.

> Let's page Mark about what to do with levelshifters and whether
> they are regulators of sorts in his book.

It does sound appealing, especially because this one could be
done completely generically by defining a regulator that has
a bunch of other regulators as well as a set of gpio lines as
inputs and one output that can be used in other devices. We
would probably only use this one together with device tree then.

	Arnd
