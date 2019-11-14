From: "Milton Miller II" <miltonm@us.ibm.com>
Subject: Re:  [PATCH 2/2] mmc: sdhci-of-aspeed: add inversion signal presence
Date: Thu, 14 Nov 2019 00:04:09 +0000
Message-ID: <OF20F73C7F.F32D5A9E-ON002584B1.00836403-002584B2.0000614A@notes.na.collabserv.com>
References: <20191113155237.30646-3-i.mikhaylov@yadro.com>,<20191113155237.30646-1-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113155237.30646-3-i.mikhaylov@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11/13/2019 around 09:57AM in some time zone, Ivan Mikhaylov wrote:
>Change the default .get_cd callback. Add inverted signal card
>detection
>check.
>
>Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
>
>diff --git a/drivers/mmc/host/sdhci-of-aspeed.c
>b/drivers/mmc/host/sdhci-of-aspeed.c
>index 8962f6664381..8eded8a6ed8d 100644
>--- a/drivers/mmc/host/sdhci-of-aspeed.c
>+++ b/drivers/mmc/host/sdhci-of-aspeed.c
>@@ -31,6 +31,7 @@ struct aspeed_sdc {
> struct aspeed_sdhci {
> 	struct aspeed_sdc *parent;
> 	u32 width_mask;
>+	u8 cd_inverted;

The mmc core/host.c checks the device tree and stores the
result as mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH

This appears to be accessale as sdhci_host->mmc->caps2.

Please reuse this bit like the other drivers.

> };
> 
> static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
>@@ -143,6 +144,21 @@ static inline int
>aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> 	return (delta / 0x100) - 1;
> }
> 
>+static int aspeed_get_cd(struct mmc_host *mmc)
>+{
>+	struct aspeed_sdhci *aspeed_sdhci;
>+	struct sdhci_pltfm_host *pltfm_priv;
>+	struct sdhci_host *host = mmc_priv(mmc);
>+
>+	int presence = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
>+			 & SDHCI_CARD_PRESENT);
>+
>+	pltfm_priv = sdhci_priv(host);
>+	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
>+
>+	return presence ^ aspeed_sdhci->cd_inverted;
>+}
>+
> static int aspeed_sdhci_probe(struct platform_device *pdev)
> {
> 	struct sdhci_pltfm_host *pltfm_host;
>@@ -183,6 +199,13 @@ static int aspeed_sdhci_probe(struct
>platform_device *pdev)
> 		goto err_pltfm_free;
> 	}
> 
>+	dev->cd_inverted = 0;
>+	host->mmc_host_ops.get_cd = aspeed_get_cd;
>+	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted")) {
>+		dev->cd_inverted = 1;
>+		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion
>enabled\n");
>+	}
>+
> 	ret = mmc_of_parse(host->mmc);
> 	if (ret)
> 		goto err_sdhci_add;
>-- 
>2.20.1
>
>
