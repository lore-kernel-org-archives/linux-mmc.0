From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [RFC PATCH] mmc: dw_mmc: add status check before clock update
Date: Tue, 10 Feb 2015 15:29:19 +0100
Message-ID: <1423578559-27947-1-git-send-email-a.hajda@samsung.com>
References: <1423572711-13787-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:37814 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307AbbBJO3b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 09:29:31 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJK00KL38FTN1B0@mailout4.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 Feb 2015 14:33:29 +0000 (GMT)
In-reply-to: <1423572711-13787-1-git-send-email-a.hajda@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

According to specs for version 250A, status register should be
tested before clock update. Otherwise in case MMC card is missing
mci_send_cmd timeouts and subsequent CTYPE registry write causes system hang.
This behavior has been observed on Exynos5422/Odroid-XU3.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi,

This version corrects usleep to usleep_range function call.

Regards
Andrzej
---
 drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 67c0451..6619c8a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -878,6 +878,25 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
+static bool dw_mci_wait_busy(struct dw_mci *host)
+{
+	unsigned long timeout;
+
+	if (host->verid < DW_MMC_250A)
+		return true;
+
+	timeout = jiffies + msecs_to_jiffies(500);
+	while (time_before(jiffies, timeout)) {
+		if (!(mci_readl(host, STATUS) & SDMMC_STATUS_BUSY))
+			return true;
+
+		usleep_range(1000, 2000);
+	}
+	dev_err(host->dev, "Busy timeout\n");
+
+	return false;
+}
+
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
@@ -891,8 +910,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
 
 	if (!clock) {
-		mci_writel(host, CLKENA, 0);
-		mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		if (dw_mci_wait_busy(host)) {
+			mci_writel(host, CLKENA, 0);
+			mci_send_cmd(slot, sdmmc_cmd_bits, 0);
+		} else
+			return;
 	} else if (clock != host->current_speed || force_clkinit) {
 		div = host->bus_hz / clock;
 		if (host->bus_hz % clock && host->bus_hz > clock)
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 0d0f7a27..ea6d4d1 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -15,6 +15,7 @@
 #define _DW_MMC_H_
 
 #define DW_MMC_240A		0x240a
+#define DW_MMC_250A		0x250a
 
 #define SDMMC_CTRL		0x000
 #define SDMMC_PWREN		0x004
-- 
1.9.1

