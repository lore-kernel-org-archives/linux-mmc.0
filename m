From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] mmc: core: Add helper for mapping IOS voltage to string
Date: Tue, 12 Jul 2016 16:08:21 +0200
Message-ID: <1468332502-28016-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Add a helper for producing a user-friendly string with chosen signaling
voltage.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mmc/core/debugfs.c | 15 +--------------
 drivers/mmc/core/host.c    | 13 +++++++++++++
 include/linux/mmc/host.h   |  2 ++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c8451ce557ae..1b669cafea12 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -157,20 +157,7 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	}
 	seq_printf(s, "timing spec:\t%u (%s)\n", ios->timing, str);
 
-	switch (ios->signal_voltage) {
-	case MMC_SIGNAL_VOLTAGE_330:
-		str = "3.30 V";
-		break;
-	case MMC_SIGNAL_VOLTAGE_180:
-		str = "1.80 V";
-		break;
-	case MMC_SIGNAL_VOLTAGE_120:
-		str = "1.20 V";
-		break;
-	default:
-		str = "invalid";
-		break;
-	}
+	str = mmc_voltage_to_str(ios);
 	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->signal_voltage, str);
 
 	switch (ios->drv_type) {
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d7e86f9b3dab..6708bea84a0d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -469,3 +469,16 @@ void mmc_free_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_free_host);
+
+const char *mmc_voltage_to_str(struct mmc_ios *ios)
+{
+	static const char * const voltages[] = {
+		[MMC_SIGNAL_VOLTAGE_330] = "3.30 V",
+		[MMC_SIGNAL_VOLTAGE_180] = "1.80 V",
+		[MMC_SIGNAL_VOLTAGE_120] = "1.20 V",
+	};
+
+	if (ios->signal_voltage <= MMC_SIGNAL_VOLTAGE_120)
+		return voltages[ios->signal_voltage];
+	return "invalid";
+}
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index aa4bfbf129e4..e1e87d3432d8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -544,4 +544,6 @@ static inline void mmc_retune_recheck(struct mmc_host *host)
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
+const char *mmc_voltage_to_str(struct mmc_ios *ios);
+
 #endif /* LINUX_MMC_HOST_H */
-- 
1.9.1
