Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E947A221;
	Tue, 12 Dec 2023 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGwTmpLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB1C433C8;
	Tue, 12 Dec 2023 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702400720;
	bh=fgV/ueNCtkTrCI5wjYcDbyfn6cdCjZFdcNhi/pc5XFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGwTmpLszqMAvT1evkp2WwFB1pDOGD7rISsvdX5xDl5WWqzXBLn+JuMwv3tU4N/Ai
	 vsuXfs9GuU9Fnyf3Gs0qJv9usvlHPRdQXM3k0/2BMsCYT/Y4XDHY1AybP0RpcfV0OM
	 AKjmZJMosm46YCKHmSyUtGxgvfdVfPiMnJbeGmNll4RnItyAFNGM0MJUL5OVXFbXp+
	 Oupnz3bcVAj2fhVNuO3qDuDZLot8Qwsbx4hReJRayWmhoquRaW/uKIDojvK8k4Ru3q
	 MycgSsg6L8ckbaWCFIWCYK9ZI8Fbh4NAgAY7dAXtT7BiAX59JOLdkmL4bvZkrXZCW5
	 frUwGUQR+GWBw==
Date: Tue, 12 Dec 2023 17:05:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel
 SocFPGA
Message-ID: <20231212-situation-catapult-31deb18f55e6@spud>
References: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mllp56Yojhimxyx"
Content-Disposition: inline
In-Reply-To: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>


--2mllp56Yojhimxyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 06:10:13PM +0100, Krzysztof Kozlowski wrote:
> The DW MSHC node in Intel SocFPGA ARM64 DTS has iommus property, so
> allow it to silence dtbs_check warnings:
>=20
>   socfpga_n5x_socdk.dtb: mmc@ff808000: Unevaluated properties are not all=
owed ('iommus' was unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> I assume the DTS represents the hardware, thus iommus is real.

Assuming it is in fact real,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml =
b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index b13b5166d20a..a6292777e376 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -35,6 +35,9 @@ properties:
>        - const: biu
>        - const: ciu
> =20
> +  iommus:
> +    maxItems: 1
> +
>    altr,sysmgr-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> @@ -62,6 +65,7 @@ allOf:
>          altr,sysmgr-syscon: true
>      else:
>        properties:
> +        iommus: false
>          altr,sysmgr-syscon: false
> =20
>  required:
> --=20
> 2.34.1
>=20

--2mllp56Yojhimxyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiSzAAKCRB4tDGHoIJi
0guKAP9KpXptHIwPy8y65zTLRaA5ROCdUPXQxch5VszAJOa7WgEAxqSaZF2RNUAA
Q44AUjPOny9XxYcpphYjYaoX3kr8Tg0=
=rnlC
-----END PGP SIGNATURE-----

--2mllp56Yojhimxyx--
