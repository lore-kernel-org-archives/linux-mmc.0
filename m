From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with
 Multiblock read
Date: Fri, 19 May 2017 09:25:45 +0300
Message-ID: <58554ec9-1544-318a-e912-3c5f6ee40e90@intel.com>
References: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31915 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbdESGbj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 May 2017 02:31:39 -0400
In-Reply-To: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: ulf.hansson@linaro.org, rjui@broadcom.com, sbranden@broadcom.com, jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 18/05/17 19:57, Srinath Mannam wrote:
> The stingray SDHCI hardware supports ACMD12 and automatically
> issues after multi block transfer completed.
> 
> If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
> on multi block read command with below error message:
> 
> Got data interrupt 0x00000002 even though no data
> operation was in progress.
> 
> This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
> ACM12 support in SDHCI hardware and suppress spurious interrupt.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3275d49..61666d2 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -187,7 +187,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>  	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
>  	.ops = &sdhci_iproc_ops,
>  };
> 

