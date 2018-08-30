From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V8 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date: Thu, 30 Aug 2018 11:34:37 +0300
Message-ID: <4931d113-1af0-26ed-ae96-8ccd1be99334@intel.com>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
 <1535617305-16952-8-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535617305-16952-8-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 30/08/18 11:21, Chunyan Zhang wrote:
> When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
> register (05Fh-058h) instead of using register (000h-004h) to indicate
> its system address of data location. The register (000h-004h) is
> re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
> may use Auto CMD23.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 62d843ac90..606d331 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3834,10 +3834,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>  		host->flags |= SDHCI_AUTO_CMD12;
>  
> -	/* Auto-CMD23 stuff only works in ADMA or PIO. */
> +	/*
> +	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO.
> +	 * For v4 mode, SDMA may use Auto-CMD23 as well.
> +	 */
>  	if ((host->version >= SDHCI_SPEC_300) &&
>  	    ((host->flags & SDHCI_USE_ADMA) ||
> -	     !(host->flags & SDHCI_USE_SDMA)) &&
> +	     !(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
>  	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
>  		host->flags |= SDHCI_AUTO_CMD23;
>  		DBG("Auto-CMD23 available\n");
> 
