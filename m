From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64 bit dma broken on Tegra186
Date: Fri, 8 Sep 2017 23:59:22 +0200
Message-ID: <20170908215636.GA4996@aiwendil>
References: <1504900113-8983-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1504900113-8983-1-git-send-email-vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2017 at 12:48:33PM -0700, Krishna Reddy wrote:
> SDHCI controllers on Tegra186 support 40 bit addressing.
> IOVA addresses are 48-bit wide on Tegra186.
> SDHCI host common code sets dma mask as either 32-bit or 64-bit.
> To avoid access issues when SMMU is enabled, disable 64-bit dma.
>=20
> Signed-off-by: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

This matches a local commit:

Tested-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmzEroACgkQ3SOs138+
s6Fq6BAAnz1Z8lTAr5WO186Zc67R4hxduaU+5twItLGrzfUg9EXqE0uC8Zqg6fLn
BRRKPZ4kl0HqXRn0cOz7XB5bioSO4L4WbUB7so+JrcEMw+FKsGsjiDQ8MaP4N6L1
Uub54jcqeHAcKpTJnW9k4AzdMrOInvDR5dTeGRop2rgA1jTvcrxZ78H8WnNJQPmB
NVvah1pS0OgkIAz9582+rW7LVa7B62QgEZvjJ26DXji1I2lSTwUe7mlB+H1dn/FF
+cwCXDV38OR7qMk3tMMuBclebyHl4iQHbmeFvD6iglXu0WmjMXzoKEjLa1RF+Y75
j2AnHOn7lZrBL0SDiod6wmKaZq5fL4P284OZYHc0rf+UWnqtyXiP9SRR6Lc9z5o6
Vz8aMyLfZCq43TsnXtOvYs6J7PGXLaIPuXF+0jBoevv8nZ74MLQ25P9o5TsHwCYJ
8WfWDfO+mXanLZv3AEOjlNSc4cikqEXaZQHM3Hp2XJA3k358i5hzV8iEmZwd4bWt
e9G554l+zwE1lleyEHafV4b/dxhAVpxuGUWIANkpwlvsSaHwZLfvilJBLhz/WViL
jxDpFhK+qYsBpCrGPaKjpdce3l7Yrye80LBdsM5jO+UQOOwWolQFU6v3B7wN3DsR
RrspNVdh7pinD3tav7a3noTUtBbMbvn9vwb9yFfsowSUGkLIlz0=
=vZnT
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
