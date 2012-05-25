From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/5 v3] mmc: add a function to get a regulator, supplying card's Vdd
Date: Fri, 25 May 2012 17:45:24 +0200
Message-ID: <1337960752-4944-10-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Add a function to get a regulator, supplying card's Vdd on a specific host.
If such a regulator is found, the function checks, whether a valid OCR mask
can be obtained from this regulator.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: remove bogus attempts to ignore the dummy regulator, drop the check 
for whether the regulator can change status, do not assign 
MMC_CAP_POWER_OFF_CARD automatically. Thanks to Mark and Magnus for 
comments.

 drivers/mmc/core/core.c  |   17 +++++++++++++++++
 include/linux/mmc/host.h |    6 ++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..0f92ec0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1013,6 +1013,23 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 }
 EXPORT_SYMBOL(mmc_regulator_set_ocr);
 
+struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct regulator *supply = devm_regulator_get(dev, "vmmc");
+	int ret;
+
+	if (IS_ERR(supply))
+		return NULL;
+
+	ret = mmc_regulator_get_ocrmask(supply);
+	if (ret > 0)
+		mmc->ocr_avail = ret;
+
+	return supply;
+}
+EXPORT_SYMBOL(mmc_regulator_get_vmmc);
+
 #endif /* CONFIG_REGULATOR */
 
 /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0707d22..368b317 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -364,6 +364,7 @@ int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -376,6 +377,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 {
 	return 0;
 }
+
+static inline struct regulator *mmc_regulator_get_vmmc(struct mmc_host *mmc)
+{
+	return NULL;
+}
 #endif
 
 int mmc_card_awake(struct mmc_host *host);
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
