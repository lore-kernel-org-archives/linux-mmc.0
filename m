Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B501ACECD;
	Thu,  6 Feb 2025 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866446; cv=none; b=nXBpCmoSaUX3wk+GAl6c+RgW8LcRuAQ/xcDCsio8r+s9AppbyPxqbAz5oIl5qu9EXteIR2sY+ghQ2a7bPRJ0RUVX6XeNEu5WkPRHyNV5z1chE8yp4O09IyZJSCuR2kX2+Oz94E5VsGsZQn2Yy6f9sIjPAnlijhIbowMTEfng2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866446; c=relaxed/simple;
	bh=IJL45hof8EZ76ZqW9H/9ssbUlriH90R7kETPe0qwoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5CE2ve93KeKDuYqqGPm2cJ4XFaqCtX+Q05xK+Q6R3vmmLVmbidirQVWffjq2UJLwneEKImSlnQzM46HNCfdI6ktz4qtILB6VHLOZdNq+SE1BmibPpW62alxWcWELrwZGm10GCDXTQ6oALOKGsKuZoHg1UxWNrcVroAWvP/BqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFGuxbDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFGuxbDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45CBC4CEDD;
	Thu,  6 Feb 2025 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866446;
	bh=IJL45hof8EZ76ZqW9H/9ssbUlriH90R7kETPe0qwoQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFGuxbDOBC88PRxt7HKAdOjq3A0i/bQ8+C5XbqjQB39QEv99MNFUclW2JE/Zthi++
	 RmSkqwcMRCd4EacMzjQ7dY2MfrO7Ug21geRoyBE8dMtA0i4MCNzqkwi1MklY+at55d
	 Cfue6yNhEVHtPtNFBcPsIgdk/lW5wYL+P9W360ClAPhRpde4/L6hfW1koeu/eYyhvS
	 pjPAYcrX6ayQMQM6hDqaHbkR1XXbMcz8NyUS62uPQGoB/JTpRL2qQRLm2cdbc48rFr
	 0+u62LdUEVbGsFdGmIg+pcoZQB/3yzATztpHkdJB3eFaxEIe1zjijZ5PmdZhCSnGgf
	 cnod05VfazxDA==
Date: Thu, 6 Feb 2025 18:27:21 +0000
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
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Message-ID: <20250206-drainer-vastly-34a3c738e2bf@spud>
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gSRDlsoD+Bdf79l9"
Content-Disposition: inline
In-Reply-To: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>


--gSRDlsoD+Bdf79l9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:18:40AM +0530, Dharma Balasubiramani wrote:
> Remove the compatible property from the list of required properties and
> mark it as optional.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changes in v2:
> - Instead of moving the compatible string to the other binding, just make=
 it
>   optional (remove from required list).
> - Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-dfc747a3d3=
fb@microchip.com

Why is this RFC? I don't see any complaints from Rob's bot, so I am
assuming that this actually works and the error you mentioned in the
previously version has been resolved?

> ---
>  Documentation/devicetree/bindings/mmc/mmc-slot.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Docume=
ntation/devicetree/bindings/mmc/mmc-slot.yaml
> index 1f0667828063..ca3d0114bfc6 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> @@ -29,7 +29,6 @@ properties:
>      maxItems: 1
> =20
>  required:
> -  - compatible
>    - reg
> =20
>  unevaluatedProperties: false
>=20
> ---
> base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
> change-id: 20241219-mmc-slot-0574889daea3
>=20
> Best regards,
> --=20
> Dharma Balasubiramani <dharma.b@microchip.com>
>=20

--gSRDlsoD+Bdf79l9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6T/CQAKCRB4tDGHoIJi
0heMAP9RIv6EPmFdFdH9C4KniHclVT6q7+ipdJy9MNtonSEGeAEAuKgviFIr+311
YAtp4FSk/X/xf6nVb9pNP7sDITwXVgc=
=vdJI
-----END PGP SIGNATURE-----

--gSRDlsoD+Bdf79l9--
