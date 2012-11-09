From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH 5/8] mmc: sdhci: fix coding style in sdhci_do_set_ios
Date: Fri,  9 Nov 2012 17:09:55 +0530
Message-ID: <1352461198-21941-6-git-send-email-tushar.behera@linaro.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42166 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2KILqI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 06:46:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2731136pad.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Nov 2012 03:46:08 -0800 (PST)
In-Reply-To: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 drivers/mmc/host/sdhci.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 28da461..b947155 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1386,9 +1386,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	 * or if it requires special setup code, you should implement that in
 	 * platform_8bit_width().
 	 */
-	if (host->ops->platform_8bit_width)
+	if (host->ops->platform_8bit_width) {
 		host->ops->platform_8bit_width(host, ios->bus_width);
-	else {
+	} else {
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 		if (ios->bus_width == MMC_BUS_WIDTH_8) {
 			ctrl &= ~SDHCI_CTRL_4BITBUS;
@@ -1467,9 +1467,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		clk &= ~SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-		if (host->ops->set_uhs_signaling)
+		if (host->ops->set_uhs_signaling) {
 			host->ops->set_uhs_signaling(host, ios->timing);
-		else {
+		} else {
 			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			/* Select Bus Speed Mode for host */
 			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
@@ -1492,8 +1492,9 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		clock = host->clock;
 		host->clock = 0;
 		sdhci_set_clock(host, clock);
-	} else
+	} else {
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 
 	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
-- 
1.7.4.1

