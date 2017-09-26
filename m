From: Colin King <colin.king@canonical.com>
Subject: [PATCH][sdhci-next] mmc: sdhci-omap: make three functions static, fixes warnings
Date: Tue, 26 Sep 2017 15:55:46 +0100
Message-ID: <20170926145546.17206-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The functions sdhci_omap_set_ios, sdhci_omap_set_power and
sdhci_omap_get_min_clock are local to the source and do not need
to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'sdhci_omap_set_ios' was not declared. Should it be static?
symbol 'sdhci_omap_set_power' was not declared. Should it be static?
symbol 'sdhci_omap_get_min_clock' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5ddae39816b7..628bfe9a3d17 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -262,7 +262,7 @@ static void sdhci_omap_set_bus_mode(struct sdhci_omap_host *omap_host,
 	omap_host->bus_mode = mode;
 }
 
-void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+static void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_pltfm_host *pltfm_host;
@@ -323,7 +323,7 @@ static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_omap_start_clock(omap_host);
 }
 
-void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
+static void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -344,7 +344,7 @@ static int sdhci_omap_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
-unsigned int sdhci_omap_get_min_clock(struct sdhci_host *host)
+static unsigned int sdhci_omap_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
-- 
2.14.1
