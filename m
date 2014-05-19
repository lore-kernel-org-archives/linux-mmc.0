From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI driver
Date: Mon, 19 May 2014 11:07:51 +0200
Message-ID: <5286335.Al3nIKDAQo@wuerfel>
References: <1400398918-1502-1-git-send-email-lho@apm.com> <1400398918-1502-2-git-send-email-lho@apm.com> <1400398918-1502-3-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49224 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbaESJI1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 May 2014 05:08:27 -0400
In-Reply-To: <1400398918-1502-3-git-send-email-lho@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Loc Ho <lho@apm.com>, chris@printf.net, ulf.hansson@linaro.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, patches@apm.com, jcm@redhat.com

On Sunday 18 May 2014 01:41:57 Loc Ho wrote:
> @@ -34,6 +36,19 @@
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
> +	struct platform_device *pdev;
> +	void __iomem	*ahb_aim_csr;
> +	const struct sdhci_arasan_ahb_ops *ahb_ops;
> +};
> +
> +/**
> + * struct sdhci_arasan_ahb_ops
> + * @init_ahb	Initialize translation bus
> + * @xlat_addr	Set up an 64-bit addressing translation
> + */
> +struct sdhci_arasan_ahb_ops {
> +	int (*init_ahb)(struct sdhci_arasan_data *data);
> +	void (*xlat_addr)(struct sdhci_arasan_data *data, u64 dma_addr);
>  };
>  
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
> @@ -51,7 +66,21 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>  	return freq;
>  }
>  
> +static void sdhci_arasan_writel(struct sdhci_host *host, u32 val, int reg)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +
> +	if (reg == SDHCI_DMA_ADDRESS) {
> +		if (sdhci_arasan->ahb_ops && sdhci_arasan->ahb_ops->xlat_addr)
> +			sdhci_arasan->ahb_ops->xlat_addr(sdhci_arasan,
> +				sg_dma_address(host->data->sg));
> +	}
> +	writel(val, host->ioaddr + reg);
> +}
> +
>  static struct sdhci_ops sdhci_arasan_ops = {
> +	.write_l = sdhci_arasan_writel,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
>  };

This looks like you are doing it at the wrong place. From what I understand,
you are using the AHB inbound window as a minimal IOMMU. Why don't you make
this a proper IOMMU driver instead and leave the SDHCI driver unchanged?

	Arnd
