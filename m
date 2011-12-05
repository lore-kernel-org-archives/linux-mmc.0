From: <r66093@freescale.com>
Subject: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Mon, 5 Dec 2011 17:23:43 +0800
Message-ID: <1323077026-12071-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:54772
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755448Ab1LEKmv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:42:51 -0500
Received: from mail106-db3 (localhost [127.0.0.1])	by
 mail106-db3-R.bigfish.com (Postfix) with ESMTP id 364FD340338	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:42:50 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.254])	by
 mail106-db3.bigfish.com (Postfix) with ESMTP id 59F6C1C0046	for
 <linux-mmc@vger.kernel.org>; Mon,  5 Dec 2011 10:40:58 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add callback function sdhci_get_cd to detect the card.
In order to check if the card is present, we will read the PRESENT STATE
register and check the bit13(Card detect pin level) and bit15(CINS).

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 drivers/mmc/host/sdhci.c |   20 ++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6d8eea3..66afd82 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2,6 +2,7 @@
  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
+ *  Copyright (C) 2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1518,6 +1519,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 	return ret;
 }
 
+static int sdhci_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int present;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		present = 0;
+	else
+		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return (present & (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL));
+}
+
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
 	if (host->flags & SDHCI_DEVICE_DEAD)
@@ -1884,6 +1903,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
+	.get_cd		= sdhci_get_cd,
 	.hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a5b654..8ea7e00 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -69,6 +69,7 @@
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
 #define  SDHCI_DATA_AVAILABLE	0x00000800
 #define  SDHCI_CARD_PRESENT	0x00010000
+#define  SDHCI_CARD_CDPL	0x00040000
 #define  SDHCI_WRITE_PROTECT	0x00080000
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
-- 
1.7.5.4


