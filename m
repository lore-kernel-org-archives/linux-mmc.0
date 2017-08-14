From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: support ESDHC_CAPABILITIES_1
 accessing
Date: Mon, 14 Aug 2017 14:43:40 +0300
Message-ID: <22824813-5eef-6d88-f936-139e8a2f9561@intel.com>
References: <1502281490-975-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753181AbdHNLuH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 07:50:07 -0400
In-Reply-To: <1502281490-975-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 09/08/17 15:24, Yangbo Lu wrote:
> eSDHC is not a standard SD host controller. SDHCI_CAPABILITIES_1
> register address is 0x44 while it's 0x114 (ESDHC_CAPABILITIES_1)
> for eSDHC.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Apart from the redundant parenthesis:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  3 +++
>  drivers/mmc/host/sdhci-of-esdhc.c | 23 +++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index c4bbd74..98898a3 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -53,6 +53,9 @@
>  #define ESDHC_CLOCK_HCKEN		0x00000002
>  #define ESDHC_CLOCK_IPGEN		0x00000001
>  
> +/* Host Controller Capabilities Register 2 */
> +#define ESDHC_CAPABILITIES_1		0x114
> +
>  /* Tuning Block Control Register */
>  #define ESDHC_TBCTL			0x120
>  #define ESDHC_TB_EN			0x00000004
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d10f831..cd85a18 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -86,6 +86,17 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  		return ret;
>  	}
>  
> +	/*
> +	 * DTS properties of mmc host are used to enable each speed mode
> +	 * according to soc and board capability. So clean up
> +	 * SDR50/SDR104/DDR50 support bits here.
> +	 */
> +	if (spec_reg == SDHCI_CAPABILITIES_1) {
> +		ret = value & (~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |

Redundant parenthesis.

> +				 SDHCI_SUPPORT_DDR50));
> +		return ret;
> +	}
> +
>  	ret = value;
>  	return ret;
>  }
> @@ -249,7 +260,11 @@ static u32 esdhc_be_readl(struct sdhci_host *host, int reg)
>  	u32 ret;
>  	u32 value;
>  
> -	value = ioread32be(host->ioaddr + reg);
> +	if (reg == SDHCI_CAPABILITIES_1)
> +		value = ioread32be(host->ioaddr + ESDHC_CAPABILITIES_1);
> +	else
> +		value = ioread32be(host->ioaddr + reg);
> +
>  	ret = esdhc_readl_fixup(host, reg, value);
>  
>  	return ret;
> @@ -260,7 +275,11 @@ static u32 esdhc_le_readl(struct sdhci_host *host, int reg)
>  	u32 ret;
>  	u32 value;
>  
> -	value = ioread32(host->ioaddr + reg);
> +	if (reg == SDHCI_CAPABILITIES_1)
> +		value = ioread32(host->ioaddr + ESDHC_CAPABILITIES_1);
> +	else
> +		value = ioread32(host->ioaddr + reg);
> +
>  	ret = esdhc_readl_fixup(host, reg, value);
>  
>  	return ret;
> 

