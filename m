From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 0/7] mmc: omap: Fixes, cleanup and add ERASE capability
Date: Sat, 22 Feb 2014 18:01:36 +0200
Message-ID: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:49621 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbaBVQRr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 11:17:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>

I've sent these patches earlier early December. See
http://www.spinics.net/lists/linux-mmc/msg23540.html

Resending now as mmc.git is updated over v3.13-rc2-208-g8ecffd791448.
No other changes than added Acked-by and Tested-by lines from Tony and Aaro.
Note Jarkko Lavinen is not cc'ed since he no longer works for Samsung and I
don't know his personal address.

Set goes on top of mmc.git v3.14-rc2-10-g7536d3f83aa4.

Jarkko Nikula (7):
  mmc: omap: Fix NULL pointer dereference due uninitialized
    cover_tasklet
  mmc: omap: Convert to devm_kzalloc
  mmc: omap: Remove duplicate host->irq assignment
  mmc: omap: Remove mem_res field from struct mmc_omap_host
  mmc: omap: Convert to devm_ioremap_resource
  mmc: omap: Remove always set use_dma flag from struct mmc_omap_host
  mmc: omap: Add erase capability

 drivers/mmc/host/omap.c | 93 +++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

-- 
1.8.5.3

