From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/5] mmc: sdhci-sprd: add get_ro hook function
Date: Mon, 26 Aug 2019 11:18:27 +0800
Message-ID: <20190826031830.30931-3-zhang.lyra@gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support write protect to sd card.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d5871865a1e9..90cb2af91159 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -374,6 +374,11 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
+{
+	return 0;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -386,6 +391,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
+	.get_ro = sdhci_sprd_get_ro,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.20.1
