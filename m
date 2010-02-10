From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Wed, 10 Feb 2010 11:51:57 +0000
Message-ID: <cover.1265801967.git.david.vrabel@csr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42982 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab0BJLwd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Feb 2010 06:52:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: David Vrabel <david.vrabel@csr.com>, linux-omap@vger.kernel.org, madhu.cr@ti.com

These patches add support for SDIO cards to the omap_hsmmc driver.  Less
restrictions on the sizes of transfers, power management changes to 
prevent SDIO cards from being turned off and losing all state, and card
interrupts.

I've been unable to test these exact patches as I only have an N900 for 
testing and the N900 support in mainline is incomplete.

David Vrabel (3):
  mmc: omap_hsmmc: use packet sync'd DMA
  mmc: omap_hsmmc: don't turn SDIO cards off when idle
  mmc: omap_hsmmc: enable SDIO card interrupts

 drivers/mmc/host/omap_hsmmc.c |  123 ++++++++++++++++++++++++++---------------
 1 files changed, 78 insertions(+), 45 deletions(-)

-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/

