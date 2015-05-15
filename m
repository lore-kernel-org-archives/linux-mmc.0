From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Fri, 15 May 2015 23:22:37 +0200
Message-ID: <201505152322.37739@pali>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <1431724489-32359-2-git-send-email-pali.rohar@gmail.com> <2523437.y90mKuWhc3@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3560218.aGnm4gBWPX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2523437.y90mKuWhc3@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--nextPart3560218.aGnm4gBWPX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 15 May 2015 23:19:44 Arnd Bergmann wrote:
> On Friday 15 May 2015 23:14:48 Pali Roh=C3=A1r wrote:
> > diff --git a/drivers/mmc/host/omap_hsmmc.c
> > b/drivers/mmc/host/omap_hsmmc.c index 9df2b68..f6073dd 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -1901,6 +1901,8 @@ static struct omap_hsmmc_platform_data
> > *of_get_hsmmc_pdata(struct device *dev)
> >=20
> >         if (of_find_property(np, "ti,needs-special-hs-handling",
> >         NULL))
> >        =20
> >                 pdata->features |=3D HSMMC_HAS_HSPE_SUPPORT;
> >=20
> > +       of_property_read_string(np, "slot-name", &pdata->name);
> > +
> >=20
> >         return pdata;
> > =20
> >  }
>=20
> This property needs to be documented in
> Documentation/devicetree/bindings/mmc/mmc.txt and preferably the
> implementation moved into mmc_of_parse.
>=20
> We should not have an interface like this specific to one driver.
>=20
> 	Arnd

Interface is already present for platform data code (which do not use=20
DT). So "pdata->name" is not DT specific...

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart3560218.aGnm4gBWPX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlVWY50ACgkQi/DJPQPkQ1JuqQCfTpymZYvKrlSduC1eKQZLNIVw
q+IAoJiwJhZ1CmcnZyKA9L+A1mKBKM4/
=O7Rl
-----END PGP SIGNATURE-----

--nextPart3560218.aGnm4gBWPX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
