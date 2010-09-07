From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 3/3] pcm043: add resources for mmc
Date: Tue, 7 Sep 2010 16:36:55 +0200
Message-ID: <20100907143655.GB8924@pengutronix.de>
References: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
	<1283769265-14147-4-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1283769265-14147-4-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hey Wolfram,

On Mon, Sep 06, 2010 at 12:34:25PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mach-pcm043.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> =

> diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm=
043.c
> index 28886f0..44278d3 100644
> --- a/arch/arm/mach-mx3/mach-pcm043.c
> +++ b/arch/arm/mach-mx3/mach-pcm043.c
> @@ -28,6 +28,7 @@
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
>  #include <linux/fsl_devices.h>
> +#include <linux/mmc/host.h>
>  =

>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -139,10 +140,31 @@ static struct i2c_board_info pcm043_i2c_devices[] =
=3D {
>  };
>  #endif
>  =

> +static struct resource sdhci_resources[] =3D {
> +       {
> +               .start          =3D 0x53fb4000,
> +               .end            =3D 0x53fb4000 + 0xff,
> +               .flags          =3D IORESOURCE_MEM,
> +       }, {
> +               .start          =3D MX35_INT_MMC_SDHC1,
> +               .end            =3D MX35_INT_MMC_SDHC1,
> +               .flags          =3D IORESOURCE_IRQ,
> +       },
> +};
> +
> +static struct platform_device sdhci_device =3D {
> +       .name           =3D "sdhci-esdhc",
> +       .id             =3D 0,
> +       .num_resources  =3D ARRAY_SIZE(sdhci_resources),
> +       .resource       =3D sdhci_resources,
> +};
> +
> +
>  static struct platform_device *devices[] __initdata =3D {
>  	&pcm043_flash,
>  	&mxc_fec_device,
>  	&imx_wdt_device0,
> +	&sdhci_device,
>  };
>  =

>  static struct pad_desc pcm043_pads[] =3D {
> @@ -217,6 +239,13 @@ static struct pad_desc pcm043_pads[] =3D {
>  	/* CAN2 */
>  	MX35_PAD_TX5_RX0__CAN2_TXCAN,
>  	MX35_PAD_TX4_RX1__CAN2_RXCAN,
> +	/* esdhc */
> +	MX35_PAD_SD1_CMD__ESDHC1_CMD,
> +	MX35_PAD_SD1_CLK__ESDHC1_CLK,
> +	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
> +	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
> +	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
> +	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
>  };
Can you please rework this to look like

	http://news.gmane.org/find-root.php?group=3Dgmane.linux.ports.arm.kernel&a=
rticle=3D89213

(i.e. put a function in arch/arm/plat-mxc/devices/platform-sdhci-esdhc.c
that dynamically allocates the platform device.)

And then (maybe in a seperate patch) call this new function from the
init routine of the pcm043.

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
