From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] SDHCI: Modify checks to determine the presense of card.
Date: Fri, 05 Mar 2010 12:29:37 +0530
Message-ID: <1267772377-14723-1-git-send-email-thomas.ab@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60792 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab0CEG6l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 01:58:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

In the sdhci_request function, the card is determined to be present based
on the SDCD pin status. SDHCI host controllers that do not use SDCD pin
but rely on other mechanism such as external pin interrupts, update the
host flags with SDHCI_DEVICE_DEAD flag based on the card insertion status.
This patch modifies the sdhci_request function such that the it uses
both the SDCD status and SDHCI_DEVICE_DEAD host flag to determine if the
card is inserted or not.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c279fbc..f1a6ebe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1106,7 +1106,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 				SDHCI_CARD_PRESENT;
 
-	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
+	if (!present && host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
 	} else
-- 
1.6.6.rc2

