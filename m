Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5F243946;
	Fri, 16 May 2025 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401135; cv=none; b=d+iNuHA33UESa23bWTqBTrUTN7QmrWXHfdl+3YKCZlvCFAqivBvn332LLjU6EJxoQS1PLRCaWLj/DbDw+WkRBH0y0dlZu8dbeHg5XyA1/AT9fVAx0Z/RPzvuYes8airpTeBPdN+Z0+pjTWcKbuzN7RZxl7692q7qtR8ZEmAjyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401135; c=relaxed/simple;
	bh=LIxhz0Ikkb6uhXfsYATNN0zoJH5c6DUtaKMEfAc+aBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDAcH/2FHlHwwzb6uTWYUPew8Z/7QiwPABich0Q1c+Go0agsrZiMiMvl/Z1w0xW/UvBtPBh+q7WmRV0WSC0z36M/B2ZXHTxBSPi0fDuwhtLcG+z68RENEg24w3OfCUfw5wlGBgxQ89EzyifII4x02AShYzJN4xJOv5CQGm5FAxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPDrwwwv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPDrwwwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F614C4CEF4;
	Fri, 16 May 2025 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401135;
	bh=LIxhz0Ikkb6uhXfsYATNN0zoJH5c6DUtaKMEfAc+aBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vPDrwwwvQ2xDcxDXAL8gNsaOcLAvIqyIE1CtyizfeMQCuNT0TZdcbI6vhnQvTvroQ
	 cr1PtUfweGB9rPToytDxG7ZxJNAEyy3xnOF/JxQrs/BfvZNVwSAe3cVmrudQlTw3Y7
	 YxTJk99uj3ZyE0fQ4NK7jk/5jNfItWApA+iC5fgU/U9lNzT9L4mwTW/jEMzrNihOkB
	 ednVZsTF11dT1ttteIgBdwIEu+Kz0A7fgHQdPKXVfHVadUF2b9RGTVoIvXbqh28e18
	 cw4ZL4GwbsDvpdhecizHs2wM8I2k8eOwZ5sBqRqjk2OFYbnh7D4WTB9CSlHHCZSRyK
	 0lw9OFm5y53ww==
Message-ID: <f13fe182-b5e5-4938-8260-24f8f60e8f83@kernel.org>
Date: Fri, 16 May 2025 15:12:10 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: sdhci: eswin: Documentation for
 eic7700 SoC
To: dongxuyang@eswincomputing.com, ulf.hansson@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, shanchun1218@gmail.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 xuxiang@eswincomputing.com
References: <20250516091259.774-1-dongxuyang@eswincomputing.com>
 <20250516091650.832-1-dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250516091650.832-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 11:16, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add device tree binding documentation for the ESWIN
> eic7700 sdhci controller module.
> 
> Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---


Folks,you need to slow down because you are sending patchsets with the
same issues, thus we need to repeat the same review comments. Learn from
the review first.

>  .../bindings/mmc/eswin,sdhci-eic7700.yaml     | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml b/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
> new file mode 100644
> index 000000000000..d4826f2aa619
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/eswin,sdhci-eic7700.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/eswin,sdhci-eic7700.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESWIN EIC7700 SoC SDHCI controller
> +
> +maintainers:
> +  - Shuang Liang <liangshuang@eswincomputing.com>
> +  - Xuyang Dong <dongxuyang@eswincomputing.com>
> +
> +allOf:
> +  - $ref: /schemas/mmc/mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-emmc-sdhci
> +
> +  reg:
> +    maxItems: 1
> +    description: Common configuration registers

Blank line, drop description

> +  "#address-cells":
> +    const: 1

Blank line

> +  "#size-cells":
> +    const: 1

This is wrong.

Why do you need these properties?  You are duplicating (and wrongly) MMC
schema.


> +
> +  interrupts:
> +    maxItems: 1
> +
> +  assigned-clocks:
> +    maxItems: 1
> +    description: should contain "core_clk" phandle + clock-specifier pairs.
> +
> +  assigned-clock-rates:
> +    maxItems: 1

Drop both properties. Do you see this anywhere in the bindings?

> +
> +  clocks:
> +    minItems: 2

No list items instead.

> +    description: handles to clock for the sdhci controller.

Drop description

> +
> +  clock-names:
> +    minItems: 2
> +    description: the name of each clock.

No, list items instead. Do you see any bindings written like that?

> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    enum: [0]
> +    description:
> +      With this property in place we will export one clock
> +      representing the Card Clock. These clocks are expected to be
> +      consumed by our PHY.
> +
> +  resets:
> +    description: resets to be used by the controller.

Missing constraints. Drop description, useless.

> +
> +  reset-names:
> +    description: names of the resets listed in resets property in the same order.

Drop property

> +
> +  bus-width:
> +    enum: [4, 8]
> +    description: for emmc bus-width is 8, for sdio bus-width is 4.

Why do you need it? Look at other bindings.

> +
> +  eswin,hsp_sp_csr:

Look at DTS coding style first. What characters are allowed in properties?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: hsp_sp_csr regs to be used by the controller.

For what purpose?

> +    items:
> +      - description: phandle to HSP_SP_CSR register block
> +      - description: status register offset
> +      - description: control register offset
> +      - description: configuration register offset
> +
> +  eswin,syscrg_csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: syscrg_csr regs to be used by the controller.

For what purpose?


> +    items:
> +      - description: phandle to SYS_CRG_CSR register block
> +      - description: status register offset
> +      - description: control register offset
> +      - description: configuration register offset
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - assigned-clocks
> +  - assigned-clock-rates
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +  - resets
> +  - reset-names
> +  - bus-width
> +  - eswin,hsp_sp_csr
> +  - eswin,syscrg_csr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line

> +    sdhci_emmc: mmc@50450000 {

Drop label

> +      compatible = "eswin,eic7700-emmc-sdhci";
> +      reg = <0x50450000 0x10000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <79>;
> +      clocks = <&clock 554>, <&clock 546>;
> +      clock-names = "clk_xin", "clk_ahb";
> +      assigned-clocks = <&clock 554>;
> +      assigned-clock-rates = <200000000>;
> +      clock-output-names = "emmc_cardclock";
> +      #clock-cells = <0>;
> +
> +      resets = <&reset 7 (1 << 6)>,
> +        <&reset 7 (1 << 3)>,
> +        <&reset 7 (1 << 19)>,
> +        <&reset 7 (1 << 23)>;
> +      reset-names = "txrx_rst", "phy_rst", "prstn", "arstn";
> +
> +      core-clk-reg = <0x51828160>;
> +      disable-cqe-dcmd;
> +      bus-width = <8>;
> +      non-removable;
> +      mmc-hs400-1_8v;
> +      max-frequency = <200000000>;
> +      eswin,hsp_sp_csr = <&hsp_sp_csr 0x1038 0x508 0x50c>;
> +      eswin,syscrg_csr = <&sys_crg 0x160 0x148 0x14c>;
> +      status = "disabled";

No, drop.


Best regards,
Krzysztof
