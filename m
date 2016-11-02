From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci: Reset cmd and data circuits after tuning failure
Date: Wed,  2 Nov 2016 15:49:10 +0200
Message-ID: <1478094551-24819-4-git-send-email-adrian.hunter@intel.com>
References: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754523AbcKBNyL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:11 -0400
In-Reply-To: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

To prevent subsequent commands failing, ensure the cmd and data circuits
are reset after a tuning timeout.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e7e1a70645e3..f8cb9a958738 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2083,6 +2083,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		if (!host->tuning_done) {
 			pr_info(DRIVER_NAME ": Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock\n");
+
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
+
 			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 			ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
-- 
1.9.1

