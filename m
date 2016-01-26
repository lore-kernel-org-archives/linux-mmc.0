From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v4 04/13] mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
Date: Tue, 26 Jan 2016 18:15:44 +0800
Message-ID: <1453803353-6266-5-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, arnd@arndb.de, ludovic.desroches@atmel.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-msm
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-msm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index ffac9b4..0653fe7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -442,16 +442,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u32 core_version, caps;
 	u8 core_major;
 
-	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
-	if (!msm_host)
-		return -ENOMEM;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = msm_host;
+	msm_host = sdhci_pltfm_priv(pltfm_host);
 	msm_host->mmc = host->mmc;
 	msm_host->pdev = pdev;
 
@@ -571,16 +567,16 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = pltfm_host->priv;
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) ==
 		    0xffffffff);
 
 	sdhci_remove_host(host, dead);
-	sdhci_pltfm_free(pdev);
 	clk_disable_unprepare(msm_host->clk);
 	clk_disable_unprepare(msm_host->pclk);
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
+	sdhci_pltfm_free(pdev);
 	return 0;
 }
 
-- 
2.7.0
