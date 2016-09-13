From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 13 Sep 2016 14:58:25 +0200
Message-ID: <20160913125825.GA3510@katana>
References: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFoUQ0Xr0qVJoEjw6n_eL3VDoUfZHpu183pM1Yt7-pAnzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoUQ0Xr0qVJoEjw6n_eL3VDoUfZHpu183pM1Yt7-pAnzQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2016 at 02:48:26PM +0200, Ulf Hansson wrote:
> On 13 September 2016 at 12:56, Simon Horman <horms+renesas@verge.net.au> =
wrote:
> >
> > Hi,
> >
> > this series is based on work by Ai Kyuse to add UHS-I SDR-104 support f=
or
> > sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> > Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS=
-I
> > SDR-50 support to the same driver.
> >
> > It is based on a merge of the next branches of the mmc tree.
> >
> > To aid review the following git branch is provided:
> > * https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git to=
pic/sdr104-driver-v7
> >
> > Overview of changes since v6:
> > * Address review by Ulf
> >   - Detailed in per-patch changelogs
> > * Move integration (arm/arm64 dt) patches to separate patchset
> >
> > Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
> > results.
> >
> >
> > Ai Kyuse (3):
> >   mmc: tmio: enhance illegal sequence handling
> >   mmc: tmio: Add hw reset support
> >   mmc: tmio: Add tuning support
> >
> > Simon Horman (3):
> >   mmc: core: Add helper to see if a host can be retuned
> >   mmc: tmio: document mandatory and optional callbacks
> >   mmc: sh_mobile_sdhi: Add tuning support
> >
> >  drivers/mmc/host/sh_mobile_sdhi.c | 265 ++++++++++++++++++++++++++++++=
+++++++-
> >  drivers/mmc/host/tmio_mmc.h       |  18 ++-
> >  drivers/mmc/host/tmio_mmc_pio.c   |  87 ++++++++++++-
> >  include/linux/mmc/host.h          |   5 +
> >  4 files changed, 367 insertions(+), 8 deletions(-)
> >
> > --
> > 2.7.0.rc3.207.g0ac5344
> >
>=20
> This looks good to me, although I would like to get an ack from
> Wolfram before I queue this up.

I'll test today or tomorrow. Same for the r7s72100 patches.

Thanks,

   Wolfram


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1/fxAAoJEBQN5MwUoCm2kw4QAJyDG1M/Tru2E4B/9EF+Z6nD
gVnsg7LgQ/6VXo8TCaHU15t+7OpKgehtvpkM/GOt4mvPF3wv93vNnRNbm5OJwHvl
oDG/JofOQnHHptejUkDEdqnSt/jJJW8urgmihirjV5ZAFbeF7gVAqfbtfL0tYSrl
GANwFrTaeOrwd7VWbVpv/rm0KY6qQ9tWOxoysfu5k4eA91VRtV5KCSL0bmtCfz4y
kNahJTwR9xTpZXpKTdJ9nOPArFltQXHxxuvKKnj3A487tcsAklWuBufTrpn+eZGm
G0JHKDIhbzGDIoXjIuIipuqxx2ja8hfXqPOEcbl4d9T5V9RBY/E5DKVtRhwYV3qV
CwhJdzP3BGngkyC4ZJf3kHzAPt3cC2IFlcl0uUU0+6CG75WZI6uInmWXouONCnhW
ZgQ0HxB7wABX5uQKCma6EmloSqqOPX4IeoiUhWCEFg2GtEfnOWg1zGsxRyUcgmEz
e0FD+RgOgt6v7nXs+KQvmyxifthzSxOVHvXBQcylZYzxlUHMUuoOPydG4JRIivKd
OwKFLqzj6B+LYyyQvsliJVgapk6iyXHwLfeU1gadSsjxuE47dr80h5t4pNFEwTZX
ZI8GajKBYVmt8mvZq30oQOspVtwFqyZPmQaS0Dz1IppmCcACcPNUsnJTssRiXiWt
u4waF6UnxXx1rq9DbczW
=bbrp
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
