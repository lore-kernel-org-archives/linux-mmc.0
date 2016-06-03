From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/32] mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
Date: Fri, 03 Jun 2016 10:42:59 +0200
Message-ID: <5371567.ZLhe0cdM9e@wuerfel>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com> <4715245.LFBOAeJdHc@wuerfel> <87vb1ra295.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61404 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbcFCImz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 04:42:55 -0400
In-Reply-To: <87vb1ra295.fsf@eliezer.anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>, linux-rpi-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

On Thursday, June 2, 2016 11:12:38 AM CEST Eric Anholt wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Wednesday, June 1, 2016 11:43:30 PM CEST Gerd Hoffmann wrote:
> >> +    /* Parse OF address directly to get the physical address for
> >> +     * DMA to our registers.
> >> +     */
> >> +    host->phys_addr = be32_to_cpup(of_get_address(pdev->dev.of_node, 0,
> >> +                                                  NULL, NULL));
> >
> > This looks broken on 64-bit systems when #address-cells=<2>, or if there
> > is an intermediate bus with a non-empty ranges property.
> >
> > What's wrong with platform_get_resource(pdev, IORESOURCE_MEM, 0)?
> 
> I'll get to the rest of the review later, but this is a weird pattern
> that we have in several bcm2835-related drivers.
> 
> We need the address as seen by the DMA controller, not the address from
> the ARM's perspective (which is offset by the dma-ranges DT property).
> This is the way that people have figured out to get that address.

I see. This is indeed a bit tricky, as there is no easy way to know
how the dmaengine is wired up to the slave. A correct solution is
probably to follow the 'dma-ranges' up from the master to the common
parent and then follow the 'ranges' back to the slave, but that
requires coming up with a new exported function.

It's perhaps good enough in the meantime to read out the address from
the slave directly, but you should not assume that the first
cell has the complete information and instead should at least
evaluate #address-cells.

	Arnd
