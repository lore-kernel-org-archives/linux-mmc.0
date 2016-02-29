From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Mon, 29 Feb 2016 07:43:38 +0100
Message-ID: <20160229064338.GC23745@ulmo>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
 <1456479257-12147-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456479257-12147-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 09:34:17AM +0000, Jon Hunter wrote:
> SD card support for Tegra114 started failing after commit a8e326a911d3
> ("mmc: tegra: implement module external clock change") was merged. This
> commit was part of a series to enable UHS-I modes for Tegra. To
> workaround this problem for now, disable UHS-I modes for Tegra114 by
> separating the soc data structures for Tegra114 and Tegra124 so that
> UHS-I is still enabled for Tegra124 but not Tegra114.
>=20
> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")
>=20
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW0+iaAAoJEN0jrNd/PrOh8wEP/0UGFZpcHnHh9ZIx8hgA4EBX
smIwNkQb9Z89qo8BzBUQuh3jBgmwgvIzFPfL13gfc8929dQlaqsoS2dh1lXRR0xc
T8e4edeiPeCF80C16lHvdTeizjAOJCg8XTjL6bH7/Rwa+Obb/V5fT8dJoZCYd45E
DiW+IUle0dscXzZwMvGNs6VUC+s5vf8nNO7WcXwwyNZJbVI6B28IBwjt/ZdfDZap
jEManeYRseuCJIaDvKh2RMC+qgo91xRXf17/+ReTCr6Mz+yAFt+hx05DI5HpAxGt
6+95WNYIuVbWYCwN8nsi+V6YwNa8LMmuP6BPStp1FeLmSswLQYxOs83r2bXCdHbs
ibHoBWEy58T01D+l7rRte667/qpXLhuqF2u+ZLRLCAODjMyb/dSjjxdgGC376u6c
So4hgYCw/9L1VtD32L7wbNrA7N9HZMa7o5STCzPmSwBf+4k+AYiori+FgMx9AdlZ
5lb4lTsRnu2V5TbuplZHbSkykn8DvnAS6G6UXtr8bE+UyFb8Go5tIyhoJDcJlmOK
jRwH7bPOcBLpYQgJgXPl4Jb5oO06bS2+h7+AsKDemUfWiJe/VMd8GXFj8b+/768j
PBW2BuUXJImgnmndi0FsiXjgho4iEHgw4Nb9SJYRB1jbo5XfD8BladZyZu2GooK3
K9Mu139FBUZuM0yQu5Le
=dSLp
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
