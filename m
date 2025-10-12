Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C861ACECE;
	Sun, 12 Oct 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760276158; cv=none; b=JQV//WF4jYy6epQ3vIWhxtdVQkMJJU+oTsQLEApJx0y5EBIolx597EOxLsbOddykb4iuzFh+CbIfCNSqfg2cPXeEiO6enyXixSfGcZKD7FXU3qz5u0I9zpBbShX8Jwygvnr+O4StXvZJzkyaU5qqNhygcnK4MG9bYjTde81b9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760276158; c=relaxed/simple;
	bh=GghfE5YM8TPbJhlO+2xIBisZv3B2f12hUO1Bx8PrXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkIC9dSeR8MvYeTAsmU0TVbQ7heIcQXC0iyyQl63/4Z/mTAq6oyjtxLDFUTSFntc2c3/TT2Ehn1bvqKsavx1aKo+7VEjuHUGeMk9fZeLfLgWtOPSuavUbTGEpz1j5VzNQy8icNtjfnDDbfJ0bANHspiXBvV4rs/hUfM1dho+nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAECxGU9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAECxGU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D3C4CEE7;
	Sun, 12 Oct 2025 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760276158;
	bh=GghfE5YM8TPbJhlO+2xIBisZv3B2f12hUO1Bx8PrXLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAECxGU9OkQcPU+8dyn7p2VwNKW9t1u2RPkZCjYkeF3DWqa97ZmnU+4SbDQSbdRd/
	 x0MndA1vj1z9/Vz3kx9X4rA227OseTyfTZpYX4rTBcAZw9JANEFhwqXd+rx/vTdeKT
	 STd2eGaLORGUkqgoN/dg95hBcK1rfLmIjGUwGzF0iGYHPRNmFp3iprjacZoAiUOyzq
	 SSJs7hq8Rfo8yrYewA8t6zNi7Pk7MMJ+BcIC9o5uyKcWbF/0HUgv4VAej33lMtI0uR
	 lpLRcdxeDNXtuJwH7jbAmcfLLKSSmNVPvrnFVaedhsjOaV+iwn74DSJlOP3nSXkVZN
	 J45esfaTvGLdA==
Date: Sun, 12 Oct 2025 14:35:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
Message-ID: <20251012-nickname-morale-e1e21796f1f1@spud>
References: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY52Dy33OnbvwAen"
Content-Disposition: inline
In-Reply-To: <20251011-davinci-mmc-v2-1-355da3e25123@gmail.com>


--PY52Dy33OnbvwAen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 08:52:07AM +0000, Charan Pedumuru wrote:
> Convert TI Highspeed MMC host controller binding to YAML format. Define
> 'clocks' and 'interrupts' properties to resolve errors identified by
> 'dt_check' and 'dtb_check'.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v2:
> - Modified the commit message.
> - Removed 'interrupts' from required properties following the old binding.
> - Changed the maintainer for the binding to "Conor Dooley".

Bro, what? Where did that come from? I know nothing about this device at
all. Find someone from TI to put there.

Conor.


> - Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd83=
52d9c@gmail.com
> ---
>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++=
++++++
>  2 files changed, 61 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Docu=
mentation/devicetree/bindings/mmc/davinci_mmc.txt
> deleted file mode 100644
> index 516fb0143d4c21d1c8e44a8846d55ea5458d7b74..0000000000000000000000000=
000000000000000
> --- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* TI Highspeed MMC host controller for DaVinci
> -
> -The Highspeed MMC Host Controller on TI DaVinci family
> -provides an interface for MMC, SD and SDIO types of memory cards.
> -
> -This file documents the properties used by the davinci_mmc driver.
> -
> -Required properties:
> -- compatible:
> - Should be "ti,da830-mmc": for da830, da850, dm365
> - Should be "ti,dm355-mmc": for dm355, dm644x
> -
> -Optional properties:
> -- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
> -- max-frequency: Maximum operating clock frequency, default 25MHz.
> -- dmas: List of DMA specifiers with the controller specific format
> -	as described in the generic DMA client binding. A tx and rx
> -	specifier is required.
> -- dma-names: RX and TX  DMA request names. These strings correspond
> -	1:1 with the DMA specifiers listed in dmas.
> -
> -Example:
> -mmc0: mmc@1c40000 {
> -	compatible =3D "ti,da830-mmc",
> -	reg =3D <0x40000 0x1000>;
> -	interrupts =3D <16>;
> -	bus-width =3D <4>;
> -	max-frequency =3D <50000000>;
> -	dmas =3D <&edma 16
> -		&edma 17>;
> -	dma-names =3D "rx", "tx";
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Do=
cumentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a97c3e447fd10f14bfe0af9e=
22f9479304f0f26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Highspeed MMC host controller for DaVinci
> +
> +description:
> +  The Highspeed MMC Host Controller on TI DaVinci family
> +  provides an interface for MMC, SD and SDIO types of memory cards.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Conor Dooley <conor+dt@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,da830-mmc
> +      - ti,dm355-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mmc@1c40000 {
> +        compatible =3D "ti,da830-mmc";
> +        reg =3D <0x40000 0x1000>;
> +        interrupts =3D <16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <17 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-width =3D <4>;
> +        max-frequency =3D <50000000>;
> +        dmas =3D <&edma 16>, <&edma 17>;
> +        dma-names =3D "rx", "tx";
> +    };
> +...
>=20
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250523-davinci-mmc-c704440c3dd0
>=20
> Best regards,
> --=20
> Charan Pedumuru <charan.pedumuru@gmail.com>
>=20

--PY52Dy33OnbvwAen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOuutgAKCRB4tDGHoIJi
0h/IAP0WtzbV+IXLwg7uVoHCeHVViaX/soKA93a6GBGYZf3TXAD/U+kDgIw5N/cW
C7kCChsy3b48ylOjF6m55Qm37cnz7Qk=
=dLIn
-----END PGP SIGNATURE-----

--PY52Dy33OnbvwAen--
