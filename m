From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/2] ARM: SAMSUNG: Add pm_caps into platform data
Date: Tue, 15 Nov 2011 18:53:52 +0900
Message-ID: <005c01cca37c$7b8afc00$72a0f400$%kim@samsung.com>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
 <1320685522-17481-2-git-send-email-sangwook.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36000 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab1KOJxy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 04:53:54 -0500
In-reply-to: <1320685522-17481-2-git-send-email-sangwook.lee@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sangwook Lee' <sangwook.lee@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, ben-linux@fluff.org, linaro-dev@lists.linaro.org, patches@linaro.org, 'Sangwook Lee' <sangwook.lee@samsung.com>

Sangwook Lee wrote:
> 
> Add pm_caps into platform_data. This is power management, usually
> for SDIO device such as SDIO WLAN.
> 
> Signed-off-by: Sangwook Lee <sangwook.lee@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
>  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
b/arch/arm/plat-samsung/dev-
> hsmmc3.c
> index ede776f..8f467f2 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -78,6 +78,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
> +	if (pd->pm_caps)
> +		set->pm_caps |= pd->pm_caps;
>  	if (pd->clk_type)
>  		set->clk_type = pd->clk_type;
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 058e096..35646de 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -40,6 +40,7 @@ enum clk_types {
>   * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
>   * @max_width: The maximum number of data bits supported.
>   * @host_caps: Standard MMC host capabilities bit field.
> + * @pm_caps: SDIO host PM capabilities bit field.
>   * @cd_type: Type of Card Detection method (see cd_types enum above)
>   * @clk_type: Type of clock divider method (see clk_types enum above)
>   * @ext_cd_init: Initialize external card detect subsystem. Called on
> @@ -67,6 +68,7 @@ enum clk_types {
>  struct s3c_sdhci_platdata {
>  	unsigned int	max_width;
>  	unsigned int	host_caps;
> +	unsigned int	pm_caps;
>  	enum cd_types	cd_type;
>  	enum clk_types	clk_type;
> 
> --
> 1.7.4.1

Hi Sangwook,

I think you need to re-work based on latest my for-next.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

