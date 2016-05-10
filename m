From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 23/23] mmc: sdhci-esdhc-imx: clear tuning bits during
 hwinit
Date: Tue, 10 May 2016 16:10:38 +0300
Message-ID: <5731DDCE.7020102@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-24-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:52709 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbcEJNPE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 09:15:04 -0400
In-Reply-To: <1460741387-23815-24-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> The tuning bits like FBCLK_SEL, SMP_CLK_SEL and DLY_CELL which affects
> timing may have already been set by ROM if booting from SD3.0 mode like
> SDR104. Let's clear it first during hw initialization before do the
> new card enumeration.
> 
> For system resume case, it's safe to clear them too since the following
> card re-initialization in mmc_xx_init_card() will do retuning and set
> correct value again.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 98aa6b5..6a699d1 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1018,6 +1018,11 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  			}
>  			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>  		}
> +
> +		/* clear tuning bits in case ROM has set it already */
> +		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
> +		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
> +		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  	}
>  }
>  
> 

