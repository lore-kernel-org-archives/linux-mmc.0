From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/7] mmc: sdio: Fix invalid vdd in voltage switch power cycle
Date: Thu, 26 Nov 2015 14:00:47 +0200
Message-ID: <1448539250-18769-5-git-send-email-adrian.hunter@intel.com>
References: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21455 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609AbbKZMEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 07:04:09 -0500
In-Reply-To: <1448539250-18769-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wenkai Du <wenkai.du@intel.com>

The 'ocr' parameter passed to mmc_set_signal_voltage()
defines the power-on voltage used when power cycling
after a failure to set the voltage.  However, in the
case of mmc_sdio_init_card(), the value passed has the
R4_18V_PRESENT flag set which is not valid for power-on
and results in an invalid vdd.  Fix by passing the card's
ocr value which does not have the flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v3.13+
---
 drivers/mmc/core/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 16d838e6d623..d61ba1a0495e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -630,7 +630,7 @@ try_again:
 	 */
 	if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-					ocr);
+					ocr_card);
 		if (err == -EAGAIN) {
 			sdio_reset(host);
 			mmc_go_idle(host);
-- 
1.9.1

