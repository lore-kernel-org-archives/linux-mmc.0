Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CB3B8BC3;
	Tue, 24 Feb 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956082; cv=none; b=TQK/1cpgLTD9cUzojGsMOL4Tpt4vpuJHhhylQ5YYdQpmHc3lgkNKS2nr59VF+gt8ZrdopR3n19a4BfT1ZdnoscFo8vcloaHZnSZNmN54JuVcAu/+vny0e7nlJVWQDdGEVMav7yq02es9peSXKpjwqsL+1psvkZT5Mw6k58S7eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956082; c=relaxed/simple;
	bh=eH4+2skd3VALylEaLIYDFMzcl1fWohpq7mxAbNYFwcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miFREwb4wX8/8WO5G1gtuu7PAnbcVNd8pRT2+KXks1D80SD4OSHSCpwp+/X9Th5bUqya0N9b4krpxER1rFg8W/MjcKBj6SGqmkCZMiENdMaVnito4mZJaImuGEe0oVOLuZIYsusg+geqJHngmf/tWOZL0XhOnoTyY+AhMFxVj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJws2CN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJws2CN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A09C2BC9E;
	Tue, 24 Feb 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771956082;
	bh=eH4+2skd3VALylEaLIYDFMzcl1fWohpq7mxAbNYFwcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJws2CN/whHAVW40p5nnLCrPNbi0scnnG0IYiQZ1mGFNbyBLM6wANqstdQiKPixQY
	 uUgkRsqYjCuzLHPuapdfGXXE2yrZ6XjeBrLNG9/sEb8XTEGR9NHlukVpXNRbpAPADp
	 M6HkrmPqOcCnly59cKJrMhNCooFGqOr2BkCuu3DY9jt6R8IVpqSEiIGdWiOaG14IYC
	 qleP2rxlaz6OO44ev1Tqh7dI5rXVwNrnIUZFllZoKNn5JNCGHU41wInPHAwa2KHQe+
	 A7/Fg6aD3ap7AU2USO5pVemUbA/CRlHbAmaBcS30cpDTLvWg43dFedBWQu1kp2i3pV
	 xBLl35TzQFXIQ==
Date: Tue, 24 Feb 2026 18:01:17 +0000
From: Conor Dooley <conor@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jszhang@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, xuxiang@eswincomputing.com,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: Re: [PATCH v3] dt-bindings: mmc: dwcmshc-sdhci: Fix resets array
 validation
Message-ID: <20260224-thud-hydroxide-4c139d351fa6@spud>
References: <20260224092337.312-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XQINSj+G7vpgZLCh"
Content-Disposition: inline
In-Reply-To: <20260224092337.312-1-hehuan1@eswincomputing.com>


--XQINSj+G7vpgZLCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 05:23:37PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
>=20
> The binding defines tuple-style reset-names items for some
> compatibles, which implicitly enforces a fixed array length
> via JSON Schema.
>=20
> Defining global maxItems for resets and reset-names causes these
> constraints to be intersected via allOf, resulting in an effective
> minItems equal to the global maxItems. This leads to dtbs_check
> failures reporting reset arrays as too short, even when the DTS
> provides the correct number of entries.
>=20
> Fixes: 30009a21f257 ("dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC77=
00")
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Signoff chain looks wrong. You're author and submitter, what did
Pritesh do?
Content looks okay to me.

>=20
> ---
> Changes in v3:
>   - Add minItems: 5 in 'else' branch for non-eswin,eic7700-dwcmshc
>     compatibles
>=20
> Changes in v2:
>   - Keep the global maxItems constraints and add minItems: 4 for both
>     resets and reset-names properties
>   - Update commit message
>=20
> - Link to v1: https://lore.kernel.org/all/20260211094736.88-1-hehuan1@esw=
incomputing.com/
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 7e7c55dc2440..5cebe5eb1efb 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -50,9 +50,11 @@ properties:
>      maxItems: 1
> =20
>    resets:
> +    minItems: 4
>      maxItems: 5
> =20
>    reset-names:
> +    minItems: 4
>      maxItems: 5
> =20
>    rockchip,txclk-tapnum:
> @@ -146,6 +148,7 @@ allOf:
>      else:
>        properties:
>          resets:
> +          minItems: 5
>            maxItems: 5
>          reset-names:
>            items:
> --=20
> 2.25.1
>=20

--XQINSj+G7vpgZLCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ3nbQAKCRB4tDGHoIJi
0uKBAQDIrqcK04VZM2IvY/RnESJb30TntkHjLyN0Z0prl3RkTQEA5vpbrQDwrYEu
6+r7qH/I8oudKasJEbcHhXwNOvWqtwc=
=0L8m
-----END PGP SIGNATURE-----

--XQINSj+G7vpgZLCh--
