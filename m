From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 1/6] mmc: tmio: drop filenames from comment at top of source
Date: Wed, 10 May 2017 11:25:25 +0200
Message-ID: <1494408330-28161-2-git-send-email-horms+renesas@verge.net.au>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54120 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdEJJZx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 05:25:53 -0400
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Reshuffle the comment at the top of the source
dropping filenames and moving up human readable strings.

This seems to be somewhat more useful information to start the
source file with. It is also less fragile, f.e. to file renames.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc.c     | 8 +++-----
 drivers/mmc/host/tmio_mmc.h     | 7 +++----
 drivers/mmc/host/tmio_mmc_dma.c | 4 +---
 drivers/mmc/host/tmio_mmc_pio.c | 8 +++-----
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e897e7fc3b14..ff14311bddbe 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc.c
+ * Driver for the MMC / SD / SDIO cell found in:
+ *
+ * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
@@ -7,10 +9,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * Driver for the MMC / SD / SDIO cell found in:
- *
- * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  */
 
 #include <linux/device.h>
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d0edb5730d3f..08076d2bc3b0 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc.h
+ * Driver for the MMC / SD / SDIO cell found in:
+ *
+ * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -10,9 +12,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for the MMC / SD / SDIO cell found in:
- *
- * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  */
 
 #ifndef TMIO_MMC_H
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index e2093db2b7ff..98ce896b13e4 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -1,13 +1,11 @@
 /*
- * linux/drivers/mmc/tmio_mmc_dma.c
+ * DMA function for TMIO MMC implementations
  *
  * Copyright (C) 2010-2011 Guennadi Liakhovetski
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * DMA function for TMIO MMC implementations
  */
 
 #include <linux/device.h>
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a2d92f10501b..d816a1061639 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc_pio.c
+ * Driver for the MMC / SD / SDIO IP found in:
+ *
+ * TC6393XB, TC6391XB, TC6387XB, T7L66XB, ASIC3, SH-Mobile SoCs
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -11,10 +13,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for the MMC / SD / SDIO IP found in:
- *
- * TC6393XB, TC6391XB, TC6387XB, T7L66XB, ASIC3, SH-Mobile SoCs
- *
  * This driver draws mainly on scattered spec sheets, Reverse engineering
  * of the toshiba e800  SD driver and some parts of the 2.4 ASIC3 driver (4 bit
  * support). (Further 4 bit support from a later datasheet).
-- 
2.1.4

