Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B263DEFFC;
	Tue, 24 Mar 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345747; cv=none; b=cAFjmWoB2mtqnMCnrDgXrZ+wO9fN81CmddRdv8CKLHvZZIW+cm2BD7Yu8c/jieeSLkfGCCOxf64IA5Z9BzFrCYX+IFdiRGZ3WAOXU5+WCZXTLTt3ij+kqMd+co53W8SeDcVte90PZnzs2fDxYK8v+nrYnrqQMllvMcnN8zLfjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345747; c=relaxed/simple;
	bh=wqBVHdCXtWzfBnU2Ip9rh+UgFZGNkji1nlFJ5xyqp6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmtrVwPkL1voWQbn+wQ0qLGboza3A37rmA2bvERztjDL5MhV52y+ywwDxfGRtnisLmbygM4epqMW5UfYY5UX8NINTfet1WbfZ5iyLlbOeBYu2GI0S9R9jZFcSpLHvHh5G4ahHiXZMHxYvAkfKW335Qxh2c8E67VAAVwk9EeZdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ3xBzO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ3xBzO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37586C2BCB7;
	Tue, 24 Mar 2026 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345746;
	bh=wqBVHdCXtWzfBnU2Ip9rh+UgFZGNkji1nlFJ5xyqp6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZ3xBzO4RfhCj2+KM1Ojven0alrz99P7lAYDHHM+aaqhVdzUf/TMKLgSkZ96/Bkfg
	 K+MVON3vcyFQDag1xm52Loqc9+FLjmtFxhPp7MhY4mfkZShIkMwhgvYNENBqYfDYen
	 v8dE6CB5T3hOaaDlDVSqnhpkCToYk0KSR1LAf48uzRRuHJPB3SNLkclK/FgyU+K46S
	 MVQBF/ykK1EXaXyTR+8EQ0/YrQ9sHZm18+4tgcch6e5Geo3p1LtrRTa7qlo/0HB/US
	 mGJKyOETQAkrea2EzA/khYHF9W8ZSxBKDzpdPpvcsxMAPWAE2C5BxzFavBCMUJ4jRj
	 rW8kI3Ztct5NQ==
Date: Tue, 24 Mar 2026 10:49:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	xuwei5@hisilicon.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	ulf.hansson@linaro.org, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert
 to DT schema
Message-ID: <20260324-wild-knowing-ant-ce3c2c@quoll>
References: <20260323194400.22886-1-rougueprince47@gmail.com>
 <20260323194400.22886-2-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323194400.22886-2-rougueprince47@gmail.com>

On Tue, Mar 24, 2026 at 01:13:59AM +0530, Bhargav Joshi wrote:
> Convert the Hisilicon DesignWare Mobile Storage Host Controller
> (dw-mshc) bindings from text format to DT schema.
> 
> As part of this conversion, the binding file is renamed from
> k3-dw-mshc.txt to hisilicon,hi3660-dw-mshc.yaml to align with compatible
> string naming conventions.

Old Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt binding
was saying clocks are biu+ciu, you have here reversed, so this needs
explanation in commit msg why (to match existing in-kernel DTS).

> 
> Examples have been updated to pass schema validation.
> 
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> ---
>  .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 111 ++++++++++++++++++
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 ------------
>  2 files changed, 111 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
> new file mode 100644
> index 000000000000..6ba1a42a27ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/hisilicon,hi3660-dw-mshc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Hisilicon specific extensions to the Synopsys Designware Mobile Storage Host Controller
> +
> +maintainers:
> +  - Zhangfei Gao <zhangfei.gao@linaro.org>
> +
> +description:
> +  The Synopsys designware mobile storage host controller is used to interface
> +  a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +  differences between the core Synopsys dw mshc controller properties described
> +  by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
> +  extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +allOf:
> +  - $ref: /schemas/mmc/synopsys-dw-mshc-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: hisilicon,hi3660-dw-mshc

This and last two entries should be one enum here.

> +      - items:
> +          - const: hisilicon,hi3670-dw-mshc
> +          - const: hisilicon,hi3660-dw-mshc
> +      - const: hisilicon,hi4511-dw-mshc
> +      - const: hisilicon,hi6220-dw-mshc

Blank line

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: card interface unit clock
> +      - description: bus interface unit clock
> +
> +  clock-names:
> +    items:
> +      - const: ciu
> +      - const: biu
> +
> +  hisilicon,peripheral-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of syscon used to control peripheral.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3620-clock.h>
> +
> +    mmc@fcd03000 {
> +        compatible = "hisilicon,hi4511-dw-mshc";
> +        reg = <0xfcd03000 0x1000>;
> +        interrupts = <0 16 4>;

Use proper flags (GIC, trigger level).

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
> +        clock-names = "ciu", "biu";
> +        vmmc-supply = <&ldo12>;
> +        fifo-depth = <0x100>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
> +        bus-width = <4>;
> +        disable-wp;
> +        cd-gpios = <&gpio10 3 0>;

Same here

> +        cap-mmc-highspeed;
> +        cap-sd-highspeed;
> +    };
> +
> +  - |
> +    #include <dt-bindings/clock/hi6220-clock.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      mmc@f723e000 {
> +          compatible = "hisilicon,hi6220-dw-mshc";

"reg" goes here

> +          bus-width = <0x4>;

That's not hex

> +          disable-wp;
> +          cap-sd-highspeed;
> +          sd-uhs-sdr12;
> +          sd-uhs-sdr25;
> +          card-detect-delay = <200>;
> +          hisilicon,peripheral-syscon = <&ao_ctrl>;
> +          reg = <0x0 0xf723e000 0x0 0x1000>;
> +          interrupts = <0x0 0x49 0x4>;

These are not supposed to be hex...


> +          clocks = <&clock_sys HI6220_MMC1_CIUCLK>,
> +                   <&clock_sys HI6220_MMC1_CLK>;
> +          clock-names = "ciu", "biu";
> +          cd-gpios = <&gpio1 0 1>;
> +          pinctrl-names = "default", "idle";
> +          pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
> +          pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
> +          vqmmc-supply = <&ldo7>;
> +          vmmc-supply = <&ldo10>;
> +      };

Best regards,
Krzysztof

