From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 1/7] mmc: core: move ocr-bit to voltage translation into separate function
Date: Mon, 12 Oct 2015 14:48:24 +0200
Message-ID: <1444654110-32293-2-git-send-email-heiko@sntech.de>
References: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:52087 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbbJLMsk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Oct 2015 08:48:40 -0400
In-Reply-To: <1444654110-32293-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

We will shortly need the calculation of an ocr-bit to the actual
voltage in a second place too, so move it from mmc_regulator_set_ocr
to a common function mmc_ocrbitnum_to_vdd to make that possible.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/core/core.c | 51 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0520064..548b5e1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1265,6 +1265,40 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+/**
+ * mmc_ocrbitnum_to_vdd - Convert a OCR bit number to its voltage
+ * @vdd_bit:	OCR bit number
+ * @min_uV:	minimum voltage value (mV)
+ * @max_uV:	maximum voltage value (mV)
+ *
+ * This function returns the voltage range according to the provided OCR
+ * bit number. If conversion is not possible a negative errno value returned.
+ */
+static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
+{
+	int		tmp;
+
+	if (!vdd_bit)
+		return -EINVAL;
+
+	/*
+	 * REVISIT mmc_vddrange_to_ocrmask() may have set some
+	 * bits this regulator doesn't quite support ... don't
+	 * be too picky, most cards and regulators are OK with
+	 * a 0.1V range goof (it's a small error percentage).
+	 */
+	tmp = vdd_bit - ilog2(MMC_VDD_165_195);
+	if (tmp == 0) {
+		*min_uV = 1650 * 1000;
+		*max_uV = 1950 * 1000;
+	} else {
+		*min_uV = 1900 * 1000 + tmp * 100 * 1000;
+		*max_uV = *min_uV + 100 * 1000;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_OF
 
 /**
@@ -1401,22 +1435,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	int			min_uV, max_uV;
 
 	if (vdd_bit) {
-		int		tmp;
-
-		/*
-		 * REVISIT mmc_vddrange_to_ocrmask() may have set some
-		 * bits this regulator doesn't quite support ... don't
-		 * be too picky, most cards and regulators are OK with
-		 * a 0.1V range goof (it's a small error percentage).
-		 */
-		tmp = vdd_bit - ilog2(MMC_VDD_165_195);
-		if (tmp == 0) {
-			min_uV = 1650 * 1000;
-			max_uV = 1950 * 1000;
-		} else {
-			min_uV = 1900 * 1000 + tmp * 100 * 1000;
-			max_uV = min_uV + 100 * 1000;
-		}
+		mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
 
 		result = regulator_set_voltage(supply, min_uV, max_uV);
 		if (result == 0 && !mmc->regulator_enabled) {
-- 
2.6.1

