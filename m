Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A42ECE86;
	Tue, 23 Sep 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622392; cv=none; b=rDI1j/LyDfGnfJWaqeuiTGA7ud4DeoP29Qw9Y6pZIZjODIDZx7sRFHDu28dBp61Ds6vardaEdC5uxub02DsF5XjeJl/rGMZKskYkWqx2chG1ErTKcZfnds+BYmnkiF/mfWHVQidBRrJRvdiCVrVMOgW0GTibC9q4YXYGjmp67Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622392; c=relaxed/simple;
	bh=BjUWFq46ZQch4IkuXbiRNszqG0RdslZ/OPhCHkN14Lc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=R7jf/dqb63mbmXHUidpv9mIbi9OxaElFESiFputtgmtxnjvWy4NnxcOqHxSF8dvvrUFZtpEpIgfK1I8XlhszHRl/MdXFL27QjaE/1C2aUUwylB0b+rzzyConRaFKpP/Aq2NBxfgN7cgcDdvb1KxvQ9U/noWfILR2IyfUWOPdW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2Va0reb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2Va0reb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497BDC4CEF5;
	Tue, 23 Sep 2025 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758622391;
	bh=BjUWFq46ZQch4IkuXbiRNszqG0RdslZ/OPhCHkN14Lc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=W2Va0rebdl5VOUh8BSEVgc2XMpiX5BCGIvk8cttUs23XsscvQkEa7wQURtFWH48rb
	 oZOfapa7klZKEc3A7sBlzLRVllO1o1wZevL4jsnV7fQYI7ZlpF53j6EhwPHRKUYlkA
	 12bLDtG6BWZ7BbfahTHwodhCU4pjZfX3DQkBk/2C59xRqH0tpjPq085DTwMx6jaqIH
	 ymptmCC34ZUYCIx72v3AMazfD2RVwvFcpdQM/xmvnVV3Am7UGM5S2oczliaUcMM2ui
	 oYmvqbS0Vzqz8aH4g/h7IrgR1SlhgWbqCD375ZGGLuB5kFZwxDQweK1vHVFAR/7fUO
	 5GzpSXX8w5z1A==
Date: Tue, 23 Sep 2025 05:13:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Ge Gordon <gordon.ge@bst.ai>, Adrian Hunter <adrian.hunter@intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, soc@lists.linux.dev, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mmc@vger.kernel.org, 
 Catalin Marinas <catalin.marinas@arm.com>
To: Albert Yang <yangzh0906@thundersoft.com>
In-Reply-To: <20250923-v4-patch-final-v1-4-2283ad7cbf88@thundersoft.com>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
 <20250923-v4-patch-final-v1-4-2283ad7cbf88@thundersoft.com>
Message-Id: <175862238966.2427901.366123788055800395.robh@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: mmc: add binding for BST DWCMSHC
 SDHCI controller


On Tue, 23 Sep 2025 14:10:10 +0800, Albert Yang wrote:
> Add device tree binding documentation for the Black Sesame Technologies
> (BST) DWCMSHC SDHCI controller.
> 
> This binding describes the required and optional properties for the
> bst,c1200-dwcmshc-sdhci compatible controller, including register layout,
> interrupts, bus width, clock configuration, and other controller-specific
> features.
> 
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> 
> ---
> Changes for v4:
> - Remove Signed-off-by line for Ge Gordon
> - Change `$ref: mmc-controller.yaml#` to `$ref: sdhci-common.yaml#`
> - Change compatible string from `bst,c1200-dwcmshc-sdhci` to `bst,c1200-sdhci`
> 
> Changes for v3:
> - Switch reg schema from maxItems to explicit items with per-entry descriptions
> - Improve example: add irq.h include and wrap under a bus node with address/size cells
> - Drop status = "disabled" from example; keep example concise
> - Add Signed-off-by: Ge Gordon
> 
> Changes for v2:
> - Simplify description, remove redundant paragraphs
> - Update $schema to reference mmc-specific scheme
> - Correct compatible to add soc name (bst,c1200-dwcmshc-sdhci)
> - Remove all redundant property descriptions
> - Drop invalid mmc_crm_base/size properties, use reg for all address ranges
> - Clean up required properties to only essential entries
> - Standardize example DTS format, fix reg syntax and property ordering
> - Remove additionalProperties: true
> ---
>  .../devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.example.dtb: /example-0/bus/mmc@22200000: failed to match any schema with compatible: ['bst,c1200-dwcmshc-sdhci']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250923-v4-patch-final-v1-4-2283ad7cbf88@thundersoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

