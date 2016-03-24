From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
Date: Thu, 24 Mar 2016 09:53:32 +0000
Message-ID: <20160324095332.GS2566@sirena.org.uk>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y9+TIksX9Q+3VPs6"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33468 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbcCXJxt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 05:53:49 -0400
Content-Disposition: inline
In-Reply-To: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>


--Y9+TIksX9Q+3VPs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2016 at 05:12:05PM +0900, Krzysztof Kozlowski wrote:

>  			buck9_reg: BUCK9 {
>  				regulator-name = "vdd_2.8v_ldo";
>  				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3750000>;
> +				regulator-max-microvolt = <3755000>;
>  				regulator-always-on;
>  				regulator-boot-on;
>  			};

Why does this regulator even have voltage constraints configured?  Is
there any intention that it should ever be varied at runtime?

--Y9+TIksX9Q+3VPs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW87kbAAoJECTWi3JdVIfQkaMH/i9SREeHV6CSf0u+8dGoxGCf
HA4VvYu9ybY0ELcfMF7fy57v1pK1sKa+OLWU6KG/ulqvFtsPAoJ+7SNMpequs1Bb
unoI3J/N2xtH1VQkcO5+VpVb8wHM7kTOrvja2TiXBNhxGPDD/C4/G4OSrSICF4b4
qnqPsWC+vto/zOfSpyoeI3Q4QYfWWMiZOs+YyvrsZwLmG9eZpvXKlChqrDx94y4M
E6EMyevM4ukYITpL6n3q9/K/+BcLsLlkN7pSHlv/9ULkEaGH1m332e1yPfGoZ2qo
Q3oXl9uriO9dddNc8efd9yk0ovE8j8eNvBMJF0sH7L45XEj+0uxZwpML5muzCH8=
=dPlc
-----END PGP SIGNATURE-----

--Y9+TIksX9Q+3VPs6--
