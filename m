From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 02/15] mmc: core: Enable / disable re-tuning
Date: Tue, 14 Apr 2015 16:12:13 +0300
Message-ID: <1429017146-15981-3-git-send-email-adrian.hunter@intel.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65351 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbbDNNOo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Apr 2015 09:14:44 -0400
In-Reply-To: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Enable re-tuning when tuning is executed and
disable re-tuning when card is no longer initialized.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..dd43f9b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1109,6 +1109,8 @@ int mmc_execute_tuning(struct mmc_card *card)
 
 	if (err)
 		pr_err("%s: tuning execution failed\n", mmc_hostname(host));
+	else
+		mmc_retune_enable(host);
 
 	return err;
 }
@@ -1140,6 +1142,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
  */
 void mmc_set_initial_state(struct mmc_host *host)
 {
+	mmc_retune_disable(host);
+
 	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
 	else
-- 
1.9.1

