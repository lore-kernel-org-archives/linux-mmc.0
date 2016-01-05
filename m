From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 01/11] mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
Date: Tue, 5 Jan 2016 18:51:29 +0800
Message-ID: <1451991099-4946-2-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:14606 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbcAEKz6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2016 05:55:58 -0500
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-bcm2835
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
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
2.6.4

