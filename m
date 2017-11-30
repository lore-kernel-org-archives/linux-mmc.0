From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: fix the mmc error after sleep on
 ls1046ardb
Date: Thu, 30 Nov 2017 12:44:49 +0200
Message-ID: <f550c0ad-7505-e553-e88d-eb8605659e7b@intel.com>
References: <20171128035706.16939-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38957 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbdK3KpJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Nov 2017 05:45:09 -0500
In-Reply-To: <20171128035706.16939-1-yinbo.zhu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: xiaobo.xie@nxp.com, yangbo.lu@nxp.com, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 28/11/17 05:57, yinbo.zhu@nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> When system wakes up from sleep on ls1046ardb, the SD operation fails
> with mmc error messages since ESDHC_TB_EN bit couldn’t be cleaned by
> eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
> rather than in probe.
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index ac2505a95403..5ee0d86a2f4d 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -578,10 +578,18 @@ static void esdhc_clock_enable(struct sdhci_host *host, bool enable)
>  
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> +	u32 val;
> +
>  	sdhci_reset(host, mask);
>  
>  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		val = sdhci_readl(host, ESDHC_TBCTL);
> +		val &= ~ESDHC_TB_EN;
> +		sdhci_writel(host, val, ESDHC_TBCTL);
> +	}
>  }
>  
>  /* The SCFG, Supplemental Configuration Unit, provides SoC specific
> @@ -771,10 +779,6 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>  	pltfm_host = sdhci_priv(host);
>  	esdhc = sdhci_pltfm_priv(pltfm_host);
>  
> -	val = sdhci_readl(host, ESDHC_TBCTL);
> -	val &= ~ESDHC_TB_EN;
> -	sdhci_writel(host, val, ESDHC_TBCTL);
> -
>  	host_ver = sdhci_readw(host, SDHCI_HOST_VERSION);
>  	esdhc->vendor_ver = (host_ver & SDHCI_VENDOR_VER_MASK) >>
>  			     SDHCI_VENDOR_VER_SHIFT;
> 

