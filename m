From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/2] mmc: sdio: Tidy error path in mmc_attach_sdio()
Date: Fri,  9 Jun 2017 15:27:17 +0300
Message-ID: <1497011238-9573-2-git-send-email-adrian.hunter@intel.com>
References: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18608 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdFIMdS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Jun 2017 08:33:18 -0400
In-Reply-To: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The error path deletes the device by calling mmc_sdio_remove() which must
be called without the host claimed. Simplify the error path so it does just
that and add a comment about why we don't disable runtime PM.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sdio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index fae732c870a9..f077fc8219d0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1159,15 +1159,14 @@ int mmc_attach_sdio(struct mmc_host *host)
 	return 0;
 
 
-remove_added:
-	/* Remove without lock if the device has been added. */
-	mmc_sdio_remove(host);
-	mmc_claim_host(host);
 remove:
-	/* And with lock if it hasn't been added. */
 	mmc_release_host(host);
-	if (host->card)
-		mmc_sdio_remove(host);
+remove_added:
+	/*
+	 * The devices are being deleted so it is not necessary to disable
+	 * runtime PM.
+	 */
+	mmc_sdio_remove(host);
 	mmc_claim_host(host);
 err:
 	mmc_detach_bus(host);
-- 
1.9.1

