From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: use bitfield access macros for cleanup
Date: Fri, 20 Oct 2017 12:02:52 +0200
Message-ID: <CAPDyKFqjZi8wN27-n-S4gEG_c2H65KjvpP=zARMh-p2pm6KTxg@mail.gmail.com>
References: <1507899031-1245-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:45038 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbdJTKCx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:02:53 -0400
Received: by mail-it0-f68.google.com with SMTP id n195so6009itg.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:02:53 -0700 (PDT)
In-Reply-To: <1507899031-1245-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 13 October 2017 at 14:50, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Accessing register fields generally need mask and shift part.
> Defining them separately, like SDHCI_CDNS_HRS06_TUNE_{SHIFT,MASK},
> is tedious.
>
> Register fields can be always defined by GENMASK (or, BIT if it it
> a single bit).  They are nicely handled by FIELD_* macros.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 56529c3..0f589e2 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -13,6 +13,7 @@
>   * GNU General Public License for more details.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> @@ -27,15 +28,14 @@
>  #define   SDHCI_CDNS_HRS04_ACK                 BIT(26)
>  #define   SDHCI_CDNS_HRS04_RD                  BIT(25)
>  #define   SDHCI_CDNS_HRS04_WR                  BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA_SHIFT         16
> -#define   SDHCI_CDNS_HRS04_WDATA_SHIFT         8
> -#define   SDHCI_CDNS_HRS04_ADDR_SHIFT          0
> +#define   SDHCI_CDNS_HRS04_RDATA               GENMASK(23, 16)
> +#define   SDHCI_CDNS_HRS04_WDATA               GENMASK(15, 8)
> +#define   SDHCI_CDNS_HRS04_ADDR                        GENMASK(5, 0)
>
>  #define SDHCI_CDNS_HRS06               0x18            /* eMMC control */
>  #define   SDHCI_CDNS_HRS06_TUNE_UP             BIT(15)
> -#define   SDHCI_CDNS_HRS06_TUNE_SHIFT          8
> -#define   SDHCI_CDNS_HRS06_TUNE_MASK           0x3f
> -#define   SDHCI_CDNS_HRS06_MODE_MASK           0x7
> +#define   SDHCI_CDNS_HRS06_TUNE                        GENMASK(13, 8)
> +#define   SDHCI_CDNS_HRS06_MODE                        GENMASK(2, 0)
>  #define   SDHCI_CDNS_HRS06_MODE_SD             0x0
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_SDR                0x2
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR                0x3
> @@ -105,8 +105,8 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>         u32 tmp;
>         int ret;
>
> -       tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
> -             (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
> +       tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
> +             FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
>         writel(tmp, reg);
>
>         tmp |= SDHCI_CDNS_HRS04_WR;
> @@ -189,8 +189,8 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>
>         /* The speed mode for eMMC is selected by HRS06 register */
>         tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> -       tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
> -       tmp |= mode;
> +       tmp &= ~SDHCI_CDNS_HRS06_MODE;
> +       tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
>         writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
>  }
>
> @@ -199,7 +199,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>         u32 tmp;
>
>         tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> -       return tmp & SDHCI_CDNS_HRS06_MODE_MASK;
> +       return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> @@ -254,12 +254,12 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>         void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>         u32 tmp;
>
> -       if (WARN_ON(val > SDHCI_CDNS_HRS06_TUNE_MASK))
> +       if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
>                 return -EINVAL;
>
>         tmp = readl(reg);
> -       tmp &= ~(SDHCI_CDNS_HRS06_TUNE_MASK << SDHCI_CDNS_HRS06_TUNE_SHIFT);
> -       tmp |= val << SDHCI_CDNS_HRS06_TUNE_SHIFT;
> +       tmp &= ~SDHCI_CDNS_HRS06_TUNE;
> +       tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_TUNE, val);
>         tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
>         writel(tmp, reg);
>
> --
> 2.7.4
>
