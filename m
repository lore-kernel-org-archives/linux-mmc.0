From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci-xenon: kill xenon_clean_phy()
Date: Tue, 16 May 2017 14:17:20 +0800
Message-ID: <20170516061720.1755-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adrian.hunter@intel.com, huziji@marvell.com, ulf.hansson@linaro.org
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Currently, the xenon_clean_phy() is only used for freeing phy_params.
The phy_params is allocated by devm_kzalloc(), there's no need to free
is explicitly.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 14 +-------------
 drivers/mmc/host/sdhci-xenon.c     |  6 +-----
 drivers/mmc/host/sdhci-xenon.h     |  1 -
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index 6356781f1cca..f7e26b031e76 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -787,14 +787,6 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
 	return ret;
 }
 
-void xenon_clean_phy(struct sdhci_host *host)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
-
-	kfree(priv->phy_params);
-}
-
 static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
 			 const char *phy_name)
 {
@@ -819,11 +811,7 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
 	if (ret)
 		return ret;
 
-	ret = xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
-	if (ret)
-		xenon_clean_phy(host);
-
-	return ret;
+	return xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
 }
 
 int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 67246655315b..bc1781bb070b 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -486,7 +486,7 @@ static int xenon_probe(struct platform_device *pdev)
 
 	err = xenon_sdhc_prepare(host);
 	if (err)
-		goto clean_phy_param;
+		goto err_clk;
 
 	err = sdhci_add_host(host);
 	if (err)
@@ -496,8 +496,6 @@ static int xenon_probe(struct platform_device *pdev)
 
 remove_sdhc:
 	xenon_sdhc_unprepare(host);
-clean_phy_param:
-	xenon_clean_phy(host);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 free_pltfm:
@@ -510,8 +508,6 @@ static int xenon_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
-	xenon_clean_phy(host);
-
 	sdhci_remove_host(host, 0);
 
 	xenon_sdhc_unprepare(host);
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 6e6523ea01ce..73debb42dc2f 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -93,7 +93,6 @@ struct xenon_priv {
 };
 
 int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
-void xenon_clean_phy(struct sdhci_host *host);
 int xenon_phy_parse_dt(struct device_node *np,
 		       struct sdhci_host *host);
 void xenon_soc_pad_ctrl(struct sdhci_host *host,
-- 
2.11.0
