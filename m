From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH v2 0/2] mmc: core: process ECC errors raised in stop
 cmds
Date: Mon, 12 Jun 2017 13:29:02 +0200
Message-ID: <20170612112902.GA1504@katana>
References: <20170408202006.27276-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqSr+3B5wq7+3+fDhB5etwEGhBadA0X7L9Tu6FUmKJgcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57002 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbdFLL3F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Jun 2017 07:29:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqSr+3B5wq7+3+fDhB5etwEGhBadA0X7L9Tu6FUmKJgcQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 10:30:27AM +0200, Ulf Hansson wrote:
> On 8 April 2017 at 22:20, Wolfram Sang <wsa+renesas@sang-engineering.com>=
 wrote:
> > Here is the second RFC for handling ECC errors flagged in the stop comm=
and
> > after a multiblock transfer. It is still RFC because I could only test =
it by
> > inducing ECC errors in software (see patch for TMIO below). Shimoda-san=
, can
> > you try this series with the SD tester again? That would be very kind.
> >
> > Other than that, I hope the patch descriptions and comments explain the=
 single
> > steps. Looking forward for thoughts.
>=20
> Apologize for the delay!
>=20
> I looked into these and the changes seems reasonable. I have applied
> them for next to allow them to get some test coverage.

Awesome, thanks Ulf!


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlk+evoACgkQFA3kzBSg
KbYswA/7Byf+SoINZTmCufD91Fy4sCMqciDyLEaZzoKk6LPynP26CG6rCItioCNW
Zfd7nrEF9EPuDsm8FQ+kXK44hMh2weBVhCV2Ue7sDUNXq2M5EaQrqgrM7RiZH4tL
cxQHWuN4sals+gLkwOtvxgfgqxdhAPkOuoQZr/sOYCOrT1P5ybdRT3TBIGLhO9Q7
IZwWV/lNrghBSgyW9uk0LfsEgsnLZCsBS8+3r5j86a1ZhkuY3piElo9Yn+PzgtgW
RsarcLz3N7fewxnpGg6i84h0FygVU/0uLd3s/vmfmifnroNdJDnV1vA579oq+Dib
2C9A8UvKy9+w4dz/NuchB52ugvCgAt7QkuzMJ0PGdm1Mpr3t9ITXL+b0ts3mAH3C
8FojcV+SJhPlJoUdzUZYyqL7IsoSrKkCH+xQlEH4BYBXkLmttGo/u5G9OUsv7XOH
V/rAuFrSIY0pDRtKZCy7cYMDIRE1RgdEcRKEzxHOCTFeTFLltdRo0Fv7Ex9TycrS
Rhh4F2ZkL0/7aLurFQ4za7s9xhqldCKpmpqFZfAqt7UTOXTa3lZxgqFIw/Kwc4aZ
0XlV1Lcf4DGtnRNi97TMpL4w4pvF5mQ5HSpPtAcIiRWuV6OZLzF7EAmWnIfbW9zo
2qV766I1kWzCKKxybFPtaXvsKW9m4TzxtGsaBMzAeO7VwdXhH14=
=FO3J
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
