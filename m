From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] MMC: SDHCI: Check mrq != NULL in sdhci_tasklet_finish
Date: Wed, 30 Mar 2011 13:35:14 +0100
Message-ID: <1301488514-20963-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1301488514-20963-1-git-send-email-dp@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55723 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754175Ab1C3MfR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 08:35:17 -0400
In-Reply-To: <1301488514-20963-1-git-send-email-dp@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

It seems that under certain circumstances the sdhci_tasklet_finish()
call can be entered with mrq set to NULL, causing the system to crash
with a NULL pointer de-reference.

Seen on S3C6410 system.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e75d070..19f4ba6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1341,7 +1341,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	 * upon error conditions.
 	 */
 	if (!(host->flags & SDHCI_DEVICE_DEAD) &&
-	    ((mrq->cmd && mrq->cmd->error) ||
+	    mrq && ((mrq->cmd && mrq->cmd->error) ||
 		 (mrq->data && (mrq->data->error ||
 		  (mrq->data->stop && mrq->data->stop->error))) ||
 		   (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST))) {
-- 
1.7.4.2

