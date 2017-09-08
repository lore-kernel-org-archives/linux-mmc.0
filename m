From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Fri, 8 Sep 2017 11:29:53 +0200
Message-ID: <20170908092953.GD18365@amd>
References: <20170906082035.t76xm5umzincncwm@macchiaveli>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906082035.t76xm5umzincncwm@macchiaveli>
Sender: linux-kernel-owner@vger.kernel.org
To: 6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com
Cc: adrian.hunter@intel.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-09-06 10:20:35, Seraphime Kirkovski wrote:
> Hi,
>=20
> > > Seems 4.13-rc4 was already broken for that but unfortuantely
> > > I didn't
> > > reproduce that. So maybe Seraphime can do git-bisect as he said "I=20
> > > get
> > > it everytime" for which I assume it could be easy for him to find=20
> > > out
> > > the problematic commit?
>=20
> I can reliably reproduce it, although sometimes it needs some more work.
> For example, I couldn't trigger it while writing less than 1 gigabyte
> and sometimes I have to do it more than once. It helps if the machine is
> doing something else in meantime, I do kernel builds.
>=20
> > Another unrelated issue with mmc_init_request() is that
> > mmc_exit_request()
> > is not called if mmc_init_request() fails, which means=20
> > mmc_init_request()
> > must free anything it allocates when it fails.
>=20
> I'm running your patch for 45 minutes now, it looks like it's fixing the=
=20
> issue on 4.13 81a84ad3cb5711cec79.
>=20
> P.S. Sorry about the formatting, have to fix my editor

Thanks for quick testing :-). And your formatting is still better than
some...


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmyYxEACgkQMOfwapXb+vJvrwCfVgpgcc55/YRWBImhpHpYAMwG
QRoAoLNQZ1tUCgD+w1Ek9rj6wTWeNXtf
=YxNZ
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
