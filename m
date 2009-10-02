From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/07] mmc: Remove const from tmio-mmc platform data
Date: Fri, 02 Oct 2009 11:22:32 +0900
Message-ID: <20091002022232.8215.10549.sendpatchset@rxone.opensource.se>
References: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:61326 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZJBC1G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 22:27:06 -0400
In-Reply-To: <20091002022158.8215.58317.sendpatchset@rxone.opensource.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

Remove const from the hclk member of the tmio-mmc platform
data. This to allow assigning a value dynamically to the
platform data in the SuperH Mobile SDHI driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the SuperH Mobile SDHI driver.

 drivers/mfd/sh_mobile_sdhi.c |    4 +---
 include/linux/mfd/tmio.h     |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

--- 0008/drivers/mfd/sh_mobile_sdhi.c
+++ work/drivers/mfd/sh_mobile_sdhi.c	2009-10-02 09:58:40.000000000 +0900
@@ -84,9 +84,7 @@ static int __init sh_mobile_sdhi_probe(s
 	}
 
 	clk_enable(priv->clk);
-
-	/* FIXME: silly const unsigned int hclk */
-	*(unsigned int *)&priv->mmc_data.hclk = clk_get_rate(priv->clk);
+	priv->mmc_data.hclk = clk_get_rate(priv->clk);
 
 	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
 	priv->cell_mmc.driver_data = &priv->mmc_data;
--- 0002/include/linux/mfd/tmio.h
+++ work/include/linux/mfd/tmio.h	2009-10-02 09:55:50.000000000 +0900
@@ -53,7 +53,7 @@ void tmio_core_mmc_clk_div(void __iomem 
  * data for the MMC controller
  */
 struct tmio_mmc_data {
-	const unsigned int		hclk;
+	unsigned int		hclk;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_no_clk_div)(struct platform_device *host, int state);
 };
