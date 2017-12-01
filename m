From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Possible regression due to "arm64: renesas: salvator: set driver
 type for eMMC"
Date: Fri, 1 Dec 2017 12:06:33 +0100
Message-ID: <20171201110632.odbk2iocniyiiqek@ninjato>
References: <20171130161759.47tjyfqefoffpus3@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zaplvtae5vpc5kb2"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33427 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbdLALGe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 1 Dec 2017 06:06:34 -0500
Content-Disposition: inline
In-Reply-To: <20171130161759.47tjyfqefoffpus3@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


--zaplvtae5vpc5kb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 05:18:03PM +0100, Simon Horman wrote:
> Hi Wolfram,
>=20
> I have observed the following behaviour in renesas-devel-20171130-v4.15-r=
c1
> which I have bisected down to being caused by d3decc2c34c8 ("arm64: dts:
> renesas: salvator: set driver type for eMMC"). The patch in question is
> based on v4.15-rc1.
>=20
> I am compiling using renesas_defconfig
>=20
> The problem manifests on Salvator-X / H3 ES1.0.
>=20
> [    2.567304] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee1=
40000 max clock rate 200 MHz
> [    2.700110] mmc0: tuning execution failed: -5
> [    2.704591] mmc0: error -5 whilst initialising MMC card
> [    2.783042] mmc0: tuning execution failed: -5
> [    2.783057] mmc0: error -5 whilst initialising MMC card
> [    2.935219] mmc0: tuning execution failed: -5
> [    2.939676] mmc0: error -5 whilst initialising MMC card
> [    3.103876] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee1=
00000 max clock rate 200 MHz
> [    3.174033] mmc0: tuning execution failed: -5

I can't reproduce this:

[    2.567789] mmc0: new HS200 MMC card at address 0001
[    2.568765] mmcblk0: mmc0:0001 BGSD3R 29.1 GiB=20
[    2.569028] mmcblk0boot0: mmc0:0001 BGSD3R partition 1 16.0 MiB
[    2.569256] mmcblk0boot1: mmc0:0001 BGSD3R partition 2 16.0 MiB
[    2.569587] mmcblk0rpmb: mmc0:0001 BGSD3R partition 3 4.00 MiB, chardev =
(243:0)
[    2.571586]  mmcblk0: p1

I tested with your above settings, but also with plain v4.15-rc1 and a cust=
om
config. That matches my test results when developing the patchset; I tested=
 on
all Gen3 boards without problems.

While I think it could be that the early ES1.0 boards might have different =
eMMC
chips...

> The behaviour on Salvator-XS / H3 ES2.0 seems inconsistent.

=2E.. I am surprised by this behaviour. I would have assumed the eMMC chips=
 would
have been fixed meanwhile.

So, the BSP had the new drive_strength setting for all Gen3 boards. See
following commits in periupport:

arm64: dts: r8a7795-es1-salvator-x: Add card driver strength property in SD=
HI2 (5086b3ae0b4667)
arm64: dts: r8a7795-salvator-x: Add card driver strength property in SDHI2 =
(8314f72db0b861)
arm64: dts: r8a7795-salvator-xs: Add card driver strength property in SDHI2=
 (01b074f6f59312)
arm64: dts: r8a7796-salvator-x: Add card driver strength property in SDHI2 =
(e4a3cc1bbe1c7b)

However, there is a comment in periupport for the patches implementing the =
new
drive strength feature:

mmc: sh_mobile_sdhi: Add the driver strength setting (3d277f92925504)

says

"eMMC operation becomes unstable in M3ws1.1+Salvator-xs."

So, maybe revert this change for other Gen3 boards now?

Regards,

   Wolfram


--zaplvtae5vpc5kb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlohN7UACgkQFA3kzBSg
KbasFg//cInyJ90UEeC/1E8GzbVvCPQTIINy7FASo11vdBMa0KZ7cuDffegN8vMk
oKU/yRXsVuxZKIrA9SbJnH29nOX8hQ90iTV3PQ345LxhGfR+Pc48reIq4eO0U7QR
207BoFid0viYtOFX5+ipA3sthn2x6U0LjvQ92tf+rS+HnM+RdV1Q6jUCftbhdE2s
4tQmOigk50SguENCvJt+m6JqkR0QJFVKOBqASneZ9tcunJ5FFB1KJE+Y4hFMfqcq
CHTeo78FOli6f/H+hc25NdDApHuYpOYovlJTiWUF4wB5Nle4ud2smJKA4+MYPMTY
o+3i1C9LiTa+DaWUK2ZxZ3wc4vwiVgOuEeVclQSdYlJDfLlQ9EVzzC7lTJJP8dRP
170AXBV1XPzSqKubO2VlohvfX8WR16QAKDr5pTRvF3BEOa5kC1Vti4Fvv72HvMnf
mX9j/peMbFofcM9VuqYeua7uq0aqKKObvXqmd98+s5CEusOF2mAMajdqG6Anegw6
FKsWKbpJGvhEH71oggjtRYD3eAwp1JIee1IqltIpqRx9jLuOAXcJCOyCNbACk2nG
NrxOSOmAtAUnInShHwSfujaA7wkEgJcphyAuuaURWO+lWQM+PR+GuzYcFROwKA8w
PJ1wVF5t4NI3H2XG3O8qAgjEzHeQizJX409rkgpVXpyHGP3eyHM=
=sR9L
-----END PGP SIGNATURE-----

--zaplvtae5vpc5kb2--
