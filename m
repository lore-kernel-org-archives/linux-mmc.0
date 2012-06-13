From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v5] mmc: add a function to get regulators, supplying card's
 power
Date: Wed, 13 Jun 2012 14:57:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206131454260.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Add a function to get regulators, supplying card's Vdd and Vccq on a
specific host. If a Vdd supplying regulator is found, the function checks,
whether a valid OCR mask can be obtained from it. The Vccq regulator is
optional. A failure to get it is not fatal.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v5: put struct mmc_supply inside struct mmc_host, thanks for all comments

 drivers/mmc/core/core.c  |   24 ++++++++++++++++++++++++
 include/linux/mmc/host.h |   16 ++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..4aa8658 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1013,6 +1013,30 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 }
 EXPORT_SYMBOL(mmc_regulator_set_ocr);
 
+int mmc_regulator_get_supply(struct mmc_host *mmc)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct regulator *supply;
+	int ret;
+
+	supply = devm_regulator_get(dev, "vmmc");
+
+	if (IS_ERR(supply))
+		return PTR_ERR(supply);
+
+	mmc->supply.vmmc = supply;
+	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
+
+	ret = mmc_regulator_get_ocrmask(supply);
+	if (ret > 0)
+		mmc->ocr_avail = ret;
+	else
+		dev_warn(mmc_dev(mmc), "Failed getting OCR mask: %d\n", ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
 #endif /* CONFIG_REGULATOR */
 
 /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0707d22..9deb725 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -155,6 +155,13 @@ struct mmc_hotplug {
 	void *handler_priv;
 };
 
+struct regulator;
+
+struct mmc_supply {
+	struct regulator *vmmc;		/* Card power supply */
+	struct regulator *vqmmc;	/* Optional Vccq supply */
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
@@ -309,6 +316,7 @@ struct mmc_host {
 #ifdef CONFIG_REGULATOR
 	bool			regulator_enabled; /* regulator state */
 #endif
+	struct mmc_supply	supply;
 
 	struct dentry		*debugfs_root;
 
@@ -357,13 +365,12 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 	wake_up_process(host->sdio_irq_thread);
 }
 
-struct regulator;
-
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_get_ocrmask(struct regulator *supply);
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
 			struct regulator *supply,
 			unsigned short vdd_bit);
+int mmc_regulator_get_supply(struct mmc_host *mmc);
 #else
 static inline int mmc_regulator_get_ocrmask(struct regulator *supply)
 {
@@ -376,6 +383,11 @@ static inline int mmc_regulator_set_ocr(struct mmc_host *mmc,
 {
 	return 0;
 }
+
+static inline int mmc_regulator_get_supply(struct mmc_host *mmc)
+{
+	return 0;
+}
 #endif
 
 int mmc_card_awake(struct mmc_host *host);
-- 
1.7.2.5

