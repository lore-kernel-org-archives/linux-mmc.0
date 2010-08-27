From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Fri, 27 Aug 2010 20:22:48 +0100
Message-ID: <20100827192248.GJ20407@void.printf.net>
References: <cover.1266847842.git.david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49673 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab0H0TWu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:22:50 -0400
Content-Disposition: inline
In-Reply-To: <cover.1266847842.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, Mike Rapoport <mike@compulab.co.il>

Hi David,

On Mon, Feb 22, 2010 at 02:24:17PM +0000, David Vrabel wrote:
> These patches add support for SDIO cards to the omap_hsmmc driver.
> Power management changes to prevent SDIO cards from being turned off
> and losing all state, and card interrupts.
> 
> I've been unable to test these exact patches as I only have an N900 for 
> testing and the N900 support in mainline is incomplete.
> 
> Changes since v1:
> - (hopefully) get all cards working again by removing a second call to
>   read MMCi_STAT in the interrupt handler.
> - flush posted writes after enabling/disabling SDIO interrupts.
> - tweak the FIXME commit on disabling FCLK to better match what really
>   going on (at least I think so anyway).
> 
> David Vrabel (2):
>   mmc: omap_hsmmc: don't turn SDIO cards off when idle
>   mmc: omap_hsmmc: enable SDIO card interrupts

Looks like this patchset wasn't merged.  Mike Rapoport replied with a 
fix for libertas.  Would you like to resubmit it?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
