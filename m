Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936487;
	b=rqABnmo3WoRDc3CMPM3dhPh3YLWbTrQwSvFIfCIUGkELPPZlqbNLehiEFH27RyqD+BTM
	 9+txQi2BcVZLmIEuPEyACVbPriQBiiFvSS027gQhPNZAo0d9XIT6f7pxsbejwjMbC9LML
	 OvlqlFQ/x1zCWMakIlWuadpONEbd+BiAQcNIMAPAMSHKi8KuRa4hAw39PZkQE/endjM2B
	 vrU/vX5qs2lVFYZUjsRLKKMooRd6mBokVzJ7odT01AxX2IH9IH651MdfxUZa67g3+wZ/w
	 TpHLBaSvy7ltUwjkIriVCu2uGrO1Vt1uU4CvmvF5mbRJ/Fxgx4w1qjPTzDSbDAgp8LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936487;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CGNf1O2wX9MR4NQSLoWq+A36asloTIZogkdNhe+ZehE=;
	b=fchpVoPXtYqIjKmJP4O0xaW9pmOVLf5mVT0uCO6RniDnE59OaecVNc8Fg0UZyIJhTy/+
	 hWFmqVy4njLb7IdDAVmrNynVratw2sFyFUTq51uWplgCtYEV5cRZTD6mPXplNHywlsvgg
	 SvWqLrb4qdQiI+y8bFgMt3xMwI6nL0noM7I0YbREtzke7QVjUMbVw0tlo55U92GBStd+c
	 bfNULZf7WLs0/ZFG2GlpBiNzD315GQ9HRQQPXkjr5AGKyyZcRGAkUd9GfShTafQqPStN/
	 K2n2x2xNh68mQTf11poe/z+cVxlx+pIw9HcAPJdm7qQXCOpoDQ3SLEuR5veq9J31p7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnnlh9in;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF3606A31C;
	Tue, 17 Nov 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnnlh9in
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB051F000C5;
	Tue, 17 Nov 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936487;
	bh=CGNf1O2wX9MR4NQSLoWq+A36asloTIZogkdNhe+ZehE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lnnlh9inJ6o/1qosKUEp7PBgwZdkUXA3L5+hn3VKZsEsWYIppauWnJbAquuI8srjb
	 7eroWmMabep0wZPx7ktACoKM594ZaI4W5AeYOPpHBn4vzfkZ3g1fbAiuJUbie+C4Ga
	 ovUa0zMtehCMIFlCU8mMtI+oxFxfEXE0cmqFwRPnkGN7LLL3nt5Szkh5WX8K972KHH
	 vDzIdy7vsHhCB4IU1s5eOiO85WdKCteVdRdub7/eWGae0Ee+VX6wK0tufHECCd7JKE
	 dLFZhcZW5WHVdHiK4ooH2O4IEBMrNHdDA1WASSDX+uhfXct9DRpZ6nogkeApyAipHk
	 +A0hwzPJrJ7zQ==
Date: Tue, 17 Nov 2026 17:28:00 +0000
From: Conor Dooley <conor@kernel.org>
To: yogo.0917.sabu@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Ulf Hansson <ulfh@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH RFC 1/6] dt-bindings: add SiRF AT550 and Yupiteru
 YPL514si descriptions
Message-ID: <20261117-tableware-geologic-c2bc6f295a4a@spud>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-1-5879573cb825@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyL+d5MTotBFRQBA"
Content-Disposition: inline
In-Reply-To: <20261117-at550-rfc-v1-v1-1-5879573cb825@gmail.com>

--uyL+d5MTotBFRQBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:06:51PM +0900, yy-Local-LLM via B4 Relay wrote:
> From: yy-Local-LLM <yogo.0917.sabu@gmail.com>
>=20
> Describe the 64-source interrupt controller, counter/match timer,
> resistive touch input and PIO SD host, together with the YPL514si board
> compatible. The counter clock is supplied by boot firmware after its
> configured divider. The initial platform inherits firmware clock and pin
> setup.
>=20
> Signed-off-by: yy-Local-LLM <yogo.0917.sabu@gmail.com>

It's okay to use an LLM, it's not okay to submit something like that
that appears to not have any human in the loop that understands what is
being submitted. Look around the tree, what other recent submissions
look anything like this? None.
pw-bot: changes-requested

Conor.

> ---
>  .../devicetree/bindings/arm/sirf,at550.yaml        | 22 ++++++++++
>  .../bindings/input/touchscreen/sirf,at550-ts.yaml  | 36 +++++++++++++++
>  .../interrupt-controller/sirf,at550-intc.yaml      | 46 ++++++++++++++++=
+++
>  .../devicetree/bindings/mmc/sirf,at550-sdhci.yaml  | 51 ++++++++++++++++=
++++++
>  .../bindings/timer/sirf,at550-timer.yaml           | 47 ++++++++++++++++=
++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  MAINTAINERS                                        |  9 ++++
>  7 files changed, 213 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sirf,at550.yaml b/Docu=
mentation/devicetree/bindings/arm/sirf,at550.yaml
> new file mode 100644
> index 000000000..f538f7ccc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sirf,at550.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sirf,at550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRF AT550 platforms
> +
> +maintainers:
> +  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    items:
> +      - const: yupiteru,ypl514si
> +      - const: sirf,at550
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sirf,at5=
50-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550=
-ts.yaml
> new file mode 100644
> index 000000000..0458db241
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.y=
aml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/sirf,at550-ts.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRF AT550 resistive touchscreen
> +
> +maintainers:
> +  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-ts
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    touchscreen@80120000 {
> +        compatible =3D "sirf,at550-ts";
> +        reg =3D <0x80120000 0x1000>;
> +        touchscreen-size-x =3D <4096>;
> +        touchscreen-size-y =3D <4096>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sirf,=
at550-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/si=
rf,at550-intc.yaml
> new file mode 100644
> index 000000000..ec68afa80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-i=
ntc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sirf,at550-intc.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRF AT550 interrupt controller
> +
> +maintainers:
> +  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +
> +description:
> +  The AT550 controller routes 64 level-sensitive interrupt sources to the
> +  ARM1136 IRQ input. Each source has a fixed active level; the single in=
terrupt
> +  cell is the source number. Firmware FIQ routes are not exposed by this=
 driver.
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-intc
> +  reg:
> +    maxItems: 1
> +  interrupt-controller: true
> +  '#interrupt-cells':
> +    const: 1
> +  '#address-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@90020000 {
> +        compatible =3D "sirf,at550-intc";
> +        reg =3D <0x90020000 0x1000>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <1>;
> +        #address-cells =3D <0>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml =
b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> new file mode 100644
> index 000000000..7129aaeec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sirf,at550-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRF AT550 SDHCI host controller
> +
> +maintainers:
> +  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +
> +description:
> +  AT550 removable SD controller. Initial support uses programmed I/O and
> +  firmware-configured clocks and pin multiplexing. DMA address translati=
on
> +  and 1.8 V operation are not described by this binding.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-sdhci
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  bus-width:
> +    enum: [1, 4]
> +  no-1-8-v: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - no-1-8-v
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@56000000 {
> +        compatible =3D "sirf,at550-sdhci";
> +        reg =3D <0x56000000 0x1000>;
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <36>;
> +        bus-width =3D <4>;
> +        max-frequency =3D <25000000>;
> +        no-1-8-v;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/timer/sirf,at550-timer.yam=
l b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> new file mode 100644
> index 000000000..d1465d438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/sirf,at550-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiRF AT550 system timer
> +
> +maintainers:
> +  - yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +
> +description:
> +  A free-running counter with six match channels. The Linux driver uses =
the
> +  low 32 counter bits and match channel zero. Firmware configures the di=
vider
> +  before boot and supplies the resulting counter clock. A running watchd=
og
> +  must be disabled by firmware before this block is handed to Linux.
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-timer
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    items:
> +      - description: Counter clock after the firmware-configured divider
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@90050000 {
> +        compatible =3D "sirf,at550-timer";
> +        reg =3D <0x90050000 0x1000>;
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <0>;
> +        clocks =3D <&counter_clk>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5471a06f9..a8927fea3 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1985,6 +1985,8 @@ patternProperties:
>      description: Shenzhen Yashi Changhua Intelligent Technology Co., Ltd.
>    "^ysoft,.*":
>      description: Y Soft Corporation a.s.
> +  "^yupiteru,.*":
> +    description: Yupiteru
>    "^yuridenki,.*":
>      description: Yuridenki-Shokai Co. Ltd.
>    "^yuzukihd,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d73899016..6c3702cd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25847,6 +25847,15 @@ F:	drivers/gpio/gpio-siox.c
>  F:	drivers/siox/*
>  F:	include/trace/events/siox.h
> =20
> +SIRF AT550 PLATFORM
> +M:	yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
> +F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-int=
c.yaml
> +F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> +F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> +
>  SIS 190 ETHERNET DRIVER
>  M:	Francois Romieu <romieu@fr.zoreil.com>
>  L:	netdev@vger.kernel.org
>=20
> --=20
> 2.56.0
>=20
>=20

--uyL+d5MTotBFRQBA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavyOoAAKCRB4tDGHoIJi
0nZWAQD2VwX1lmubRbbDr8OPc7uw3FcgQZVFRko0QaMOvllh2QEA6OXdvFQ8xQKf
wwavfkXRS5p/uAyJYH6posMgOG8V8wA=
=f1Ec
-----END PGP SIGNATURE-----

--uyL+d5MTotBFRQBA--
