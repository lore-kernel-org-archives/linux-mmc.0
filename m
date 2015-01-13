From: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
Subject: [PATCH] mmc: host: sdhci: Added a space before (
Date: Tue, 13 Jan 2015 20:47:24 +0530
Message-ID: <1421162244-5980-1-git-send-email-md.jamalmohiuddin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57043 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbAMPRo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 10:17:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mohammad Jamal <md.jamalmohiuddin@gmail.com>

This patch solves the coding style issue by adding a space
before (

Signed-off-by: Mohammad Jamal <md.jamalmohiuddin@gmail.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1453cd1..910ee7b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1624,7 +1624,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	 * signalling timeout and CRC errors even on CMD0. Resetting
 	 * it on each ios seems to solve the problem.
 	 */
-	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
+	if (host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 	mmiowb();
-- 
1.7.9.5

