Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795111290;
	b=Fi3Nz8JyEu8x43KhFarscWlcbEUrIndwHNxQtvIyhPOVYtnlv68Qx5xM05BUVXPbOJYK
	 fpIQYEUCszgtEwOOeSwn5CdCF/Z3hb0ALcVhLkAeOsTW+Pv+a9ubJlOY+GwLPEsNiG3QB
	 nsiUmu942ppilSFfjnBO2AEUdu39zK5ka5WT41Hf7+H9q+qyQpRr9wq4Hril+/WXLftFc
	 WoUioJiypiRMaqAx81HOBKAFrBgquisPB8qMzz6b8bKS9xffBsV/o+7sVfP+niwbftBuS
	 3ZoLfW8dLF4RGK0wl+EqE+50760NrBlWp9pzaOUNqZtKf0+QGp+e03YZTgegnlaGMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111290;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mBnC+LDDdHjJvEmrt7O1ftT0whMAvSyt4fbGMaKJPxE=;
	b=XcejG+pZa24cB4Bap5OZ6U7tNUihVFluB4XkmLuu3Cgx10W9jfqGNS5t84IJ7GT+MDsJ
	 YJQxsL6gACtvgrbJLtiVo1A2h8nEebmoJfVSJ37Kb5G1GYDDaEvx9Y/lyaNUprt/YTnIt
	 raDh6eJx7DSDWUv9yEMIaSD6mxvQdIQTvocMVH1cxI4OI1NQGBITJ1joVvdC62YvopDq2
	 Ay7Pjku/AFciiD6jIVXBPOA6rG3Cm8WcFTgLlrIdX5erKFA8H/yM7Af5XU7anQNqbEdeT
	 zser8so0XGnrZI4AnliydY8JmxAiN/s4oMsGcQP0EootHYVHJ5H+oo4gZYHJf3ddQRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B48oboth;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D7606A324;
	Thu, 19 Nov 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B48oboth
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDBE1F000C5;
	Thu, 19 Nov 2026 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795111289;
	bh=mBnC+LDDdHjJvEmrt7O1ftT0whMAvSyt4fbGMaKJPxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B48obothF4dCLUEkjh+GW2NVTgaNBA9Z0hs0yzxS74fiv/KuAgKSWIzArac6hcY+k
	 9z5t1RsHEgf/491sObUHihtXJrK8uDWq4RD5gqKn2jwHWoIt/U4kknzK0aJsHSOnfL
	 kw/FAMDRF+Zl1EXK4z/yzx8ABJ2QI1POeDWIOXSCtsfUzQKzjHRNFpf5pdHZ28FWK7
	 m1a+2aUy6ePbQVbkE8JqBo2L7rXErlXDWZhzFSngjBxcc8HFFJYUFHguY5Hz3OXbyz
	 0uGmJFP62w56BBPtggRNbdMp/zpJKreWlebrSO1nVV9ukQrAsY1Ki48Jnexw8I0Uu8
	 wnzxbSFOshSNw==
Date: Thu, 19 Nov 2026 18:01:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Arthur Heymans <arthur@aheymans.xyz>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 07/10] dt-bindings: net: wireless: add
 XRadio XR819
Message-ID: <20261119-cyclic-shoplift-fde1709c7180@spud>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
 <20261119175002.458988-8-arthur@aheymans.xyz>
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
	protocol="application/pgp-signature"; boundary="fJC5a6TJ4HXTMEDB"
Content-Disposition: inline
In-Reply-To: <20261119175002.458988-8-arthur@aheymans.xyz>

--fJC5a6TJ4HXTMEDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 06:49:59PM +0100, Arthur Heymans wrote:
> The XR819 exposes one SDIO function. Boards may provide a MAC address
> and wire a GPIO interrupt instead of using the SDIO interrupt.
>=20
> Prepared with OpenAI Codex.
>=20
> Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> ---
>  .../bindings/net/wireless/xradio,xr819.yaml   | 49 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/xradio=
,xr819.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/xradio,xr819.=
yaml b/Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
> new file mode 100644
> index 000000000000..4f6919b6bcbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/xradio,xr819.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: XRadio XR819 SDIO wireless controller
> +
> +maintainers:
> +  - Arthur Heymans <arthur@aheymans.xyz>
> +
> +description:
> +  The XR819 is a 2.4 GHz IEEE 802.11b/g/n controller connected to the ho=
st
> +  through SDIO. Its out-of-band interrupt may be connected to a host GPI=
O.
> +
> +properties:
> +  compatible:
> +    const: xradio,xr819
> +
> +  reg:
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  local-mac-address: true
> +
> +required:
> +  - compatible
> +  - reg

Is this not missing several clocks and supplies?
Datasheet I found online had multiple of both.

Cheers,
Conor.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mmc {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        wifi@1 {
> +            compatible =3D "xradio,xr819";
> +            reg =3D <1>;
> +            interrupt-parent =3D <&pio>;
> +            interrupts =3D <10 IRQ_TYPE_EDGE_RISING>;
> +            local-mac-address =3D [02 00 00 00 00 01];
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cf311e6c4be..6e7b5f6beba4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7211,6 +7211,7 @@ F:	Documentation/process/cve.rst
>  CW1200 WLAN driver
>  S:	Orphan
>  L:	linux-wireless@vger.kernel.org
> +F:	Documentation/devicetree/bindings/net/wireless/xradio,xr819.yaml
>  F:	drivers/net/wireless/st/
>  F:	include/linux/platform_data/net-cw1200.h
> =20
> --=20
> 2.56.0
>=20

--fJC5a6TJ4HXTMEDB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav85dQAKCRB4tDGHoIJi
0ul9AQDHOzmbgpDtVLXF/h/QHpmMRcFP2xNHfvAFIDyVDOEHrQD/ZMRlN17BaFG4
LRGlt3Wj2DaXhCj7odovj1pbCmj/iAc=
=baqQ
-----END PGP SIGNATURE-----

--fJC5a6TJ4HXTMEDB--
