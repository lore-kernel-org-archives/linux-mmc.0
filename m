From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Request for SPI testing
Date: Sat, 3 Jul 2010 19:05:04 +0200
Message-ID: <20100703190504.693fe8fa.ospite@studenti.unina.it>
References: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__3_Jul_2010_19_05_04_+0200_MjlMGvnVjM_UH3MN"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:35031 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab0GCRL0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 3 Jul 2010 13:11:26 -0400
In-Reply-To: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, Ernst Schwab <eschwab@online.de>, Ned Forrester <nforrester@whoi.edu>, David Brownell <dbrownell@users.sourceforge.net>, Anton Vorontsov <cbouatmailru@gmail.com>, openezx-devel@lists.openezx.org

--Signature=_Sat__3_Jul_2010_19_05_04_+0200_MjlMGvnVjM_UH3MN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jun 2010 21:30:34 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> I've pushed out Ernst's spi bus locking API patches to the following
> branch.  Before I push them into linux-next, I'd like to get some
> testing.  Can I have some volunteers please to pull this branch and
> give it a spin?  Bonus points for people who have mmc cards
> multiplexed with other devices on their SPI bus.
>

=46rom a quick test it works for me too, I have both the MMC and the PMIC
(battery, regulators) attached to spi, this is Motorola A910 phone
(pxa27x). Just FYI I applied the patches to 2.6.34 and tested with this
kernel, without the patches I cannot make mmc_spi work reliably (lots
of I/O errors, due to conflict with the PMIC) with these patches I can
finally use the MMC card.

Thanks a lot,
   Antonio

> Cheers,
> g.
>=20
> The following changes since commit 5904b3b81d25166e5e39b9727645bb47937618=
e3:
>   Linus Torvalds (1):
>         Merge branch 'perf-fixes-for-linus' of
> git://git.kernel.org/.../tip/linux-2.6-tip
>=20
> are available in the git repository at:
>=20
>   git://git.secretlab.ca/git/linux-2.6 spi/test
>=20
> Cory Maccarrone (1):
>       SPI100k: Fix 8-bit and RX-only transfers
>=20
> Ernst Schwab (2):
>       spi/mmc_spi: SPI bus locking API, using mutex
>       spi/mmc_spi: mmc_spi adaptations for SPI bus locking API
>=20
>  drivers/mmc/host/mmc_spi.c  |   59 ++---------
>  drivers/spi/omap_spi_100k.c |   23 +++--
>  drivers/spi/spi.c           |  225 ++++++++++++++++++++++++++++++++++++-=
------
>  include/linux/spi/spi.h     |   12 +++
>  4 files changed, 227 insertions(+), 92 deletions(-)
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>=20


--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

--Signature=_Sat__3_Jul_2010_19_05_04_+0200_MjlMGvnVjM_UH3MN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwvbcAACgkQ5xr2akVTsAFWYwCgnz6hkyBo0Dx1UKkJVyV1ysg2
5nsAmwU2SAivs1FQl5ZbxB9ORR3LH3y9
=vdWX
-----END PGP SIGNATURE-----

--Signature=_Sat__3_Jul_2010_19_05_04_+0200_MjlMGvnVjM_UH3MN--
