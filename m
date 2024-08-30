Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA461758F;
	Fri, 30 Aug 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025708; cv=none; b=P7XfsXxNxKgZ/HWcQOFAEL8YOHXUz+K2ndJW/lRrVQedaLLK+LYGoED2fD7Xf0ZzznyXoDKF+8Vt0SAgP04iHPweYt2nlddfm9OYP+LNJoKs+084MNYCQDRAl2HjM8ntO1xzPWNMmshD2M9NXqqcjL0uFNMljt8Fpcqa+ptArF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025708; c=relaxed/simple;
	bh=C7SzgnZQ5XbL0Poy8QlUNW6+CVwAR6aH2vrX/N/Txxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgtWmrL8WjpJwuWJrtW+T1oCAHRqvFiIYJmkJ9+0/bZEt6K31bw7kf4/VtBIJHdT8jvbV78wp7aRvjwt7s4kZ9TZYxyPuuKT7khs8LReze6sIb31+bY6vS43m7iy+UUX0QbzKk0VUp2S5saf98H+xJj2TTo2u394JhieXkaVcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKvebFtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKvebFtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8895EC4CEC2;
	Fri, 30 Aug 2024 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725025708;
	bh=C7SzgnZQ5XbL0Poy8QlUNW6+CVwAR6aH2vrX/N/Txxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKvebFtRV+e4c4onP/eArXUHfNnw+SSvW4ORRbhw1Rjjg3fMsXfAr4B+w3zJt+E3+
	 6WQykcEprwYkvPJOmEoRoIEu7lWKUhIL68FNSgE57SF5I631cRIdoy4hz8OlElR3Hl
	 hRlAC2IJFcPyR5GMgsgGE25vQOZyFxBiocdP9H/SMrscBNjggBl9LK3zVRLoav5Yg+
	 aJRV11RhcN+9scvQI/STiYvV9p4zW+uoJFenWbw0wKEk/5RHUoMKcDxBte1jJkuyUn
	 5Xgznb6ICztJcLc/qKHX8usYgssCOEPn8dlgEbR+RIWt8M/8y4IHgp4MFvGghYHQOY
	 EjGGbyRsNiLdg==
Date: Fri, 30 Aug 2024 14:48:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Message-ID: <20240830-satisfy-dislike-27ed075138b3@spud>
References: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
 <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BDXgFad7zf52Vic3"
Content-Disposition: inline
In-Reply-To: <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>


--BDXgFad7zf52Vic3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:49:42PM +0530, Dharma Balasubiramani wrote:
> Convert sdhci-atmel documentation to yaml format. The new file will inher=
it
> from sdhci-common.yaml.
>=20
> Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
> in the DT.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 98 ++++++++++++++++=
++++++
>  .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
>  2 files changed, 98 insertions(+), 35 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.ya=
ml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> new file mode 100644
> index 000000000000..91d18b2545e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SDHCI controller
> +
> +maintainers:
> +  - Aubin Constans <aubin.constans@microchip.com>
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +description:
> +  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,sama5d2-sdhci
> +          - atmel,sama5d3-sdhci
> +          - atmel,sama5d4-sdhci
> +          - microchip,sam9x60-sdhci
> +      - items:
> +          - enum:
> +              - microchip,sama7g5-sdhci
> +          - const: microchip,sam9x60-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +    description: |
> +      The sama5d2 family includes three clocks: `hclock`, `multclk`, and=
 `baseclk`.
> +      For other families, including sam9x60 and sam9x7, only `hclock` an=
d `multclk` are used.

This should instead be an items list, rather than a text based
description.

> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3

We prefer that you describe the entries at this level, and constrain
them in the conditional bits below. IOW, move the items list here,
and only use minItems/maxItems below.

> +
> +  microchip,sdcal-inverted:
> +    type: boolean
> +    description:
> +      When present, polarity on the SDCAL SoC pin is inverted.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d2-sdhci
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3

maxItems: 3 or minItems: 3? Your answer will depend on whether or not
baseclk is optional on sama5d2.

Cheers,
Conor.

> +        clock-names:
> +          items:
> +            - const: hclock
> +            - const: multclk
> +            - const: baseclk
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: hclock
> +            - const: multclk
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/at91.h>
> +    mmc@a0000000 {
> +        compatible =3D "atmel,sama5d2-sdhci";
> +        reg =3D <0xa0000000 0x300>;
> +        interrupts =3D <31 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks =3D <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> +        clock-names =3D "hclock", "multclk", "baseclk";
> +        assigned-clocks =3D <&sdmmc0_gclk>;
> +        assigned-clock-rates =3D <480000000>;
> +    };

--BDXgFad7zf52Vic3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHNpwAKCRB4tDGHoIJi
0hybAQDUlIVOHIEiR1wC9Pruszi99jufighJpzE4S1psUqavTAEA2IlB4SSTQg7j
Ypqt/472eU2lCY9H6m0T51AJB5hbzw8=
=bSGL
-----END PGP SIGNATURE-----

--BDXgFad7zf52Vic3--
