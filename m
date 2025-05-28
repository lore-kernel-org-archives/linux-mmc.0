Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C121578D;
	Wed, 28 May 2025 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432944; cv=none; b=VX2eJVGlc97ap8oRXGyRpJ0fhgNED8Bt1TbInqr5cT4JnTvNFm8/Bk9q4mj0K5P0qmTgz4pfmmfBlt32mW6N2tCMn/b4DwmOrFIfdvGPF9DM+kHVQzizZRjqABcZQCtvuDBz5LQgUK6vEIacc4j3q+xQeLmfg4lZAw4pp4XB7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432944; c=relaxed/simple;
	bh=cMZRIRLMM0VSkieLJ1IQwaOz+O4cfkLzSRbY+K9JyQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivb4M13/Gv0XwzamOQQu/dwqE4kbUmHV4ZwWP2IWmKTr8bsmmwHA9QZ9Bj+wotChuj+b5eoprCqlSKllcqdK8Fdvp+/kNLfF/6ZTa3jGLbcNcaozOLTaewXGQum3TDQhngfXHQZJKsZbWHr29EI/VNn8Ol36Z5zOJ9U4p/L/rL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWH8kOyt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWH8kOyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D54AC4CEE7;
	Wed, 28 May 2025 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748432944;
	bh=cMZRIRLMM0VSkieLJ1IQwaOz+O4cfkLzSRbY+K9JyQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWH8kOytaHnKNpKoKpfuCHaaGD42tHq8sfDgcl92DzsS5DnN+Q9PuxSl69Z0NKBc8
	 ewm0U+kZwiZsXwwK/pO9E5lb09OzgKAsqPN+YXhfSm9QOLOC7UE/i27sBxmPY+t3uX
	 nS7zxr/GqgWZEDHMBix2AVwUwgcmBN/p3Rtdep4oosgKNbNgjvHwcGEL3nKCVtpd4w
	 pZM1fMqpiKY03QZBQIEQLx65rz91he2qgWkGBoSHQv8Nf2csE1+7w/AlfxRyikpMW+
	 nlzFWK4rpdaJkncqQ74ydh/chJsBq3Oefv8/CaNn3l+FDugsIhshUH7idR2DbAnxyF
	 p43YhVntx5RMg==
Message-ID: <e69145c0-6303-40a1-a33e-9173d72b04e5@kernel.org>
Date: Wed, 28 May 2025 13:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] dt-bindings: mmc: add binding for BST DWCMSHC
 SDHCI controller
To: Albert Yang <yangzh0906@thundersoft.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>
Cc: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250528085451.481267-1-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250528085451.481267-1-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2025 10:54, Albert Yang wrote:
> Add device tree binding documentation for the Black Sesame Technologies
> (BST) DWCMSHC SDHCI controller.
> 
> This binding describes the required and optional properties for the
> bst,dwcmshc-sdhci compatible controller, including register layout,
> interrupts, bus width, clock configuration, and other controller-specific
> features.

Completely redundant paragraph, drop.

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
>  .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> new file mode 100644
> index 000000000000..429e7f50cdec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/bst,dwcmshc-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Black Sesame Technologies DWCMSHC SDHCI Controller
> +
> +maintainers:
> +  - Ge Gordon <gordon.ge@bst.ai>
> +
> +description: |
> +  The BST DWCMSHC SDHCI controller is a Synopsys DesignWare Mobile Storage Host
> +  Controller IP integrated in BST SoCs.
> +
> +  This documents the differences between the core properties in mmc.yaml and the
> +  properties used by the sdhci-bst driver.

redundant paragraph, drop.

Missing ref to proper schema. Look how other bindings do it.

> +
> +properties:
> +  compatible:
> +    const: bst,dwcmshc-sdhci

You have to use soc specific compatibles. Just look at other bindings.

> +
> +  reg-names:
> +    const: base
> +    description: Specify the register name

Drop reg-names, useless.

> +
> +  reg:
> +    maxItems: 1
> +    description: Host controller base address

Drop description, redundant.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: One MMC interrupt should be described here

Drop description, redundant.


> +
> +  interrupt-names:
> +    items:
> +      - const: IRQDWMMC0

Drop interrupt-names

> +
> +  non-removable:
> +    type: boolean
> +    description: Non-removable slot (like eMMC)
> +
> +  bus-width:
> +    description: Number of data lines
> +    enum: [1, 4, 8]
> +
> +  clock-frequency:
> +    description: Base clock frequency in Hz
> +
> +  max-frequency:
> +    description: Maximum clock frequency in Hz
> +
> +  fifo-depth:
> +    description: |
> +      FIFO depth in bytes. If this property is not specified, the default value
> +      of the fifo size is determined from the controller registers.
> +

All of above are redundant, drop.

> +  mmc_crm_base:
> +    description: Base address of MMC CRM registers
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  mmc_crm_size:
> +    description: Size of MMC CRM registers
> +    $ref: /schemas/types.yaml#/definitions/uint32

No clue what are these but they look completely wrong. Why would you
define address size as different property than reg?

> +
> +  memory-region:
> +    maxItems: 1
> +    description: Specify the MMC DMA buffer range
> +
> +  sdhci,auto-cmd12:
> +    type: boolean
> +    description: Enable auto CMD12 support

Drop, your compatible defines it, there is no vendor sdhci and this is I
think legacy

> +
> +  dma-coherent:
> +    type: boolean
> +    description: Enable coherent DMA operations

Drop description, redundant.

> +
> +required:
> +  - compatible
> +  - reg-names
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - non-removable
> +  - bus-width
> +  - clock-frequency
> +  - max-frequency
> +  - fifo-depth
> +  - mmc_crm_base
> +  - mmc_crm_size
> +
> +examples:
> +  - |
> +    dwmmc0@22200000 {

Never tested

> +        status = "okay";

Drop

> +        compatible = "bst,dwcmshc-sdhci";
> +        reg-names = "base";

Follow DTS coding style for order and naming style.

> +        reg = <0x0 0x22200000 0x0 0x1000>;
> +        interrupts = <0x0 0x90 0x4>;
> +        interrupt-names = "IRQDWMMC0";
> +        #address-cells = <0x2>;
> +        #size-cells = <0x0>;
> +        clock-frequency = <200000000>;
> +        max-frequency = <200000000>;
> +        mmc_crm_base = <0x23006000>;
> +        mmc_crm_size = <0x1000>;
> +        fifo-depth = <0x400>;
> +        bus-width = <8>;
> +        non-removable;
> +        sdhci,auto-cmd12;
> +        dma-coherent;
> +        memory-region = <&mmc_dma_buf>;
> +    };
> +
> +additionalProperties: true

This cannot be true. Do you see any device binding like that? No. This
means you are doing something completely different. Please do not
reinvent this but take latest reviewed binding and customize it.

> \ No newline at end of file

You have patch warnings.

Best regards,
Krzysztof
