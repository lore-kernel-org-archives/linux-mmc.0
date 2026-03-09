Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50B6274B3B;
	Mon,  9 Mar 2026 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773095564; cv=none; b=AUyw+4x/83P9UTJpmqoAkphLDvtSXvLf+8r4FaIRSh24JUVaOx1R5N3R5M1odGyQ8Jr83GSEDynPFD6NpyaMQw6lV9lcqmxU8NF2ZTCVfGqfft1boJdR/WCXB/DpC1xQbbW7tmDQJ2Kg6Qe1tkS2LZIg8gLaXtEOp3V1u8QEW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773095564; c=relaxed/simple;
	bh=FaIoNEU8MA2+l6iUbU2Y8yJEW4wWlPByDkDUlBEYM0M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Xmv3/85aYAaJ40MLM8Wc7praDHrMeqv3y8F6+bHlh2hAKx3kG+OKWT0Ryzuetf3Hm6FVGm1I9gDTddy7aKUWLk/h+EZTeJ730T0stkiCOE1d5MBgVPASrwp/pJgLdt/gzCLPtUb49goMg6HzTN6OSUGCcHZM3pVOTBGzhEDh148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIrY7pMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIrY7pMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEDC4CEF7;
	Mon,  9 Mar 2026 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773095564;
	bh=FaIoNEU8MA2+l6iUbU2Y8yJEW4wWlPByDkDUlBEYM0M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vIrY7pMrC0o66sVYmUQMwPslxpNfGQDJf+UZESlUwOS/u0d+xhg/2Mfoa6+tXkDbj
	 O1QIlQfvTUgFfWtTB5hnfEOuw9YGxHkBmv7LsQk7Z49Vcy512YBRHEht0xwOcTJr9W
	 z0jVpYLSj2MWIEtFiQJdYiXzIV+QlNAAhdL9RxLOo9jS22T4aVloy9pnR6g7Zh93kK
	 Fx87fBogtrj8YQjv4+i9EulcSI4RUF8HgWaJVNlR7uUy1FeJcKdXuElojvRDv3u/3b
	 bZhBYBlMbGJaraWxRIdGDkM0M06MHN//nH7jhLTNl9maSyvTN++HEc0+BGF4IMnyj3
	 k27VeYui5868w==
Date: Mon, 09 Mar 2026 17:32:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, jszhang@kernel.org, 
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, 
 krzk+dt@kernel.org, linux-kernel@vger.kernel.org, conor+dt@kernel.org
To: nick.hawkins@hpe.com
In-Reply-To: <20260309211333.977919-2-nick.hawkins@hpe.com>
References: <20260309211333.977919-1-nick.hawkins@hpe.com>
 <20260309211333.977919-2-nick.hawkins@hpe.com>
Message-Id: <177309556326.2409403.9578800888648270072.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE
 GSC dwcmshc compatible


On Mon, 09 Mar 2026 16:13:32 -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
> Cortex-A53) BMC SoC eMMC controller.
> 
> The HPE GSC requires access to the MSHCCS register in the SoC system
> register block to configure SCG sync disable (bit 18) for HS200 RX
> delay-line phase selection.  The existing 'hpe,gxp-sysreg' syscon
> phandle is required for this compatible to access MSHCCS via regmap.
> 
> The HPE GSC eMMC interface only exposes a single 'core' clock (no
> bus clock), so clocks/clock-names are constrained to maxItems: 1.
> 
> Add an example node with the hpe,gxp-sysreg syscon reference.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml: allOf:1:then:properties:clock-names: {'maxItems': 1, 'items': [{'const': 'core'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml: allOf:1:then:properties:clocks: {'maxItems': 1, 'items': [{'description': 'core clock'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260309211333.977919-2-nick.hawkins@hpe.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

