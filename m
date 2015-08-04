From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v3 1/6] mmc: sdhci-esdhc-imx: add imx7d support and
 support HS400
Date: Tue, 4 Aug 2015 11:25:15 +0800
Message-ID: <20150804032513.GD24870@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-2-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438160637-28061-2-git-send-email-haibo.chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, johan.derycke@barco.com, fabio.estevam@freescale.com, b29396@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 29, 2015 at 05:03:52PM +0800, Haibo Chen wrote:
> The imx7d usdhc is derived from imx6sx, the difference is that
> imx7d support HS400.
> 
> So introduce a new compatible string for imx7d and add HS400
> support for imx7d usdhc.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 66 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index c6b9f64..b441eed 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -44,6 +44,7 @@
>  #define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
>  #define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
>  #define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
> +#define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
>  /* Bits 3 and 6 are not SDHCI standard definitions */
>  #define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
>  /* Tuning bits */
> @@ -60,6 +61,16 @@
>  #define  ESDHC_TUNE_CTRL_MIN		0
>  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
>  
> +/* strobe dll register */
> +#define ESDHC_STROBE_DLL_CTRL		0x70
> +#define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
> +#define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
> +#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
> +
> +#define ESDHC_STROBE_DLL_STATUS		0x74
> +#define ESDHC_STROBE_DLL_STS_REF_LOCK	(1 << 1)
> +#define ESDHC_STROBE_DLL_STS_SLV_LOCK	0x1
> +
>  #define ESDHC_TUNING_CTRL		0xcc
>  #define ESDHC_STD_TUNING_EN		(1 << 24)
>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
> @@ -120,6 +131,8 @@
>  #define ESDHC_FLAG_ERR004536		BIT(7)
>  /* The IP supports HS200 mode */
>  #define ESDHC_FLAG_HS200		BIT(8)
> +/* The IP supports HS400 mode */
> +#define ESDHC_FLAG_SUP_HS400		BIT(9)
>  
>  struct esdhc_soc_data {
>  	u32 flags;
> @@ -156,6 +169,12 @@ static struct esdhc_soc_data usdhc_imx6sx_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>  
> +static struct esdhc_soc_data usdhc_imx7d_data = {
> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_SUP_HS400,

Better to use ESDHC_FLAG_HS400 to keep align with exist ESDHC_FLAG_HS200.

Regards
Dong Aisheng
