Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24113D63B;
	Fri, 19 Jul 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401173; cv=none; b=qvrkxhf3C9gi6MV1qKc8qRjvDVeIsbljuHCwIe4v46e+a+SNsCDFNp2CI2Zx9lRox9q5+S1cBMelYx+52/MV1JOGmFQNfmcgVkedXxzH4KJZFORoaPSO1wpPkpJZW+rksZygUSO4ZJXgAK7CHFG+4eiWeqhwZ7XoetfskgMK+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401173; c=relaxed/simple;
	bh=riKWNj9ymyyL39s71PP994WyzSU+759xl9rDSHnUAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv4QKm/JChaHT/KZPx3YBBcUaiv/q+XcfeayD9zXJ1j6ct4BtfUQRQsSVjd+5ikXf10oOKeUmsHc/SOD6WuoS1RlyMAgQIXQcfP8Yo35g86XIULsFx2qG9o/FyyctbBSU9TjmF2Cq/UenQcjBMbVE1B8sdqcqJQKxS4T6z212L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqcu5kTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqcu5kTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AEFC32782;
	Fri, 19 Jul 2024 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721401172;
	bh=riKWNj9ymyyL39s71PP994WyzSU+759xl9rDSHnUAF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hqcu5kTgtqSNGXwpr+rLf04U8saJ0oT+7KTOqaK5tIjgB49z7iYXDKoh002v28T47
	 KHyA5ZaXNQsi2hio+QNnXJ8uwE6iQppaC9K+BWrJQhHPfQnyGq3KC3s5pkiMo8dRiE
	 RFplIazgJJqcuOewPcVf8x7dtkusX1kR6fsneJl3lRbSyTyzXgXvxrWZamOk6hqoNk
	 m1wTGrmoVGkd27pfCG1MUL9lGyTfUwcjb9LqCSzpWsAwp9D2nt5HgS/QvlaLEebiBa
	 6NOf4oUk6/EdVNVJ7XcCGHbqilRXLwYCwdm4i7yUI/13ZUPJGF+/wV9tnCX/OlNNDe
	 lkl4tuS9RJjTQ==
Date: Fri, 19 Jul 2024 15:59:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
Message-ID: <20240719-catnip-pushup-81d3e104de7b@spud>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
 <55bc60606bc9b2558eeddb00fd8b659d3fcd69ff.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mebK71Pev/WbD3jG"
Content-Disposition: inline
In-Reply-To: <55bc60606bc9b2558eeddb00fd8b659d3fcd69ff.1721377374.git.unicorn_wang@outlook.com>


--mebK71Pev/WbD3jG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 04:46:50PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
>=20
> SG2042 defines 3 clocks for SD/eMMC controllers.
> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), so reuse
>   existing "core".
> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>   and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>   source, so reuse existing "bus".
> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>   existing "timer" which was added for rockchip specified.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 60 +++++++++++++------
>  1 file changed, 43 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 4d3031d9965f..80d50178d2e3 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -10,9 +10,6 @@ maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>    - Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> =20
> -allOf:
> -  - $ref: mmc-controller.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -21,6 +18,7 @@ properties:
>        - snps,dwcmshc-sdhci
>        - sophgo,cv1800b-dwcmshc
>        - sophgo,sg2002-dwcmshc
> +      - sophgo,sg2042-dwcmshc
>        - thead,th1520-dwcmshc
> =20
>    reg:
> @@ -31,22 +29,11 @@ properties:
> =20
>    clocks:
>      minItems: 1
> -    items:
> -      - description: core clock
> -      - description: bus clock for optional
> -      - description: axi clock for rockchip specified
> -      - description: block clock for rockchip specified
> -      - description: timer clock for rockchip specified

Does anyone know what "for rockchip specified" means? Is meant to be "for
rockchip specifically"? If it is, should probably be actually
constrained! Patch itself seems fine though and I don't think it's your
responsibility to fix that, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> -
> +    maxItems: 5
> =20
>    clock-names:
>      minItems: 1
> -    items:
> -      - const: core
> -      - const: bus
> -      - const: axi
> -      - const: block
> -      - const: timer
> +    maxItems: 5
> =20
>    resets:
>      maxItems: 5
> @@ -63,7 +50,6 @@ properties:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
> =20
> -
>  required:
>    - compatible
>    - reg
> @@ -71,6 +57,46 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sophgo,sg2042-dwcmshc
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: core clock
> +            - description: bus clock
> +            - description: timer clock
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: timer
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          items:
> +            - description: core clock
> +            - description: bus clock for optional
> +            - description: axi clock for rockchip specified
> +            - description: block clock for rockchip specified
> +            - description: timer clock for rockchip specified
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: axi
> +            - const: block
> +            - const: timer
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--mebK71Pev/WbD3jG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpp/TgAKCRB4tDGHoIJi
0qRSAQCcxNgXXQFBflYmeBWap/fYoOK6l9k5GvMV4TcSeNbazAEAt9rJueFEhCG0
M64Ytc4yOLvPk7XxHj6Mt7x1DATCXg8=
=+Shv
-----END PGP SIGNATURE-----

--mebK71Pev/WbD3jG--
