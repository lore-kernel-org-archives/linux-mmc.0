From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 8/8] mmc: omap4: hsmmc: fix module re-insertion
Date: Thu, 15 Mar 2012 17:04:28 +0200
Message-ID: <20120315150426.GT28447@arwen.pp.htv.fi>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-9-git-send-email-svenkatr@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331822022-26714-9-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 15, 2012 at 08:03:42PM +0530, Venkatraman S wrote:
> From: Balaji T K <balajitk@ti.com>
>=20
> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
> Addng the offset to platform_device resource structure
> increments the start address for every insmod operation.
> MMC command fails on re-insertion as module due to incorrect register bas=
e.
> Fix this by updating the ioremap base address only.
>=20
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4476b26..f324cf4 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1813,8 +1813,6 @@ static int __devinit omap_hsmmc_probe(struct platfo=
rm_device *pdev)
>  	if (res =3D=3D NULL || irq < 0)
>  		return -ENXIO;
> =20
> -	res->start +=3D pdata->reg_offset;
> -	res->end +=3D pdata->reg_offset;
>  	res =3D request_mem_region(res->start, resource_size(res), pdev->name);
>  	if (res =3D=3D NULL)
>  		return -EBUSY;
> @@ -1838,7 +1836,7 @@ static int __devinit omap_hsmmc_probe(struct platfo=
rm_device *pdev)
>  	host->dma_ch	=3D -1;
>  	host->irq	=3D irq;
>  	host->slot_id	=3D 0;
> -	host->mapbase	=3D res->start;
> +	host->mapbase	=3D res->start + pdata->reg_offset;

could this be done with a revision check at some point so we drop the
pdata requirement ? Not part of $SUBJECT though, because you're just
moving the increment.

--=20
balbi

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYgT6AAoJEIaOsuA1yqREq+cP/1z078gnRX+M+EYz+tfbZjuE
rKSVWyS3ulcIa03SL83bWNgB5rf/Vo9U5lfAEBBJZuNNg5kUR5GtYctEMeYAMWtq
ICI0Db4/5BbYyhvPs8K6Hbgj4ne1I/M+kSmk2qgBrh0j6Ak52NfBg0XTZlNa4j2e
ny3oVIPZGjGVkVmptMDInJstK9nngoiXvnyMVRP7aW+f38OY3bmXHyztNs7DVPui
uPyWgMXGNEntGMOU3oJaqDmvYy6KIdwk7MYNhmEXhKniz/w2i6xS5uH22LWnLoCa
ZZjcIL+JFx67RxXObFA/1mIb/2c92wg0BtLJ5x4MFGUsY83tgsaXfHEvlHi4XYSP
9+T9FyEo5+/oQyJfJ25eIbjqxZVlBmfIe4B6oGARQg+5Weq3P7HwzE5qV/pZKJn/
IQ6SDk6vtjBPuRb1cyhghFgAl1gODECZQ3tGc1tXeuYurbd9HYCuhSRG0Y7+7QN3
yt8SDXR5gMsr2d8U2P2gyQ3Bj7pp2AV7HADBV+YdNAqScx6x16n9Qa4MeZ7j2JIt
b2NKQS2ElcWycyfGxrttqQpibRxMejc/dg1oNtAcr4MrHR7GkGFtPJjMTPhsXY86
GJur0fcfdpbjeS1obRugLYmDDNIQEZWbprdnRQM0WSLx1dqXEROFCKkxdQyHcR7S
k8VKhnANnO5FcDPX/kdV
=h5Mu
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--
