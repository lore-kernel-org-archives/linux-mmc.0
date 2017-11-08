From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: fix eMMC couldn't work after
 kexec
Date: Wed, 8 Nov 2017 10:14:22 +0200
Message-ID: <e966dc12-b966-7f3e-661a-472a718ca97b@intel.com>
References: <20171108074009.28914-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43966 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdKHIOf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Nov 2017 03:14:35 -0500
In-Reply-To: <20171108074009.28914-1-yinbo.zhu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: linux-mmc@vger.kernel.org, yangbo.lu@nxp.com

On 08/11/17 09:40, yinbo.zhu@nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
> used to reset for all. The driver should make sure it's cleared before card
> initialization, otherwise the initialization would fail.
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc.h    | 1 +
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index dfa58f8b8dfa..74b42dbc1ef6 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -60,6 +60,7 @@
>  /* Tuning Block Control Register */
>  #define ESDHC_TBCTL			0x120
>  #define ESDHC_TB_EN			0x00000004
> +#define ESDHC_TB_DIS			(0x1 << 2)

You refer to TB_EN in the commit message, yet here you introduce
ESDHC_TB_DIS with the same value.  Shouldn't you stick with one or the other.

>  
>  /* Control Register for DMA transfer */
>  #define ESDHC_DMA_SYSCTL		0x40c
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d96a057a7db8..b89de8e55330 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -783,6 +783,9 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  	pltfm_host = sdhci_priv(host);
>  	esdhc = sdhci_pltfm_priv(pltfm_host);
>  
> +	val = sdhci_readl(host, ESDHC_TBCTL);
> +	val &= ~ESDHC_TB_DIS;
> +	sdhci_writel(host, val, ESDHC_TBCTL);
>  	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>  			     SDHCI_VENDOR_VER_SHIFT;
> 

