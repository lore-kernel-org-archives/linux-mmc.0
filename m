From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
	initialization
Date: Wed, 18 Apr 2012 16:29:56 +0100
Message-ID: <20120418152956.GP25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk> <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57882 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab2DRPaP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 11:30:15 -0400
Content-Disposition: inline
In-Reply-To: <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Apr 18, 2012 at 08:53:32PM +0530, T Krishnamoorthy, Balaji wrote:
> Hi,
> 
> drivers/mmc/host/omap.c is also using dma_mask should that also be removed

Does this driver make use of this platform data?

If so, it needs converting to DMA engine _before_ this patch (which is
one reason why its a good idea to do these changes as separate patches...
as I've done.)  It means stuff like this can be slotted in as necessary
in the patch order.

I'm told that driver is OMAP2 only - I don't have any OMAP2 platforms to
be able to test it on (I only have OMAP3 and OMAP4.)
