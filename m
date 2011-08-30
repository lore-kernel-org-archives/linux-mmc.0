From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
Date: Tue, 30 Aug 2011 09:01:37 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D3F@HQMAIL01.nvidia.com>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
 <20110830034035.GC19294@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:17183 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab1H3QBu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 12:01:50 -0400
In-Reply-To: <20110830034035.GC19294@S2100-06.ap.freescale.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Shawn Guo wrote at Monday, August 29, 2011 9:41 PM:
> On Tue, Aug 23, 2011 at 12:15:33PM -0600, Stephen Warren wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Add hooks to read gpio configuration out of the device tree node.
...
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt
...
> > +* NVIDIA Tegra Secure Digital Host Controller
> > +
> > +This controller on Tegra family SoCs provides an interface for MMC, SD,
> > +and SDIO types of memory cards.
> > +
> > +Required properties:
> > +- compatible : Should be "nvidia,<chip>-sdhci"
> > +- reg : Should contain eSDHC registers location and length
> > +- interrupts : Should contain eSDHC interrupt
> 
> You may want to replace eSDHC with something Tegra specific.

True. The patch is already submitted. Do you think it's worth posting one
just to fix that; it still seems pretty clear what's required?

Thanks.

-- 
nvpublic

