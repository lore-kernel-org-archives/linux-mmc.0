From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: don't enable UHS modes on Tegra210
Date: Mon, 4 Jan 2016 08:51:58 +0100
Message-ID: <20160104075158.GA23057@ulmo>
References: <1451490549-21430-1-git-send-email-dev@lynxeye.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451490549-21430-1-git-send-email-dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2015 at 04:49:09PM +0100, Lucas Stach wrote:
> Tegra210 needs a different tuning sequence than Tegra30+. Disable
> UHS modes until support for this is properly added.
>=20
> Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
> ---
> Ulf,
> this is a follow on patch to my Tegra UHS-I series. After reading the
> Tegra210 TRM I realized that the currently implemented tuning sequence wi=
ll
> only work on Tegra30..Tegra124.  If you don't keep your tree stable you
> might want to squash this into [PATCH v2 4/5] mmc: tegra: enable UHS-I mo=
des,
> otherwise please pick this up as a fix on top.
> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWiiSaAAoJEN0jrNd/PrOh0vgP/RcSRPg1eOMqpQsIzwykiOWV
Jw3TfJHAOWPO2JPSP+Zj3Pv5CHoqeWa3SVSYp4xHaTdcDp1fTrJtDPA1VdQgwfE7
7Jv83JB9w7VR3ouhQU1VTq74aUn//EfpcTwos1DKmqG2ms7lKKRYZAvlMeq7tmgN
25sj/+q3b3XDHpMuXZ61nBItmWbtKfuikk6dD2v0kR/9ddtqeBdCaUgX0jBvyYRe
dciq6uDQdZcLSjeyAb20e7DQdWIgI62Eb6YAUW0h/Y05UnckG2TNJDCIYnNd9q/v
q0FkixRdIOmqVRGdFAnihHjxKgfPNBy6UYlbRM/O5M5wTVc8aIgRPFXmegM4OjNg
uwoxSyTF7YjIgFsnj3R/zrCUsz8AOoyWbGWLuNA7eNZo0Zo0Z6onrt7hkIeRdRS+
e8lUcNsB5Rr1WzpQo8zsEHRlUGcrWxrz2qpsiJpnl9wVM4HUlQaba2yuLqTfgbTP
J8+D9sU9cfER5d2vEwfAb/qjPXRsZirLoDRvHB0DjU5j+WGx635QFeODRXvpKki6
oZfsVzoV2nBRKi45/Q/In8SSRgduijUsSiqfuO7QrHqA8MBWdRELYL29GQjQ9e+R
xAWZqJdmyaE3nyZ6Q7XoWEWf68ih+Q4oz/U5s1HK0I9ocmQo01mTd1je8R9Q7C5T
E/BtkQx5XfsJ0Ubs9fDS
=I7Gw
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
