Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15574440A22;
	Wed, 22 Jul 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738238; cv=none; b=ihrdOQ35b+9BUNsvQYeFVUQdRLlzXk34jOB5mtGfyz7nmKt9Z5cPzQdzi3gsJmBEYyJ7iFqLIoxXdgS37NfcIIfjmfFxg9CK9/rdAL5j7Et0HWT4we93XDvaQQ6MnbrOlWAroTwalykdv0xzf99tccW0YlD0j92wbnoAZq1lxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738238; c=relaxed/simple;
	bh=NP2VTwIJz6GvU680agEVNUChBePvaecFsczaL0UtImk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/DAYNbB7dBmd5H1pZJHbd3r5f23WA2Hc/hyYbOqpXGU+6XLTRs/71LHQYpWMQrqsT7boNflTLEk3CgJTQgBiqqkdca1vWUCYIWZkBAYTInq+GMY5UXqf3ltlQvyV97pJniDGyB4Xlyv5K5yC3ropjcgqZGxP4qO3meTlfB08yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOO2DJmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOO2DJmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAA61F00A3A;
	Wed, 22 Jul 2026 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738236;
	bh=45z0ibFQ4CLVhktux66Xc6FkspGt19/aZl3QuabuhdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOO2DJmHiOYtbka7ChMLPwu88tw87fnNrVqhX3vgWFIVLmtDBiEixwZ8QvBGkPeY2
	 jtwww6gcjYydGWGT6JB7s+Mjd7qWJxalsjjFCIGrQtc0tAW/V2cRDNlAqT798LuE7s
	 PqBHoNp29axYcw5ZfL5LTah6SRm8kXIk/ZKM2VNsYMIZbF3w7Gkkxa3ymQYxG8l5YU
	 oMvShgHA6SiIujQohXQDZUmc/WP6Iff+Z6woO30/p8r0hMf0YQssRyaBiFCgx/04T6
	 G58W5MLMlHvOhWGgeecZUcNdsA6VUTIDMDTSImSyRotS06N1d073rXDAqsfGzxwKBm
	 VXSE9KLn8/I8A==
Date: Wed, 22 Jul 2026 17:37:12 +0100
From: Conor Dooley <conor@kernel.org>
To: rohan1sj@cadence.com
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mparab@cadence.com, pawell@cadence.com, sjakhade@cadence.com,
	mpillai@cadence.com, razb@mobileye.com
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: cdns,sdhci: Add CQE support
Message-ID: <20260722-nursing-shrine-9e9196d96f14@spud>
References: <20260722-cdns_sdhci_cqe-support-v3-0-4412856a4488@cadence.com>
 <20260722-cdns_sdhci_cqe-support-v3-1-4412856a4488@cadence.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+pkj7PAJz+Or51pX"
Content-Disposition: inline
In-Reply-To: <20260722-cdns_sdhci_cqe-support-v3-1-4412856a4488@cadence.com>

--+pkj7PAJz+Or51pX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 04:18:37PM +0530, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
>=20
> Cadence host controller can optionally support CQE.
> Add optional CQE register space to cdns sdhci bindings.
>=20
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 28 ++++++++++++++++=
+++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Docu=
mentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 6c7317d13aa6..10bc9ac2073a 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -22,7 +22,14 @@ properties:
> =20
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: hc
> +      - enum: [bctl, cqhci]
> +      - const: cqhci
> =20
>    interrupts:
>      maxItems: 1
> @@ -131,13 +138,27 @@ allOf:
>      then:
>        properties:
>          reg:
> +          minItems: 2
>            items:
>              - description: Host controller registers
>              - description: Elba byte-lane enable register for writes
> +            - description: CQE (Command Queuing Engine) registers (optio=
nal)

I see no explanation in your commit message for why the elba is being
modified.

This new reg entry should be restricted to only the device-specific
compatibles that actually support it.

pw-bot: changes-requested

Thanks,
Conor.

> +        reg-names:
> +          minItems: 2
> +          items:
> +            - const: hc
> +            - const: bctl
> +            - const: cqhci
>      else:
>        properties:
>          reg:
> -          maxItems: 1
> +          items:
> +            - description: Host Controller registers
> +            - description: CQE (Command Queuing Engine) registers (optio=
nal)
> +        reg-names:
> +          items:
> +            - const: hc
> +            - const: cqhci
> =20
>  unevaluatedProperties: false
> =20
> @@ -145,7 +166,8 @@ examples:
>    - |
>      emmc: mmc@5a000000 {
>          compatible =3D "socionext,uniphier-sd4hc", "cdns,sd4hc";
> -        reg =3D <0x5a000000 0x400>;
> +        reg =3D <0x5a000000 0x400>, <0x5a000400 0x060>;
> +        reg-names =3D "hc", "cqhci";
>          interrupts =3D <0 78 4>;
>          clocks =3D <&clk 4>;
>          bus-width =3D <8>;
>=20
> --=20
> 2.43.0
>=20
>=20

--+pkj7PAJz+Or51pX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDxuAAKCRB4tDGHoIJi
0iURAQDTEzszT++d0dUjJHzZ+k8ZCpvV0tLrIw19CH5rq7xqkwEAikoksUDUP7fm
E0+o8Oi77N/E157lwzMwrSRYBfnigA8=
=MCW6
-----END PGP SIGNATURE-----

--+pkj7PAJz+Or51pX--
