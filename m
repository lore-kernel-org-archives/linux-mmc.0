From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/9] esdhc-2 mxc: Modify the MSL codes when upstreaming
	fsl esdhc driver
Date: Sat, 4 Sep 2010 21:02:30 +0200
Message-ID: <20100904190230.GA30544@pengutronix.de>
References: <1283334506-12721-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58395 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab0IDTCh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Sep 2010 15:02:37 -0400
Content-Disposition: inline
In-Reply-To: <1283334506-12721-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hello Richard,

On Wed, Sep 01, 2010 at 05:48:26PM +0800, Richard Zhu wrote:
> Modify the plat-mxc related MSL codes.
The question might be stupid, but what is MSL?

Note I havn't looked deeper into the mx51 iomuxer, but still I'd like t=
o
understand your commit without reading the reference manual.  And it
looks wrong to me that you add/change iomux stuff and extend struct
imxmmc_platform_data in one commit.

> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   31 ++++++++++++++---=
---------
>  arch/arm/plat-mxc/include/mach/mmc.h        |    9 +++++++
>  2 files changed, 26 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/p=
lat-mxc/include/mach/iomux-mx51.h
> index 21bfa46..325b78b 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -45,6 +45,9 @@ typedef enum iomux_config {
>  				PAD_CTL_PKE | PAD_CTL_HYS)
>  #define MX51_GPIO_PAD_CTRL		(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
>  				PAD_CTL_SRE_FAST)
> +#define MX51_SDHCI_PAD_CTRL 	PAD_CTL_DSE_HIGH | PAD_CTL_PUS_47K_UP |=
 \
> +				PAD_CTL_PKE | PAD_CTL_PUE | PAD_CTL_SRE_FAST | \
> +				PAD_CTL_DVS
missing parenthesis
> =20
>  /*
>   * The naming convention for the pad modes is MX51_PAD_<padname>__<p=
admode>
> @@ -294,20 +297,20 @@ typedef enum iomux_config {
>  #define MX51_PAD_DISP2_DAT13__DISP2_DAT13       IOMUX_PAD(0x790, 0x3=
88, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_DISP2_DAT14__DISP2_DAT14       IOMUX_PAD(0x794, 0x3=
8C, 0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_DISP2_DAT15__DISP2_DAT15       IOMUX_PAD(0x798, 0x3=
90, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_CMD__SD1_CMD               IOMUX_PAD(0x79C, 0x3=
94, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_CLK__SD1_CLK               IOMUX_PAD(0x7A0, 0x3=
98, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA0__SD1_DATA0           IOMUX_PAD(0x7A4, 0x3=
9C, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA1__SD1_DATA1           IOMUX_PAD(0x7A8, 0x3=
A0, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA2__SD1_DATA2           IOMUX_PAD(0x7AC, 0x3=
A4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD1_DATA3__SD1_DATA3           IOMUX_PAD(0x7B0, 0x3=
A8, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_SD1_CMD__SD1_CMD	IOMUX_PAD(0x79C, 0x394, IOMUX_CONF=
IG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD1_CLK__SD1_CLK	IOMUX_PAD(0x7A0, 0x398, IOMUX_CONF=
IG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
wrong indention.  Changing space to tab is OK, but the values should
still be aligned.

> +#define MX51_PAD_SD1_DATA0__SD1_DATA0	IOMUX_PAD(0x7A4, 0x39C, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA1__SD1_DATA1	IOMUX_PAD(0x7A8, 0x3A0, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA2__SD1_DATA2	IOMUX_PAD(0x7AC, 0x3A4, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD1_DATA3__SD1_DATA3	IOMUX_PAD(0x7B0, 0x3A8, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_0__GPIO_1_0		IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,=
   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_1__GPIO_1_1		IOMUX_PAD(0x7B8, 0x3B0, 1, 0x0,=
   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_CMD__SD2_CMD               IOMUX_PAD(0x7BC, 0x3=
B4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_CLK__SD2_CLK               IOMUX_PAD(0x7C0, 0x3=
B8, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA0__SD2_DATA0           IOMUX_PAD(0x7C4, 0x3=
BC, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA1__SD2_DATA1           IOMUX_PAD(0x7C8, 0x3=
C0, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA2__SD2_DATA2           IOMUX_PAD(0x7CC, 0x3=
C4, 0, 0x0,   0, NO_PAD_CTRL)
> -#define MX51_PAD_SD2_DATA3__SD2_DATA3           IOMUX_PAD(0x7D0, 0x3=
C8, 0, 0x0,   0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_1__GPIO_1_1	IOMUX_PAD(0x7B8, 0x3B0, IOMUX_CO=
NFIG_GPIO, 0x0, 0, MX51_GPIO_PAD_CTRL)
> +#define MX51_PAD_SD2_CMD__SD2_CMD	IOMUX_PAD(0x7BC, 0x3B4, IOMUX_CONF=
IG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_CLK__SD2_CLK	IOMUX_PAD(0x7C0, 0x3B8, IOMUX_CONF=
IG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL | PAD_CTL_HYS)
> +#define MX51_PAD_SD2_DATA0__SD2_DATA0	IOMUX_PAD(0x7C4, 0x3BC, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA1__SD2_DATA1	IOMUX_PAD(0x7C8, 0x3C0, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA2__SD2_DATA2	IOMUX_PAD(0x7CC, 0x3C4, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
> +#define MX51_PAD_SD2_DATA3__SD2_DATA3	IOMUX_PAD(0x7D0, 0x3C8, IOMUX_=
CONFIG_SION, 0x0, 0, MX51_SDHCI_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_2__GPIO_1_2		IOMUX_PAD(0x7D4, 0x3CC, 0, 0x0,=
   0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_2__I2C2_SCL		IOMUX_PAD(0x7D4, 0x3CC, (2 | IO=
MUX_CONFIG_SION), \
>  							0x9b8,   3, MX51_I2C_PAD_CTRL)
> @@ -316,7 +319,7 @@ typedef enum iomux_config {
>  							0x9bc,   3, MX51_I2C_PAD_CTRL)
>  #define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ	IOMUX_PAD(0x7FC, 0x3D4, =
0, 0x0,   0, NO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_4__GPIO_1_4		IOMUX_PAD(0x804, 0x3D8, 0, 0x0,=
   0, NO_PAD_CTRL)
> -#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, 0, 0x0,=
   0, NO_PAD_CTRL)
> +#define MX51_PAD_GPIO_1_5__GPIO_1_5		IOMUX_PAD(0x808, 0x3DC, IOMUX_C=
ONFIG_GPIO, 0x0, 0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_6__GPIO_1_6		IOMUX_PAD(0x80C, 0x3E0, 0, 0x0,=
   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_7__GPIO_1_7		IOMUX_PAD(0x810, 0x3E4, 0, 0x0,=
   0, MX51_GPIO_PAD_CTRL)
>  #define MX51_PAD_GPIO_1_8__GPIO_1_8		IOMUX_PAD(0x814, 0x3E8, 0, 0x0,=
   1, MX51_GPIO_PAD_CTRL)
> diff --git a/arch/arm/plat-mxc/include/mach/mmc.h b/arch/arm/plat-mxc=
/include/mach/mmc.h
> index 29115f4..19badbe 100644
> --- a/arch/arm/plat-mxc/include/mach/mmc.h
> +++ b/arch/arm/plat-mxc/include/mach/mmc.h
> @@ -34,6 +34,15 @@ struct imxmmc_platform_data {
> =20
>  	/* enable card detect using DAT3 */
>  	int dat3_card_detect;
> +
> +	/* Bus width capabilities, DDR mode and so on*/
> +	unsigned int caps;
> +	/* Min clk frequency the eSDHC can be supported */
> +	unsigned int min_clk;
> +	/* Max clk frequency the eSDHC can be supported */
> +	unsigned int max_clk;
> +	/* Write protected or not, 1:protected.*/
> +	int (*wp_status) (struct device *);
>  };
> =20
>  #endif

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
