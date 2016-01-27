From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 09/25] mmc: sdhci: allocate alignment and DMA
 descriptor buffer together
Date: Wed, 27 Jan 2016 19:50:57 +0000
Message-ID: <20160127195057.GH10826@n2100.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
 <E1aO3qd-0005iN-OG@rmk-PC.arm.linux.org.uk>
 <56A88A81.8090505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40285 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966795AbcA0TvM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 14:51:12 -0500
Content-Disposition: inline
In-Reply-To: <56A88A81.8090505@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Wed, Jan 27, 2016 at 11:14:41AM +0200, Adrian Hunter wrote:
> On 26/01/16 15:39, Russell King wrote:
> > -		} else if (host->adma_addr & (SDHCI_ADMA2_DESC_ALIGN - 1)) {
> > +		} else if (dma & SDHCI_ADMA2_MASK) {
> 
> The descriptor table has a bigger alignment requirement, so that should remain the check i.e.
> 
> 		} else if ((dma + host->align_buffer_sz) & (SDHCI_ADMA2_DESC_ALIGN - 1)) {

No other comments?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
