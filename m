From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: core: Remove timeout when enabling cache
Date: Wed, 7 Nov 2018 09:47:41 +0100
Message-ID: <20181107084741.GA31092@kunai>
References: <20181106133007.12318-1-sjoerd.simons@collabora.co.uk>
 <9051c212-6e2a-bc39-3686-693e6cd87f1d@ti.com>
 <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <303b49cbb5b687d6b6a7ad4048eda459586c0806.camel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Faiz Abbas <faiz_abbas@ti.com>, linux-mmc@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, Hongjie Fang <hongjiefang@asrmicro.com>, Bastian Stender <bst@pengutronix.de>, Kyle Roeschley <kyle.roeschley@ni.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Harish Jenny K N <harish_kandiga@mentor.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> That also happens to be one of the cards we deploy; However i did
> wonder about adding a quirk but decided against it as it was not clear
> to me from the specification that CACHE ON really is meant to complete
> within GENERIC_CMD6_TIMEOUT. That and i fret about ending up in hit-a-
> mole games as the failure is really quite tedious (boot failure).=20

I agree that we should use the more defensive variant as a default. I
mean there should be no performance regression since most cards will
respond just faster, or? The only downside I could see is that we might
miss a real timeout with no bounds set and might get stuck? Maybe it is
worth contacting eMMC spec people to at least know what is the expected
behaviour?


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvipqgACgkQFA3kzBSg
KbYHLw/7Bv4FJNQWjg+ox2ikLhOwBTCA17ia1KziTy3hpkArpy0hZR4yn+0qBDrl
kXcsMqMzEQHp4IFZrvFQuNOGR/ItKOW7whg4d3B0VJB2wDtu02Dna05PEe4txu4G
qjId6n9UHvuR2xBW5wo23MWqXiTMdTcQb5hn0Df1vh8AsajoRTXfLvz0i9RYAJiG
omER+4GgvToO/PZWdoqskorPIJPRVsz90QIVaeFPoXkDHr2XM+XYsK3Iaos3RJRO
7W95u8+R4CWAvYbxVvNFgj8oD/y91ntVbkcJz+km6BgR/Y0ck3YeqE0SKbRtFrkk
YgaqISJDE2MpLR9WKOCGOqTN7bDdiaDgIGUZAErngyBI4WmjUPscZf71UY++SxnV
5r2u0wyZ5MnXaiQez8+u6G6Z4VrnyhTwHtZDOBeFeQHlcEGKSVEjZ4I4JloNWM0d
eylx8dAUqvNQQVadwXvlqGxzXN2/2V+dGKc5l1t+h/8vUYMqSHP46qPsCKVgQmcn
2DRahrpE80xT+//2+XNq3ffGBdzCg/q3WwSqa3bkp861O1Jemp42GQwLHjF9Q/E4
mk40YBIe4+w6CfVgJ6vXpq/3vcpZ/AivlHuCleXvz02pHC0/irVbeXlmJ5IkPevC
4cUTJlAc+N3wDvWnEgxmH6e/yyTN1MiZqx+s6NcSxPXkIRdifaI=
=2ZIL
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
