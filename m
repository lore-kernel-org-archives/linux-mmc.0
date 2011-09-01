From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: Fix Ignore obselete ext csd in eMMC4.5
Date: Thu,  1 Sep 2011 11:49:51 +0530
Message-ID: <1314857991-6848-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

In the eMMC 4.5 specification the EC_ERASE_MULT and
SEC_TRIM_MULT have become obselete and donot carry
any valid information.
	This patch makes sure that the above mentioned
parameters are used only for versions below eMMC 4.5.
All the versions above 4.5 will ignore their usage by
assuming them as dont cares.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91a0a74..47ce1e4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1351,8 +1351,12 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 			erase_timeout = 1;
 	}
 
-	/* Multiplier for secure operations */
-	if (arg & MMC_SECURE_ARGS) {
+	/* Multiplier for secure operations
+	 * eMMC 4.5 specification defines these values
+	 * sec_erase_mult,sec_trim_mult as obselete(so dont care).
+	 * These multipliers are only valid for versions < eMMC 4.5
+	 */
+	if ((arg & MMC_SECURE_ARGS) && (card->ext_csd.rev < 6)) {
 		if (arg == MMC_SECURE_ERASE_ARG)
 			erase_timeout *= card->ext_csd.sec_erase_mult;
 		else
-- 
1.7.1
