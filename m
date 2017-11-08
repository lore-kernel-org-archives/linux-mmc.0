From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Wed, 8 Nov 2017 18:53:20 +0100
Message-ID: <20171108175320.wnq3d2x7lmpaya7s@ninjato>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dpieyx7twuryuz7d"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33526 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbdKHRxV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 8 Nov 2017 12:53:21 -0500
Content-Disposition: inline
In-Reply-To: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--dpieyx7twuryuz7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yamada-san,

Thank you for the detailed write up. I hope we find a good solution,
too.

I've got a few questions first:

> I know this is a big churn, but I'd like
> to propose renaming like follows in a long run:
>=20
> tmio_mmc_core.c      ->  mnsd.c              Core code of this IP
> tmio_mmc.c           ->  mnsd-tmio.c         For MMC integrated in TMIO M=
FD
> renesas_sdhi_core.c  ->  mnsd-renesas-core.c For Renesas SoCs
> (or, mnsd-sdhi-core.c or whatever. please choose any favorite name)
>                          mnsd-uniphier.c     For Socionext UniPhier SoCS

Do you want to just change the filenames or the function names as well?

> I see more strangeness.  Those mmc drivers must include <linux/mfd/tmio.h=
>,
> but TMIO is unrelated to Renesas, Socionext.
> We need to fix the interface.

What kind of fix do you have in mind? Changing filenames or change
everything which has TMIO or tmio in the name?

> If I can get consensus, I am very happy to
> contribute for better organizing this IP variants.
>=20
> CCing Marek Vasut, a contractor working for Renesas.
> He and I are also working on SD card driver in U-Boot.
> I want to introduce correct and systematic naming scheme
> for a long-run maintainability and applicable to other projects
> since Linux has a big influence in OSS.

Can you explain a bit more why the long-run maintainability gets improved?
I don't really see that yet and will try to explain below.

Disclaimer: I am contracted by Renesas but the views I am going to share
come from my personal point of view as the maintainer of this driver.

Preface: For me, names are just names. We have a few examples where the
"historical" names are kept because they just happened to be first. The
AT24 driver supports way more than only Atmel chips, and all the STMPE
have kept their names, although the SoC is called MXS these days. Which
also proves that names are just names, IP cores and companies are easily
renamed.

If we can rename things easily to match reality, I am not against it. In
this case, I wonder, though, if the rename is really easy? If you just
change the filenames, then we got a strange mix, because the function
names are still using tmio_*. If you change those function names, too,
then the resulting change is very intrusive. It could introduce errors,
looking up git history becomes a tad more tedious, and users may get
confused what is what. Seeing all this, I don't think such a change
would be helpful for the long-run maintainability.

I'd be much happier with a paragraph at the beginning of the "TMIO" core
file (or maybe all "TMIO" files, I don't care much) explaining the
situation like you did with your mail. But keeping the code largely
as-is.

I am open for discussion, though.

Again, this is my personal view. We will discuss things internally, too,
to see if there is also an "official" statement from Renesas.

Thanks,

   Wolfram


--dpieyx7twuryuz7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloDRIwACgkQFA3kzBSg
KbZ9HQ/+JDyzNSnxjYpH8LMbSUQEzYktcOUNNwHH6MPYupaLWj0a1QXZK/z3biAy
Cveuj3yXPVsEePGmjf8ip/0JfDDGYd9bXheDRyPptVjlBcPLtjLeMc6R0XnuId/O
oN/OIa0+uqhNWP62WrzrN/O7Y4+5OGuK0+KeUNwor2YogXGPqDPbG48H+efNH2QD
kf+lIYkPnfUqEqURC4+5y1BEWlPgQJigsoPPQRDq8JPuwhsoQzFFANfqtwMjtN+3
Yam+GKMVLCKpjDTciySylWBlf97Plzfvk6OlEAvc9QQJ3qAbSWdzzFoqxIx4P85s
Pm1FIexJ43yV6xBeOGRY/JgkCdQmRXHRvWevdHFDzcmhwC7gbK2juEvI55+tWPC9
wHpwry/zZ7dGiTPulW81hYy3ZS+T4xJJIdgfvcVU5Om0ERyZsblG1KSAiyumJZoJ
TalSJ/Vr+GPgDVtqpTCzSdy1oj/crW4emp4GbsR39glIhMmeMQtaqDLS9nIDVU8f
nWoXxgJ33ADKs7lpPuSNYg+0uMyriKZGlbgTf0BcyYwmxE10Wq0zUeyJbGhR1l6a
1aGn8iL0FkKMQFAOBw1NxbHR2gHOgFFUeMv2TD8FZHBOrfeg3N2lWo952ti+Bk21
U46Finvwi79c4E0gCjrs0UoFuVgYkv+CyCzT75yqbOsA3kYesUk=
=diQx
-----END PGP SIGNATURE-----

--dpieyx7twuryuz7d--
