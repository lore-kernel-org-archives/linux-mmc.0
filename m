Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB042BCF51;
	Wed,  2 Jul 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466202; cv=none; b=L9PJFsRgczzLMrR9aR/2RnFfyIrDyr4s1gDfknh3sGrUGsSgpe6VHQkJz2034572ZuV1On0skUM5EpWUZcLroHN7Eq+vZNj2ZDtxAb4j9iTpkGSU4ljNJuSRtleNPCnPHMySmiNklkcGw4OONRytzrwK72HEqj1qEl3QXwR/IcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466202; c=relaxed/simple;
	bh=5xTRH5PYEaVJDARbqaeq3IhfaSjFqnrZPJsVGBRmnt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNRBMu7B6bI0XxgwGRcxT5fZvElA1KsrWizTVDuQSRSVIhxgvWz/bSqdOMgvZmTjPO0Thq77AuVXNw9JEEc3Kg7i5sY5vSR0P0CI/02oaj0pNJk6dVU7kOxeYb/BkAuHKk1jfRWchZR0AWG72gX7T5W6l6qlsJrXHpwHXXugOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pArD1O/U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pArD1O/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58D3C4CEE7;
	Wed,  2 Jul 2025 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751466202;
	bh=5xTRH5PYEaVJDARbqaeq3IhfaSjFqnrZPJsVGBRmnt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pArD1O/UwmfYrZAe86RreErEXF52+qIoEnoLQU+hhAnMWuOcAdFOjloPWrEtrBCQp
	 zZFb4YLZgiZ0Vq61POcF7jZO5M6NOYR09ft1QIklWZ2Lt9V/ArhZvehN6kUlEkmG/e
	 FqQPia48H7N82vy/1DxdNXZxxWYBRHLtT+ugmfLObCSkX4GNgdFEtI2goRT+d33D1Y
	 s+DZwh25hMpiMJLY4JkPC2tolt/w8gZ70iPpusFawKxfxyMYk+tIUeLwla7k/0LmiH
	 1OQnMwqguOdfdJ2pJ12fatyR0PxKX6u06jUN493EpHj0sFho/EPhpN/tdLK8SpZlaD
	 xmlA1VGo+dBag==
Date: Wed, 2 Jul 2025 09:23:21 -0500
From: Rob Herring <robh@kernel.org>
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: krzk+dt@kernel.org, krzk@kernel.org, conor+dt@kernel.org,
	gordon.ge@bst.ai, catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com, will@kernel.org,
	ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
	soc@lists.linux.dev, bst-upstream@bstai.top,
	neil.armstrong@linaro.org, jonathan.cameron@huawei.com,
	bigfoot@classfun.cn, kever.yang@rock-chips.com, mani@kernel.org,
	geert+renesas@glider.be, andersson@kernel.org, nm@ti.com,
	nfraprado@collabora.com, quic_tdas@quicinc.com, ebiggers@google.com,
	victor.shih@genesyslogic.com.tw, shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: add binding for BST DWCMSHC
 SDHCI controller
Message-ID: <20250702142321.GA1462423-robh@kernel.org>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-5-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702094444.3523973-5-yangzh0906@thundersoft.com>

On Wed, Jul 02, 2025 at 05:44:40PM +0800, Albert Yang wrote:
> Add device tree binding documentation for the Black Sesame Technologies
> (BST) DWCMSHC SDHCI controller.
> 
> This binding describes the required and optional properties for the
> bst,dwcmshc-sdhci compatible controller, including register layout,
> interrupts, bus width, clock configuration, and other controller-specific
> features.
> 
> ---
> Changes for v2:
> - Simplified description, removed redundant paragraphs
> - Updated $schema to reference mmc-specific scheme
> - Corrected compatible to add soc name
> (bst,c1200-dwcmshc-sdhci)
> - Removed all redundant property descriptions
> - Dropped invalid mmc_crm_base/size properties, use reg for all address
> ranges
> - Cleaned up required properties to only essential entries
> - Standardized example DTS format, fixed reg syntax and property
> ordering
> - Removed additionalProperties: true
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
>  .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> new file mode 100644
> index 000000000000..699dc404caac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> @@ -0,0 +1,67 @@
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
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: bst,c1200-dwcmshc-sdhci
> +
> +  reg:
> +    maxItems: 2
> +    description: |
> +      Register base addresses and sizes for the SDHCI controller.
> +      First entry is the core SDHCI registers, second entry is the
> +      CRM registers.

items:
  - description: Core SDHCI registers
  - description: CRM registers

Though what CRM is should be defined.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +  memory-region:
> +    maxItems: 1
> +
> +  dma-coherent: true
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
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mmc@22200000 {
> +        compatible = "bst,c1200-dwcmshc-sdhci";
> +        reg = <0x0 0x22200000 0x0 0x1000>,
> +              <0x0 0x23006000 0x0 0x1000>;
> +        interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk_mmc>;
> +        clock-names = "core";
> +        memory-region = <&mmc0_reserved>;
> +        max-frequency = <200000000>;
> +        bus-width = <8>;
> +        non-removable;
> +        dma-coherent;
> +        status = "disabled";

Examples should be enabled. Drop.

> +    };
> -- 
> 2.25.1
> 
