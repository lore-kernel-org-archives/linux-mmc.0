From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Wed, 14 Sep 2016 18:04:10 +0200
Message-ID: <20160914160409.GA24436@katana>
References: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFoUQ0Xr0qVJoEjw6n_eL3VDoUfZHpu183pM1Yt7-pAnzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoUQ0Xr0qVJoEjw6n_eL3VDoUfZHpu183pM1Yt7-pAnzQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--0OAP2g/MAC+5xKAE
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

So, I did test this on my M3-W Salvator-X (with the fixup patch
Simon sent on top of this series):

+ My SanDisk card always gets properly tuned; re-inserting works

+ My Samsung card gets properly tuned if it is the first card
  inserted to a slot.

- The Samsung card does not get tuned when it was not the first card in
  a slot, i.e. it was re-inserted or the SanDisk card had been used in
  that slot before:

[   56.799203] mmc2: tuning execution failed: -5
[   56.803565] mmc2: error -5 whilst initialising SD card

Note that if I re-insert the SanDisk card to this slot, it will be tuned
correctly. Just the Samsung card will continue to fail.

Any pointers? Maybe some more re-initialization?

Regards,

   Wolfram


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2XT5AAoJEBQN5MwUoCm2TsYP/RVoaN8defknKxjDSF71dWSu
G/92fB3ZMM6GEC0FsJ4S80ksKK8JvwSV0mom2uOw6WPYzhyBOWn+DSMpC6mITYJy
mU97Wagr7OSJjOXhqOwJn9o9Wld9OCQXZEBMnZiKuC5KhKCocLReUTTblX0JVu2Q
eTeQWYf/NVFoy3B2z6S6r3G8BaAJsysGEJG82gJqQjuKvRaUpELZRSFlNppb2pkR
H9hCyCq3u/GtHuow7wfpGert2vKFrN/U1LQc5kvgPuUDKlPjpU/llEVsj8SrFOct
4MBttnjKcZ3+ToCTURxI+u0Md0pmKUzGVZTcLdnoTF0gR8+0crTvGwiGxkuQSD8/
vmGd7Nni5C0v4VujiN/ylh/Zus5ARi6aSodQWhq2NZoogmt+JbyTHtsb6gq3zBeu
ceIEQ8cLll2TfUm9MU6ZJYHVsJRGvkF4t3uYYd6nMabfUuywfGB0MRRoUsVTHMdS
f763BVC0sRc3OBXhFcYoMp00R0Wzz09WrtQMRNkiwsxuyxASK98QMqb+AQFOGaBN
Dmzuigl9YHuQ6oIfTNrBO27J2k1EVY+EG+AzD3SRj4yD8KQtJRQOjeDbJsTNRLe5
Hz976eiqkiVz4e+EcTYQ64SaGUYfwVQ4gz4GoM4Nz7z+agob+oqQTOTQXyXP6piN
0Mjjxoj+KgDwyZ1xJY8F
=3zLJ
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
