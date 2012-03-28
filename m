From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [Patch v1]mmc:core: correct mmc_erase_timeout calculation
Date: Wed, 28 Mar 2012 16:29:33 +0800
Message-ID: <20120328082933.GA27568@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12274 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab2C1Ie1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Mar 2012 04:34:27 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, adrian.hunter@intel.com

According to JEDEC 7.8.2, mmc_erase_timeout calculation should be follow:
1. Secure erase timeout = 300ms * ERASE_TIMEOUT_MULT * SEC_ERASE_MULT
2. Secure trim timeout = 300ms * ERASE_TIMEOUT_MULT * SEC_TRIM_MULT
3. Trim timeout = 300ms * TRIM_MULT
4. Erase timeout:
   a. if ERASE_GROUP_DEF is true: Erase timeout = 300ms * ERASE_TIMEOUT_MULT
   b. if ERASE_GROUP_DEF is false: Erase timeout = write block delay

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 14f262e..d9d6d1c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1405,12 +1405,36 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 {
 	unsigned int erase_timeout;
 
-	if (card->ext_csd.erase_group_def & 1) {
-		/* High Capacity Erase Group Size uses HC timeouts */
-		if (arg == MMC_TRIM_ARG)
-			erase_timeout = card->ext_csd.trim_timeout;
+	/*
+	 * JEDEC 7.8.2
+	 *
+	 * 1. Secure erase/trim timeout is calculated absed on Erase Timeout
+	 * and additional SEC_ERASE_MULT/SEC_TRIM_MULT.
+	 * So secure erase/trim timeout = ERASE Timeout * SEC_ERASE_MULT/
+	 * SEC_TRIM_MULT.
+	 * ERASE Timeout = 300ms * ERASE_TIMEOUT_MULT
+	 *
+	 * 2. trim timeout is calculated based on the TRIM_MULT factor.
+	 * So trim timeout = 300ms * TRIM_MULT
+	 *
+	 * 3. erase timeout calculation:
+	 *	a. if ERASE_GROUP_DEF is enabled, ERASE_TIMEOUT_MULT should be
+	 *	used to calculate erase timeout, so:
+	 *	erase timeout = 300 * ERASE_TIMEOUT_MULT
+	 *	b. if ERASE_GROUP_DEF is diabled, the duration of an erase
+	 *	command will be the number of Erase blocks to be erased
+	 *	multiplied by the block write delay.
+	 */
+	if (arg & MMC_SECURE_ARGS) {
+		erase_timeout = card->ext_csd.hc_erase_timeout;
+		if (arg == MMC_SECURE_ERASE_ARG)
+			erase_timeout *= card->ext_csd.sec_erase_mult;
 		else
-			erase_timeout = card->ext_csd.hc_erase_timeout;
+			erase_timeout *= card->ext_csd.sec_trim_mult;
+	} else if (arg & MMC_TRIM_ARGS) {
+		erase_timeout = card->ext_csd.trim_timeout;
+	} else if (card->ext_csd.erase_group_def & 1) {
+		erase_timeout = card->ext_csd.hc_erase_timeout;
 	} else {
 		/* CSD Erase Group Size uses write timeout */
 		unsigned int mult = (10 << card->csd.r2w_factor);
@@ -1441,14 +1465,6 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 			erase_timeout = 1;
 	}
 
-	/* Multiplier for secure operations */
-	if (arg & MMC_SECURE_ARGS) {
-		if (arg == MMC_SECURE_ERASE_ARG)
-			erase_timeout *= card->ext_csd.sec_erase_mult;
-		else
-			erase_timeout *= card->ext_csd.sec_trim_mult;
-	}
-
 	erase_timeout *= qty;
 
 	/*
-- 
1.7.1

