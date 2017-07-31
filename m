From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] mmc: sdhci-cadence: add suspend / resume support
Date: Mon, 31 Jul 2017 21:56:49 +0900
Message-ID: <1501505809-393-4-git-send-email-yamada.masahiro@socionext.com>
References: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:52619 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdGaM6U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2017 08:58:20 -0400
In-Reply-To: <1501505809-393-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, Adrian Hunter <adrian.hunter@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Currently, the probe function initializes the PHY, but PHY settings
are lost during the sleep state.  Restore the PHY registers when
resuming.

To facilitate this, split sdhci_cdns_phy_init() into the DT parse
part and PHY update part so that the latter can be invoked from the
resume hook.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 77 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 19d5698244b5..7473766801a5 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -67,9 +67,16 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
+struct sdhci_cdns_phy_param {
+	u8 addr;
+	u8 data;
+};
+
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_phy_param phy_params[0];
 };
 
 struct sdhci_cdns_phy_cfg {
@@ -115,9 +122,22 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 	return 0;
 }
 
-static int sdhci_cdns_phy_init(struct device_node *np,
-			       struct sdhci_cdns_priv *priv)
+static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
 {
+	unsigned int count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
+		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
+			count++;
+
+	return count;
+}
+
+static void sdhci_cdns_phy_param_parse(struct device_node *np,
+				       struct sdhci_cdns_priv *priv)
+{
+	struct sdhci_cdns_phy_param *p = priv->phy_params;
 	u32 val;
 	int ret, i;
 
@@ -127,9 +147,19 @@ static int sdhci_cdns_phy_init(struct device_node *np,
 		if (ret)
 			continue;
 
-		ret = sdhci_cdns_write_phy_reg(priv,
-					       sdhci_cdns_phy_cfgs[i].addr,
-					       val);
+		p->addr = sdhci_cdns_phy_cfgs[i].addr;
+		p->data = val;
+		p++;
+	}
+}
+
+static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+{
+	int ret, i;
+
+	for (i = 0; i < priv->nr_phy_params; i++) {
+		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
+					       priv->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -302,6 +332,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
+	size_t priv_size;
+	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 
@@ -313,7 +345,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, sizeof(*priv));
+	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
+	priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
+	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
@@ -322,7 +356,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->clk = clk;
 
-	priv = sdhci_cdns_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
@@ -336,7 +371,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	ret = sdhci_cdns_phy_init(dev->of_node, priv);
+	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+
+	ret = sdhci_cdns_phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -353,6 +390,28 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __maybe_unused sdhci_cdns_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
+	ret = sdhci_cdns_phy_init(priv);
+	if (ret)
+		return ret;
+
+	return sdhci_resume_host(host);
+}
+
+static const struct dev_pm_ops sdhci_cdns_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_cdns_resume)
+};
+
 static const struct of_device_id sdhci_cdns_match[] = {
 	{ .compatible = "socionext,uniphier-sd4hc" },
 	{ .compatible = "cdns,sd4hc" },
@@ -363,7 +422,7 @@ MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
 static struct platform_driver sdhci_cdns_driver = {
 	.driver = {
 		.name = "sdhci-cdns",
-		.pm = &sdhci_pltfm_pmops,
+		.pm = &sdhci_cdns_pm_ops,
 		.of_match_table = sdhci_cdns_match,
 	},
 	.probe = sdhci_cdns_probe,
-- 
2.7.4

