From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 2/2] arm: samsung: remove sdhci default configuration setup
 platform helper
Date: Mon, 05 Sep 2011 14:16:04 +0900
Message-ID: <001801cc6b8a$e953bda0$bbfb38e0$%kim@samsung.com>
References: <1314976702-19284-1-git-send-email-thomas.abraham@linaro.org>
 <1314976702-19284-2-git-send-email-thomas.abraham@linaro.org>
 <1314976702-19284-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1314976702-19284-3-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Thomas Abraham wrote:
> 
> The sdhci platform helper function that sets up the default controller
> configuration is removed for all Samsung platforms since such default
> controller configuration can be handled by the driver.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos4/setup-sdhci.c        |   47 -----------------------
>  arch/arm/mach-s3c2416/setup-sdhci.c        |   37 ------------------
>  arch/arm/mach-s3c64xx/setup-sdhci.c        |   48 -----------------------
>  arch/arm/mach-s5pc100/setup-sdhci.c        |   42 --------------------
>  arch/arm/mach-s5pv210/setup-sdhci.c        |   41 --------------------
>  arch/arm/plat-samsung/dev-hsmmc.c          |    2 -
>  arch/arm/plat-samsung/dev-hsmmc1.c         |    2 -
>  arch/arm/plat-samsung/dev-hsmmc2.c         |    2 -
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    2 -
>  arch/arm/plat-samsung/include/plat/sdhci.h |   57
----------------------------
>  10 files changed, 0 insertions(+), 280 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/setup-sdhci.c
b/arch/arm/mach-exynos4/setup-
> sdhci.c
> index 1e83f8c..92937b4 100644
> --- a/arch/arm/mach-exynos4/setup-sdhci.c
> +++ b/arch/arm/mach-exynos4/setup-sdhci.c
> @@ -10,16 +10,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -
> -#include <plat/regs-sdhci.h>
> 
>  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> 
> @@ -29,41 +20,3 @@ char *exynos4_hsmmc_clksrcs[4] = {
>  	[2] = "sclk_mmc",	/* mmc_bus */
>  	[3] = NULL,
>  };
> -
> -void exynos4_setup_sdhci_cfg_card(struct platform_device *dev, void
__iomem
> *r,
> -				  struct mmc_ios *ios, struct mmc_card
*card)
> -{
> -	u32 ctrl2, ctrl3;
> -
> -	/* don't need to alter anything according to card-type */
> -
> -	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> -
> -	/* select base clock source to HCLK */
> -
> -	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> -
> -	/*
> -	 * clear async mode, enable conflict mask, rx feedback ctrl, SD
> -	 * clk hold and no use debounce count
> -	 */
> -
> -	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> -		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> -		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> -		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> -		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> -
> -	/* Tx and Rx feedback clock delay control */
> -
> -	if (ios->clock < 25 * 1000000)
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> -			 S3C_SDHCI_CTRL3_FCSEL2 |
> -			 S3C_SDHCI_CTRL3_FCSEL1 |
> -			 S3C_SDHCI_CTRL3_FCSEL0);
> -	else
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 |
> S3C_SDHCI_CTRL3_FCSEL0);
> -
> -	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> -	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> -}
> diff --git a/arch/arm/mach-s3c2416/setup-sdhci.c
b/arch/arm/mach-s3c2416/setup-
> sdhci.c
> index ed34fad..cee5395 100644
> --- a/arch/arm/mach-s3c2416/setup-sdhci.c
> +++ b/arch/arm/mach-s3c2416/setup-sdhci.c
> @@ -12,17 +12,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -
> -#include <plat/regs-sdhci.h>
> -#include <plat/sdhci.h>
> 
>  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> 
> @@ -32,30 +22,3 @@ char *s3c2416_hsmmc_clksrcs[4] = {
>  	[2] = "hsmmc-if",
>  	/* [3] = "48m", - note not successfully used yet */
>  };
> -
> -void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> -				  void __iomem *r,
> -				  struct mmc_ios *ios,
> -				  struct mmc_card *card)
> -{
> -	u32 ctrl2, ctrl3;
> -
> -	ctrl2 = __raw_readl(r + S3C_SDHCI_CONTROL2);
> -	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> -	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> -		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> -		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> -		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> -		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> -
> -	if (ios->clock < 25 * 1000000)
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> -			 S3C_SDHCI_CTRL3_FCSEL2 |
> -			 S3C_SDHCI_CTRL3_FCSEL1 |
> -			 S3C_SDHCI_CTRL3_FCSEL0);
> -	else
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 |
> S3C_SDHCI_CTRL3_FCSEL0);
> -
> -	__raw_writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> -	__raw_writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> -}
> diff --git a/arch/arm/mach-s3c64xx/setup-sdhci.c
b/arch/arm/mach-s3c64xx/setup-
> sdhci.c
> index f344a22..c75a71b 100644
> --- a/arch/arm/mach-s3c64xx/setup-sdhci.c
> +++ b/arch/arm/mach-s3c64xx/setup-sdhci.c
> @@ -12,17 +12,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -
> -#include <plat/regs-sdhci.h>
> -#include <plat/sdhci.h>
> 
>  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> 
> @@ -32,41 +22,3 @@ char *s3c64xx_hsmmc_clksrcs[4] = {
>  	[2] = "mmc_bus",
>  	/* [3] = "48m", - note not successfully used yet */
>  };
> -
> -void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
> -				  void __iomem *r,
> -				  struct mmc_ios *ios,
> -				  struct mmc_card *card)
> -{
> -	u32 ctrl2, ctrl3;
> -
> -	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> -	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> -	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> -		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> -		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> -		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> -		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> -
> -	if (ios->clock < 25 * 1000000)
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> -			 S3C_SDHCI_CTRL3_FCSEL2 |
> -			 S3C_SDHCI_CTRL3_FCSEL1 |
> -			 S3C_SDHCI_CTRL3_FCSEL0);
> -	else
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 |
> S3C_SDHCI_CTRL3_FCSEL0);
> -
> -	pr_debug("%s: CTRL 2=%08x, 3=%08x\n", __func__, ctrl2, ctrl3);
> -	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> -	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> -}
> -
> -void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
> -				  void __iomem *r,
> -				  struct mmc_ios *ios,
> -				  struct mmc_card *card)
> -{
> -	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r +
> S3C64XX_SDHCI_CONTROL4);
> -
> -	s3c6400_setup_sdhci_cfg_card(dev, r, ios, card);
> -}
> diff --git a/arch/arm/mach-s5pc100/setup-sdhci.c
b/arch/arm/mach-s5pc100/setup-
> sdhci.c
> index be25879..6418c6e 100644
> --- a/arch/arm/mach-s5pc100/setup-sdhci.c
> +++ b/arch/arm/mach-s5pc100/setup-sdhci.c
> @@ -11,17 +11,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -
> -#include <plat/regs-sdhci.h>
> -#include <plat/sdhci.h>
> 
>  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> 
> @@ -31,35 +21,3 @@ char *s5pc100_hsmmc_clksrcs[4] = {
>  	[2] = "sclk_mmc",	/* mmc_bus */
>  	/* [3] = "48m",		- note not successfully used yet */
>  };
> -
> -
> -void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
> -				    void __iomem *r,
> -				    struct mmc_ios *ios,
> -				    struct mmc_card *card)
> -{
> -	u32 ctrl2, ctrl3;
> -
> -	/* don't need to alter anything according to card-type */
> -
> -	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r +
> S3C64XX_SDHCI_CONTROL4);
> -
> -	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> -	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> -	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> -		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> -		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> -		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> -		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> -
> -	if (ios->clock < 25 * 1000000)
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> -			 S3C_SDHCI_CTRL3_FCSEL2 |
> -			 S3C_SDHCI_CTRL3_FCSEL1 |
> -			 S3C_SDHCI_CTRL3_FCSEL0);
> -	else
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 |
> S3C_SDHCI_CTRL3_FCSEL0);
> -
> -	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> -	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> -}
> diff --git a/arch/arm/mach-s5pv210/setup-sdhci.c
b/arch/arm/mach-s5pv210/setup-
> sdhci.c
> index a83b6c9..6b8ccc4 100644
> --- a/arch/arm/mach-s5pv210/setup-sdhci.c
> +++ b/arch/arm/mach-s5pv210/setup-sdhci.c
> @@ -10,17 +10,7 @@
>   * published by the Free Software Foundation.
>  */
> 
> -#include <linux/kernel.h>
>  #include <linux/types.h>
> -#include <linux/interrupt.h>
> -#include <linux/platform_device.h>
> -#include <linux/io.h>
> -
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -
> -#include <plat/regs-sdhci.h>
> -#include <plat/sdhci.h>
> 
>  /* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> 
> @@ -30,34 +20,3 @@ char *s5pv210_hsmmc_clksrcs[4] = {
>  	[2] = "sclk_mmc",	/* mmc_bus */
>  	/* [3] = NULL,		- reserved */
>  };
> -
> -void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
> -				    void __iomem *r,
> -				    struct mmc_ios *ios,
> -				    struct mmc_card *card)
> -{
> -	u32 ctrl2, ctrl3;
> -
> -	/* don't need to alter anything according to card-type */
> -
> -	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA, r +
> S3C64XX_SDHCI_CONTROL4);
> -
> -	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> -	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> -	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> -		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> -		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> -		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> -		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> -
> -	if (ios->clock < 25 * 1000000)
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> -			 S3C_SDHCI_CTRL3_FCSEL2 |
> -			 S3C_SDHCI_CTRL3_FCSEL1 |
> -			 S3C_SDHCI_CTRL3_FCSEL0);
> -	else
> -		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 |
> S3C_SDHCI_CTRL3_FCSEL0);
> -
> -	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> -	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> -}
> diff --git a/arch/arm/plat-samsung/dev-hsmmc.c
b/arch/arm/plat-samsung/dev-
> hsmmc.c
> index db7a65c..5f15bf7 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc.c
> @@ -70,8 +70,6 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->max_width = pd->max_width;
>  	if (pd->cfg_gpio)
>  		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
>  	if (pd->clk_type)
> diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c
b/arch/arm/plat-samsung/dev-
> hsmmc1.c
> index 2497321..2249794 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc1.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc1.c
> @@ -70,8 +70,6 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->max_width = pd->max_width;
>  	if (pd->cfg_gpio)
>  		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
>  	if (pd->clk_type)
> diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c
b/arch/arm/plat-samsung/dev-
> hsmmc2.c
> index f60aedb..58af1eb 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc2.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc2.c
> @@ -71,8 +71,6 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->max_width = pd->max_width;
>  	if (pd->cfg_gpio)
>  		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
>  	if (pd->clk_type)
> diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
b/arch/arm/plat-samsung/dev-
> hsmmc3.c
> index ede776f..bb44271 100644
> --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> @@ -74,8 +74,6 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata
*pd)
>  		set->max_width = pd->max_width;
>  	if (pd->cfg_gpio)
>  		set->cfg_gpio = pd->cfg_gpio;
> -	if (pd->cfg_card)
> -		set->cfg_card = pd->cfg_card;
>  	if (pd->host_caps)
>  		set->host_caps |= pd->host_caps;
>  	if (pd->clk_type)
> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 058e096..7f57173 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -55,10 +55,6 @@ enum clk_types {
>   *		 cd_type == S3C_SDHCI_CD_GPIO
>   * @ext_cd_gpio_invert: invert values for external CD gpio line
>   * @cfg_gpio: Configure the GPIO for a specific card bit-width
> - * @cfg_card: Configure the interface for a specific card and speed. This
> - *            is necessary the controllers and/or GPIO blocks require the
> - *	      changing of driver-strength and other controls dependent on
> - *	      the card and speed of operation.
>   *
>   * Initialisation data specific to either the machine or the platform
>   * for the device driver to use or call-back when configuring gpio or
> @@ -80,10 +76,6 @@ struct s3c_sdhci_platdata {
>  						      int state));
> 
>  	void	(*cfg_gpio)(struct platform_device *dev, int width);
> -	void	(*cfg_card)(struct platform_device *dev,
> -			    void __iomem *regbase,
> -			    struct mmc_ios *ios,
> -			    struct mmc_card *card);
>  };
> 
>  /**
> @@ -132,17 +124,11 @@ extern void exynos4_setup_sdhci3_cfg_gpio(struct
> platform_device *, int w);
>  #ifdef CONFIG_S3C2416_SETUP_SDHCI
>  extern char *s3c2416_hsmmc_clksrcs[4];
> 
> -extern void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> -					   void __iomem *r,
> -					   struct mmc_ios *ios,
> -					   struct mmc_card *card);
> -
>  static inline void s3c2416_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
>  #endif /* CONFIG_S3C_DEV_HSMMC */
>  }
> 
> @@ -151,7 +137,6 @@ static inline void s3c2416_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
>  #endif /* CONFIG_S3C_DEV_HSMMC1 */
>  }
> 
> @@ -165,17 +150,11 @@ static inline void s3c2416_default_sdhci1(void) { }
>  #ifdef CONFIG_S3C64XX_SETUP_SDHCI
>  extern char *s3c64xx_hsmmc_clksrcs[4];
> 
> -extern void s3c6400_setup_sdhci_cfg_card(struct platform_device *dev,
> -					 void __iomem *r,
> -					 struct mmc_ios *ios,
> -					 struct mmc_card *card);
> -
>  static inline void s3c6400_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -184,7 +163,6 @@ static inline void s3c6400_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -193,21 +171,14 @@ static inline void s3c6400_default_sdhci2(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC2
>  	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
> -	s3c_hsmmc2_def_platdata.cfg_card = s3c6400_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> -extern void s3c6410_setup_sdhci_cfg_card(struct platform_device *dev,
> -					 void __iomem *r,
> -					 struct mmc_ios *ios,
> -					 struct mmc_card *card);
> -
>  static inline void s3c6410_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = s3c64xx_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -216,7 +187,6 @@ static inline void s3c6410_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = s3c64xx_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -225,7 +195,6 @@ static inline void s3c6410_default_sdhci2(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC2
>  	s3c_hsmmc2_def_platdata.clocks = s3c64xx_hsmmc_clksrcs;
>  	s3c_hsmmc2_def_platdata.cfg_gpio = s3c64xx_setup_sdhci2_cfg_gpio;
> -	s3c_hsmmc2_def_platdata.cfg_card = s3c6410_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -244,17 +213,11 @@ static inline void s3c6400_default_sdhci2(void) { }
>  #ifdef CONFIG_S5PC100_SETUP_SDHCI
>  extern char *s5pc100_hsmmc_clksrcs[4];
> 
> -extern void s5pc100_setup_sdhci0_cfg_card(struct platform_device *dev,
> -					   void __iomem *r,
> -					   struct mmc_ios *ios,
> -					   struct mmc_card *card);
> -
>  static inline void s5pc100_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = s5pc100_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
>  #endif
>  }
> 
> @@ -263,7 +226,6 @@ static inline void s5pc100_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = s5pc100_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
>  #endif
>  }
> 
> @@ -272,7 +234,6 @@ static inline void s5pc100_default_sdhci2(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC2
>  	s3c_hsmmc2_def_platdata.clocks = s5pc100_hsmmc_clksrcs;
>  	s3c_hsmmc2_def_platdata.cfg_gpio = s5pc100_setup_sdhci2_cfg_gpio;
> -	s3c_hsmmc2_def_platdata.cfg_card = s5pc100_setup_sdhci0_cfg_card;
>  #endif
>  }
> 
> @@ -288,17 +249,11 @@ static inline void s5pc100_default_sdhci2(void) { }
>  #ifdef CONFIG_S5PV210_SETUP_SDHCI
>  extern char *s5pv210_hsmmc_clksrcs[4];
> 
> -extern void s5pv210_setup_sdhci_cfg_card(struct platform_device *dev,
> -					   void __iomem *r,
> -					   struct mmc_ios *ios,
> -					   struct mmc_card *card);
> -
>  static inline void s5pv210_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv210_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -307,7 +262,6 @@ static inline void s5pv210_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv210_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -316,7 +270,6 @@ static inline void s5pv210_default_sdhci2(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC2
>  	s3c_hsmmc2_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
>  	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv210_setup_sdhci2_cfg_gpio;
> -	s3c_hsmmc2_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -325,7 +278,6 @@ static inline void s5pv210_default_sdhci3(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC3
>  	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
>  	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
> -	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -341,17 +293,11 @@ static inline void s5pv210_default_sdhci3(void) { }
>  #ifdef CONFIG_EXYNOS4_SETUP_SDHCI
>  extern char *exynos4_hsmmc_clksrcs[4];
> 
> -extern void exynos4_setup_sdhci_cfg_card(struct platform_device *dev,
> -					   void __iomem *r,
> -					   struct mmc_ios *ios,
> -					   struct mmc_card *card);
> -
>  static inline void exynos4_default_sdhci0(void)
>  {
>  #ifdef CONFIG_S3C_DEV_HSMMC
>  	s3c_hsmmc0_def_platdata.clocks = exynos4_hsmmc_clksrcs;
>  	s3c_hsmmc0_def_platdata.cfg_gpio = exynos4_setup_sdhci0_cfg_gpio;
> -	s3c_hsmmc0_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -360,7 +306,6 @@ static inline void exynos4_default_sdhci1(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC1
>  	s3c_hsmmc1_def_platdata.clocks = exynos4_hsmmc_clksrcs;
>  	s3c_hsmmc1_def_platdata.cfg_gpio = exynos4_setup_sdhci1_cfg_gpio;
> -	s3c_hsmmc1_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -369,7 +314,6 @@ static inline void exynos4_default_sdhci2(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC2
>  	s3c_hsmmc2_def_platdata.clocks = exynos4_hsmmc_clksrcs;
>  	s3c_hsmmc2_def_platdata.cfg_gpio = exynos4_setup_sdhci2_cfg_gpio;
> -	s3c_hsmmc2_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> @@ -378,7 +322,6 @@ static inline void exynos4_default_sdhci3(void)
>  #ifdef CONFIG_S3C_DEV_HSMMC3
>  	s3c_hsmmc3_def_platdata.clocks = exynos4_hsmmc_clksrcs;
>  	s3c_hsmmc3_def_platdata.cfg_gpio = exynos4_setup_sdhci3_cfg_gpio;
> -	s3c_hsmmc3_def_platdata.cfg_card = exynos4_setup_sdhci_cfg_card;
>  #endif
>  }
> 
> --
> 1.6.6.rc2

Hi Thomas,

The arch/arm/plat-samsung/dev-hsmmcX.c files have been changed due to commit
61e62fcb ("ARM: SAMSUNG: Consolidate common function to set SDHCI plat
data"). So if possible please make your patch based on latest my for-next :)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
