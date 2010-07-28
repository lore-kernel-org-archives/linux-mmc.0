From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 1/3] mmc: Auto CMD12 support for eSDHC driver
Date: Wed, 28 Jul 2010 14:03:50 +0800
Message-ID: <1280297030-25686-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:26053
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752012Ab0G1GSH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 02:18:07 -0400
Received: from mail15-va3 (localhost.localdomain [127.0.0.1])	by
 mail15-va3-R.bigfish.com (Postfix) with ESMTP id 9F00F6F048A	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:06 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.238])	by
 mail15-va3.bigfish.com (Postfix) with ESMTP id 1987E30804F	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:06 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o6S6I1RF015257	for <linux-mmc@vger.kernel.org>; Tue, 27 Jul 2010 23:18:01
 -0700 (MST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chang-Ming.Huang@freescale.com

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add auto CMD12 command support for eSDHC driver.
This is needed by P4080 and P1022 for block read/write.
Manual asynchronous CMD12 abort operation causes protocol violations on
these silicons.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    4 ++++
 drivers/mmc/host/sdhci.c         |   14 ++++++++++++--
 drivers/mmc/host/sdhci.h         |    3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index a2e9820..0c30242 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -154,6 +154,10 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 		host->ops = &sdhci_of_data->ops;
 	}
 
+	if (of_get_property(np, "fsl,sdhci-auto-cmd12", NULL))
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..1424d08 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ * Copyright 2010 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -817,8 +818,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	WARN_ON(!host->data);
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
-	if (data->blocks > 1)
-		mode |= SDHCI_TRNS_MULTI;
+	if (data->blocks > 1) {
+		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
+		else
+			mode |= SDHCI_TRNS_MULTI;
+	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
 	if (host->flags & SDHCI_REQ_USE_DMA)
@@ -1108,6 +1113,11 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
 #endif
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+		if (mrq->stop) {
+			mrq->data->stop = NULL;
+			mrq->stop = NULL;
+		}
 
 	host->mrq = mrq;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..aa112aa 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/sdhci.h - Secure Digital Host Controller Interface driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ * Copyright 2010 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -240,6 +241,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller uses Auto CMD12 command to stop the transfer */
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5


