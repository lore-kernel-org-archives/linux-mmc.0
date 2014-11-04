From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 03/15] mmc: sdhci: Fix ADMA table size warning
Date: Tue,  4 Nov 2014 12:42:37 +0200
Message-ID: <1415097769-19032-4-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbaKDKoZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:25 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The intent of the warning is to warn if the ADMA table
overflows.  However there can be one more 'end' entry
so the condition should be adjusted accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e759357..4436f77 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -555,7 +555,7 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		 * If this triggers then we have a calculation bug
 		 * somewhere. :/
 		 */
-		WARN_ON((desc - host->adma_desc) > ADMA_SIZE);
+		WARN_ON((desc - host->adma_desc) >= ADMA_SIZE);
 	}
 
 	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
-- 
1.9.1

