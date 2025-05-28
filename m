Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E12F2F;
	Wed, 28 May 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419230; cv=none; b=Sd6lV/kT6FVtGk8Z0ejGuGr8O07kHieZR1JYGQXfrah6RLBHBVMt/PKPpUKNAmzAEoJX9GSB/Z0JESA+SPV1lsPvaYugerGbcZjr0519b7utxbT+DqITZZtZsG88fuvY/qM0BI4nq11cUh1w6Iswr9OIvUJibeCAc2gZO1+RiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419230; c=relaxed/simple;
	bh=TmszLVj5iUvpcleJUy57ZyoHPz759+MbiVMNdUK/0Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ahltmd259FYpSNW9JjxprhoQ6xBK2Otg156jMKfR+LH/f9nRtMpKJe2CPbzaqECMU70CTeHE7Mk+PsVdRkxpn1fyiTo0+79AEU0YwJkjiTtSZypWquRsFjUw+1IKKE558S180YY4B8ZnwAbNfgEBVV6pu2mHKbKrGkKMXiz1Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3GzBSDk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3GzBSDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA2C4CEEB;
	Wed, 28 May 2025 08:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748419229;
	bh=TmszLVj5iUvpcleJUy57ZyoHPz759+MbiVMNdUK/0Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i3GzBSDkMqQqxwqNiCJROS5Skhr4W5gJf2J7xHjASkor7ATp0BJaY8OLa1sME71lA
	 Q04/wnFCpgLVOEkL6+06NrPrkA0zy1IR9hdLWcclSQwoV8sblSzARRVogeOH6uBM85
	 azcO7CJR32BftuPPfenfolAWI6EFBOZbEVe3VOvNphzDDMJOFiD8k2Dz4piedsvRPb
	 2Ycp4/UEUYwgXKDZiuCpJW7HO2zu1hPBMuP491d5UPBkRADC+uXanHfUWWGipytd+6
	 TnkzQMN+txu0qT1KORT/Uq08LbBgBIc34C1ryCIaYjO9YC8KTEPxRH46y0E7sAXGB9
	 O02xtsnzbrZ4Q==
Message-ID: <56bcea70-6180-443b-8c9b-f5d2a129c73f@kernel.org>
Date: Wed, 28 May 2025 10:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-omap: convert text based binding
 to json schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/05/2025 19:05, Charan Pedumuru wrote:
> Convert TI OMAP SDHCI Controller binding to YAML format.
> Changes during Conversion:
> - Add patternProperties for pinctrl-<n>.
> - Define new properties like "ti,hwmods", "ti,needs-special-reset"
>   "ti,needs-special-hs-handling", "cap-mmc-dual-data-rate"
>   and "pbias-supply".

Why? commit should answer this.

> - Remove "ti,hwmods", "pinctrl-names" and "pinctrl-<n>"

Why? You just added ti,hwmods, so how can you remove it from required?

>   from required as they are not necessary for all DTS files.
> - Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
>   "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
>  .../devicetree/bindings/mmc/sdhci-omap.yaml        | 155 +++++++++++++++++++++


Filename: ti,omap-sdhci.yaml or one of the compatibles (or anything else
following convention that it should match compatible).


"ti,needs-special-hs-handling" is already documented in other binding


>  2 files changed, 155 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> deleted file mode 100644
> index f91e341e6b36c410275e6f993dd08400be3fc1f8..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -* TI OMAP SDHCI Controller


...


> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e707837bc242b055bbc497ed893a91c9b24f2dde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-omap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI OMAP SDHCI Controller
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>

This is supposed to be someone caring about this device. Eventually
platform maintainer.

> +
> +description:
> +  For UHS devices which require tuning, the device tree should have a
> +  cpu_thermal node which maps to the appropriate thermal zone. This
> +  is used to get the temperature of the zone during tuning.
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap2430-sdhci
> +      - ti,omap3-sdhci
> +      - ti,omap4-sdhci
> +      - ti,omap5-sdhci
> +      - ti,dra7-sdhci
> +      - ti,k2g-sdhci
> +      - ti,am335-sdhci
> +      - ti,am437-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  pinctrl-names:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    minItems: 1
> +    maxItems: 19
> +    items:
> +      enum:
> +        - default
> +        - default-rev11
> +        - hs
> +        - sdr12
> +        - sdr12-rev11
> +        - sdr25
> +        - sdr25-rev11
> +        - sdr50
> +        - ddr50-rev11
> +        - sdr104-rev11
> +        - ddr50
> +        - sdr104
> +        - ddr_1_8v-rev11
> +        - ddr_1_8v
> +        - ddr_3_3v
> +        - hs-rev11
> +        - hs200_1_8v-rev11
> +        - hs200_1_8v
> +        - sleep
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  ti,hwmods:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      This field is used to fetch the information such as
> +      address range, irq lines, dma lines, interconnect, PRCM register,
> +      clock domain, input clocks associated with MMC.
> +    pattern: "^mmc[0-9]+$"
> +
> +  ti,needs-special-reset:

I don't understand why you added this. There is no user of it.

> +    description:
> +      It indicates that a specific soft reset sequence is required for
> +      certain Texas Instruments devices, particularly those with
> +      HSMMC (High-Speed MultiMediaCard) controllers.
> +    type: boolean
> +
> +  ti,needs-special-hs-handling:

I don't understand why you added this. There is no user of it.


> +    description:
> +      It's presence in an MMC controller's DT node signals to the Linux kernel's
> +      omap_hsmmc driver that this particular IP block requires special software
> +      handling or workarounds to correctly manage High-Speed (HS) modes like
> +      SDR25, SDR50, SDR104, DDR50.
> +    type: boolean
> +
> +  pbias-supply:
> +    description:
> +      It is used to specify the voltage regulator that provides the bias
> +      voltage for certain analog or I/O pads.
> +
> +  cap-mmc-dual-data-rate:
> +    description:
> +      A characteristic or capability associated with MultiMediaCard (MMC)
> +      interfaces, specifically indicating that the MMC controller
> +      supports Dual Data Rate (DDR) mode

Drop the property. We have standard properties for this and there is no
ABI for it anyway.

> +    type: boolean
> +
> +  ti,non-removable:
> +    description:
> +      It indicates that a component is not meant to be easily removed or
> +      replaced by the user, such as an embedded battery or a non-removable
> +      storage slot like eMMC.
> +    type: boolean
> +    deprecated: true
> +
> +  vmmmc-supply:
> +    description:
> +      It is used to specify the power supply (regulator) for the MMC/SD card's
> +      main operating voltage (VCC/VDD).
> +
> +  clock-frequency:

Why is it here? Nothing in commit msg explained adding it.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      It is used to specify the frequency of a clock in Hertz (Hz). It's a
> +      fundamental property for communicating hardware clocking information from
> +      the Device Tree to the Linux kernel.

Redundant description. It is not a fundamental property. It is a legacy
property.

> +
> +patternProperties:
> +  "^pinctrl-[0-9]+$":
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandles to pinctrl states. The numeric suffix determines the
> +      state index corresponding to entries in the pinctrl-names array.
> +    minItems: 1

Why exactly do you need these?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
Best regards,
Krzysztof
