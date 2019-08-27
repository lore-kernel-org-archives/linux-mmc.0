From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
Date: Tue, 27 Aug 2019 15:24:26 +0200
Message-ID: <CAPDyKFr5opD2yBXmFRBY-9oA_3ShVv0GPFRO8Q_8TEiT+z2pQA@mail.gmail.com>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= <alejandro.gonzalez.correo@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, 25 Aug 2019 at 17:06, Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:
>
> Some Allwinner H6 boards have timing problems when dealing with
> DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.
>
> These timing problems result in out of sync communication between the
> driver and the eMMC, which renders the memory unsuable for every
> operation but some basic commmands, like reading the status register.
>
> The cause of these timing problems is not yet well known, but they go
> away by disabling DDR mode operation in the driver. Like on some H5
> boards, it might be that the traces are not precise enough to support
> these speeds. However, Jernej Skrabec compared the BSP driver with this
> driver, and found that the BSP driver configures pinctrl to operate at
> 1.8 V when entering DDR mode (although 3.3 V operation is supported), whi=
le
> the mainline kernel lacks any mechanism to switch voltages dynamically.
> Finally, other possible cause might be some timing parameter that is
> different on the H6 with respect to other SoCs.
>
> Therefore, as this fix works reliably, the kernel lacks the required
> dynamic pinctrl control for now and a slow eMMC is better than a not
> working eMMC, just disable DDR operation for now on H6-compatible
> devices.
>
> Signed-off-by: Alejandro Gonz=C3=A1lez <alejandro.gonzalez.correo@gmail.c=
om>

Assuming this should go stable as well? Perhaps you can find a
relevant commit that we can put as a fixes tag as well?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d577a6b0ceae..dac57d76d009 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1395,14 +1395,17 @@ static int sunxi_mmc_probe(struct platform_device=
 *pdev)
>
>         /*
>          * Some H5 devices do not have signal traces precise enough to
> -        * use HS DDR mode for their eMMC chips.
> +        * use HS DDR mode for their eMMC chips. Other H6 devices operate
> +        * unreliably on HS DDR mode, too.
>          *
>          * We still enable HS DDR modes for all the other controller
> -        * variants that support them.
> +        * variants that support them properly.
>          */
>         if ((host->cfg->clk_delays || host->use_new_timings) &&
>             !of_device_is_compatible(pdev->dev.of_node,
> -                                    "allwinner,sun50i-h5-emmc"))
> +                                    "allwinner,sun50i-h5-emmc") &&
> +           !of_device_is_compatible(pdev->dev.of_node,
> +                                    "allwinner,sun50i-h6-emmc"))
>                 mmc->caps      |=3D MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>
>         ret =3D mmc_of_parse(mmc);
> --
> 2.20.1
>
