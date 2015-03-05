From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info
Date: Thu, 5 Mar 2015 10:59:30 +0100
Message-ID: <CAPDyKFrBh=QNmB_2p-3VoTSw_GnH1GUNDYXjZbO=6jw5AYRxZQ@mail.gmail.com>
References: <878ufo12qq.wl%kuninori.morimoto.gx@renesas.com>
	<8761as12ox.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:59216 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbbCEJ7b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 04:59:31 -0500
Received: by mail-qa0-f42.google.com with SMTP id w8so38073393qac.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2015 01:59:30 -0800 (PST)
In-Reply-To: <8761as12ox.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 24 February 2015 at 03:07, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current sh_mobile_sdhi's platform data is set via sh_mobile_sdhi_info
> and it is just copied to tmio_mmc_data.
> Now, tmio mmc platform data is specified via tmio_mmc_data.
> This patch replace sh_mobile_sdhi_info to tmio_mmc_data
>
> struct sh_mobile_sdhi_info {      -> struct tmio_mmc_data {
>         int dma_slave_tx;         ->    void            *chan_priv_tx;
>         int dma_slave_rx;         ->    void            *chan_priv_rx;
>         unsigned long tmio_flags; ->    unsigned long   flags;
>         unsigned long tmio_caps;  ->    unsigned long   capabilities;
>         unsigned long tmio_caps2; ->    unsigned long   capabilities2;
>         u32 tmio_ocr_mask;        ->    u32             ocr_mask;
>         unsigned int cd_gpio;     ->    unsigned int    cd_gpio;
> };                                      unsigned int    hclk;
>                                         void (*set_pwr)(...);
>                                         void (*set_clk_div)(...);
>                                       };
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

For the mmc parts,

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   20 ++++++++---------
>  arch/arm/mach-shmobile/board-bockw.c           |   14 ++++++------
>  arch/arm/mach-shmobile/board-kzm9g.c           |   20 ++++++++---------
>  arch/arm/mach-shmobile/board-marzen.c          |   10 ++++-----
>  arch/sh/boards/board-sh7757lcr.c               |    9 ++++----
>  arch/sh/boards/mach-ap325rxa/setup.c           |    9 ++++----
>  arch/sh/boards/mach-ecovec24/setup.c           |   20 ++++++++---------
>  arch/sh/boards/mach-kfr2r09/setup.c            |   10 ++++-----
>  arch/sh/boards/mach-migor/setup.c              |    9 ++++----
>  arch/sh/boards/mach-se/7724/setup.c            |   17 +++++++-------
>  drivers/mmc/host/sh_mobile_sdhi.c              |   28 ++----------------------
>  include/linux/mmc/sh_mobile_sdhi.h             |   10 ---------
>  12 files changed, 73 insertions(+), 103 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 6d949f1..7eac846 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -754,12 +754,12 @@ static struct platform_device vcc_sdhi1 = {
>  };
>
>  /* SDHI0 */
> -static struct sh_mobile_sdhi_info sdhi0_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +static struct tmio_mmc_data sdhi0_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>                           MMC_CAP_POWER_OFF_CARD,
> -       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
> +       .flags          = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
>         .cd_gpio        = 167,
>  };
>
> @@ -796,12 +796,12 @@ static struct platform_device sdhi0_device = {
>  };
>
>  /* SDHI1 */
> -static struct sh_mobile_sdhi_info sdhi1_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI1_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI1_RX,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +static struct tmio_mmc_data sdhi1_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI1_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI1_RX,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>                           MMC_CAP_POWER_OFF_CARD,
> -       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
> +       .flags          = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
>         /* Port72 cannot generate IRQs, will be used in polling mode. */
>         .cd_gpio        = 72,
>  };
> diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
> index f27b5a8..25558d1 100644
> --- a/arch/arm/mach-shmobile/board-bockw.c
> +++ b/arch/arm/mach-shmobile/board-bockw.c
> @@ -201,12 +201,12 @@ static struct rcar_phy_platform_data usb_phy_platform_data __initdata =
>
>
>  /* SDHI */
> -static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
> -       .dma_slave_tx   = HPBDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = HPBDMA_SLAVE_SDHI0_RX,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED,
> -       .tmio_ocr_mask  = MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
> -       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT,
> +static struct tmio_mmc_data sdhi0_info __initdata = {
> +       .chan_priv_tx   = (void *)HPBDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)HPBDMA_SLAVE_SDHI0_RX,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED,
> +       .ocr_mask       = MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
> +       .flags          = TMIO_MMC_HAS_IDLE_WAIT,
>  };
>
>  static struct resource sdhi0_resources[] __initdata = {
> @@ -683,7 +683,7 @@ static void __init bockw_init(void)
>                 platform_device_register_resndata(
>                         NULL, "sh_mobile_sdhi", 0,
>                         sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
> -                       &sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
> +                       &sdhi0_info, sizeof(struct tmio_mmc_data));
>         }
>
>         /* for Audio */
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 7c9b63b..260d831 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -442,11 +442,11 @@ static struct platform_device vcc_sdhi2 = {
>  };
>
>  /* SDHI */
> -static struct sh_mobile_sdhi_info sdhi0_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +static struct tmio_mmc_data sdhi0_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .flags          = TMIO_MMC_HAS_IDLE_WAIT,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>                           MMC_CAP_POWER_OFF_CARD,
>  };
>
> @@ -484,13 +484,13 @@ static struct platform_device sdhi0_device = {
>  };
>
>  /* Micro SD */
> -static struct sh_mobile_sdhi_info sdhi2_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI2_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI2_RX,
> -       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT |
> +static struct tmio_mmc_data sdhi2_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI2_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI2_RX,
> +       .flags          = TMIO_MMC_HAS_IDLE_WAIT |
>                           TMIO_MMC_USE_GPIO_CD |
>                           TMIO_MMC_WRPROTECT_DISABLE,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED | MMC_CAP_POWER_OFF_CARD,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_POWER_OFF_CARD,
>         .cd_gpio        = 13,
>  };
>
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 598f704..51db288 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -122,11 +122,11 @@ static struct resource sdhi0_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sdhi0_platform_data = {
> -       .dma_slave_tx = HPBDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx = HPBDMA_SLAVE_SDHI0_RX,
> -       .tmio_flags = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
> -       .tmio_caps = MMC_CAP_SD_HIGHSPEED,
> +static struct tmio_mmc_data sdhi0_platform_data = {
> +       .chan_priv_tx = (void *)HPBDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx = (void *)HPBDMA_SLAVE_SDHI0_RX,
> +       .flags        = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
> +       .capabilities = MMC_CAP_SD_HIGHSPEED,
>  };
>
>  static struct platform_device sdhi0_device = {
> diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
> index 669df51..324599b 100644
> --- a/arch/sh/boards/board-sh7757lcr.c
> +++ b/arch/sh/boards/board-sh7757lcr.c
> @@ -17,6 +17,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/flash.h>
>  #include <linux/io.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/mmc/sh_mobile_sdhi.h>
> @@ -243,10 +244,10 @@ static struct platform_device sh_mmcif_device = {
>  };
>
>  /* SDHI0 */
> -static struct sh_mobile_sdhi_info sdhi_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI_RX,
> -       .tmio_caps      = MMC_CAP_SD_HIGHSPEED,
> +static struct tmio_mmc_data sdhi_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI_RX,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED,
>  };
>
>  static struct resource sdhi_resources[] = {
> diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
> index d4b01d4c..cbd2a9f 100644
> --- a/arch/sh/boards/mach-ap325rxa/setup.c
> +++ b/arch/sh/boards/mach-ap325rxa/setup.c
> @@ -18,6 +18,7 @@
>  #include <linux/mmc/sh_mobile_sdhi.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/mtd/sh_flctl.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/regulator/fixed.h>
> @@ -447,8 +448,8 @@ static struct resource sdhi0_cn3_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sdhi0_cn3_data = {
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sdhi0_cn3_data = {
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device sdhi0_cn3_device = {
> @@ -474,8 +475,8 @@ static struct resource sdhi1_cn7_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sdhi1_cn7_data = {
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sdhi1_cn7_data = {
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device sdhi1_cn7_device = {
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 0d30492..d531791 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -601,12 +601,12 @@ static struct platform_device sdhi0_power = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sdhi0_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
> +static struct tmio_mmc_data sdhi0_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .capabilities   = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
>                           MMC_CAP_NEEDS_POLL,
> -       .tmio_flags     = TMIO_MMC_USE_GPIO_CD,
> +       .flags          = TMIO_MMC_USE_GPIO_CD,
>         .cd_gpio        = GPIO_PTY7,
>  };
>
> @@ -635,12 +635,12 @@ static struct platform_device sdhi0_device = {
>
>  #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
>  /* SDHI1 */
> -static struct sh_mobile_sdhi_info sdhi1_info = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI1_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI1_RX,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
> +static struct tmio_mmc_data sdhi1_info = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI1_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI1_RX,
> +       .capabilities   = MMC_CAP_SDIO_IRQ | MMC_CAP_POWER_OFF_CARD |
>                           MMC_CAP_NEEDS_POLL,
> -       .tmio_flags     = TMIO_MMC_USE_GPIO_CD,
> +       .flags          = TMIO_MMC_USE_GPIO_CD,
>         .cd_gpio        = GPIO_PTW7,
>  };
>
> diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
> index 1df4398..7d997ce 100644
> --- a/arch/sh/boards/mach-kfr2r09/setup.c
> +++ b/arch/sh/boards/mach-kfr2r09/setup.c
> @@ -373,11 +373,11 @@ static struct resource kfr2r09_sh_sdhi0_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_flags     = TMIO_MMC_WRPROTECT_DISABLE,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sh7724_sdhi0_data = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .flags          = TMIO_MMC_WRPROTECT_DISABLE,
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device kfr2r09_sh_sdhi0_device = {
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 8b73194..29b7c0d 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -15,6 +15,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mobile_sdhi.h>
>  #include <linux/mtd/physmap.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/i2c.h>
>  #include <linux/regulator/fixed.h>
> @@ -408,10 +409,10 @@ static struct resource sdhi_cn9_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sh7724_sdhi_data = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device sdhi_cn9_device = {
> diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
> index 1162bc6..4f6635a 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mobile_sdhi.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/delay.h>
>  #include <linux/regulator/fixed.h>
> @@ -468,10 +469,10 @@ static struct resource sdhi0_cn7_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sh7724_sdhi0_data = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI0_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI0_RX,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sh7724_sdhi0_data = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI0_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI0_RX,
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device sdhi0_cn7_device = {
> @@ -497,10 +498,10 @@ static struct resource sdhi1_cn8_resources[] = {
>         },
>  };
>
> -static struct sh_mobile_sdhi_info sh7724_sdhi1_data = {
> -       .dma_slave_tx   = SHDMA_SLAVE_SDHI1_TX,
> -       .dma_slave_rx   = SHDMA_SLAVE_SDHI1_RX,
> -       .tmio_caps      = MMC_CAP_SDIO_IRQ,
> +static struct tmio_mmc_data sh7724_sdhi1_data = {
> +       .chan_priv_tx   = (void *)SHDMA_SLAVE_SDHI1_TX,
> +       .chan_priv_rx   = (void *)SHDMA_SLAVE_SDHI1_RX,
> +       .capabilities   = MMC_CAP_SDIO_IRQ,
>  };
>
>  static struct platform_device sdhi1_cn8_device = {
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 3137e29..354f4f3 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -202,7 +202,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         struct sh_mobile_sdhi *priv;
>         struct tmio_mmc_data *mmc_data;
>         struct tmio_mmc_data *mmd = pdev->dev.platform_data;
> -       struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
>         struct tmio_mmc_host *host;
>         struct resource *res;
>         int irq, ret, i = 0;
> @@ -246,32 +245,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         else
>                 host->bus_shift = 0;
>
> -       if (mmd) {
> -               /*
> -                * FIXME
> -                *
> -                * sh_mobile_sdhi_info will be replaced to tmio_mmc_data soon.
> -                * But, sh_mobile_sdhi_info is used under
> -                * ${LINUX}/arch/arm/mach-shmobile/
> -                * ${LINUX}/arch/sh/
> -                * To separate large patch into "tmio_mmc_data has .chan_priv_?x"
> -                * and "replace sh_mobile_sdhi_info in tmio_mmc_data",
> -                * here has dummy method.
> -                * These should be removed.
> -                */
> -               struct tmio_mmc_data m;
> -
> -               mmd = &m;
> -               m.flags         = p->tmio_flags;
> -               m.ocr_mask      = p->tmio_ocr_mask;
> -               m.capabilities  = p->tmio_caps;
> -               m.capabilities2 = p->tmio_caps2;
> -               m.cd_gpio       = p->cd_gpio;
> -               m.chan_priv_tx  = (void *)p->dma_slave_tx;
> -               m.chan_priv_rx  = (void *)p->dma_slave_rx;
> -
> +       if (mmd)
>                 *mmc_data = *mmd;
> -       }
> +
>         dma_priv->filter = shdma_chan_filter;
>         dma_priv->enable = sh_mobile_sdhi_enable_dma;
>
> diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> index da77e5e20..95d6f03 100644
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -7,14 +7,4 @@
>  #define SH_MOBILE_SDHI_IRQ_SDCARD      "sdcard"
>  #define SH_MOBILE_SDHI_IRQ_SDIO                "sdio"
>
> -struct sh_mobile_sdhi_info {
> -       int dma_slave_tx;
> -       int dma_slave_rx;
> -       unsigned long tmio_flags;
> -       unsigned long tmio_caps;
> -       unsigned long tmio_caps2;
> -       u32 tmio_ocr_mask;      /* available MMC voltages */
> -       unsigned int cd_gpio;
> -};
> -
>  #endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
> --
> 1.7.9.5
>
