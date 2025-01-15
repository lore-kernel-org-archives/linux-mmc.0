Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F623F264;
	Wed, 15 Jan 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931080; cv=none; b=hUgA1HVa1yFMy55EySnSflPfp/yAToFKBO3wxK4fAVFTeXFcLQb/IaaVVszfxkxVMJ3PPEEZIxsCkcR8PUaZQucBW24gGDoywOt1ye1qUYjhz6p6EjDJalUPTBDNJg2j6y3ki3M54h3jIP9PGWtCct6eQGrM4XZiUHldORERgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931080; c=relaxed/simple;
	bh=GwlvPNaPX/8qtQSzF5HZ0CbwmzU3891kv5TaAZRdsyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKFsoxWpMBPhyZvDnyhiXnx8m80tGwMVkaobojs9U2uwlQu7QyUKieHOcUBfoQwI//Y2S7sNfW4pzJJ8fNDRyKiTVtLfjxJBNoYk76H4iG5sH45yyhUDeKebZkQjc177gzHQ0qbMUI2F/CrMij6UM5ly9sIpA4mfv/E3P5K8do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH0sF1vk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH0sF1vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6126AC4CEDF;
	Wed, 15 Jan 2025 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736931080;
	bh=GwlvPNaPX/8qtQSzF5HZ0CbwmzU3891kv5TaAZRdsyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rH0sF1vkNx1L3XZR86dN2P0tkIbKx0cq7/VFJWk1hqRrbs+P5kaJmWPQBophzb7t7
	 JNV2Xt3UDsKJ5zkok7ejBI4wME6Bjv2433J6mKbuyYrjv8TV4rcc3TwwR5GLWdICl3
	 QQb0j9PWDphGTXNEwnQ1/ljAToRflqx+4YzOobwDC71fMcYPx0Uc92lcGE7cMHfO7f
	 YKfm+Y3HaMlyIFtPXDJ5flLcG+hEXEz0ZHhgRfRjX8eC3Y5XywINkbjslgncWwFfMs
	 07q81fNT7UrDUBb9jWtPaID6nOIahSdAoe92BDmxVHjCf6jBVuV1rUiwJdoPGSS6QA
	 OkcQ8ZtKBiCpQ==
Date: Wed, 15 Jan 2025 09:51:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581
Message-ID: <phnwf7vkincyeua3jhboi5pod7uwkigwc2ibpygrg7gezeh36d@gpx6krsqfbqe>
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115073026.31552-1-ansuelsmth@gmail.com>

On Wed, Jan 15, 2025 at 08:29:50AM +0100, Christian Marangi wrote:
> Document eMMC compatible for AN7581. This eMMC controller doesn't have
> regulator exposed to the system and have a single clock only for source
> clock and only default pintctrl.
> 
> Rework the schema to permit these new requirements and make supply
> optional only for airoha,an7581-mmc compatible.
> 
> Also provide an example for airoha,an7581-mmc.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> This depends on patch merged in clk-next 
> bfe257f9780d8f77045a7da6ec959ee0659d2f98
> 
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 64 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index f86ebd81f5a5..6dad5455b369 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -27,6 +27,7 @@ properties:
>            - mediatek,mt8183-mmc
>            - mediatek,mt8196-mmc
>            - mediatek,mt8516-mmc
> +          - airoha,an7581-mmc

Please keep things ordered. The list is nicely ordered so far.

>        - items:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
> @@ -48,11 +49,11 @@ properties:
>    clocks:
>      description:
>        Should contain phandle for the clock feeding the MMC controller.
> -    minItems: 2
> +    minItems: 1
>      maxItems: 7
>  
>    clock-names:
> -    minItems: 2
> +    minItems: 1
>      maxItems: 7
>  
>    interrupts:
> @@ -72,7 +73,7 @@ properties:
>        Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
>        will be switched between GPIO mode and SDIO DAT1 mode, state_eint is mandatory in this
>        scenario.
> -    minItems: 2
> +    minItems: 1
>      items:
>        - const: default
>        - const: state_uhs
> @@ -170,9 +171,6 @@ required:
>    - clock-names
>    - pinctrl-names
>    - pinctrl-0
> -  - pinctrl-1
> -  - vmmc-supply
> -  - vqmmc-supply
>  
>  allOf:
>    - $ref: mmc-controller.yaml#
> @@ -335,6 +333,40 @@ allOf:
>              - const: axi_cg
>              - const: ahb_cg
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: airoha,an7581-mmc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: source clock
> +
> +        clock-names:
> +          items:
> +            - const: source
> +
> +        pinctrl-names:
> +          items:
> +            - const: default
> +    else:

No else, you are now duplicating other "if:then" cases. There is already
such for "reg" so it does not really make it more readable. Just be sure
each variant has a strict, upper and lower, constraints.


> +      properties:
> +        clocks:
> +          minItems: 2
> +
> +        clock-names:
> +          minItems: 2
> +
> +        pinctrl-names:
> +          minItems: 2
> +
> +      required:
> +        - pinctrl-1
> +        - vmmc-supply
> +        - vqmmc-supply

These should go to each variant's if:then: or separate if:then: covering
all existing variants for the required fields.

> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -389,5 +421,25 @@ examples:
>          vqmmc-supply = <&mt6397_vgp3_reg>;
>          mmc-pwrseq = <&wifi_pwrseq>;
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    mmc@1fa0e000 {
> +        compatible = "airoha,an7581-mmc";
> +        reg = <0x1fa0e000 0x1000>,
> +              <0x1fa0c000 0x60>;
> +        clocks = <&scuclk EN7581_CLK_EMMC>;
> +        clock-names = "source";
> +        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&mmc_pins>;
> +        bus-width = <4>;
> +        max-frequency = <52000000>;
> +        disable-wp;
> +        cap-mmc-highspeed;
> +        non-removable;
> +

Drop blank line.


Best regards,
Krzysztof

