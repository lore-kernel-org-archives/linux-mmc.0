From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
Date: Mon, 14 Jan 2019 10:31:56 +0200
Message-ID: <d6e57ce6-680c-4264-435c-8699fa704526@intel.com>
References: <20190109124312.10154-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, j-keerthy@ti.com, edubezval@gmail.com, olof@lixom.net
List-Id: linux-mmc@vger.kernel.org

On 9/01/19 2:43 PM, Faiz Abbas wrote:
> Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
> for the driver to get temperature for tuning.
> 
> However, this causes the following warning on keystone_defconfig because
> keystone does not support TI_SOC_THERMAL:
> 
> "WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"
> 
> Fix this by changing the select to imply.
> 
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..bc61eefcb695 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
>  	tristate "TI SDHCI Controller Support"
>  	depends on MMC_SDHCI_PLTFM && OF
>  	select THERMAL
> -	select TI_SOC_THERMAL
> +	imply TI_SOC_THERMAL
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's DRA7 SOCs. The controller supports
> 
