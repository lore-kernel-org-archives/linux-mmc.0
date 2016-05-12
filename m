From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 12 May 2016 14:41:39 +0200
Message-ID: <20160512124139.GC1638@katana>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <CAMuHMdWKu7wLDthh2QXKJBS_a7yz38HFbi4wSLMnWV0Y5qbbbQ@mail.gmail.com>
 <SG2PR06MB0919A06B80C8231816200645D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <CAMuHMdVmA7t3k+56yP9n++WGRqLy1pkbtmpe+SmJRaDJmU04zA@mail.gmail.com>
 <SG2PR06MB0919E39A668AD2ECA9DEE018D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <CAMuHMdWaZ-sbx3JXc2h59R6OzkiKnmbmPDaSKZ+4aRie0YMYuA@mail.gmail.com>
 <SG2PR06MB0919824AFCAE20C395E50738D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <CAMuHMdW_VkpjoLyXOvbdwwm=h5L8A8JrGKf_P6ig_pBqM-tGtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_VkpjoLyXOvbdwwm=h5L8A8JrGKf_P6ig_pBqM-tGtw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As the sdhi0 MSTP clock is still enabled, there must be an unknown clock that's
> needed for proper operation, but that's currently not controlled by software.

I'd guess the SCC needs a seperate clock?


--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNHoDAAoJEBQN5MwUoCm2YsgQAIZ/kxd8nXjzb7R0ZoBfvdsu
V7fWtO8fBTSnl7JQoILzlCeuydAwar4OuwezbEgjEoDKea99olhbONI0wAzYocu7
ViwnfpYrxv34EFUuN2QGC7orAFMm+zQlqSHmpWqz1qVmtPxw+YA7PkyQeUyJ2tNz
hL2e9ns9qwC0wgAI4Q8vBzvMuDSMCC14cQ5ZG/nTItCHSGhTJ4rGGjKUwBuYjWZk
pkxg0u4GJDx24DDsz0eKt3hvmksf/7dMMNeHljFkbXdJ47VUAHGx3DjuIjZyZx9h
sA5KrtdnyhRWs8/74ijHupjtzBbVzDhS3UrDYcmn2DwJdHOYBx+E3UvJieGJ+ayV
eScEwEwMKsoqCPZq9JqB2YGAyKcHj0kJ/+jBCfvQELn4SOmtEP70i2QV3SnTVUHz
Wni4tcM+EsFaVyHIcq9MqA5vPk7S+nOaHQ+svnrZyCLPN/h0bG26NgNuVSqZhLT/
9rl33kfMsyPG2NIsct8i46oyazYqSK0gZTYErGihXCjLaxGRLYq0SunkrOayHV2l
hnBvxiU57IbpaGDt5GlnPgDAKZkOKjppU1oNCm14BT6MYJstCk3I+eneAXcsGdI8
t2BCu+HouPZ680GDgzLlIszkkaCq2AOd1pzhBz2sBSWZHit7gr+p6YsIzRA1mG8K
eQZCJx/7VcLqUCeHIlH8
=Z+c+
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
