From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 04/11] mmc: sdhci-of-arasan: use sdhci_pltfm_init for private
 allocation
Date: Tue, 5 Jan 2016 18:51:32 +0800
Message-ID: <1451991099-4946-5-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: Jisheng Zhang <jszhang@marvell.com>, kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates the
sdhci-of-arasan driver to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 75379cb..53c8d36 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -81,7 +81,7 @@ static int sdhci_arasan_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = sdhci_suspend_host(host);
@@ -106,7 +106,7 @@ static int sdhci_arasan_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
 	ret = clk_enable(sdhci_arasan->clk_ahb);
@@ -137,10 +137,13 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 
-	sdhci_arasan = devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
-			GFP_KERNEL);
-	if (!sdhci_arasan)
-		return -ENOMEM;
+	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata,
+				sizeof(*sdhci_arasan));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
@@ -166,20 +169,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}
 
-	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
-	if (IS_ERR(host)) {
-		ret = PTR_ERR(host);
-		goto clk_disable_all;
-	}
-
 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
 		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
 	}
 
 	sdhci_get_of_property(pdev);
-	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
 
 	ret = mmc_of_parse(host->mmc);
@@ -208,7 +203,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
-- 
2.6.4
