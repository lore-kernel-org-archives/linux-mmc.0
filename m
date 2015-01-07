From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Wed, 07 Jan 2015 10:23:49 +0100
Message-ID: <2017134.He5GnynN45@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <7306460.62PqiTEhxi@wuerfel> <87fvbnpblr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87fvbnpblr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 07 January 2015 02:28:43 Kuninori Morimoto wrote:
>=20
> Hi Arnd
>=20
> Thank you for your DMAEngine fixup patch.
> I tried this patch, and have comment.

Thanks for looking at the changes

> > =20
> > -	sdev =3D to_shdma_dev(schan->dma_chan.device);
> > -	ret =3D sdev->ops->set_slave(schan, match, 0, true);
> > +	ret =3D sdev->ops->set_slave(schan, schan->real_slave_id, 0, true=
);
> > +	schan->real_slave_id =3D slave_id;
> >  	if (ret < 0)
> >  		return false;
>=20
> Here, your patch is
>=20
> 	ret =3D sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
> 	schan->real_slave_id =3D slave_id;
> 	if (ret < 0)
>=20
> But, it doesn't work. Maybe, you want this
>=20
> 	schan->real_slave_id =3D slave_id;
> 	ret =3D sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
> 	if (ret < 0)

Right, I broke it in a last-minute change. Originally I had

 	schan->real_slave_id =3D slave_id;
 	ret =3D sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
 	if (ret < 0) {
		schan->real_slave_id =3D 0;
		return ret;
	}

and then meant to shorten it to

 	ret =3D sdev->ops->set_slave(schan, slave_id, 0, true);
 	if (ret < 0)
		return ret;
 	schan->real_slave_id =3D slave_id;

Either of those should be fine, but what I wrote was instead was
completely wrong.

> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmci=
f.c
> > index 7d9d6a321521..df3a537f5a83 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -388,7 +388,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *=
host,
> >  {
> >  	struct dma_slave_config cfg =3D { 0, };
> >  	struct dma_chan *chan;
> > -	unsigned int slave_id;
> > +	void *slave_data;
> >  	struct resource *res;
> >  	dma_cap_mask_t mask;
> >  	int ret;
> > @@ -414,8 +414,6 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *=
host,
> > =20
> >  	res =3D platform_get_resource(host->pd, IORESOURCE_MEM, 0);
> > =20
> > -	/* In the OF case the driver will get the slave ID from the DT */
> > -	cfg.slave_id =3D slave_id;
> >  	cfg.direction =3D direction;
> > =20
> >  	if (direction =3D=3D DMA_DEV_TO_MEM) {
>=20
> I got error here
>=20
>=20
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c: In function =E2=
=80=98sh_mmcif_request_dma_one=E2=80=99:
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:400:3: error: =E2=
=80=98slave_id=E2=80=99 undeclared (first use in this function)
>    slave_id =3D direction =3D=3D DMA_MEM_TO_DEV
>    ^
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:400:3: note: eac=
h undeclared identifier is reported only once for each function it appe=
ars in
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:391:8: warning: =
unused variable =E2=80=98slave_data=E2=80=99 [-Wunused-variable]
>   void *slave_data;
>         ^
>=20
> Maybe you are missing this
>=20
>         if (pdata)
> -               slave_id =3D direction =3D=3D DMA_MEM_TO_DEV
> -                        ? pdata->slave_id_tx : pdata->slave_id_rx;
> +               slave_data =3D direction =3D=3D DMA_MEM_TO_DEV
> +                       ? (void *)pdata->slave_id_tx : (void *)pdata-=
>slave_id_rx;
>         else
> -               slave_id =3D 0;
> +               slave_data =3D 0;
> =20
>         chan =3D dma_request_slave_channel_compat(mask, shdma_chan_fi=
lter,
> -                               (void *)(unsigned long)slave_id, &hos=
t->pd->dev,
> +                               slave_data, &host->pd->dev,
>                                 direction =3D=3D DMA_MEM_TO_DEV ? "tx=
" : "rx");
> =20
>         dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
>=20
>=20
> sh_mobile_sdhi DMA works if I fixuped above

Either that or undo the change to the type. I originally planned to cha=
nge the
sh_mmcif_plat_data to use a void* type already, but then didn't do that=
 because
it conflicts with your other patch, and I failed to revert my earlier c=
hange
correctly.

	Arnd
