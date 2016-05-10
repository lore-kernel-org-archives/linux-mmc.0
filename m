From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 15/23] mmc: sdhci-esdhc-imx: support setting tuning start
 point
Date: Tue, 10 May 2016 14:17:22 +0300
Message-ID: <5731C342.5060309@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-16-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-16-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 15/04/16 20:29, Dong Aisheng wrote:
> The delay cells of some SoCs may have less delay per one cell,
> for such SoCs, user could set the start delay cell point to bypass
> the first a few meaningless tuning commands.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 14 +++++++++++---
>  include/linux/platform_data/mmc-esdhc-imx.h |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d02db66..9f9be3f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -75,7 +75,8 @@
>  #define ESDHC_TUNING_CTRL		0xcc
>  #define ESDHC_STD_TUNING_EN		(1 << 24)
>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
> -#define ESDHC_TUNING_START_TAP		0x1
> +#define ESDHC_TUNING_START_TAP_DEFAULT	0x1
> +#define ESDHC_TUNING_START_TAP_MASK	0xff
>  #define ESDHC_TUNING_STEP_MASK		0x00070000
>  #define ESDHC_TUNING_STEP_SHIFT		16
>  
> @@ -489,7 +490,12 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
>  				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
>  				tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> -				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
> +				tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT;
> +				if (imx_data->boarddata.tuning_start_tap) {
> +					tuning_ctrl &= ~ESDHC_TUNING_START_TAP_MASK;
> +					tuning_ctrl |= imx_data->boarddata.tuning_start_tap;
> +				}
> +
>  				if (imx_data->boarddata.tuning_step) {
>  					tuning_ctrl &= ~ESDHC_TUNING_STEP_MASK;
>  					tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
> @@ -975,6 +981,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  		boarddata->wp_type = ESDHC_WP_GPIO;
>  
>  	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
> +	of_property_read_u32(np, "fsl,tuning-start-tap",
> +			     &boarddata->tuning_start_tap);
>  
>  	if (of_find_property(np, "no-1-8-v", NULL))
>  		boarddata->support_vsel = false;
> @@ -1197,7 +1205,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
>  		writel(readl(host->ioaddr + ESDHC_TUNING_CTRL) |
> -			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP,
> +			ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP_DEFAULT,
>  			host->ioaddr + ESDHC_TUNING_CTRL);
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 95ccab3..7daa78a 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -46,5 +46,6 @@ struct esdhc_platform_data {
>  	bool support_vsel;
>  	unsigned int delay_line;
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
> +	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
>  };
>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
> 
