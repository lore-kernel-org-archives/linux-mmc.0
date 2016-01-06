From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v3 01/12] mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
Date: Wed, 6 Jan 2016 18:31:32 +0800
Message-ID: <1452076303-1960-2-git-send-email-jszhang@marvell.com>
References: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452076303-1960-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-bcm2835
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-bcm2835.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 1c65d46..4a6a1d1 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -74,7 +74,7 @@ static inline u32 bcm2835_sdhci_readl(struct sdhci_host *host, int reg)
 static void bcm2835_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct bcm2835_sdhci *bcm2835_host = pltfm_host->priv;
+	struct bcm2835_sdhci *bcm2835_host = sdhci_pltfm_priv(pltfm_host);
 	u32 oldval = (reg == SDHCI_COMMAND) ? bcm2835_host->shadow :
 		bcm2835_sdhci_readl(host, reg & ~3);
 	u32 word_num = (reg >> 1) & 1;
@@ -152,20 +152,12 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	int ret;
 
-	host = sdhci_pltfm_init(pdev, &bcm2835_sdhci_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &bcm2835_sdhci_pdata,
+				sizeof(*bcm2835_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	bcm2835_host = devm_kzalloc(&pdev->dev, sizeof(*bcm2835_host),
-					GFP_KERNEL);
-	if (!bcm2835_host) {
-		dev_err(mmc_dev(host->mmc),
-			"failed to allocate bcm2835_sdhci\n");
-		return -ENOMEM;
-	}
-
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = bcm2835_host;
 
 	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pltfm_host->clk)) {
-- 
2.7.0.rc3
