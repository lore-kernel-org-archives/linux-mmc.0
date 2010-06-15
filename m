From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/3] ARM: SAMSUNG: Add the member of platdata to
	implement SDMMC Write Protection
Date: Tue, 15 Jun 2010 13:02:45 +0100
Message-ID: <20100615120245.GD7248@trinity.fluff.org>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com> <1276601268-7226-2-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:43218 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab0FOMCq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Jun 2010 08:02:46 -0400
Content-Disposition: inline
In-Reply-To: <1276601268-7226-2-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Lee Hyuk <hyuk1.lee@samsung.com>, ben-linux@fluff.org

On Tue, Jun 15, 2010 at 08:27:46PM +0900, Kukjin Kim wrote:
> From: Lee Hyuk <hyuk1.lee@samsung.com>
> 
> This patch adds the members of platdata which are cfg_wp and get_ro.
> The cfg_wp is the function for setting the specific GPIO for WP pin
> and get_ro is the function for getting data from the assigned GPIO.

Why not just pass gpio numbers, and have the sdhci-s3c driver claim them
if they are valid?
 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-samsung/dev-hsmmc.c          |    4 ++++
>  arch/arm/plat-samsung/dev-hsmmc1.c         |    4 ++++
>  arch/arm/plat-samsung/dev-hsmmc2.c         |    4 ++++
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    4 ++++
>  arch/arm/plat-samsung/include/plat/sdhci.h |    6 ++++++
>  5 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
> index 4c05b39..f2bae6f 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc.c
> @@ -65,4 +65,8 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->cfg_wp)
> +		set->cfg_wp = pd->cfg_wp;
> +	if (pd->get_ro)
> +		set->get_ro = pd->get_ro;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
> index e49bc4c..b326e0d 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc1.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc1.c
> @@ -65,4 +65,8 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->cfg_wp)
> +		set->cfg_wp = pd->cfg_wp;
> +	if (pd->get_ro)
> +		set->get_ro = pd->get_ro;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
> index 824580b..3474ef2 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc2.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc2.c
> @@ -66,4 +66,8 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->cfg_wp)
> +		set->cfg_wp = pd->cfg_wp;
> +	if (pd->get_ro)
> +		set->get_ro = pd->get_ro;
>  }
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c b/arch/arm/plat-samsung/dev-hsmmc3.c
> index 05d5ea4..1da8ea7 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -69,4 +69,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
>  		set->cfg_gpio = pd->cfg_gpio;
>  	if (pd->cfg_card)
>  		set->cfg_card = pd->cfg_card;
> +	if (pd->cfg_wp)
> +		set->cfg_wp = pd->cfg_wp;
> +	if (pd->get_ro)
> +		set->get_ro = pd->get_ro;
>  }
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
> index 1314ffa..da198d8 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -29,6 +29,8 @@ struct mmc_ios;
>   *            is necessary the controllers and/or GPIO blocks require the
>   *	      changing of driver-strength and other controls dependant on
>   *	      the card and speed of operation.
> + * @cfg_wp: Configure the GPIO in order to allocate WP pin.
> + * @get_ro: Call back function for getting data from the allocated GPIO.

if you just used gpio calls and passed a gpio number here,
you'd not need cfg_wp.

>   *
>   * Initialisation data specific to either the machine or the platform
>   * for the device driver to use or call-back when configuring gpio or
> @@ -45,6 +47,8 @@ struct s3c_sdhci_platdata {
>  			    void __iomem *regbase,
>  			    struct mmc_ios *ios,
>  			    struct mmc_card *card);
> +	void	(*cfg_wp)(int dev_id);
> +	int	(*get_ro)(struct mmc_host *mmc);
>  };
>  
>  /**
> @@ -234,6 +238,8 @@ extern void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
>  					   struct mmc_ios *ios,
>  					   struct mmc_card *card);
>  
> +extern void s3c_sdhci_set_platdata(void);
> +
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  static inline void s5pv210_default_sdhci0(void)
>  {
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

