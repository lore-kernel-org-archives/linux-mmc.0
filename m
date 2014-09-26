From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
Date: Fri, 26 Sep 2014 17:02:04 +0200
Message-ID: <20140926150204.GT15315@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <1410466706-27386-12-git-send-email-maxime.ripard@free-electrons.com>
 <3992138.y6J8TjIuMq@pagira.o2s.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6M1qd/2fGtHH53kd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3992138.y6J8TjIuMq-pgFh0Jf6HD9Xzn/AsuzBOg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David =?iso-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--6M1qd/2fGtHH53kd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 04:27:10PM +0200, David Lanzend=F6rfer wrote:
> Hello
> > Now that we have proper support to use the generic phase API in our clo=
ck
> > driver, switch the MMC driver to use it.
> > [...]
> >  	/* determine delays */
> >  	if (rate <=3D 400000) {
> > -		oclk_dly =3D 0;
> > -		sclk_dly =3D 7;
> > +		oclk_dly =3D 180;
> > +		sclk_dly =3D 42;
> > [...]
> How did you calculate the actual phase values from the original parameter=
s?

Like shown in the clock driver. 0 is always a 180 deg phase shift, and
any other value is the number of the parent clock cycle to outphase
the clock of.

the clock out phase is calculating using:

phase =3D 360 * interval / period.

with period =3D 1 / (parent_freq / divider)
and interval =3D reg / parent_freq

which makes

phase =3D 360 * (reg / parent_freq) * (parent_freq / divider)

If we simplify by removing the parent_freq, we end up with

phase =3D 360 * reg / divider, which makes it rather trivial to
calculate.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--6M1qd/2fGtHH53kd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJX/sAAoJEBx+YmzsjxAgjhMP/3LH/NXxHjd1LPXorKLYqrHA
vXCTiTsepGhBrEtrsEYQ58XO++uBLGFK64o7boHEFo73hXft2ZnMdIU03TDm7IH9
CbDLnQmtHUCWmJtbxiPq68z45cKdOOufJPjMlH5fOzWM8AvfjTd+k1ah1pjJ1uVl
rLgrDiNPuvs2hbVVRZ8MEc62U7PKHBFblt9zGZr22ZBc74FyyDnyMspm3ocGqgMB
WiZ8W1FNbHFw3nZ9iS0kx45Vv0qP5ZQF/V4U8Vt/N209mE3HjI/z2QshCkVpR13z
uNhJ1nmSkh3AKVcF2/zsAi2JrbaUDU07Kuuma8nEgYBFv1x6NaeBZe/E3RKWbLjs
9r50XFO+rxM9ZkdzDhKQg4hbUrGOK8AqfZRmHn23yGxckjQli8qLK1NvNugyKzNA
HQ6PvicRXfrR5KJOCS2eFSXITmsSy91D2Jzj3ciYMdD4VhluuSqSxRtsgsACIhy0
d/W2/8DIwoY2Pplq1RBfC0lMn/p/SznUHfVavBmVydmzClbV8hjWJk5rrndW1klN
9gNXz+c5fu158K0ZFWyqboElsDxex1UxSl/5LMGpmQQVZc7HEqG/6IYGV4KoKa8T
sFUZmF+2Ivk605cHq+vG+52sL/q5T5Gs/sD4/nbLqBUw6/Srba0F9eRIP5YE0Rfc
Ow2aNi6nU6pNsYs9yKyo
=WD9R
-----END PGP SIGNATURE-----

--6M1qd/2fGtHH53kd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
