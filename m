From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 02/15] mmc: core: Disable re-tuning when card is no longer initialized
Date: Fri, 27 Mar 2015 22:57:30 +0200
Message-ID: <1427489863-9050-3-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbbC0U7v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 16:59:51 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

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
index c296bc0..2679264 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1140,6 +1140,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
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

