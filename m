Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38C1BD9E9;
	Thu, 19 Dec 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639070; cv=none; b=fM0O/On1uc6KUoKFalRGoFfMNyyQusyYkusSCNByrj0lzy7VaQIbJ51ON26tm9IH/xP3O2MSy+c0ZqDSi6JDTfnp0bInaNFXnHS82AX7buLIQlJCU8jgb9n8fx5bLHc6OHd4lCnA6VUxnu4Q4iGyq4f23DWuI5qwxE61iJ2rfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639070; c=relaxed/simple;
	bh=Oxv7gQG1cNXbG0Fp3Bpc5LzhotYBPEpA0l2FLf6oEvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCMZ4BPBRWgpzoeQlJfQYJElPDs/R0qBzhtcNxyo0ZjG/3UwCzF4ptCEitKvQoyqKmDarWE0keMUGpfDQRjQp4zmnUjy4TzAT8wJNWhIf596xy+yYYdzCT3fBTmQbhxhzzLUymDCXgl/G9f/KHdngSvUEmySmzkcmM9PoRKwlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwZjYF+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwZjYF+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F60C4CED4;
	Thu, 19 Dec 2024 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639070;
	bh=Oxv7gQG1cNXbG0Fp3Bpc5LzhotYBPEpA0l2FLf6oEvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwZjYF+3NvizdHmvVN9RAsyQzBQkvEOjm5w/XOMpU39UcRQH0f1qop4Bax3JqGV7W
	 bplpnRxoDMZyeuZ8WxbCqUUfbXQGYFW3vpNqvSdsw5VTADUl0kYL4ZCgMA0tIWZbjf
	 /uDT4XaDk30CdDndhAgksSFqC969dtsuRNJQlV8ATaYZqf+H+Lq6rvI4OUAbR/mcsc
	 8whZew4hdzVtIO7ZPuCvMshqSsTG22DCod0pAX+YoXzPBCvryOPaQ4nIyeR3X8FANJ
	 oDgovQcR2EGA6aZ9T3gRRZFPnXjA8ccKV3Hl/r7NaE5d1OSW72M0ru/8lBiKukv6xS
	 /TTXhi+l2t4gA==
Date: Thu, 19 Dec 2024 20:11:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
Message-ID: <20241219-scenic-revision-17da9231d61a@spud>
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E6C8VplMw1mOJcDT"
Content-Disposition: inline
In-Reply-To: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>


--E6C8VplMw1mOJcDT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 09:40:41AM +0530, Dharma Balasubiramani wrote:
> Move the `compatible` property into its specific binding to make the MMC
> slot more generic and modular.

This makes no sense, as presented. What's the real reason for this
change? You want to ref mmc-slot.yaml but the compatible is causing a
driver to probe?
Otherwise, if this is just to avoid having to fix up some devicetree
source files, I don't think we should do this.

Thanks,
Conor.

>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml | 4 ++++
>  Documentation/devicetree/bindings/mmc/mmc-slot.yaml              | 7 +--=
----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.=
yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> index 022682a977c6..7600a4988eca 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> @@ -54,6 +54,10 @@ patternProperties:
>        A node for each slot provided by the MMC controller
> =20
>      properties:
> +      compatible:
> +        items:
> +          - const: mmc-slot
> +
>        reg:
>          enum: [0, 1, 2]
> =20
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-slot.yaml
> index 1f0667828063..84c4605658e0 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> @@ -20,19 +20,15 @@ properties:
>    $nodename:
>      pattern: "^slot(@.*)?$"
> =20
> -  compatible:
> -    const: mmc-slot
> -
>    reg:
>      description:
>        the slot (or "port") ID
>      maxItems: 1
> =20
>  required:
> -  - compatible
>    - reg
> =20
> -unevaluatedProperties: false
> +additionalProperties: true
> =20
>  examples:
>    - |
> @@ -40,7 +36,6 @@ examples:
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
>        slot@0 {
> -        compatible =3D "mmc-slot";
>          reg =3D <0>;
>          bus-width =3D <4>;
>        };
>=20
> ---
> base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
> change-id: 20241219-mmc-slot-0574889daea3
>=20
> Best regards,
> --=20
> Dharma Balasubiramani <dharma.b@microchip.com>
>=20

--E6C8VplMw1mOJcDT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2R92QAKCRB4tDGHoIJi
0uF0AQCCkZ/AGdPEHj/YRGeKMFGk8lttRZIYHRKX8V3//6ycbgD/T1LEsSfzTuzT
XIO5WbdO0FiyWZ0dsPH7aR+mC0O2Jgg=
=My4h
-----END PGP SIGNATURE-----

--E6C8VplMw1mOJcDT--
