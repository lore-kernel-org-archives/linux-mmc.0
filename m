From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/8] mmc: omap_hsmmc: add DMA engine support
Date: Wed, 18 Apr 2012 11:11:12 -0700
Message-ID: <20120418181112.GK21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRs1-0004bP-HH@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2DRSLX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 14:11:23 -0400
Content-Disposition: inline
In-Reply-To: <E1SKRs1-0004bP-HH@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

* Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
> Add DMA engine support to the OMAP HSMMC driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.

Glad to see this happening!

No luck here though, after a quick test I'm getting the following with MMC
not working:

zoom3
[    2.277160] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
[    2.284729] omap_hsmmc omap_hsmmc.2: unable to obtain RX DMA engine channel 78
[    2.292999] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
blaze
[    1.681610] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
[    1.689331] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
[    1.697174] omap_hsmmc omap_hsmmc.4: unable to obtain RX DMA engine channel 60
n900
[    2.492248] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
[    2.500488] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48

And leaving out patch 7/8 produces similar errors for both rx and tx, but MMC
works without DMA:

n900
[    2.478363] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
[    2.486267] omap_hsmmc omap_hsmmc.0: unable to obtain TX DMA engine channel 61
[    2.718322] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
[    2.726135] omap_hsmmc omap_hsmmc.1: unable to obtain TX DMA engine channel 47


Regards,

Tony
