Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF992868BC;
	Mon, 19 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670377; cv=none; b=u0f8zeXoZz+xPIHLkAZg9JgRCRk+kHBPTOiCtxaixKONnK/ZcokG2xvSK2MmlxS9YxJF6+mgLoINXnKKsJVyLAFD58SFq+EWgCBNUjAUHgLV0nrStSMTrl6svnNsqz4arxBDCOgvkYtP706bO9OxitU2AI3yiq42XoL1oqEroNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670377; c=relaxed/simple;
	bh=JlwXRh9DmHUzKvQCtmK1UT8qIxa3tpK7B8H1bzoYiHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrcwCWUgRms3RcpG9q0OhOc8rOzn/rLWzK4FpqIDSo7fCnuhjmIaINukEKGuuOyNLUQjJtwTpcm+TX0FYwyocM/zuSNbkMZ1lNF1+ns+poE+O3lAewGDoZyAGC8l4Cdl5aD+FYbjf8ryyZBNrDVdhS+6CMRiCu5lRugW9+wsX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShuXCRhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShuXCRhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF1C4CEE4;
	Mon, 19 May 2025 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670376;
	bh=JlwXRh9DmHUzKvQCtmK1UT8qIxa3tpK7B8H1bzoYiHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShuXCRhqXvMPcXBXtEaViEJSWX1lK8JCUgxGkp76ftEJ575zQj10DSh3yP4wJ3qKq
	 xCnqqbHna+XvjleoTuWozCncdXzkaxxfTgTwprcZtEKF2bRW/KKo007Ttkc8WlPDj/
	 2UlCsEGoYxTs98KZ+2jcr6NrP06OflYXP8oA0eSX4pEhnVII6Hy2UTkcL7MOmCLl8u
	 C2mqBPSTzKccfbVrmQTFDC7ol9Evvm7B+A/PaZk8SlgGzJhHvl4y8MCtwMIoAM+m4i
	 YAQXU/lPSuKJX8To6rjoEy2f5DOabCDZp5o7HW1Ftax3/D+MANeFu1lG6hN51HWuoZ
	 GUbujc8m0c+YQ==
Date: Mon, 19 May 2025 16:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
Message-ID: <20250519-unstamped-tabasco-05d9c7223289@spud>
References: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2TFq8HbynKfNjeYI"
Content-Disposition: inline
In-Reply-To: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>


--2TFq8HbynKfNjeYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 01:11:17PM +0000, Charan Pedumuru wrote:
> Convert TI MMC host controller binding to YAML format.
> Changes during Conversion:
> - Add new properties 'dma', 'dma-names' under required.
> - Define two separate phandles for 'dmas' in the examples.
> - Include appropriate header file for interrupts and use
>   it in the examples.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
> Changes in v2:
> - Added include statement for irq interrupt controller and
>   modified the interrupts under property to use header.
> - Changed maintainer to Rob Herring.
> - Defined two seperate phandles for 'dmas' under examples.
> - Rename the YAML file name to the compatible 'ti,omap2420-mmc'.
> - Added missing type and maxItems to 'ti,hwmods' under properties.
> - Link to v1: https://lore.kernel.org/r/20250510-ti-omap-v1-1-588b0ccb182=
3@gmail.com
> ---
>  .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   | 64 ++++++++++++++++=
++++++
>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
>  2 files changed, 64 insertions(+), 26 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b=
/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..195db77e0063b867f318ffc6b=
5f8811adb531515
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI MMC host controller for OMAP1 and 2420
> +
> +description:
> +  The MMC Host controller for TI OMAP1 and 2420 family provides
> +  an interface for MMC, SD and SDIO types of memory cards.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>

This patch looks fine, but I don't want to ack this with Rob's name
there. Tony Lindgren <tony@atomide.com> wrote the original binding
as far as I saw from a quick check, maybe he's a more suitable pick?

--2TFq8HbynKfNjeYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtVZAAKCRB4tDGHoIJi
0sJoAQCMywvtM7wlxsalHrW+jWJPkT8+LCZAa+BZi9ETg8TYoQD/SVPwiJn33MPP
eCskujcf388uaMJvnT+wN1VeQLsLhQ8=
=2UCH
-----END PGP SIGNATURE-----

--2TFq8HbynKfNjeYI--
