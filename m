From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Wed, 30 Aug 2017 14:36:24 +0200
Message-ID: <20170830123624.vurdnh6bojbtrjal@flea.lan>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
 <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aqzbkk2ndrwasqsp"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39326 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdH3Mg0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 08:36:26 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFonXp4Uqi=DLxKf=1ecOx-2E5mUkEXqnqJPE-J57xXQcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


--aqzbkk2ndrwasqsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, Aug 30, 2017 at 02:29:24PM +0200, Ulf Hansson wrote:
> On 25 August 2017 at 11:49, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The reset hook was left implemented. Provide a dumb implementation so t=
hat
> > client drivers can depend on it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Do you want me to pick this up via my mmc tree? If so, is that okay by
> the clock maintainers?

I also happen to be the maintainer of that part of the kernel
(reporting to Mike and Stephen of course). We don't have anything
touching that file in next, so unless they feel like it should go
through their tree, it would be easier to keep the two changes
together and merge them through your tree.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--aqzbkk2ndrwasqsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZprFIAAoJEBx+YmzsjxAgnbcP/3gwfodfQelm5qubvJ0/q9QH
FZD2FNwD0qMRYiygrxUUwDRVPVM/utt5avZdqnuW+yJuroZT2nKjan58gliiIWjo
pgtPtGKMfsE7RJjAmhkJF2c16wuTLjBdEHo5Ft9jqk/W4hhyQGgKhWGjHpUVLHwU
qttBOdvyCkbyATv8rXTxEB3ZSKdYtcQCf94Hiyw3B19CqVpZixpVKU1+/BpZcvx7
vMf2DF8zz9DNRlVZLNjSJqXn9qPQbY3HwM35Hkefvb9KE5rx1XCPvHtU9zqvMdBY
OApTeHfhRmgzBGkLHnaBEWXrD/UO3BNaDClXkiVU53/gtzjAuPGlHd0vK35ksRef
LDFRkQFZGIz1re0jrT2N2BN7nKv8SuRJJc6yJ9V9ak4HCZAX/lNx0Hy7Q6wOObst
8lvaN9dJx12HCWfe38ju58MZu+qRC8g1olSzZ7jZOGqyx5VTiqLmTqpowJuT6rtD
mCU2udv7E989h/GN3CEwsjFHLSbTG4yUJCqWvH1TKqJA5vqPzHy9hyZQfh8uQjqi
Xm4AV+kyRBPq8qFYnW91fYiwl+1xPfABZrQh/n7DYc66+KPw5P3NQbSCMXV8++MN
tkgdmWjDmcmPQDCsvJ5CIYtsGdGkPcyzJ96CsUnqJskksR+Y2gCjvFUBeoUlngO8
9xVLMk3kQa4B92cOyl/e
=FDbk
-----END PGP SIGNATURE-----

--aqzbkk2ndrwasqsp--
