From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: sh_mmcif: Use platform_get_irq_optional() for
 optional interrupt
Date: Wed, 2 Oct 2019 10:58:05 +0200
Message-ID: <20191002085805.GA10270@ninjato>
References: <20191001180834.1158-1-geert+renesas@glider.be>
 <20191002081553.GB1388@ninjato>
 <TYAPR01MB454472C76E03930717A2898BD89C0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdWBghL8Em0OoCKjJdU7OiY_pV3Lmc=SXhV2yY=sKJJ-aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBghL8Em0OoCKjJdU7OiY_pV3Lmc=SXhV2yY=sKJJ-aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Please cherry-pick the top commit from renesas-devel:
> 6e47c841329eb9b0 ("ARM: fix __get_user_check() in case uaccess_* calls
> are not inlined")

Thanks a lot, Geert. I can confirm this patch fixes the issue I was
seeing:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Could you kindly forward this tag to Yamada-san or bounce me the patch
so I can do it?

Thanks again,

   Wolfram


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2UZpkACgkQFA3kzBSg
Kbbzrw/9Fy0DuET9/QhPpkciG0if9TcmOmULaCWrBLLTLmKs4VG8YrtkFAhLNXg9
aobUjyTteybY6rXp3b/jlPmr6qgtQNlyYNmHx5h1Z967jnn6hpOMXlrpzMcaFfTS
TvoaK7a0bFUc90O4PgSL75Lgn3zU5gGZl8ZJAf5h7Oc7cnfyKDr1UVtAvJrNki5Q
zTjE7+FakyExml+DaPEQGYx5iLYYakIBsWOyVAGmIMHmKpp4nzYTutF+aFR0ezzW
eKvscgdTBxPWVInFRV/vH4vy0KgMEHr0SG8K2HCAwoXvMni8mYP1gATzBjkJQODc
szwuNgLfQ6rlrjFh2SDsqUozpk+Bgrz0u77K7ocZtLmBtGTvQ6/7wcKiecxNLSrp
rAUBfF0VdJvK23BsuwYt3AAnjCYCu16bl/Fg/Sijh0va2MufQEQqISzIu1CNeEmy
ETOrJV3VDl9u1GgUt4xBzrO1Nc1JrSxx68apKuQ2KmUpSAJ/Oi5FSftCb+Fra9lY
43uFrAQ6njrGrVb0PbSg7d0PBIngV6KNyDZfwhy3qL8eid/bqn8R8/Pvbpk/5Evg
oyJjx3fhe5iwdr4cEMaLn3shcbYNO/AaRllhijlaWST6RR3YA3yf5RnHjTs59RHo
882RvFdxDr7gfBhbhZpDkm1imPA0VdFzxHGnhESstCwtlYNvcX8=
=Csu1
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
