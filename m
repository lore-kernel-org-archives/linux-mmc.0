From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-aspeed: add inversion signal
 presence
Date: Thu, 14 Nov 2019 15:10:46 +0200
Message-ID: <fcb5f8b5-40b9-6497-b24d-0b73e2525949@intel.com>
References: <20191114125435.27756-1-i.mikhaylov@yadro.com>
 <20191114125435.27756-3-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114125435.27756-3-i.mikhaylov@yadro.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

On 14/11/19 2:54 PM, Ivan Mikhaylov wrote:
> Change the default .get_cd callback. Add inverted signal card detection
> check.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 8962f6664381..186559ee8fcc 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -143,6 +143,19 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
>  	return (delta / 0x100) - 1;
>  }
>  
> +static int aspeed_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	int present = !!(sdhci_readl(host, SDHCI_PRESENT_STATE)
> +			 & SDHCI_CARD_PRESENT);
> +
> +	if (mmc->caps2 & MMC_CAP2_CD_ACTIVE_HIGH)
> +		present = !present;

Perhaps safer to flip the bit using CONFIG_MMC_SDHCI_IO_ACCESSORS and
->readl() callback

> +
> +	return present;
> +}
> +
>  static int aspeed_sdhci_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -183,6 +196,10 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	host->mmc_host_ops.get_cd = aspeed_get_cd;
> +	if (of_property_read_bool(pdev->dev.of_node, "cd-inverted"))
> +		dev_info(&pdev->dev, "aspeed: sdhci: presence signal inversion enabled\n");

Is this print really needed?

> +
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto err_sdhci_add;
> 
