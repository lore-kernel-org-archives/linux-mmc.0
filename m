From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND 8/8] mmc: omap4: hsmmc: fix module re-insertion
Date: Fri, 16 Mar 2012 12:38:02 +0200
Message-ID: <20120316103801.GQ16835@arwen.pp.htv.fi>
References: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
 <1331822022-26714-9-git-send-email-svenkatr@ti.com>
 <20120315150426.GT28447@arwen.pp.htv.fi>
 <CANfBPZ-TRRoMrRsE-4twQuq8Q9Htce3BJH2r8hf8OVUou=p4Fg@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K5roPakIqCb4O6y8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:57435 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031020Ab2CPKiN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 06:38:13 -0400
Received: by mail-lb0-f176.google.com with SMTP id m11so1904236lbo.7
        for <linux-mmc@vger.kernel.org>; Fri, 16 Mar 2012 03:38:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANfBPZ-TRRoMrRsE-4twQuq8Q9Htce3BJH2r8hf8OVUou=p4Fg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: balbi@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com


--K5roPakIqCb4O6y8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 04:02:16PM +0530, S, Venkatraman wrote:
> On Thu, Mar 15, 2012 at 8:34 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Mar 15, 2012 at 08:03:42PM +0530, Venkatraman S wrote:
> >> From: Balaji T K <balajitk@ti.com>
> >>
> >> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
> >> Addng the offset to platform_device resource structure
> >> increments the start address for every insmod operation.
> >> MMC command fails on re-insertion as module due to incorrect register =
base.
> >> Fix this by updating the ioremap base address only.
> >>
> >> Signed-off-by: Balaji T K <balajitk@ti.com>
> >> ---
> >> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A04 +---
> >> =A01 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsm=
mc.c
> >> index 4476b26..f324cf4 100644
> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> @@ -1813,8 +1813,6 @@ static int __devinit omap_hsmmc_probe(struct pla=
tform_device *pdev)
> >> =A0 =A0 =A0 if (res =3D=3D NULL || irq < 0)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> >>
> >> - =A0 =A0 res->start +=3D pdata->reg_offset;
> >> - =A0 =A0 res->end +=3D pdata->reg_offset;
> >> =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(res),=
 pdev->name);
> >> =A0 =A0 =A0 if (res =3D=3D NULL)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> >> @@ -1838,7 +1836,7 @@ static int __devinit omap_hsmmc_probe(struct pla=
tform_device *pdev)
> >> =A0 =A0 =A0 host->dma_ch =A0 =A0=3D -1;
> >> =A0 =A0 =A0 host->irq =A0 =A0 =A0 =3D irq;
> >> =A0 =A0 =A0 host->slot_id =A0 =3D 0;
> >> - =A0 =A0 host->mapbase =A0 =3D res->start;
> >> + =A0 =A0 host->mapbase =A0 =3D res->start + pdata->reg_offset;
> >
> > could this be done with a revision check at some point so we drop the
> > pdata requirement ? Not part of $SUBJECT though, because you're just
> > moving the increment.
> >
> That's a good idea. Will post that patch as part of another clean up seri=
es in
> the pipeline.

sounds good to me ;-)

--=20
balbi

--K5roPakIqCb4O6y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYxgJAAoJEIaOsuA1yqREOnAQAJwxGqRpVOGA7wks2P0iINxi
44yGoAWpdTDKDaoy7ft/94R5urjNQ/QJE6nDg+daHN3hamDuhoJIOo61LCfnk9OA
52aemCOs0U0/buArFFvVb6U9SwvRoRd63bWm++Zdn328tj23XyMufEll8FLoDXT+
Z76bnqt66+zi3280ylr5K++C7/egNWlnHKvQfAQtlCqSTmLOKWeBBmLRDeeowb6u
9bu7i41leW0/g92/FADbvvlG08vqp6csau3F/+R792jjxrn2VRnBGnwRyPZ64L9s
c1qzso1JlMAbgmwBPBdDCm0yIwuCgCHRLp7Ixg3sjQTzBKWWUDS/MOG9pbaZn1+3
6ZW/cs3HI+C2PonccTOhfV7tIlfx+fcc4zVwz9poRo6Zk60VaKc/cNcixbIx2qrB
+mXZr2TnTy+Y0Y9iDekA0BEkXnjoEzuctt9bC7dtcla2RomD5EIGPLDkxU90IB0N
LbjSPpw4Xr2iYiAveL6ik6EJINovALH72Pa280ZoHJ/fsVuu+bfvbUFjuivJad6w
GK4JLodzUrjbpdeOPVrxQTiLq6Kk6g7VKYWk/CTII9l4A9HTOr0R7hkAZi2iayoG
7CZMqbEnCvY2EGrxB49as3J3Wq3LgCByHMD00uqwOjBkLVbHSBcCKQHl8f0YiawE
vg9AJNbH3LGZn+LVLNW7
=qEAO
-----END PGP SIGNATURE-----

--K5roPakIqCb4O6y8--
