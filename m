From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Mon, 20 Jun 2011 22:40:51 +0900
Message-ID: <20110620134045.GD9325@verge.net.au>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
 <1308550015-15717-4-git-send-email-horms@verge.net.au>
 <BANLkTikfMgR5AMZtq7wGKJ4LRP6yjtjhOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BANLkTikfMgR5AMZtq7wGKJ4LRP6yjtjhOA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 04:04:04PM +0900, Magnus Damm wrote:
> On Mon, Jun 20, 2011 at 3:06 PM, Simon Horman <horms@verge.net.au> wr=
ote:
> > Some controllers require waiting for the bus to become idle
> > before writing to some registers. I have implemented this
> > by adding a hook to sd_ctrl_write16() and implementing
> > a hook for SDHI which waits for the bus to become idle.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
>=20
> Hi Simon,
>=20
> Thanks for your work on this!
>=20
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -55,6 +57,37 @@ static int sh_mobile_sdhi_get_cd(struct platform=
_device *pdev)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOS=
YS;
> > =C2=A0}
> >
> > +static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 int timeout =3D 1000;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 while (--timeout && !(sd_ctrl_read16(host, C=
TL_STATUS2) & (1 << 13)))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (!timeout)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_warn(host->p=
data->dev, "timeout waiting for SD bus idle\n");
> > +
> > +}
> > +
> > +static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host=
, int addr)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE=
_WAIT))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>=20
> and
>=20
> > @@ -86,6 +119,7 @@ static int __devinit sh_mobile_sdhi_probe(struct=
 platform_device *pdev)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_data->hclk =3D clk_get_rate(priv->cl=
k);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_data->set_pwr =3D sh_mobile_sdhi_set=
_pwr;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_data->get_cd =3D sh_mobile_sdhi_get_=
cd;
> > + =C2=A0 =C2=A0 =C2=A0 mmc_data->write16_hook =3D sh_mobile_sdhi_wr=
ite16_hook;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_data->capabilities =3D MMC_CAP_MMC_H=
IGHSPEED;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_data->fl=
ags =3D p->tmio_flags;
>=20
> Doesn't it make more sense to do:
>=20
> if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
>   mmc_data->write16_hook =3D sh_mobile_sdhi_write16_hook;
>=20
> and skip the check inside the sh_mobile_sdhi_write16_hook() function?
>=20
> No need to do that check on every register access unless really neede=
d.

Sure, good idea.
