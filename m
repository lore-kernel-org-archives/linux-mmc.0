From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 1/5] mmc: sdhci-pxav3: enable proper resuming on Armada 38x
 SoC
Date: Fri,  9 Oct 2015 03:03:51 +0200
Message-ID: <1444352635-21965-2-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444352635-21965-1-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: thomas.petazzoni@free-electrons.com, andrew@lunn.ch, ulf.hansson@linaro.org, jason@lakedaemon.net, tawfik@marvell.com, jaz@semihalf.com, nadavh@marvell.com, alior@marvell.com, gregory.clement@free-electrons.com, mw@semihalf.com, sebastian.hesselbarth@gmail.com
List-Id: linux-mmc@vger.kernel.org

When resuming from suspend on Armada 38x SoC MBus windows have to be
re-configured and for that purpose mv_conf_mbus_windows function needed
rework. MBus windows register base address obtaining was moved to
armada_38x_quirks function in order to be kept in pxa global structure,
because it is used during a resume.

This commit fixes resuming from suspend by calling MBus windows
configuration routine and therefore enabling proper DMA operation.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d..76b9a70 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -63,6 +63,7 @@ struct sdhci_pxa {
 	struct clk *clk_io;
 	u8	power_mode;
 	void __iomem *sdio3_conf_reg;
+	void __iomem *mbus_win_regs;
 };
 
 /*
@@ -81,30 +82,16 @@ struct sdhci_pxa {
 #define SDIO3_CONF_CLK_INV	BIT(0)
 #define SDIO3_CONF_SD_FB_CLK	BIT(2)
 
-static int mv_conf_mbus_windows(struct platform_device *pdev,
+static int mv_conf_mbus_windows(struct device *dev, void __iomem *regs,
 				const struct mbus_dram_target_info *dram)
 {
 	int i;
-	void __iomem *regs;
-	struct resource *res;
 
 	if (!dram) {
-		dev_err(&pdev->dev, "no mbus dram info\n");
-		return -EINVAL;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "cannot get mbus registers\n");
+		dev_err(dev, "no mbus dram info\n");
 		return -EINVAL;
 	}
 
-	regs = ioremap(res->start, resource_size(res));
-	if (!regs) {
-		dev_err(&pdev->dev, "cannot map mbus registers\n");
-		return -ENOMEM;
-	}
-
 	for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
 		writel(0, regs + SDHCI_WINDOW_CTRL(i));
 		writel(0, regs + SDHCI_WINDOW_BASE(i));
@@ -122,8 +109,6 @@ static int mv_conf_mbus_windows(struct platform_device *pdev,
 		writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
 	}
 
-	iounmap(regs);
-
 	return 0;
 }
 
@@ -135,6 +120,14 @@ static int armada_38x_quirks(struct platform_device *pdev,
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 	struct resource *res;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");
+	pxa->mbus_win_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pxa->mbus_win_regs)) {
+		dev_err(mmc_dev(host->mmc),
+			"failed to obtain MBus windows register base\n");
+		return PTR_ERR(pxa->mbus_win_regs);
+	}
+
 	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -403,7 +396,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
 			goto err_mbus_win;
-		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
+		ret = mv_conf_mbus_windows(&pdev->dev, pxa->mbus_win_regs,
+					   mv_mbus_dram_info());
 		if (ret < 0)
 			goto err_mbus_win;
 	}
@@ -520,6 +514,12 @@ static int sdhci_pxav3_resume(struct device *dev)
 {
 	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+
+	if (pxa->mbus_win_regs)
+		ret = mv_conf_mbus_windows(dev, pxa->mbus_win_regs,
+					   mv_mbus_dram_info());
 
 	pm_runtime_get_sync(dev);
 	ret = sdhci_resume_host(host);
-- 
1.8.3.1
