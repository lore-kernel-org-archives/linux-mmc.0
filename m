From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: use bitfield access macros for
 cleanup
Date: Thu, 19 Oct 2017 11:37:53 +0300
Message-ID: <2ed276f9-5869-93ed-766f-a122f4942591@intel.com>
References: <1507899031-1245-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507899031-1245-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: Piotr Sroka <piotrs@cadence.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 13/10/17 15:50, Masahiro Yamada wrote:
> Accessing register fields generally need mask and shift part.
> Defining them separately, like SDHCI_CDNS_HRS06_TUNE_{SHIFT,MASK},
> is tedious.
> 
> Register fields can be always defined by GENMASK (or, BIT if it it
> a single bit).  They are nicely handled by FIELD_* macros.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
>  #define   SDHCI_CDNS_HRS04_ACK			BIT(26)
>  #define   SDHCI_CDNS_HRS04_RD			BIT(25)
>  #define   SDHCI_CDNS_HRS04_WR			BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA_SHIFT		16
> -#define   SDHCI_CDNS_HRS04_WDATA_SHIFT		8
> -#define   SDHCI_CDNS_HRS04_ADDR_SHIFT		0
> +#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> +#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> +#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
>  
>  #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
>  #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> -#define   SDHCI_CDNS_HRS06_TUNE_SHIFT		8
> -#define   SDHCI_CDNS_HRS06_TUNE_MASK		0x3f
> -#define   SDHCI_CDNS_HRS06_MODE_MASK		0x7
> +#define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
> +#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
>  #define   SDHCI_CDNS_HRS06_MODE_SD		0x0
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
> @@ -105,8 +105,8 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  	u32 tmp;
>  	int ret;
>  
> -	tmp = (data << SDHCI_CDNS_HRS04_WDATA_SHIFT) |
> -	      (addr << SDHCI_CDNS_HRS04_ADDR_SHIFT);
> +	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
> +	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
>  	writel(tmp, reg);
>  
>  	tmp |= SDHCI_CDNS_HRS04_WR;
> @@ -189,8 +189,8 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
>  
>  	/* The speed mode for eMMC is selected by HRS06 register */
>  	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> -	tmp &= ~SDHCI_CDNS_HRS06_MODE_MASK;
> -	tmp |= mode;
> +	tmp &= ~SDHCI_CDNS_HRS06_MODE;
> +	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
>  	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
>  }
>  
> @@ -199,7 +199,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  	u32 tmp;
>  
>  	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
> -	return tmp & SDHCI_CDNS_HRS06_MODE_MASK;
> +	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>  
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> @@ -254,12 +254,12 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>  	u32 tmp;
>  
> -	if (WARN_ON(val > SDHCI_CDNS_HRS06_TUNE_MASK))
> +	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
>  		return -EINVAL;
>  
>  	tmp = readl(reg);
> -	tmp &= ~(SDHCI_CDNS_HRS06_TUNE_MASK << SDHCI_CDNS_HRS06_TUNE_SHIFT);
> -	tmp |= val << SDHCI_CDNS_HRS06_TUNE_SHIFT;
> +	tmp &= ~SDHCI_CDNS_HRS06_TUNE;
> +	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_TUNE, val);
>  	tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
>  	writel(tmp, reg);
>  
> 
