From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] MMC: SDHCI: Check mrq != NULL in sdhci_tasklet_finish
Date: Wed, 27 Apr 2011 14:24:20 +0100
Message-ID: <1303910660-21583-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303910660-21583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60862 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759185Ab1D0NYX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 09:24:23 -0400
In-Reply-To: <1303910660-21583-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

It seems that under certain circumstances the sdhci_tasklet_finish()
call can be entered with mrq set to NULL, causing the system to crash
with a NULL pointer de-reference.

Seen on S3C6410 system.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5553829..5c85352 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1384,7 +1384,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	 * upon error conditions.
 	 */
 	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
-	    ((mrq->cmd && mrq->cmd->error) ||
+	    mrq && ((mrq->cmd && mrq->cmd->error) ||
 		 (mrq->data && (mrq->data->error ||
 		  (mrq->data->stop && mrq->data->stop->error))) ||
 		   (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
-- 
1.7.4.1

