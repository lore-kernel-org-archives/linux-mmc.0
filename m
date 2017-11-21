From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Tue, 21 Nov 2017 21:01:11 +0100
Message-ID: <20171121200111.vrpmsubme55356qv@ninjato>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato>
 <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi>
 <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkevyjmnpgnzpki5"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55000 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdKUUBO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Nov 2017 15:01:14 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--xkevyjmnpgnzpki5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

thanks for the feedback!

> So what do you think of this?:
>=20
> 1) Rename tmio_core.c to tmio.c, and fold in some more information
> about the history of the IP in the header of the file. Yeah, "tmio"
> may not be the absolutely correct name, but on the other hand it
> preserves consistency and I there are no need to rename any functions.
> 2) Rename tmio_mmc.h to tmio.h - and move potential tmio_mmc specific
> bits to tmio_mmc.c.
> 3) Rename renesas_sdhi_core.c to tmio_renesas_sdhi.c. Again, I don't
> think we need any functions to be renamed because of this change.
> 4) Rename renesas_sdhi.h to tmio_renesas_sdhi.h.

I can agree to that. Clarifying 3), I think though, we should have:
	tmio_sdhi.c

and on top of that:

	tmio_sdhi_internal_dmac.c
	tmio_sdhi_sys_dmac.c

?

> Following the naming strategy from the above, I the new file name for
> new tmio variant should be tmio_uniphier.c.

Yes.

Kind regards,

   Wolfram


--xkevyjmnpgnzpki5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloUhgcACgkQFA3kzBSg
KbYseA/9HRvkiqkOUzJqqNwQywYiwGSy54h+WGHcbtKYFmS+/xpJSPYRhFxLcFW3
UP9NIInk5fQe61O3+TIzCEv62D2+IOofapNRoFxXoskpWFYVqAxXjnXVJlWt5fkn
I+Z1WfVYm8ED9UMCnjpHCOf1i7EW3PGjzEpy7zXkXFkCxyZEJ/50IV8Z51azsf/1
1EOdGNaw4NLsTuo6wDm7wUFcCd3qS8nnfg5TYEuHSj7bDON96SuMZAxExA6BM7Ll
ZQ2GWBW1dWh0TxSVhWG8r0AVdqUTB6HtwUqXmidezKb1e+czYL8lHGSpXtTfZ2xt
6lLiI0xCSH5l5qyKdBgvT6odVg3h9ZVCiI3NEacTNSZqrr5td8SgXHr+d+PWU19o
Yyz/PV6kasYTCtFz9PioDndqqqTNbj36qrc5Gi8OqNK26o5oJqEQXfOX15orYbJQ
e3fr179PUHSyvx3U5XrUU+tBC16EkJBAtuct4h6fhchoHRFT7l12rEA8Y5XiAobE
Gag2jtWOlkQNC6LhKTUoricRyQqPYIZVQ1dnNYL3HvK6qnZk+PrcFHxLQtqJ3kVY
3Ofx3+AD011OKn7PhsNrnmBmcnB/FjXJ6jDsJ9+4m9wEo8prDxlDndebStnnFz+c
aMPdzGLMjM34LqjcHzQFKBC2MNJ83FQz4HrW4lbCdAaU5aAIniI=
=u2mn
-----END PGP SIGNATURE-----

--xkevyjmnpgnzpki5--
