From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: add inversion signal presence
Date: Wed, 13 Nov 2019 18:52:37 +0300
Message-ID: <20191113155237.30646-3-i.mikhaylov@yadro.com>
References: <20191113155237.30646-1-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113155237.30646-1-i.mikhaylov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Change the default .get_cd callback. Add inverted signal card detection
check.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 8962f6664381..8eded8a6ed8d 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -31,6 +31,7 @@ struct aspeed_sdc {
 struct aspeed_sdhci {
 	struct aspeed_sdc *parent;
 	u32 width_mask;
+	u8 cd_inverted;
 };
 
 static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
@@ -143,6 +144,21 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
 	return (delta / 0x100) - 1;
 }
 
+static int aspeed_get_cd(struct mmc_host *mmc)
+{
+	struct aspeed_sdhci *aspeed_sdhci;
+	struct sdhci_pltfm_host *pltfm_priv;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	int presence = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
+			 & SDHCI_CARD_PRESENT);
+
+	pltfm_priv = sdhci_priv(host);
+	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
+
+	return presence ^ aspeed_sdhci->cd_inverted;
+}
+
 static int aspeed_sdhci_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
@@ -183,6 +199,13 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	dev->cd_inverted = 0;
+	host->mmc_host_ops.get_cd = aspeed_get_cd;
+	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted")) {
+		dev->cd_inverted = 1;
+		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion enabled\n");
+	}
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto err_sdhci_add;
-- 
2.20.1
