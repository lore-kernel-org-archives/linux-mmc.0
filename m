Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC91E132D;
	Wed,  9 Oct 2024 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503353; cv=none; b=dIdUjEI6AuwyTc2JAP7m5G460C4BJEUsJFow+WWqlEsLGoBP8Mbx/tQc/fiVSVPUElg5mitdyHUl25/tbwNDZpOUqY6Ffr+okqM26bhtEFLGFjsPDAS0j4CuxZmw1hqkCq2AxLjv5iV2fxrhAhlz9OkKfgUD5L31YvK5L9SLWJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503353; c=relaxed/simple;
	bh=C1NpSIwyabYuPOgSxRtFpJJ+JGk1iE4Uf4o/+dftn4U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UU9dE0HkQo0rTshEV4OOpc2JG0zVx+Fp1IPkbS97na5/lDzKSk0S55vOugtVrQwOJMPDFtD20e5Lav+NaMwBpKa8ZUrVCSkqEemntRQTItDwCXyX/YpOBuq8jNWWl3b62o+CTnoydCdOWNKe8yY2IFkd82oFB8cyzuxLlqITcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUco/PJ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUco/PJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A52BC4CEC3;
	Wed,  9 Oct 2024 19:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728503352;
	bh=C1NpSIwyabYuPOgSxRtFpJJ+JGk1iE4Uf4o/+dftn4U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iUco/PJ0EvyCK95r884GLz5452WgNbDLEaiZHE338NnjcNkuXgb00c/5wIRO7/0zZ
	 0xMTbCI7amCfzMPcCeXtHvOOM+cv3zdp6gh0SBSHWGwRKElVMXxAQW6iVBR17eqOG9
	 rXwuDk4Ec0K5r4rXWm1prPtrq+UVVFpCBRVSjo4BzwKjKuPsm16jDI7RVYzzz/qUUs
	 iCK8BgheyblKxeDpsB03mszQ2JACq0u6FA9VhwCyi2/bIXbvKuXyDn4qNTTgU9wGlJ
	 u7VjwRCr55RbbouFol1rJTNJZnUtS+HWXAN7V4Kf01s9jPV2o6OnskggJtSFV9Zzg6
	 Llj4/phkn6ZLg==
Date: Wed, 09 Oct 2024 14:49:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: linux-arm-kernel@lists.infradead.org, eladwf@gmail.com, 
 daniel@makrotopia.org, ansuelsmth@gmail.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, john@phrozen.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mmc@vger.kernel.org, 
 Chaotian Jing <chaotian.jing@mediatek.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
In-Reply-To: <20241009165547.5959-2-linux@fw-web.de>
References: <20241009165547.5959-1-linux@fw-web.de>
 <20241009165547.5959-2-linux@fw-web.de>
Message-Id: <172850335071.570182.9793183065235967586.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC


On Wed, 09 Oct 2024 18:55:41 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add binding definitions for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - fixed minItems on clock-names too
> v2:
> - fixed minItems to 4
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: allOf:5:then:properties:clocks: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'source clock'}, {'description': 'HCLK which used for host'}, {'description': 'Advanced eXtensible Interface'}, {'description': 'Advanced High-performance Bus clock'}] is too long
	[{'description': 'source clock'}, {'description': 'HCLK which used for host'}, {'description': 'Advanced eXtensible Interface'}, {'description': 'Advanced High-performance Bus clock'}] is too short
	False schema does not allow 4
	1 was expected
	4 is greater than the maximum of 2
	4 is greater than the maximum of 3
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: allOf:5:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'source'}, {'const': 'hclk'}, {'const': 'axi_cg'}, {'const': 'ahb_cg'}] is too long
	[{'const': 'source'}, {'const': 'hclk'}, {'const': 'axi_cg'}, {'const': 'ahb_cg'}] is too short
	False schema does not allow 4
	1 was expected
	4 is greater than the maximum of 2
	4 is greater than the maximum of 3
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241009165547.5959-2-linux@fw-web.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

