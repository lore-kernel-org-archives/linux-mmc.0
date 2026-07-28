Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AD4964F;
	Tue, 28 Jul 2026 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224996; cv=none; b=rsmhKAp2dA1Y8eXkzKh0qkLg3XNTAN8HNjSyp/5hT4JBtHCCXzEcy+KzYESKt6KOOdUs9wnfKL1d6YCdE07N2RiE6jZotP/P3CCyU6FuVfNMaO8qLTH95r3hNSQ9ULYhyZnlWkYNn7IX1nMsWlYReCYZOS3f9WnzuQeSsaP8pHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224996; c=relaxed/simple;
	bh=xJ+iAjl43gN/ekAbs91Zbu41aRGSOsF8gD2d1SFsKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnQ63HYUVjKQIpJY24VYWCUzkKqKcr+u3edtWbiVM2jGZeB1xx20h5867zGYeL/mBRSzzyA51sCGS8BG0eCsfo2HNhtc4UxldFzx7Uvfl6HtmZUBJ2cnfQFfNAwQulXEy7BJZFUGlheRnWiamTStH51U0R0t9RdOR0kW579iSyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejC75acI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejC75acI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2721F000E9;
	Tue, 28 Jul 2026 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785224995;
	bh=NF3d8NpMnyJSbXnshg6ESwO1p9oQFHLPHkzdEORyB2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejC75acInfzG3wHSzRxzbUtRkw6tM8h3UBl6gkx5CvwrhruEbflvl1re3gSIe9wWa
	 y0Saj2NYUovxgBVLUwBg0Q2gmkPK4RgZG++idCBtPRaTTmwwVqsLS4U44GhSwOP0Ph
	 NbY/Z1qJSPqmkUW26xa5/uy59tMgZehaaLZMFw6dalo1TfZivCb6KQS7/GXPcCchFq
	 ZeAMUVyP4UINC8X1aTMEwxcKRZc5nlj75oUjaipMCGZCGzVros1bSgvYkyO+sanZKw
	 yCy6fn3AefSIOo/9++ObB27MPxqA3HzMgrx4gEXtzAjh5dlbuaPHquTRKF/NONeMVy
	 bWrIo7U6Mw4Vw==
Date: Tue, 28 Jul 2026 09:49:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com, 
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Message-ID: <20260728-fearless-efficient-collie-b37340@quoll>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724145009.7456-1-tanmay.kathpalia@altera.com>

On Fri, Jul 24, 2026 at 07:50:00AM -0700, Tanmay Kathpalia wrote:
> +description:
> +  Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller with an
> +  interface to a Cadence Combo PHY. The controller has separate card interface
> +  and bus interface clock domains.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: altr,agilex5-sd6hc
> +      - const: cdns,sd6hc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: card interface unit (CIU / SDMCLK) clock
> +      - description: bus interface unit (BIU) clock
> +
> +  clock-names:
> +    items:
> +      - const: ciu
> +      - const: biu
> +
> +  resets:
> +    minItems: 1

Drop

> +    maxItems: 3
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 3

Drop both and list items. And then drop that "if:then:" block.

Case of 1 item is simply impossible.

> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  cdns,iocell-input-delay-ps:
> +    description:
> +      Input delay across the IO cells, used for SD6HC PHY timing calculations.
> +    minimum: 0
> +    maximum: 20000
> +
> +  cdns,iocell-output-delay-ps:
> +    description:
> +      Output delay across the IO cells, used for SD6HC PHY timing calculations.
> +    minimum: 0
> +    maximum: 20000
> +
> +  cdns,delay-element-ps:
> +    description:
> +      DLL delay element size, used for SD6HC PHY timing calculations.
> +    minimum: 1
> +    maximum: 1000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names

resets and reset-names should be required

> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: altr,agilex5-sd6hc

Best regards,
Krzysztof

