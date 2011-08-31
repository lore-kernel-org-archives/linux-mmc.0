From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
Date: Wed, 31 Aug 2011 10:49:30 +0800
Message-ID: <20110831024929.GA19795@S2100-06.ap.freescale.net>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
 <20110830034035.GC19294@S2100-06.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF04B3279D3F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:8992 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853Ab1HaCks (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 22:40:48 -0400
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D3F@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 30, 2011 at 09:01:37AM -0700, Stephen Warren wrote:
> Shawn Guo wrote at Monday, August 29, 2011 9:41 PM:
> > On Tue, Aug 23, 2011 at 12:15:33PM -0600, Stephen Warren wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Add hooks to read gpio configuration out of the device tree node.
> ...
> > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
> ...
> > > +* NVIDIA Tegra Secure Digital Host Controller
> > > +
> > > +This controller on Tegra family SoCs provides an interface for MMC, SD,
> > > +and SDIO types of memory cards.
> > > +
> > > +Required properties:
> > > +- compatible : Should be "nvidia,<chip>-sdhci"
> > > +- reg : Should contain eSDHC registers location and length
> > > +- interrupts : Should contain eSDHC interrupt
> > 
> > You may want to replace eSDHC with something Tegra specific.
> 
> True. The patch is already submitted. Do you think it's worth posting one
> just to fix that;

It's totally your call.

Regards,
Shawn

> it still seems pretty clear what's required?
> 

