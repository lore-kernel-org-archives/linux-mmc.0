From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mmc: sdhci_am654: Make some symbols static
Date: Fri, 28 Jun 2019 12:07:51 +0800
Message-ID: <20190628040751.46196-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, faiz_abbas@ti.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-mmc@vger.kernel.org

Fix sparse warnings:

drivers/mmc/host/sdhci_am654.c:192:6: warning: symbol 'sdhci_j721e_4bit_set_clock' was not declared. Should it be static?
drivers/mmc/host/sdhci_am654.c:261:18: warning: symbol 'sdhci_j721e_8bit_ops' was not declared. Should it be static?
drivers/mmc/host/sdhci_am654.c:284:18: warning: symbol 'sdhci_j721e_4bit_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/sdhci_am654.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3b39481..bb90757 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -189,7 +189,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
-void sdhci_j721e_4bit_set_clock(struct sdhci_host *host, unsigned int clock)
+static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
+				       unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
@@ -258,7 +259,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
-struct sdhci_ops sdhci_j721e_8bit_ops = {
+static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -281,7 +282,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.flags = DLL_PRESENT,
 };
 
-struct sdhci_ops sdhci_j721e_4bit_ops = {
+static struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
2.7.4
