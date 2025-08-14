Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14983280CD3;
	Thu, 14 Aug 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161432; cv=none; b=QfU+vnyzSpPfDSXpzO7CdxAJqCzdOVsWtrNQqHGBOr4mBZpGCMIZja2QZj9Rsol0iJvuwEAOiRAkc9b+YCFTOq5fM+TkzD6eYgZgOYDkN2r8aWqEHA+aQ956hp8dJJ4E6m5ZE/KzEixphgFZ+uqxEebcMrXMbhQGHsSmfGBTjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161432; c=relaxed/simple;
	bh=zBBMpjxchhWiyBvmzjN70hDruHm4DDlsdqIjn1UqLmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE9jCQHsURK6YSl1KUxTXMqRVCGbjnNlhkdHAvTb41Y0bQjOSPSt9kl2/EKM+z42yJMzEEQbkTEhIT8aAP8JiQYlPOgi361Q3mGRPli23HO/7XRNgSKTH6hlbJc+kQmI1D+jm8fOPb9ATyrAVzQNQi4FxZONOL1GUkZ/yxUuqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnE9x6U1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnE9x6U1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4CDC4CEED;
	Thu, 14 Aug 2025 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161431;
	bh=zBBMpjxchhWiyBvmzjN70hDruHm4DDlsdqIjn1UqLmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnE9x6U1d7F/Z3sEtqC8/X2KEujCLsIqKoaqSJCeVAKH8Z0X15DjpNdHuI8eHAYzP
	 cMfsgKb+HtuMYLFyFwElj1VcH6HtkxSTovxwpsB0biJocVMgewveKV2yN41GSkbnSS
	 nhEabxtcrAXMXz0XTsxCe2DxAo2JGJrlYNJRWksfT+MOFVempws+56All8eRxNI4uT
	 FkgIwTwCXSkl/eraHB0chEg2NyQ+/Rr3xyPNs1K5Scqllgh70KvJJhUDqWGufIdDu5
	 JNhnnEgwygPMK6amDXdkU0xJ3b5ts+R19c2lEr2t9lsq719B6H4GkfDd/sM9CrZXUc
	 xR+WNqd77frCQ==
Date: Thu, 14 Aug 2025 10:50:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Albert Yang <yangzh0906@thundersoft.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	ulf.hansson@linaro.org, catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	adrian.hunter@intel.com, robin.murphy@arm.com, ding.wang@bst.ai, gordon.ge@bst.ai, 
	bst-upstream@bstai.top, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org, soc@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: mmc: add binding for BST DWCMSHC
 SDHCI controller
Message-ID: <20250814-first-camouflaged-worm-51ee57@kuoka>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
 <20250812123110.2090460-5-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812123110.2090460-5-yangzh0906@thundersoft.com>

On Tue, Aug 12, 2025 at 08:31:06PM +0800, Albert Yang wrote:
> Add device tree binding documentation for the Black Sesame Technologies
> (BST) DWCMSHC SDHCI controller.
> 
> This binding describes the required and optional properties for the
> bst,c1200-dwcmshc-sdhci compatible controller, including register layout,
> interrupts, bus width, clock configuration, and other controller-specific
> features.

Please drop this paragraph, it's completely redundant. You should
rather describe the hardware.

> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
> Changes for v3:
> - Switch reg schema from maxItems to explicit items with per-entry
> descriptions
> - Improve example: add irq.h include and wrap under a bus node with
> address/size cells
> - Drop status = "disabled" from example; keep example concise
> - Add Signed-off-by: Ge Gordon
> 
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
> ---
>  .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> new file mode 100644
> index 000000000000..aa72ce60259f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
> @@ -0,0 +1,70 @@
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

You want sdhci-common.yaml instead.

> +
> +properties:
> +  compatible:
> +    const: bst,c1200-dwcmshc-sdhci

Keep just one name, so bst,c1200-dwcmshc (sdhci is redundant, right? Do
you have more than one dwcmshc?)

> +
> +  reg:
> +    items:
> +      - description: Core SDHCI registers
> +      - description: CRM registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

Best regards,
Krzysztof

