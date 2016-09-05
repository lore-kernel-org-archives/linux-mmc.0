From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] mmc: host: sh_mobile_sdhi: don't populate unneeded
 functions
Date: Mon, 5 Sep 2016 10:18:23 +0200
Message-ID: <20160905081823.GC1601@katana>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
 <20160824093438.2478-3-wsa+renesas@sang-engineering.com>
 <CANqRtoTJWN52roRwJHh1cZrb2Jqf5OD-ffjKgiW4Y5jqCeVzhg@mail.gmail.com>
 <20160902052258.GA1601@katana>
 <CAPDyKFpVtYtL97YQskPazJPQSHkVuF5BEaaGH_HE=xfkYUq=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpVtYtL97YQskPazJPQSHkVuF5BEaaGH_HE=xfkYUq=Rg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > It can be argued that this tag could be added:
> >
> > Fixes: 452e5eef6d311e ("mmc: tmio: Add UHS-I mode support")
> >
> > I don't know how well it applies, though, because the code has been
> > modified a lot recently. But we can try.
>=20
> Please tell me if you would like me to drop any of the changes I
> queued up in this series.
>=20
> Of course, I can also amend the change log, just tell me.

If you could add the Fixes: tag, this would be welcome. Thanks, Ulf!


--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXzSpPAAoJEBQN5MwUoCm2N/QP/3DEFwG5YKMLKfjAzfCjLo25
bALrpIvqnZCxP2TY3cux1Ypozjbwmd1Y6JhiGEQoniDUCsYGv+YFzrflAcU6ScGM
MWrx3aQNnWs+at98Grti1V6ry4uJQyXKThlE+Wk34z+PX1fI1lvQ/fhCMizCspOk
ngMwXEg1EnJJctagE4oS9b+93iEAvJDxJ83HTkBKyuqDWta/5Y4tk6VJ1OPDsiKB
Cmh9N46AJUzUXMPbBptq61h7iTMQXxlMo7Mvytqcm/VV/vxmL8JnAlEP/K9i94CV
G+4iEv/HpW72tOnJlfOBXCCcugDsurNkN13aYES/ECqGuwYhpBQMYuuIVfe9olQf
fAT24JvhjqBsJdUXE2KUrtvhobD3PbSB44QQj25D4JptlRPr7Y/Soi4LkzUL7gyl
OCxQh+8Q2rdKLWWgekLVSDEBJbaBh8xqj/wUgfSQD+mkqt+jIgoxdsUYJlzcawWN
4xGZr/WK+6+ggjq2VDMaNW3WUjIrInnrnSEGU2KV+NhHjEoJXt4X9joNs30gGsE8
3HjHGpIHBA/hKa3EWbMOsVIoc3WLET+zwAAIF4dFM3axNUw0uY2jhIwmIAAGfdlN
6z7/Y7GjKvSKRMn5XxomW7h8WqQKOTyRwvByY/HWXmF+h4BAVego2K8lH/xdnBIl
ep1+ArxLuJ2YNnoEuADp
=iyHZ
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
