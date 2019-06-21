From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: remove another TMIO MMC variant usdhi6rol0.c
Date: Fri, 21 Jun 2019 12:50:25 +0200
Message-ID: <20190621105025.GA2987@kunai>
References: <20190621060511.29609-1-yamada.masahiro@socionext.com>
 <CAK7LNASGVbkGgu7psy4DfCxmr-AxSQ3fmGJ=aDAiuSkJ5hrDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNASGVbkGgu7psy4DfCxmr-AxSQ3fmGJ=aDAiuSkJ5hrDwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rabin Vincent <rabin.vincent@axis.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2019 at 03:16:11PM +0900, Masahiro Yamada wrote:
> (Added Lars Persson, Guennadi Liakhovetski)
>=20
> On Fri, Jun 21, 2019 at 3:06 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>=20
> This needs Ack from Renesas.
> But, I do not know if TMIO folks are sure about this driver, though.
> (If they had been sure about it, they should not have duplicated the driv=
er
> in the first place.)

=2E.. and from the original mail:

> Delete this driver now. Please re-implement it based on tmio_mmc_core.c
> if needed.

I was never happy with this driver existing, yet I never knew which HW
platform needed this, so I didn't touch it. But I'd like to see it go in
favor of merging with the TMIO code base.

>=20
> Perhaps, some code snippets in this driver might be useful for cleaning
> tmio_mmc. It will stay in git history forever, and you can dig for it
> whenever you need it.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I double checked there is no user in the current tree. I also searched
the web and did not find any out-of-tree user or even a reference of it.

So, for now:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

But this seriously needs an Ack from Shimoda-san or Morimoto-san. And
maybe Guennadi has remarks, too?

Thanks,

   Wolfram


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Mtm0ACgkQFA3kzBSg
KbbYNw//U2nOKt1qTxm7Lxvm3Ii9b1Qhqs/pvoKWphHfPaQw+dgf5vXSZlMkE6QR
hG3it64ADcyRC+zdjUf+XUgF9GLHHTSZgGtECW4CYQSGjCEQ2Qfc+8WXr5AHCY8h
NIK7wRhy6MVn0pkLUL0iFQqAYR1a8aFIPim3omAyEjDN2fj0abHuImzoTHtxTgQ3
kklk1LlsCDS0yDOjkljhxHySzIOY2YkzRCTaOvYYVuyn30G0/uUXL9uuafF1jYPY
lCPj+88A6px1qXROIJmYTzYpFxdHDmTWBfMtenRHGTM79vXf3nswy8Mxt5PDom04
C872tCkhTo859e9IwcI24SYr576YZsSU0sw3GY23AJotsg58ifXVrzDjzEZewfNU
s9MPvBXPhmjlMCEbwOkfEOGtwsDgcXOJdxjKPVF+bMYDbE4XGLxV375axcmf13Vw
cj0OYvNBpHf9fcejEbYRnYHzAfc1Y4QMLF5NHccF2V1AAAVpl5hADEs+ypcjPBfe
HChlxkw0rwz8e+ZdEr4FjcpXoIaVHIXYPAcyMn2u/XiADa8XUHmRJxvf0Rz6A30r
h4ox4TRJrKQy69gPJMxNx4FGyZJjlPlMfa6khtYAhPoiEzruUttVdryTMIRwOD8l
j/MmsFwAsK06IpUOqosDwNXoUpU/DHXtmk/i/xOo4+9euVaLMrk=
=gcmd
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
