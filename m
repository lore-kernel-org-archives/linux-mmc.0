From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: add SD clock limitation for
 imx6ull
Date: Thu, 27 Dec 2018 10:01:24 +0200
Message-ID: <cff15a85-3f72-a8ea-2e5f-731963175fde@intel.com>
References: <1545292612-14471-1-git-send-email-haibo.chen@nxp.com>
 <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545292612-14471-2-git-send-email-haibo.chen@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: BOUGH CHEN <haibo.chen@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 20/12/18 9:49 AM, BOUGH CHEN wrote:
> i.MX6ULL has errata ERR010450, point out that due to SOC I/O
> timing limitation, for eMMC HS200 and SD/SDIO 3.0 SDR104, the
> clock rate can't exceed 150MHz. And for eMMC DDR52 and SD/SDIO
> DDR50 mode, the clock rate can't exceed 45MHz.
> 
> This patch add this limit for imx6ull.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Apart from the kbuild test robot complaints (do they need to be fixed?):

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d0d3193..75a2484 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -138,7 +138,11 @@
>  #define ESDHC_FLAG_HS200		BIT(8)
>  /* The IP supports HS400 mode */
>  #define ESDHC_FLAG_HS400		BIT(9)
> -
> +/* The IP has errata ERR010450
> + * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
> + * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
> + */
> +#define ESDHC_FLAG_ERR010450           BIT(10)
>  /* A clock frequency higher than this rate requires strobe dll control */
>  #define ESDHC_STROBE_DLL_CLK_FREQ	100000000
>  
> @@ -177,6 +181,12 @@ struct esdhc_soc_data {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>  
> +static struct esdhc_soc_data usdhc_imx6ull_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_ERR010450,
> +};
> +
>  static struct esdhc_soc_data usdhc_imx7d_data = {
>  	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> @@ -227,6 +237,7 @@ struct pltfm_imx_data {
>  	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
>  	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
>  	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
> +	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
>  	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
>  	{ /* sentinel */ }
>  };
> @@ -733,6 +744,12 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  		| ESDHC_CLOCK_MASK);
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
> +	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
> +		if (imx_data->is_ddr)
> +			clock = clock > 45000000 ? 45000000 : clock;
> +		else
> +			clock = clock > 150000000 ? 150000000 : clock;
> +
>  	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
>  			pre_div < 256)
>  		pre_div *= 2;
> 
