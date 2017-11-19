From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT] mmc: core: use usleep_range rather than HZ magic in
 mmc_delay()
Date: Sun, 19 Nov 2017 22:22:11 +0100
Message-ID: <20171119212211.kfp2poxos5ilvdpq@tetsubishi>
References: <20171114225520.6793-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFrgO0JRatud5JRDONS=VTNef8WS+qvRAUo1AXep9wMpZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbq2tsubcdgifvha"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrgO0JRatud5JRDONS=VTNef8WS+qvRAUo1AXep9wMpZg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org


--vbq2tsubcdgifvha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This means we get usleep_range(20000, 25000) for the worst case.
>=20
> Perhaps we want "ms <=3D 16" instead, thus getting usleep
> usleep_range(16000, 20000) for the worst case? No?

I read the timers-howto that ms <=3D 20 is for the min value. If you think
25ms is too much for max in that case, maybe we can find a better
formula for max? My honest opinion is, it won't matter much in practice,
though. Especially, since we are not busy-looping anymore...


--vbq2tsubcdgifvha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAloR9fwACgkQFA3kzBSg
Kbb6DBAAjg5Ijw/k74bgKPGsgQPHztN6EU0EdR1JUJJlLlY3fNtoWv8b/rkCoq0c
WXQQUlFhIRf5gnbvZm8/8BoxEtfgvPr7T6ovZmsjjbFQMQURYVdhqH8qA4cTncSl
Dj2j+gjOcEHcfh8S83f/K0DzyYveoVQ94UTynPwnu6E1oNHAk0vHboI8Bij8zUTx
50P4dO/gxVA9SfVmGZPDOEIyOhDNEyfWYg/oWPXPy9cCW79XZPS7qQy/LwIj+PCQ
zxmRc8IPXGnagNNYJpVMqN7mQP6SG7sAdzcmaX0yv6+smt8dEdvbZEwgER39NNpg
B/HIod7BhqVMs+KQPHxfYUTO670WM0zOJKewmNwvodrg4Z9eynNYHF3U1zqGVNeU
tkdlvjwK1RvY3nR/185jFdbJqN2fPHhoHn2ESs5o8qVXdjAjCnzAauo57mcOr2mn
gtbV2pZwhTZFI/xJbP9HAEk1AWVXwFPLN20/34UgHIBPHqlfRbjTG/keNaRCllcM
ydt709J79gC/aGitLL3fc1vxwTjAgXtTmejofdEkfPN83LQWoxEMIgOy9fN66FLM
fwPFCsYv4BhyFYk158iNyM0ah+VDuKZWWVvBnjTvUOJ2N7P3FD9pR9BUQw6X4q1Y
b6Gljg0/OP/vJjSUkywTyI7uMwW6Zsi8XemFzAR77Q+v53jve9I=
=ZSnv
-----END PGP SIGNATURE-----

--vbq2tsubcdgifvha--
