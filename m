Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5B158D96;
	Mon, 16 Sep 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508432; cv=none; b=QaEyDdJaYVfyJDqeGqv54GQ+0muWxKJWFSA4T6DDVN75FSQn+OgiOizgXXNmpgoTTn8wTK+yHU04a2q8mIlyq5gdCcascC+uDbg5DkHwF5FLdotAeABJp3qUYy61Xl0IQTk9mDAO8urNDhhN5I3y3xi0ItFnBJudfxW3MyZoyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508432; c=relaxed/simple;
	bh=qOgVuJKaEdKj21DVkkp/lMIeO9oIy+tidNV376TfMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7o8UoR4N0fXBOSjCYZk678h1xkzDfNlmaeVNuMvK8BLpkd7CnKmHtbK2/psF84YqhbVZWjgHOt9mps3zQ8osXB3CuHBp18vCnYwiui2zjxbO83HMfl9FidP7XkiBpT+Bv0GScTaUtwmczLXklLnabfxd109ECPUNPkHaKC94cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxFxdFFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxFxdFFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F01C4CEC4;
	Mon, 16 Sep 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726508431;
	bh=qOgVuJKaEdKj21DVkkp/lMIeO9oIy+tidNV376TfMx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxFxdFFrkp7w2Ip+VoLobiA5mjW/El/K+T8Cg69DeU1O/h4EqKiZATUK+bi4u3oql
	 uPjde9odYPv3iu8d0LGmJtLLhu9fqrqODW3DgzHurU+ncBIs6dX+svoDMHvL6TNydh
	 /BX59JkIb4mUsQH1j+DGNtFXP2jzWTH3loVq97lYFcI550cxvH1P+6Y/lzDOSFtnS1
	 wvh/yrvUfWUV235kuQ1ZMdVOJqeSyR8cc2VduVFRuri8chqFbyQuC2iDjfBkB6MJFP
	 GOyVzF5G1Gqebo0XF6bTDL3GVii3kLnKGqZt8vPTEGQOpCeXY1SO3fxfUcwex2BRqo
	 dTsnNWfTt0tYQ==
Date: Mon, 16 Sep 2024 12:40:30 -0500
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to
 dtschema
Message-ID: <20240916174030.GA835203-robh@kernel.org>
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>

On Wed, Sep 11, 2024 at 05:20:47PM +0200, Neil Armstrong wrote:
> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 -----------
>  .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 101 +++++++++++++++++++++
>  2 files changed, 101 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
> deleted file mode 100644
> index 8765c605e6bc..000000000000
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> -
> -The highspeed MMC host controller on Amlogic SoCs provides an interface
> -for MMC, SD, SDIO and SDHC types of memory cards.
> -
> -Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> -as the speed of SD standard 2.0.
> -
> -The hardware provides an internal "mux" which allows up to three slots
> -to be controlled. Only one slot can be accessed at a time.
> -
> -Required properties:
> - - compatible : must be one of
> -	- "amlogic,meson8-sdio"
> -	- "amlogic,meson8b-sdio"
> -	along with the generic "amlogic,meson-mx-sdio"
> - - reg : mmc controller base registers
> - - interrupts : mmc controller interrupt
> - - #address-cells : must be 1
> - - size-cells : must be 0
> - - clocks : phandle to clock providers
> - - clock-names : must contain "core" and "clkin"
> -
> -Required child nodes:
> -A node for each slot provided by the MMC controller is required.
> -NOTE: due to a driver limitation currently only one slot (= child node)
> -      is supported!
> -
> -Required properties on each child node (= slot):
> - - compatible : must be "mmc-slot" (see mmc.txt within this directory)
> - - reg : the slot (or "port") ID
> -
> -Optional properties on each child node (= slot):
> - - bus-width : must be 1 or 4 (8-bit bus is not supported)
> - - for cd and all other additional generic mmc parameters
> -   please refer to mmc.txt within this directory
> -
> -Examples:
> -	mmc@c1108c20 {
> -		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
> -		reg = <0xc1108c20 0x20>;
> -		interrupts = <0 28 1>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
> -		clock-names = "core", "clkin";
> -
> -		slot@1 {
> -			compatible = "mmc-slot";
> -			reg = <1>;
> -
> -			bus-width = <4>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> new file mode 100644
> index 000000000000..4d1142d2ff02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> +
> +description:
> +  The highspeed MMC host controller on Amlogic SoCs provides an interface
> +  for MMC, SD, SDIO and SDHC types of memory cards.
> +  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> +  as the speed of SD standard 2.0.
> +  The hardware provides an internal "mux" which allows up to three slots
> +  to be controlled. Only one slot can be accessed at a time.

You need '|' or this is treated as 1 paragraph. If it is 1 paragraph, 
then format it that way.

But really if you want 3 paragraphs, then you should use '>' and put 2 
CR's between each paragraph.

> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amlogic,meson8-sdio
> +          - amlogic,meson8b-sdio
> +      - const: amlogic,meson-mx-sdio
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: clkin
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +
> +patternProperties:
> +  "slot@[a-f0-9]+$":

Are you going to add 'slot' to nodename in mmc-controller.yaml?

> +    $ref: mmc-controller.yaml#
> +    description:
> +      A node for each slot provided by the MMC controller

blank line

> +    properties:
> +      compatible:
> +        const: mmc-slot

This is also used by the Cavium controller. Should be common.

> +
> +      reg:
> +        description:
> +          the slot (or "port") ID
> +        maxItems: 1

Aren't there limits in the number of slots the h/w can support?

> +
> +      bus-width:
> +        enum: [1, 4]
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@c1108c20 {
> +        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
> +        reg = <0xc1108c20 0x20>;
> +        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clk_core>, <&clk_in>;
> +        clock-names = "core", "clkin";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        slot@1 {
> +            compatible = "mmc-slot";
> +            reg = <1>;
> +            bus-width = <4>;
> +        };
> +    };
> 
> ---
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-6fa70546ebb8
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 
