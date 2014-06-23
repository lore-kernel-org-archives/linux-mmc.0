From: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v3 09/10] ARM: update multi_v7_defconfig for STI
Date: Mon, 23 Jun 2014 12:53:16 +0200
Message-ID: <53A8071C.8090309@st.com>
References: <1401899424-1365-1-git-send-email-peter.griffin@linaro.org> <1401899424-1365-10-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HOR5cGsoHwLw1fvDJL46tjJwuNhfCgpws"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401899424-1365-10-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--HOR5cGsoHwLw1fvDJL46tjJwuNhfCgpws
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/04/2014 06:30 PM, Peter Griffin wrote:
> This patch enables SDHCI STI platform driver.
>=20
> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> ---=20
> arch/arm/configs/multi_v7_defconfig | 1 + 1 file changed, 1
> insertion(+)

Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>

>=20
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig index d4e8a47..48951fc
> 100644 --- a/arch/arm/configs/multi_v7_defconfig +++
> b/arch/arm/configs/multi_v7_defconfig @@ -277,6 +277,7 @@
> CONFIG_MMC_SDHCI_TEGRA=3Dy CONFIG_MMC_SDHCI_DOVE=3Dy=20
> CONFIG_MMC_SDHCI_SPEAR=3Dy CONFIG_MMC_SDHCI_BCM_KONA=3Dy=20
> +CONFIG_MMC_SDHCI_ST=3Dy CONFIG_MMC_OMAP=3Dy CONFIG_MMC_OMAP_HS=3Dy=20
> CONFIG_MMC_MVSDIO=3Dy
>=20


--HOR5cGsoHwLw1fvDJL46tjJwuNhfCgpws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJTqAccAAoJEMo4jShGhw+JhAsQAJabGblynDfRLIeG3CEVIRaA
b3osDGHMYdd9sdrVTv6StOnXcqqBUu0Wv3JQqVuEpDWUOmE8bHKFaD+aw+TzNXwo
WqgIf03PuPOLmRq40EOm8QR/mREJBIMG8DK9lGu8u3yc1A9VJ/mTMEhAocKLRKdf
0LzKa7HzkTaweciI7iX+x88OJcVuXM+XfHZXo4iN1st0+gF0C0Kuxw2CNG9xl4yn
87urXkstu5LydtwcsMZaNlgVqBStOc3SmGW8yGZwh/awCv5Noz6uM0iBalTJ4by0
Bkg0GyarO8rtLsY+o9n+J0tHukfOV/OPSy2TKz8Gu9r6KeTyaiXOG41WaoJj+p55
Sph061gPCMFaKUUS4nwzTEnr0ctBgmeCt2WTF8F7InlqpvYB3FIg0tkl1yCvzBZs
+bJjPdxYSGN05yl6l2qVO1tbXL/tm27THfgx2gF1PkR973TUzzE2nDrbFY0oiejK
uNVngzOZF4B3aq2fd88hzVDccj2FRuKnZrvVQV6bxbvAovEjc5Qy0zewWr1HPU2r
2FBrI4m/hZtDFBqmCv4NPYO7R4HvEh1WYED6TwXKIDTP/P7MjLF7B24hus3yDnBb
jwvtcLnZIJbzalPKPHozXvUQgYdHRlaagcK9WmID9ccVMkq7oNCyQybSrALMpsQE
xJYigi0kj1loffStSPKG
=zZ5P
-----END PGP SIGNATURE-----

--HOR5cGsoHwLw1fvDJL46tjJwuNhfCgpws--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
