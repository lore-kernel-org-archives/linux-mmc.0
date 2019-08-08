From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-cadence: use struct_size() helper
Date: Thu, 8 Aug 2019 11:53:01 -0500
Message-ID: <20190808165301.GA30877@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct sdhci_cdns_priv {
	...
        struct sdhci_cdns_phy_param phy_params[0];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params

with:

struct_size(priv, phy_params, nr_phy_params)

Also, notice that, in this case, variable priv_size is not necessary,
hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-cadence.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 163d1cf4367e..1768a13f89be 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -337,7 +337,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	size_t priv_size;
 	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
@@ -351,8 +350,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 		return ret;
 
 	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	priv_size = sizeof(*priv) + sizeof(priv->phy_params[0]) * nr_phy_params;
-	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data, priv_size);
+	host = sdhci_pltfm_init(pdev, &sdhci_cdns_pltfm_data,
+				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
-- 
2.22.0
