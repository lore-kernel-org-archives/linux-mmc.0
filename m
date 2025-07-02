Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1B28A414;
	Wed,  2 Jul 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462913; cv=none; b=pQ69UfWvro346TXjR5EGQz3paV14BXnHxc323dOnulJ0r3FLA3xedgXHt1IrKB1kvh1a3F/E9OqCvLY2Z0TwEaXjkD7rfq/q/IwVGwk+pRWfGjGsukccu8YpTRSlFPF51DmoWRMFDPbW5rtbwpDPqU4jyR9mrk4r7CRB6rP6KB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462913; c=relaxed/simple;
	bh=HOh/U2jjhpt3b0ncodfdVaIpcAFRoWXCxIDJv1aaaiY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KAtmtvR7J4VVo3+RhTwVB2EL7sVfcjHqIS0Z8b0EN8eYvLg1ttdPQ0soOcEBg7oPSn0uY4hmKSxz5F9HYacA2cqrSFUEaRJfHAO8iQUOemB0W7RTBIU0LkfGDpOw/dQkJQnOCxdnSEqUiuEA4Oa1E9Rd32arS7Ml1SlUEMyNQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuYpeq2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuYpeq2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7ABC4CEED;
	Wed,  2 Jul 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462911;
	bh=HOh/U2jjhpt3b0ncodfdVaIpcAFRoWXCxIDJv1aaaiY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LuYpeq2pMsJv1WcpV1kQwxOWzJ41FmhhGElleCfZJTuIQ6v71aiH6MLEgPD7jZmv2
	 icusDw3bfy60Vao5HfzKmYAfVFWbfX2hqVWFLteRbrusoovpXK9RVbxwl2d7Ulx8iC
	 rfVnqpcoB1OeWeGkkPKbnnw0pmuPQjIqH1hdaqN1V5xJukVK7NiTpWq35yULr02st+
	 Elmb8VxP8b3Mgd7qrd+SacBs8b8diuSllXk8bW6aRa04F2MAqLkd25rtVh+TccLVLY
	 s09Y4M3qMaN8j+rHxlnXNIZHOOXDNG+pIpF9g48N2dOIyEumKTofjoQ50AxVF7m0Ks
	 BcEKnaoqf8oow==
Date: Wed, 02 Jul 2025 08:28:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: andersson@kernel.org, krzk@kernel.org, victor.shih@genesyslogic.com.tw, 
 will@kernel.org, quic_tdas@quicinc.com, nfraprado@collabora.com, 
 mani@kernel.org, ebiggers@google.com, geert+renesas@glider.be, 
 geert.uytterhoeven@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
 shanchun1218@gmail.com, nm@ti.com, arnd@arndb.de, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 jonathan.cameron@huawei.com, bigfoot@classfun.cn, catalin.marinas@arm.com, 
 linux-kernel@vger.kernel.org, soc@lists.linux.dev, gordon.ge@bst.ai, 
 kever.yang@rock-chips.com, ben.chuang@genesyslogic.com.tw, 
 bst-upstream@bstai.top, ulf.hansson@linaro.org, neil.armstrong@linaro.org, 
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com
To: Albert Yang <yangzh0906@thundersoft.com>
In-Reply-To: <20250702094444.3523973-5-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-5-yangzh0906@thundersoft.com>
Message-Id: <175146290763.1131398.8272632937196214694.robh@kernel.org>
Subject: Re: [PATCH v2 4/8] dt-bindings: mmc: add binding for BST DWCMSHC
 SDHCI controller


On Wed, 02 Jul 2025 17:44:40 +0800, Albert Yang wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.example.dtb: mmc@22200000 (bst,c1200-dwcmshc-sdhci): reg: [[0, 572522496], [0, 4096], [0, 587227136], [0, 4096]] is too long
	from schema $id: http://devicetree.org/schemas/mmc/bst,dwcmshc-sdhci.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250702094444.3523973-5-yangzh0906@thundersoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

