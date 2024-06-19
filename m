Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C682594;
	Wed, 19 Jun 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782197; cv=none; b=N2qOjMIxjr+j7wU8coLa4kyrZzRm7x4NBVyFww3GlGp1q/zUXu3JFL5819Gpib/IeTnxoFcYweemDPPphz25f65988h51sztVIlBbKyqim2iYNko5qDnVzh8YDwCYDKXbTZwxAYXl//layHqqtkVpSCVPO3wHRUWjJUKGzhlED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782197; c=relaxed/simple;
	bh=1E+NlnCtf6FDTfcIULRBa8rlKaG+cIdJkekR/2DISmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmtaigR1DPZbKsYQeBO0BDyVAZOoflwlGHCo0C/WkJzBgNqAS6zJUiXB3khRi6th0t7bfodN/CtV+5xnw14C1Be9ePRH4b07cjxtw4Lq9Ntv+4WJeiDhs/h0P+V2IhyVfc7+xDhsd2zx0Gy1Th1CFkw6cJMsKiwMqgtWQi6G7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDDpx/f0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDDpx/f0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C3C4AF1A;
	Wed, 19 Jun 2024 07:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718782196;
	bh=1E+NlnCtf6FDTfcIULRBa8rlKaG+cIdJkekR/2DISmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDDpx/f0P2MpRJfAlUmxvnjYcPBr4aBvc62BRxvzDFvXVCBWtTaM4lJs3VGbuRJ8z
	 tchvDMOKkqKDk6GfVVinmttRKqLvkonMB2kJom+YfCAzKG1TCit7oVaWqEDBCmRMnQ
	 uVbexEZhuCYYQwG+yhzoybbtcJ3sv4WrcF1LF2WuDWZRpuA32dM4tjT4j3dWbnz5be
	 s8lRZq0ig+D4GIuhxkZxxYuHnVPgNyakuhGd34Cyu7i+Re6yqTLNd7zxoeVJX42qzL
	 fParSYrWTBu4jo/MUUOe9s48Imhh4Us1lx4cNqMbW/2nRUoWRvA71EPQSYBqyxFXqX
	 pX0LjXnVODyrQ==
Message-ID: <3d193f01-2c8b-4d6c-8139-11f2d9a34d2d@kernel.org>
Date: Wed, 19 Jun 2024 09:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
 MA35D1 SDHCI controller
To: Shan-Chun Hung <shanchun1218@gmail.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-2-shanchun1218@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240619054641.277062-2-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 07:46, Shan-Chun Hung wrote:
> Add binding for Nuvoton MA35D1 SDHCI controller.
> 
> Signed-off-by: schung <schung@nuvoton.com>

Since this was not tested, only limited review follows. Please test your
future patches.

> ---
>  .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
> new file mode 100644
> index 000000000000..173449360dea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/nuvoton,ma35d1-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 SD/SDIO/MMC Controller
> +
> +maintainers:
> +  - Shan-Chun Hung <shanchun1218@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  This controller on Nuvoton MA35 family SoCs provides an interface for MMC, SD, and
> +  SDIO types of memory cards.
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop

> +      - enum:
> +          - nuvoton,ma35d1-sdhci

Blank line

> +  reg:
> +    maxItems: 1
> +    description: The SDHCI registers

Drop

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    description:
> +      Should at least contain default and state_uhs.

? Contradicts constraints.

> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: state_uhs
> +
> +  pinctrl-0:
> +    description:
> +      Should contain default/high speed pin ctrl.
> +    maxItems: 1
> +
> +  pinctrl-1:
> +    description:
> +      Should contain uhs mode pin ctrl.
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1

No, maxItems instead.

> +    description: The SDHCI bus clock

Drop

> +
> +  resets:
> +    maxItems: 1
> +    description:
> +      Phandle and reset specifier pair to softreset line of sdhci.

Drop

> +
> +  nuvoton,sys:

1. too generic, what is sys?

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon that configure sdhci votage stable

2. typo: voltage

3. Which syscon?

4. Why you are not implementing regulators?


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +unevaluatedProperties: false

Hm? And where is ref to MMC schema?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    soc {
> +	#address-cells = <2>;
> +	#size-cells = <2>;

Fix your indentation.

Use 4 spaces for example indentation.

> +        sdhci0: sdhci@40180000 {

Drop label

> +            compatible = "nuvoton,ma35d1-sdhci";
> +            reg = <0x0 0x40180000 0x0 0x2000>;
> +            interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&clk SDH0_GATE>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_sdhci0>;
> +            bus-width = <4>;
> +            max-frequency = <100000000>;
> +            no-1-8-v;
> +            status = "disabled";

Drop

> +        };
> +
> +        sdhci1: sdhci@40190000 {

Drop this example. One is enough.



Best regards,
Krzysztof

