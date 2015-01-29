From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 02/15] mmc: core: Disable re-tuning when card is no longer initialized
Date: Thu, 29 Jan 2015 11:00:17 +0200
Message-ID: <1422522030-17793-3-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47307 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758253AbbA2JCe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:02:34 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Re-tuning is done before a request is sent to the card.
Host controller drivers can choose to enable re-tuning
when tuning is done during card initialization. To
ensure that re-tuning gets disabled, add disabling to
mmc_set_initial_state() which is called whenever the
card is powered on, off, or reset.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1be7055..e9ab5ff 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1137,6 +1137,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
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

