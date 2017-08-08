From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Tue, 8 Aug 2017 13:47:57 +0200
Message-ID: <20170808114757.GB1674@katana>
References: <1502152045-150457-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqqjyOmAQkaa6DjJKs+BF-sOdN_jAtAR4CZg+vYVCLt0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:33912 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdHHLr7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Aug 2017 07:47:59 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqqjyOmAQkaa6DjJKs+BF-sOdN_jAtAR4CZg+vYVCLt0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 12:37:31PM +0200, Ulf Hansson wrote:
> On 8 August 2017 at 02:27, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
> > mode as it is expected behaviour and most of the backup partition
> > tables should be located near some of the last blocks which will
> > always make open-ending read exceed the capacity of cards.
> >
> > Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop=
 cmd into account")
> > Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop comman=
ds")
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Tested-by: Shawn Guo <shawnguo@kernel.org>
> > Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Thanks, applied for fixes!

Ulf, I would like some more discussion about this patch but need time to
think about it some more. I'll try to have my answer ready by this
evening, but I'd appreciate to have at least one day to respond to a
patch. Otherwise it is difficult for me to focus on the other work I
have. Could that meet your workflow?


--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmJpM8ACgkQFA3kzBSg
KbYiRA//enZInuEhSIAvwYiNaH6/7ueqbYm5KlS7BmWRBsvJUhdGuwk2VQf3Uglr
vOJYa7la/QMRKMw/k1pD2qlCatSQpGlApRNZIiBOk1SxOBF1EjOTIIYBlbkp9W3u
4QB6Gp5yogM4ljPMq8nUGTwVnAx50j6DEMrIT4Q7aOTI6oO1k2ke10sgwhC0BVhk
ufNfu1F580vJ5BmEBFatgPNXXLLMN3b2H+ZpA8z2EqmMDB3+iG75s5q7HP7RZQ1X
XYpwVat/0rSEMfqBUVKWCBrc4+G5WkWrmi1kP2FufKDfPqumEzqA7QYNoSPuXDqe
HEXiiQhAENUBNjYTbpu/WDovOkC8/GZ45Rbf4TpDTYx1VfG0DWIsV2I83lOoxE02
DWxS4LMtYimjFR2rUTVwx3xegqCpRjFLttHiS48miqetteyKY5Ue6wsO6pDyFIpz
8QsPW831HqBD71a52fBlgNYb8dMqizpIuAhB1bAK8jZwfhWJ9ZWJRUaN0bNa3ZA0
pd/XRLnATsHnXa3NJdDWLCMql2jM5VhBVWislS8cdUXf5ueUJOMq/bz2TS8jdQ+j
r9lx2tE7cjOzDsFPeev+T6g0MAIuyIsDQimc7VcFZugSUi0gNP/FMrRZS9IxRRJB
Ah9FSanNmSfr6sgJXJFE3zX87KUNinTNsrgcvcK9VxEuInv2U3A=
=TmRd
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
