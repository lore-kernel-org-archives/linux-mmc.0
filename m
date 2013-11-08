From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/8] mmc: tmio: Extract bus_width modifications to a function
Date: Fri,  8 Nov 2013 07:06:14 +0100
Message-ID: <1383890776-6912-7-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35892 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGGe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:34 -0500
Received: by mail-la0-f53.google.com with SMTP id eh20so1360008lab.40
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:33 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 33a5e26..fefe86c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -837,6 +837,19 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
 		host->set_pwr(host->pdev, 0);
 }
 
+static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
+				unsigned char bus_width)
+{
+	switch (bus_width) {
+	case MMC_BUS_WIDTH_1:
+		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
+		break;
+	case MMC_BUS_WIDTH_4:
+		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
+		break;
+	}
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -920,16 +933,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
-	if (host->power != TMIO_MMC_OFF_STOP) {
-		switch (ios->bus_width) {
-		case MMC_BUS_WIDTH_1:
-			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
-		break;
-		case MMC_BUS_WIDTH_4:
-			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
-		break;
-		}
-	}
+	if (host->power != TMIO_MMC_OFF_STOP)
+		tmio_mmc_set_bus_width(host, ios->bus_width);
 
 	/* Let things settle. delay taken from winCE driver */
 	udelay(140);
-- 
1.7.9.5

