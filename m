Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FA5286280;
	Wed, 19 Feb 2025 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003806; cv=none; b=JS6w3emvZi3jXByd/ELYK8fczbZov/74SFQu9stIJ1o8fNLhl91DEe8KsZ/EoxMSxoE5gtP5hSyBRUjWp1lwAn+r/kamf8Vqiz3szBAaDn/bIHGEt3v65UVf+GLl1jc1e2kDrfDBUSOVX/4v9C1nZQ/TVP66uELeteShsMVZlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003806; c=relaxed/simple;
	bh=jJj74kq2dXg5VOc0yCCKcirAapeCmvuLU0B0w4KuQQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcXm7XjPHgEYYBC7cwA+vXT0nY1CG68TbGP41hVi9/7ffQYXaNxjwzWjIAJZ/oCSfr9c8h0X+W6XDkdQAeYbA7HtpyK77h3Wd9VlruCGIYXOGJtWYVFmU+ASYYAyxR0GcTde5HYac7tOGgpj6CqUISoLqG+ATDSe2mJJfaFPFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT9G67YH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT9G67YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A904C4CED1;
	Wed, 19 Feb 2025 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003805;
	bh=jJj74kq2dXg5VOc0yCCKcirAapeCmvuLU0B0w4KuQQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JT9G67YHTPyWuV4c8g3Dviag3iI5OsJ0Aw1swxfwhD88uWVwhvFNF5T7AiEacq/Xi
	 nQZyxf6GXzQTeqO373fjlM0MKOMoYBh63Pxd4nS024yIv1aGQul5wS7xo8Oeq4hJp2
	 ImuoR0boWN/6Kj3u9lhZ/44GAByjDb/sTSvnkgx1TNbRziXwVTSnRDRlWbAOdXETru
	 XRiTlXMxxE8VrxLaNYncx9TBcGEbyhxdpld06fKIuauccThdIJST7m/GbAZRm8gHF0
	 hAp5NnxaQ04f13X1+NdAPGAvsiekKLplm9a9XKlb7hHlymIFAMjSqWBuLCyRJubHfK
	 NwqEajbwKENgA==
Date: Wed, 19 Feb 2025 16:23:23 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mmc: atmel,hsmci: Convert to json
 schema
Message-ID: <20250219222323.GA3013450-robh@kernel.org>
References: <20250212-mmc-slot-v3-0-2bf288207040@microchip.com>
 <20250212-mmc-slot-v3-2-2bf288207040@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-mmc-slot-v3-2-2bf288207040@microchip.com>

On Wed, Feb 12, 2025 at 02:52:11PM +0530, Dharma Balasubiramani wrote:
> Convert atmel,hsmci documentation to yaml format. The new file will inherit
> from mmc-controller.yaml.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 106 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 --------------
>  2 files changed, 106 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
> new file mode 100644
> index 000000000000..feaa98e44955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/atmel,hsmci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel High-Speed MultiMedia Card Interface (HSMCI)
> +
> +description:
> +  The Atmel HSMCI controller provides an interface for MMC, SD, and SDIO memory
> +  cards.
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Aubin Constans <aubin.constans@microchip.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +properties:
> +  compatible:
> +    const: atmel,hsmci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rxtx
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mci_clk
> +
> +  "#address-cells":
> +    const: 1
> +    description: Used for slot IDs.
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^slot@[0-9]+$":

If reg can only be 0 or 1, then allowing 2-<infinity> is not valid.

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +    $ref: mmc-slot.yaml
> +    description: A slot node representing an MMC, SD, or SDIO slot.
> +
> +    properties:
> +      reg:
> +        enum: [0, 1]
