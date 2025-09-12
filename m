Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B236309EEC;
	Fri, 12 Sep 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704211; cv=none; b=hI1PncQu7q2KvI/+xpicWbNPCFmxX7kavupEIlRhn+IYNueP2BjwUx6k9xpUZIDRZEuWqrAv/uirybbhAobRDpbvD/1ysDtNEg5jGp0+3q+k3h2sLPGzP8fQwbiKW/cqq510ZFFUgq8YGRLu3Ku8eO2lWQP12cbCBp7r6Im1nKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704211; c=relaxed/simple;
	bh=BHvO3ffOu/pYItZcjhAHlIsp5Ebwcjc3/LkaEdv6EYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYcIM1nV26aZMYcI7bzmriu1oyPpWkkpuxz9zLUKvjBg5S/Mm3rgcNQm6jYtS4l2CDI5Zo6P7PmDagvNEeCex0J082mXfOuPQYSTynitVeVCZ+4OHWwIe6XiQtQ99VlnlIrcRQZh2QIrCSyBezMdjo7UrWT7tEzmhk6fZBLJhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbdrWw+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbdrWw+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70A4C4CEF1;
	Fri, 12 Sep 2025 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757704210;
	bh=BHvO3ffOu/pYItZcjhAHlIsp5Ebwcjc3/LkaEdv6EYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbdrWw+qY6KsEX7m6TBsiOQZHcO3FJQNY0FxU1AUBr89RmfNJX8ys5j0lqqRaodld
	 FGZrkvkZAzbWh2yDTywPu7bIJLMJ4EL40PDVEWgKatHREe2006Tf0zRYH0gygHZpNm
	 38YvJJT42306TLIRY3UDKGjU3gh+DbypDHqJYmwG8y+F/9iYtBrOMWSgwgg7BuDTe5
	 FjxLszL6EdzIz79xcJggobJYyze67DTQUmQoVZBLAGNj2Je6OhthnMKXvTOeKDRMhZ
	 RYifvyGjGvKIN6BMUQgUMMDeDtqxxNntYAftHrbzQfHagQjn69VIhDqdwmVTIqHb3U
	 UOuBwU9kDMSrw==
Date: Fri, 12 Sep 2025 20:10:04 +0100
From: Conor Dooley <conor@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, adrian.hunter@intel.com,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com, dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com, weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com, caohang@eswincomputing.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20250912-pork-oaf-3480d3d0ef67@spud>
References: <20250912093451.125-1-hehuan1@eswincomputing.com>
 <20250912093713.142-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="er6Xm9SJtE93Y+go"
Content-Disposition: inline
In-Reply-To: <20250912093713.142-1-hehuan1@eswincomputing.com>


--er6Xm9SJtE93Y+go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 05:37:13PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
>=20
> EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
>=20
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 81 +++++++++++++++++--
>  1 file changed, 75 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f882219a0a26..e0f34bc28e0c 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -30,6 +30,7 @@ properties:
>            - sophgo,sg2002-dwcmshc
>            - sophgo,sg2042-dwcmshc
>            - thead,th1520-dwcmshc
> +          - eswin,eic7700-dwcmshc
> =20
>    reg:
>      maxItems: 1
> @@ -52,17 +53,51 @@ properties:
>      maxItems: 5
> =20
>    reset-names:
> -    items:
> -      - const: core
> -      - const: bus
> -      - const: axi
> -      - const: block
> -      - const: timer
> +    maxItems: 5
> =20
>    rockchip,txclk-tapnum:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
> =20
> +  clock-output-names:
> +    maxItems: 1
> +    description:
> +      The name of the clock output representing the card clock,
> +      consumed by the PHY.

You have one clock, why do you need this?

> +
> +  '#clock-cells':
> +    enum: [0]

const: 0

> +    description:
> +      Specifies how many cells are used when referencing the
> +      exported clock from another node. This property indicates
> +      that the clock output has no extra parameters and represents
> +      the card clock.

This description is not needed.

> +
> +  eswin,hsp-sp-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: Phandle to HSP(High-Speed Peripheral) device
> +      - description: Offset of the stability status register for
> +                     internal clock
> +      - description: Offset of the stability register for host
> +                     regulator voltage.
> +    description: |
> +      High-Speed Peripheral device needed to configure internal
> +      clocks, and the power.
> +
> +  eswin,syscrg-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: Phandle to system CRG(System Clock and Reset
> +                     Generator) device
> +      - description: Offset of core clock control register
> +    description: |
> +      System Clock and Reset Generator device needed to configure
> +      core clock.

This reeks of improper clock tree description. Why can you not just
request the rate that you need via the common clk framework? Likewise
for reset. You already have a clocks property that has to include the
core clock, so I don't see why you need another property to get around
it.

As a result, I'm also suspicious of your hsp-sp-csr, but these at least
appear to be internal clocks if your description is to be believed.
I'd like you to explain exactly what those clocks do and what the "HSP"
actually is. What other peripherals use it?

Also, your driver turns on this hsp clock but never turns it off. Same
for the power.

I want to see the full dts for what you're doing here before I approve
this, there's too much here that looks wrong.

> +
> +  drive-impedance-ohm:

How come this one has no eswin prefix? Also, the unit is "Ohms", not
"Ohm".

Additionally, any eswin properties should be restricted to eswin devices
only.

> +    description: Specifies the drive impedance in Ohm.
> +    enum: [33, 40, 50, 66, 100]
> +
>  required:
>    - compatible
>    - reg
> @@ -110,6 +145,40 @@ allOf:
>              - const: block
>              - const: timer
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: eswin,eic7700-dwcmshc
> +    then:
> +      properties:
> +        resets:
> +          minItems: 4
> +          maxItems: 4
> +        reset-names:
> +          items:
> +            - const: arstn
> +            - const: phy_rst
> +            - const: prstn
> +            - const: txrx_rst

How come you're so drastically different to the other devices?
Also, putting "_rst" in a reset name is pointless. These are all resets
after all by nature.

Cheers,
Conor.

> +      required:
> +        - clock-output-names
> +        - '#clock-cells'
> +        - eswin,hsp-sp-csr
> +        - eswin,syscrg-csr
> +        - drive-impedance-ohm
> +    else:
> +      properties:
> +        resets:
> +          maxItems: 5
> +        reset-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: axi
> +            - const: block
> +            - const: timer
> +
>    - if:
>        properties:
>          compatible:
> --=20
> 2.25.1
>=20

--er6Xm9SJtE93Y+go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMRwDAAKCRB4tDGHoIJi
0shHAQC+SrqvSbv2pQ0Nma2DkzXWQp1AlSILxib/onOdJjFDjAD/StEwusEOYc0V
WqBLKaCHIC5d9NoKe6QdUlkErvglkAY=
=vvpd
-----END PGP SIGNATURE-----

--er6Xm9SJtE93Y+go--
