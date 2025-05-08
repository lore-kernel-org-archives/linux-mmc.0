Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051242797A1;
	Thu,  8 May 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716464; cv=none; b=VVy72q37e2E1xdpFSH08TGYGOlh2FTGDpRevpbuMMaZsTwEwu8+oJhrIQyIlR6UGqepif/ExJEIZdicRX9gtKG3Y38LHM6luyFQvBa5CO/KtxWLMwv/otX/OSAnynPk3NhRHOVXJfMLESL9F14W23BHCyttsAq/X9JI+paCS4r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716464; c=relaxed/simple;
	bh=QIuc44QP0WM4Pw9F2ju2kBjf5vcyErqm+b11yGk5wuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBGKvw0zw48Unv6qTyOD7I2ZbsumFQnJNH9dSIqWXn0Kwi6qroHAkfJEz0MkEOuaDkuD4AzZptfBAmxjrtRKsZC4DfJtaXarwB1g7jAllS7yCutMurEffXGsi8Uw+ZXujswwywbl9k2tG+WAhLDvLTbpiPE2ZblAd1dEc7IJ9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBHQT7pQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBHQT7pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A797C4CEF0;
	Thu,  8 May 2025 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716463;
	bh=QIuc44QP0WM4Pw9F2ju2kBjf5vcyErqm+b11yGk5wuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBHQT7pQVo7fKSgQwmUwh1Xg30z84+6ci8scyf6g4JbXlrkSx6a3j5f0+lbsesMPq
	 zDk8zBB9/gKTavRQ/iTTgtJw8opwOVcpa8xWHHaLCpIvOZyu8VlFHFycE4J8TvbIdE
	 OVm6qoPGEelCUGhdPCoXrRAnBwMcec05DWVqBDHvJBAXCn3m1c6tt/+xtepbMTs1on
	 oy1lFs+KmrDUYwSPLeycTYsqCam2JImCXt+M+ijgjkWap2ByHIlsgaV8IzUy8AaYA7
	 KyivPrSAIC51liUOSy+AWAgfkSwPGMrtz/vzg+sQaVukJYBesV7DMpkv5ha+Lk+MBY
	 0gswxutPHjKPg==
Date: Thu, 8 May 2025 16:00:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC
 controller binding
Message-ID: <20250508-snagged-amber-432ed9bf3d41@spud>
References: <cover.1746581751.git.zhoubinbin@loongson.cn>
 <9b5a416143d5d5da7084f3a868cf01e6827cd653.1746581751.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yxWiAtlT6kYeWJue"
Content-Disposition: inline
In-Reply-To: <9b5a416143d5d5da7084f3a868cf01e6827cd653.1746581751.git.zhoubinbin@loongson.cn>


--yxWiAtlT6kYeWJue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 03:28:05PM +0800, Binbin Zhou wrote:
> Add the Loongson-2K SoC's SD/SDIO/eMMC controller binding with DT schema
> format using json-schema.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/mmc/loongson,ls2k-mmc.yaml       | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k-m=
mc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml=
 b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> new file mode 100644
> index 000000000000..97a0853399f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/loongson,ls2k-mmc.yaml#

Filename matching a compatible please.
Otherwise this looks okay to me.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The SD/SDIO/eMMC host controller for Loongson-2K family SoCs
> +
> +description:
> +  The MMC host controller on the Loongson-2K0500/2K1000 (using an extern=
ally
> +  shared apbdma controller) provides the SD and SDIO device interfaces.
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k0500-mmc
> +      - loongson,ls2k1000-mmc
> +
> +  reg:
> +    items:
> +      - description: Loongson-2K MMC controller registers.
> +      - description: APB DMA config register for Loongson-2K MMC control=
ler.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +    mmc@1fe2c000 {
> +        compatible =3D "loongson,ls2k1000-mmc";
> +        reg =3D <0x1fe2c000 0x68>,
> +              <0x1fe00438 0x8>;
> +        interrupt-parent =3D <&liointc0>;
> +        interrupts =3D <31 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk LOONGSON2_APB_CLK>;
> +        dmas =3D <&apbdma1 0>;
> +        dma-names =3D "rx-tx";
> +        bus-width =3D <4>;
> +        cd-gpios =3D <&gpio0 22 GPIO_ACTIVE_LOW>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96b827049501..5bf74aa63299 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13935,6 +13935,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>  F:	drivers/soc/loongson/loongson2_guts.c
> =20
> +LOONGSON-2 SOC SERIES MMC/SD/SDIO CONTROLLER DRIVER
> +M:	Binbin Zhou <zhoubinbin@loongson.cn>
> +L:	linux-mmc@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> +
>  LOONGSON-2 SOC SERIES PM DRIVER
>  M:	Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:	linux-pm@vger.kernel.org
> --=20
> 2.47.1
>=20

--yxWiAtlT6kYeWJue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzHKwAKCRB4tDGHoIJi
0qOOAQDdUx174xNJP7VuO8Wx3FELbXXDU37gOWFiYDolPaiA6gEA8s2yAOMCa6KW
GjvybMWKWRlXBEoZ16diEIzbh+Pk6wA=
=4nOo
-----END PGP SIGNATURE-----

--yxWiAtlT6kYeWJue--
