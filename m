From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: fix eMMC couldn't work after
 kexec
Date: Wed, 22 Nov 2017 10:29:56 +0200
Message-ID: <95ac5aa7-3043-69b8-fbaa-965dacb9a25c@intel.com>
References: <20171108090950.4900-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36780 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbdKVIaO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 22 Nov 2017 03:30:14 -0500
In-Reply-To: <20171108090950.4900-1-yinbo.zhu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: linux-mmc@vger.kernel.org, yangbo.lu@nxp.com

On 08/11/17 11:09, yinbo.zhu@nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> The bit eSDHC_TBCTL[TB_EN] couldn't be reset by eSDHC_SYSCTL[RSTA] which is
> used to reset for all. The driver should make sure it's cleared before card
> initialization, otherwise the initialization would fail.
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Change in v2:
> 		Replace ESDHC_TB_DIS with default register bit ESDHC_TB_EN
> 
>  drivers/mmc/host/sdhci-of-esdhc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d96a057a7db8..023c24bd0d94 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -783,6 +783,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  	pltfm_host = sdhci_priv(host);
>  	esdhc = sdhci_pltfm_priv(pltfm_host);
>  
> +	val = sdhci_readl(host, ESDHC_TBCTL);
> +	val &= ~ESDHC_TB_EN;
> +	sdhci_writel(host, val, ESDHC_TBCTL);
> +
>  	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>  			     SDHCI_VENDOR_VER_SHIFT;
> 

