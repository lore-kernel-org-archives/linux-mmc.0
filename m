From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Mon, 20 Jun 2011 16:04:04 +0900
Message-ID: <BANLkTikfMgR5AMZtq7wGKJ4LRP6yjtjhOA@mail.gmail.com>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
	<1308550015-15717-4-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1308550015-15717-4-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 3:06 PM, Simon Horman <horms@verge.net.au> wrot=
e:
> Some controllers require waiting for the bus to become idle
> before writing to some registers. I have implemented this
> by adding a hook to sd_ctrl_write16() and implementing
> a hook for SDHI which waits for the bus to become idle.
>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---

Hi Simon,

Thanks for your work on this!

> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -55,6 +57,37 @@ static int sh_mobile_sdhi_get_cd(struct platform_d=
evice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOSYS;
> =A0}
>
> +static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> +{
> + =A0 =A0 =A0 int timeout =3D 1000;
> +
> + =A0 =A0 =A0 while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2)=
 & (1 << 13)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> +
> + =A0 =A0 =A0 if (!timeout)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(host->pdata->dev, "timeout wai=
ting for SD bus idle\n");
> +
> +}
> +
> +static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, =
int addr)
> +{
> + =A0 =A0 =A0 if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

and

> @@ -86,6 +119,7 @@ static int __devinit sh_mobile_sdhi_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0mmc_data->hclk =3D clk_get_rate(priv->clk);
> =A0 =A0 =A0 =A0mmc_data->set_pwr =3D sh_mobile_sdhi_set_pwr;
> =A0 =A0 =A0 =A0mmc_data->get_cd =3D sh_mobile_sdhi_get_cd;
> + =A0 =A0 =A0 mmc_data->write16_hook =3D sh_mobile_sdhi_write16_hook;
> =A0 =A0 =A0 =A0mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
> =A0 =A0 =A0 =A0if (p) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_data->flags =3D p->tmio_flags;

Doesn't it make more sense to do:

if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
  mmc_data->write16_hook =3D sh_mobile_sdhi_write16_hook;

and skip the check inside the sh_mobile_sdhi_write16_hook() function?

No need to do that check on every register access unless really needed.

Thanks,

/ magnus
