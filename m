From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 2 Oct 2017 15:03:53 +0200
Message-ID: <20171002130353.GA25433@amd>
References: <20170905194739.GA31241@amd>
 <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
 <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <72c93a69-610f-027e-c028-379b97b6f388@intel.com>
 <20171002084131.GA24414@amd>
 <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-10-02 14:06:03, Linus Walleij wrote:
> On Mon, Oct 2, 2017 at 10:41 AM, Pavel Machek <pavel@ucw.cz> wrote:
>=20
> >> Bounce buffers are being removed from v4.15
>=20
> As Adrian states, this would make any last bugs go away. I would
> even consider putting this patch this into fixes if it solves the problem.
>=20
> > although you may experience
> >> performance regression with that:
> >>
> >>       https://marc.info/?l=3Dlinux-mmc&m=3D150589778700551
> >
> > Hmm. The performance of this is already pretty bad, I really hope it
> > does not get any worse.
>=20
> Did you use bounce buffers? Those were improving performance on
> some laptops with TI or Ricoh host controllers and nothing else was
> ever really using it (as can be seen from the commit).

Thinkpad X220... how do I tell if I was using them? I believe so,
because I uncovered bug in them before.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnSOTkACgkQMOfwapXb+vLC7QCZAfSSy+2u+u9pvrLC579qxsqd
kM4An1/hp9y9gOLAHZ4nUdVxRMlPs0+k
=iLSc
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
