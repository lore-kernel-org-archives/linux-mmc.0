From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
Date: Sat, 12 Jan 2019 22:12:42 +0100
Message-ID: <20190112211242.GA4512@zn.tnic>
References: <20190109124312.10154-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, j-keerthy@ti.com, edubezval@gmail.com, olof@lixom.net
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 09, 2019 at 06:13:12PM +0530, Faiz Abbas wrote:
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
> -- 

Fixes the warnings I'm seeing with randconfig builds.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
