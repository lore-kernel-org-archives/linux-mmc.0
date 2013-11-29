From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: add support for Tegra124
Date: Fri, 29 Nov 2013 16:55:17 +0100
Message-ID: <20131129155516.GP9712@ulmo.nvidia.com>
References: <1385417993-7848-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385417993-7848-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 03:19:53PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Tegra124's MMC controller is very similar to earlier SoC generations,
> and can be supported by the same driver.
>=20
> However, there are some non-backwards-compatible HW differences, and
> hence a new DT compatible value must be used to describe the HW. This
> patch updates the driver to support that new compatible value.
>=20
> That said, the HW differences are only relevant when enabling certain
> high-performance transfer modes. Since the driver is currently very
> simple and doesn't enable those modes, we don't actually need to address
> any of these HW differences in the code yet, hence the simple nature of
> this patch.
>=20
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmLjkAAoJEN0jrNd/PrOhcUMQALqD797ScvWFjBQalIr8zacR
FIDVM/QVAEckSoEIFp9ZUGSMQTONsAuxTxA5adyKcSqXJPoUAWgPQO9EjQwSk9yV
1qXqhVciwYoaVeqimOM5gNDJIz/uHS83s0VZz8zM1NFOrUOrihYhh9ChnzRttwmZ
p/P7hOGw5FWfUlMydqG5FW7yz7rAUoRZ1l5USRnj1Au9rNa/xQBgvtJzjKohdv+o
MxIdSODny+t+PVix1Dz8yxDVGQo+P5MIamtZXbTV0kg8c79CBJge5fIU+uk1RLRa
B6DJVpW9tBisTA93mFsfS60nz+I+YMzZEtm0G5XskKowDPqkFRPDoM8xQeiqG8kz
iwnyEw0d4n0cE0AciT2BkHHsuaZaIvDKgkS/G++uXbkeG+pWdwTZeEbdriNUnWhG
zKvvM5IZGQwlnWLySeE/lfqhnY/KGUzsopoF2ovlkj8TMGjXaEGaxSpxQq3vT0Xy
9Fd4NfQ1qZVvHQA0FShhAweMUxGFz4IvZzok9B0MTdmi4XYg5JQrHzr+dQP62Eg1
ieIKHpC/tLycEVLk5zNujDoHFWwwmUCMvvO4RZItAfz9LSmRdNFhad+m0i8s4w/3
oAeKJX6KyJR5DHgBm6zE8Hn/IsZpebIJWA+a7z0br7buCxpRQFMZW4jLHTiNcPkT
ghBIk+keBXqjykYPaYTl
=JG0e
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--
