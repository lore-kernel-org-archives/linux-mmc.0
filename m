From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] ARM: exynos: remove the MMC_CAP2_BROKEN_VOLTAGE
Date: Fri, 21 Sep 2012 08:36:36 +0900
Message-ID: <0ad401cd9788$c6a41180$53ec3480$%kim@samsung.com>
References: <505AD968.9070106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12463 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605Ab2ITXgh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 19:36:37 -0400
In-reply-to: <505AD968.9070106@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Adrian Hunter' <adrian.hunter@intel.com>

Jaehoon Chung wrote:
> 
> This patch is dependency with Chris's patch.
> "[PATCH] mmc: core: Replace MMC_CAP2_BROKEN_VOLTAGE with test for fixed
> regulator"
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=421fc8e70
> 079b8b9e473a55a6267302695641dcc
> 
> After applied that patch, it needs not to set MMC_CAP2_BROKEN_VOLTAGE.
> 
Yeah, we don't need more this. This will be queued into -late branch for
v3.7 or can be queued into cleanup for next merge window because this is not
critical.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/mach-nuri.c           |    1 -
>  arch/arm/mach-exynos/mach-universal_c210.c |    1 -
>  arch/arm/mach-s5pv210/mach-goni.c          |    1 -
>  3 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-
> nuri.c
> index 90d8daa..6e0b0fa 100644
> --- a/arch/arm/mach-exynos/mach-nuri.c
> +++ b/arch/arm/mach-exynos/mach-nuri.c
> @@ -113,7 +113,6 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data
> __initdata = {
>  	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
>  				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED
|
>  				MMC_CAP_ERASE),
> -	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
>  	.cd_type		= S3C_SDHCI_CD_PERMANENT,
>  };
> 
> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-
> exynos/mach-universal_c210.c
> index 8139cd2..865be0a 100644
> --- a/arch/arm/mach-exynos/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> @@ -754,7 +754,6 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data
> __initdata = {
>  	.max_width		= 8,
>  	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
>  				MMC_CAP_MMC_HIGHSPEED |
MMC_CAP_SD_HIGHSPEED),
> -	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
>  	.cd_type		= S3C_SDHCI_CD_PERMANENT,
>  };
> 
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-
> s5pv210/mach-goni.c
> index c552581..239e896 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -774,7 +774,6 @@ static void __init goni_pmic_init(void)
>  /* MoviNAND */
>  static struct s3c_sdhci_platdata goni_hsmmc0_data __initdata = {
>  	.max_width		= 4,
> -	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
>  	.cd_type		= S3C_SDHCI_CD_PERMANENT,
>  };
> 
> --
> 1.7.4.1

