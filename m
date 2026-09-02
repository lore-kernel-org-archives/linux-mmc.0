Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D965382299;
	Wed,  2 Sep 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372226; cv=none; b=gp5ImR+lWct7eYEpvTF4+f8KSJMihVxEcihmnh9rhL/TARxM9Srual0LOnzxZu57lbtLbEh1roX9yD8u+ojeuMHPM3XcaX3erHZvm1cfUhFCaehShfP1yTuLI55sriz+L4CjZTepej7txa3x8dgIFE0uUpoLL5Q0DORLMfeXfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372226; c=relaxed/simple;
	bh=U0DQvdMBxlrrrjlvjwHNoQY0+Gbfmq4eCEwuD81yDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzzobXqNZPdmLH1JfvF52XtM2wOlfmIcurOLX/HlbItnCZkjlpwCCA+ojBVMxwUpyz++eM1D8GPgTsvuofehzDfO8q47HVOtaIsJlmWVf3EdfptLyysmS/w1wtvqvovZxD/dAsGSBO0TbiwEHMDsbXELWiLrHkHDNhzjuH4hCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YryQdOG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YryQdOG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8A41F000E9;
	Wed,  2 Sep 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788372225;
	bh=Uj9/RDwv9k2iRrF8z8+r037C19R/tl/T6HaynuHBg7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YryQdOG6rCS+CoxXuEhmKqZdD8O0bh7F0WgNxh8InFZjr/iLSM0valYUf4rdXM5E6
	 Vxe3whVlTKMY0QPvSa04XFtUlbX8YsISoVn3NrW+crTxg88qsYsTr3tnLISd4Kd8Dt
	 iYtrHEj2YTmG3kJJLChg+lb7XBELtrMweBQCCo7iZ7+muXc64rjY96EBBYmH/+R6ie
	 NwZVU3R9XH//x33Z0hYhHJPSQgGQgNRvyr5CmG+ouEnbkdMnmMRfgYhJMMsAhhnpiT
	 jMljJ/6L/ziJe6kbaA5W9kRZrJn7mcUOgv+T88DR0r/Pk39Ub4KzjoNcLcZbgbgdgO
	 1DQu/IxJCAB5w==
Date: Wed, 2 Sep 2026 19:03:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mmc: spacemit,sdhci: Add tx delay
 property
Message-ID: <20260902-crept-player-b3f30ab4e6f6@spud>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JPvI9JMjjGIUeUlx"
Content-Disposition: inline
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>

--JPvI9JMjjGIUeUlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 07:03:13AM +0000, Yixun Lan wrote:
> From: Long Wan <long.wan@linux.spacemit.com>
>=20
> Introduce a vendor specific property to configure the step count of TX
> delay line which should be applied before RX tuning, compensating for
> board level trace differences. The TX delay line result comes from test
> out of real board which vary from different hardware layout.
>=20
> Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> Signed-off-by: Yixun Lan <dlan@kernel.org>

Everyone seems to have their own custom delays, so what's another..
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/=
Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> index f35bf7ce08dd..3399a2d076dc 100644
> --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> @@ -63,6 +63,16 @@ properties:
>    pinctrl-1:
>      description: Optional pinctrl state for 1.8V UHS operation with "uhs=
" name
> =20
> +  spacemit,tx-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +    description:
> +      TX delay line setting applied before RX tuning, compensating for
> +      board level trace differences. This is a delay line step count with
> +      no fixed time-per-step conversion; determined empirically per board
> +      specific, used on SD/SDIO hosts.
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.55.0
>=20

--JPvI9JMjjGIUeUlx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaphk/AAKCRB4tDGHoIJi
0po+AQCA6PqLcTKT7imRX8EmzXyV4cbV44EdaTRHvitAdUV6IgD/ViMPsvHGYEO1
7Ph5zn0Vyp3Oo8iHwbyKP3VfMdWVMQg=
=fS0X
-----END PGP SIGNATURE-----

--JPvI9JMjjGIUeUlx--
