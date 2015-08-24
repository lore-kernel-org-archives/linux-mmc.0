From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 2/2] mmc: core: sdio: claim host before power up or power off
Date: Mon, 24 Aug 2015 15:45:17 +0530
Message-ID: <1440411317-8813-2-git-send-email-kishon@ti.com>
References: <1440411317-8813-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44539 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbbHXKPa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Aug 2015 06:15:30 -0400
In-Reply-To: <1440411317-8813-1-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: adrian.hunter@intel.com, neilb@suse.de, zhonghui.fu@linux.intel.com, afenkart@gmail.com, kishon@ti.com

mmc_sdio_runtime_resume and mmc_sdio_runtime_suspend does power up and
power off respectively but does so without claiming the host. Among other
things mmc_claim_host inovkes pm_runtime_get_sync to enable the clocks.
Invoke mmc_claim_host before mmc_power_up and mmc_power_off in
mmc_sdio_runtime_resume and mmc_sdio_runtime_suspend respectively.

This is required since certain platforms (like TI SoCs) access
the controller registers during power up.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/core/sdio.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0cbbfb8..40795b2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1023,16 +1023,24 @@ static int mmc_sdio_power_restore(struct mmc_host *host)
 
 static int mmc_sdio_runtime_suspend(struct mmc_host *host)
 {
+	mmc_claim_host(host);
 	/* No references to the card, cut the power to it. */
 	mmc_power_off(host);
+	mmc_release_host(host);
 	return 0;
 }
 
 static int mmc_sdio_runtime_resume(struct mmc_host *host)
 {
+	int ret;
+
+	mmc_claim_host(host);
 	/* Restore power and re-initialize. */
 	mmc_power_up(host, host->card->ocr);
-	return mmc_sdio_power_restore(host);
+	ret = _mmc_sdio_power_restore(host);
+	mmc_release_host(host);
+
+	return ret;
 }
 
 static int mmc_sdio_reset(struct mmc_host *host)
-- 
1.7.9.5

