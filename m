Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB65383C82;
	Mon,  2 Mar 2026 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480862; cv=none; b=cRu28/gH6R2YlY25tJbS5Sm1MKrGYAuiGom2o5B27z6ADPC5Sd5NUMJEDEYEpGneW58j9l4atHxwcsW9DQlXqMcCPdpmOMru7974vEYWymBGtNxauPRGKB6iEZJpDQwKy6meVIM1Cw81FSOC0bZrp0NsQKc3Eohv3Q5kLqNgPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480862; c=relaxed/simple;
	bh=4uFExyb/T0MzxhLUFU30FXOPf9KZVBS9ZIAPO6aIsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GchCIQUak8HajvPSQlgo1mlK8TS8OTNlF8Kq5scEvfXYlq3VgSGcZM/lLRPEkFAba9UX6JimEZRc/yCpPlnYYNB0sH8Pld0GLL2igojuGaX3nwKNKkY0PVKAGm8OHCe0WIfBsUlXM08FbJWT1S1NIrv+7TD6iEa1FQYkWVHxHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tReVVx8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tReVVx8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFDCC19423;
	Mon,  2 Mar 2026 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772480861;
	bh=4uFExyb/T0MzxhLUFU30FXOPf9KZVBS9ZIAPO6aIsjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tReVVx8bhSnMn9zNZNNi60VikYqIm7XooavgaK5H0YdUiZzdcuXEPDENxvkXxCo2p
	 YcO+VKAB2Ddj4/ak6/og6PGBKy8X9i+zQ5jlDtcm709At1XAoNrkPI453wCfNPEhDN
	 33vXbZ6NvccnsoX8cy1ikS1wAQWQbc+dT1dFA8LGqPUPTgKdtcTzDaFXqn79aCWcEk
	 dVg6n2lgtModxgDrHB4K5IcOQW0wtua2xl+pq5RPUzfbCtinmROltqAH0Frrn3aW3v
	 6koNCjoQAbr3oqkhOswWMU5OzZCdIYRJWIHYxh6hafrl8umgrzkHXrI3XVTADt5+53
	 gBjI/7nYEr0Zg==
Date: Mon, 2 Mar 2026 19:47:37 +0000
From: Conor Dooley <conor@kernel.org>
To: nick.hawkins@hpe.com
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jszhang@kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC
 dwcmshc compatible
Message-ID: <20260302-denture-widow-dfe7fa5ef561@spud>
References: <20260302190141.1481298-1-nick.hawkins@hpe.com>
 <20260302190141.1481298-2-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lvqyi9yYojnOiVXw"
Content-Disposition: inline
In-Reply-To: <20260302190141.1481298-2-nick.hawkins@hpe.com>


--Lvqyi9yYojnOiVXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 01:01:40PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
> Cortex-A53) BMC SoC eMMC controller.
>=20
> The HPE GSC wires an additional 32-bit register, MSHCCS (eMMC
> Configuration/Status Register).  This register
> controls SCG sync disable (bit 18) for HS200 RX delay-line phase
> selection and reflects the current data transfer width (bits 17:16).
> A second reg entry is mandatory for this compatible to map MSHCCS.
>=20
> The HPE GSC eMMC interface only exposes a single 'core' clock (no
> bus clock), so clocks/clock-names are constrained to maxItems: 1.
>=20
> Add an example node showing the two-entry reg layout (SDHCI base at
> 0xc0100000 and MSHCCS at 0xc0000110).
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 43 ++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 7e7c55dc2440..9c326dff589f 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -23,6 +23,7 @@ properties:
>            - const: sophgo,sg2044-dwcmshc
>            - const: sophgo,sg2042-dwcmshc
>        - enum:
> +          - hpe,gsc-dwcmshc
>            - rockchip,rk3568-dwcmshc
>            - rockchip,rk3588-dwcmshc
>            - snps,dwcmshc-sdhci
> @@ -33,7 +34,8 @@ properties:
>            - eswin,eic7700-dwcmshc
> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> =20
>    interrupts:
>      maxItems: 1
> @@ -87,6 +89,35 @@ required:
>  allOf:
>    - $ref: mmc-controller.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: hpe,gsc-dwcmshc
> +
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: SDHCI base registers
> +            - description: |
> +                MSHCCS register. A 32-bit register that controls SCG sync
> +                disable (bit 18) for HS200 RX delay-line phase selection
> +                and reflects the current data transfer width (bits 17:16=
).
> +        clocks:
> +          maxItems: 1
> +          items:
> +            - description: core clock
> +        clock-names:
> +          maxItems: 1
> +          items:
> +            - const: core
> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>    - if:
>        properties:
>          compatible:
> @@ -190,5 +221,15 @@ examples:
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
>      };
> +  - |
> +    mmc@c0100000 {
> +      compatible =3D "hpe,gsc-dwcmshc";
> +      reg =3D <0xc0100000 0x1000>, <0xc0000110 0x4>;

A 0x4 sized region is always incredibly suspect. What is at address
0xc000010c or 0xc0000114? Usually in these sorts of scenarios, it ends
up being that there's some sort of misc. register region of which this
is just one register, that should be represented as a syscon.

> +      interrupts =3D <0 17 0x4>;
> +      clocks =3D <&emmcclk>;
> +      clock-names =3D "core";
> +      bus-width =3D <8>;
> +      non-removable;
> +    };
> =20
>  ...
> --=20
> 2.34.1
>=20

--Lvqyi9yYojnOiVXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaXpWQAKCRB4tDGHoIJi
0hfyAP9XV0NDZCafu3miNq3viKP2KEnW9StDhOUQc8+CC203KgEArxfRYc4NLYxT
zby5U5o9Wx4FTlmGGkFd33NtUqKEwQ0=
=BaYE
-----END PGP SIGNATURE-----

--Lvqyi9yYojnOiVXw--
