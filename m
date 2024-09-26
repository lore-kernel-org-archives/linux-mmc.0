Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5911581F3;
	Thu, 26 Sep 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367240; cv=none; b=Xrn3WVGgJUn5X/Yb9l7ZVuOKPit4WhKfeNdxm8QR0yMYjgmcDFUZON/cs2IEZ8Zr3VsBg4aae9mz5+H3UD0O/jLUBWAuFU5BQF31GXu9gDrhOBfPVSww5jeTTi36BCY8JS136V95jAO9Uhv3e2ss7O3uU/22MTcgBq+FAHM6zeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367240; c=relaxed/simple;
	bh=7vn8F+i4bEeKF3b0bUuklVycjsEm0yuEh18P9WeIlLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+F+6REWmGGtfbbSD86+sLxLI9grBE9P1RZG0pybkvzClZytVSGxxX9jymbFfUbiDutouQDMjejnReVezgWUPUtl0qMy5/9VX53jWoqoRLz6mu0QNMcuKa8GPPs2l0HFEhyWHFpdPdBMeVEVoj7YknVkNukXLNAAPHj75LuFXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efMmBCXC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efMmBCXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66511C4CEC5;
	Thu, 26 Sep 2024 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727367239;
	bh=7vn8F+i4bEeKF3b0bUuklVycjsEm0yuEh18P9WeIlLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efMmBCXCAt1k+tJ4J0c/ZlREBJtvswL3y3/vVBLcHSZTL9+uM0q+u9ekHfDC6Ax1N
	 WUqY3S66gL3mnDjul84umvldE8zXjRdmgR3AK5EUlgUT+1058rPS+jDh39+D2im9Tw
	 v5QVVtWC4R+a/zNPyVgmMDo7w9xrJCQvM3QMpJBMRiIBveZAz8RbQL6OOB0gxzRnlC
	 sF6TaBckQw7KgwCKQgQfkUHevZc8SzRyCGntesISjkGJkNeWcS53ExkdamzUj7qfYl
	 u1lDUL4nktfZJ/2IdUT8TYGuD75MYFzwHovmvD6iyYKsP0a+jBNQVrNa1SfSY1kRPb
	 OJVlmVuK3UnAg==
Date: Thu, 26 Sep 2024 17:13:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	matthias.bgg@gmail.com, wenbin.mei@mediatek.com,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Message-ID: <20240926-footprint-faster-4263120d0b83@spud>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rTdKX9h0An540zaG"
Content-Disposition: inline
In-Reply-To: <20240926070405.20212-3-andy-ld.lu@mediatek.com>


--rTdKX9h0An540zaG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 03:03:18PM +0800, Andy-ld Lu wrote:
> Extend the devicetree bindings to include the MT8196 mmc controller
> by adding the compatible string 'mediatek,msdc-v2', which could be
> also used for future compatible SoCs that support new tx/rx.
>=20
> Add three properties for MT8196 settings:
> - 'mediatek,prohibit-gate-cg', indicate if the source clock CG could
>   be disabled when CPU access IP registers.
>=20
> - 'mediatek,stop-dly-sel', configure read data clock stops at block gap.
>=20
> - 'mediatek,pop-en-cnt', configure the margins of write and read
>   pointers while begin to pop data transfer.
>=20
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Document=
ation/devicetree/bindings/mmc/mtk-sd.yaml
> index c532ec92d2d9..82d1a9fac67c 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -25,6 +25,7 @@ properties:
>            - mediatek,mt8173-mmc
>            - mediatek,mt8183-mmc
>            - mediatek,mt8516-mmc
> +          - mediatek,msdc-v2
>        - items:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
> @@ -154,6 +155,30 @@ properties:
>      enum: [32, 64]
>      default: 32
> =20
> +  mediatek,stop-dly-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs need to set appropriate stop-dly-sel to configure read d=
ata clock
> +      stops at block gap. The valid range is from 0 to 0xf.

If you used a specific compatible for these devices, which you should,
you would not require either this or "pop-en-cnt".

> +    minimum: 0
> +    maximum: 0xf
> +
> +  mediatek,pop-en-cnt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs need to set appropriate pop-en-cnt to configure the marg=
ins of write
> +      and read pointers while begin to pop data transfer. The valid rang=
e is from 0
> +      to 0xf.
> +    minimum: 0
> +    maximum: 0xf
> +
> +  mediatek,prohibit-gate-cg:

This is also probably detectable from a specific compatible, if you had
one?
TL;DR specific compatibles please, non of this "msdc-v2" stuff, sorry.

Thanks,
Conor.

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Decide if source clock CG could be disabled when CPU access IP reg=
isters.
> +      If present, source clock CG could not be disabled.
> +      If not present, source clock CG could be disabled.
> +
>    resets:
>      maxItems: 1
> =20
> @@ -191,6 +216,7 @@ allOf:
>              - mediatek,mt8188-mmc
>              - mediatek,mt8195-mmc
>              - mediatek,mt8516-mmc
> +            - mediatek,msdc-v2
>      then:
>        properties:
>          clocks:
> --=20
> 2.46.0
>=20
>=20

--rTdKX9h0An540zaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWIQwAKCRB4tDGHoIJi
0p62AQC7zWy8sxC+DpKsViZDlAuVYx19RGJZLpxLCCMrqTjtggEA47f0DiCOzh8l
0cDhA/a8DytL3SRUlW08RURFaOLoWAo=
=qF+N
-----END PGP SIGNATURE-----

--rTdKX9h0An540zaG--
