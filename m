From: Chris Ball <cjb@laptop.org>
Subject: Re: drivers/mmc/host/sdhci-of-core.c on sparc64
Date: Fri, 14 Jan 2011 01:12:13 +0000
Message-ID: <20110114011212.GA22374@void.printf.net>
References: <20110113151033.dbfd7524.akpm@linux-foundation.org> <20110113233828.GA21404@void.printf.net> <20110113154140.7176df4c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51865 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab1ANBMT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jan 2011 20:12:19 -0500
Content-Disposition: inline
In-Reply-To: <20110113154140.7176df4c.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>

Hi,

On Thu, Jan 13, 2011 at 03:41:40PM -0800, Andrew Morton wrote:
> > > drivers/mmc/host/sdhci-of-core.c:24:25: asm/machdep.h: No such file or directory
> > > drivers/mmc/host/sdhci-of-core.c: In function `sdhci_of_wp_inverted':
> > > drivers/mmc/host/sdhci-of-core.c:115: error: implicit declaration of function `machine_is'
> > > 
> > > That code's been there for a while.  Did someone change Kconfig?
> > 
> > Can you attach a .config?  <asm/machdep.h> is arch-specific, so I'd
> > suggest that you're building on an unsupported arch.
> > 
> 
> sparc64 allmodconfig.

You're right, Andrew -- Rob (CC'd) changed the MMC Kconfig to build this
driver on Sparc.  Mainline commit 236cdc7bc71 ("of: make drivers depend
on CONFIG_OF instead of CONFIG_PPC_OF").

Rob also posted a patch to devicetree-discuss@, on top of the one above
("mmc: sdhci-of: fix build on non-powerpc platforms"), to fix up the
Sparc build by ifdef'ing for PPC inside the driver.  Grant merged the
first patch but not the second, hence sparc64 allmodconfig is broken
now.  The reason Grant didn't merge the second patch may be that Wolfram
objected to #ifdef proliferation inside the driver.

Options, as I see it:
 * revert the commit such that MMC_SDHCI_OF once again depends on PPC_OF
 * take the second patch as-is
 * come up with a less-#ifdeffy second patch

Wolfram, would appreciate your input on what we should do here.  Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
