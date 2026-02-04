Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2768423177;
	Wed,  4 Feb 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228631; cv=none; b=il7/8PzY799pGDDtwHlUK/tZzWRc3JzCqDNQevHdaMhQimvHt45W5mIKcSct+IhIhHCht5YccgaKKgX2rexpxd60b/hCr//dVC+SW2TBf1T86A6oN+z9DU0bk4cuBrw8gZMpBWURdp+fpENjmGG1DcX5pN7p6+kRaw7TFozylrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228631; c=relaxed/simple;
	bh=WxnyfoifFLABy924YWy34UmPHS+Gu+G1OW1cX5TS97g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q73QhaxrVxi/jcESwJYe6OujX0itagkurRcXGOp1k+0dQzZ1/Z6OKS/i0HSFiynxqV2d4jtnUyf15yIx1RvI9r+j4jfufuFqG1BWN18AjQAW+9vXpEmM/IadpgFnve6QZeWbUBGVQJ1TRg9b67TfcNizyvg5ouRHZmIaRyHYVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwlvXR0B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwlvXR0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F98C4CEF7;
	Wed,  4 Feb 2026 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770228630;
	bh=WxnyfoifFLABy924YWy34UmPHS+Gu+G1OW1cX5TS97g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwlvXR0BslkaCy+/hSCOL0MF1xdY916PZTThBizYeo+xr+kKryC5ijj74IyVy7lXm
	 APGnV4r1EqI8sExTrRGxlIqMXdqsmQAYZIE7Mkg6FNDTY8MetCUl+o3pr3dbSwG+Mb
	 ONGbZc+/e47L/Ud14axA4wRO5X22Bp84ZJR8R8RrVTf+FpvpPfj3f5wXGJvKrHhfaR
	 WxpJWGmiVgsN8XeDnY6p0Dqu8GuBSHViK9Z9vJ/fqu8w/h3gQEIZmWf6nff8XWweO9
	 JDsTVFVItFCZnIhHJxmxMBOR6/qNIgoAcxGECk2yLo59G0LIjH8Ak5TrDf2C6yDwBB
	 oL8PCWRP2V2lg==
Date: Wed, 4 Feb 2026 18:10:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn, me@ziyao.cc
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add sdhci support for Canaan k230
Message-ID: <20260204-imperfect-blitz-55fe5a85590f@spud>
References: <20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260204082908.27501-2-jiayu.riscv@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/gxknbu3c92leW+z"
Content-Disposition: inline
In-Reply-To: <20260204082908.27501-2-jiayu.riscv@isrc.iscas.ac.cn>


--/gxknbu3c92leW+z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 04:29:06PM +0800, Jiayu Du wrote:
> The Canaan k230 uses the SDHCI from Synopsys. Add compatible strings
> to the k230. The k230 has two controllers. MMC0 supports eMMC, while
> MMC1 supports SDIO.
>=20
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 7e7c55dc2440..cab33da3af7d 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -23,6 +23,8 @@ properties:
>            - const: sophgo,sg2044-dwcmshc
>            - const: sophgo,sg2042-dwcmshc
>        - enum:
> +          - canaan,k230-emmc
> +          - canaan,k230-sdio

I don't understand why there are two compatibles here, when the driver
is able to handle them both identically, using the common properties for
mmc controllers to differentiate. Is which is emmc and which sdio
actually just determined by how the k230 boards use them?

Or, if there are pinout differences, would pinctrl allow each to be used
for either?

>            - rockchip,rk3568-dwcmshc
>            - rockchip,rk3588-dwcmshc
>            - snps,dwcmshc-sdhci
> @@ -87,6 +89,26 @@ required:
>  allOf:
>    - $ref: mmc-controller.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - canaan,k230-emmc
> +              - canaan,k230-sdio
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 5
> +        clock-names:
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
> 2.52.0
>=20

--/gxknbu3c92leW+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaYOLkQAKCRB4tDGHoIJi
0jE5AP9A5xbrmdc6tgcmxgxJUe3JH7gzKH+FdLOdHZitm/CrGgEA9tVmRtqMmCcu
bGQiOM9DLm67cQgmD4jeFM1ADLjrmAs=
=fQk9
-----END PGP SIGNATURE-----

--/gxknbu3c92leW+z--
