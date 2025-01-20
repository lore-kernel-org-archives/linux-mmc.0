Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD3155A52;
	Mon, 20 Jan 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404972; cv=none; b=jjMz6lUctokKgQyi2U6gBlIKQhe0aarikvw2G+HAOcSpqx+ZQVfKz2fjkF3IPnVctYxJr//x4L5lJSEg/kuKhyAErpNbEWz5H7QJnGZ+awNLgnypZWeikGnBFHV4+dDEQkjJfDVbTBpnlvvV9ormpTmJDbBXPsBbhFW9BxHgRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404972; c=relaxed/simple;
	bh=WDoCCA3w5eEl8wS9Gz8iLhDSYRHG+YTayG/JhkEBJGc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CRLbmYwVoJapKjsliRrK/+bQwPwvqQVgShQUlgX6Ila+gWWNecx4xkAVzGQcsM5MTINR/eUjlO8af9aD9Y07YqN31QmAsS46C7ZTHtoeDw9qjvUogQ2MQfu19SPjJTYrGsUTrvyB7niUokICw/YiEKnhMDZ4pXmpBbzA2iMZjh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv9KogGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv9KogGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D0CC4CEDD;
	Mon, 20 Jan 2025 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737404972;
	bh=WDoCCA3w5eEl8wS9Gz8iLhDSYRHG+YTayG/JhkEBJGc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bv9KogGjcVzMKThShlLVPH5bcRAthWi7voKuzUEu9kqWn7lLzjXhryTk0BqcA/Ez/
	 nq+4DHUN7cf1LExDN2+tfvEKmt+gaZUxSJpbfYFNKLrCi7R6EDWHzIFBa027H6Z84n
	 rSPXd191pPpIWvXVCME8S9xMY109URyY6+ie6X9jdkfXCPK8e3AEGAiZ8cna48xnYA
	 Gas3i4kt9YuhwZ3LZGUgfQDq0atH4FU3c+zdjvqSIphmXTAQor/z4A/kgx4QEdUpMP
	 6jsVGaxOLq880rmSRQ2geYQRYnRs9Uff7M1Pw58Cc2xgcz/Pwohs3QBofd1ippPaiA
	 zfI91BacpRp7Q==
Date: Mon, 20 Jan 2025 14:29:30 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 Chaotian Jing <chaotian.jing@mediatek.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 upstream@airoha.com, linux-arm-kernel@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250120184728.18325-1-ansuelsmth@gmail.com>
References: <20250120184728.18325-1-ansuelsmth@gmail.com>
Message-Id: <173740497060.601130.3509016769870545640.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581


On Mon, 20 Jan 2025 19:47:01 +0100, Christian Marangi wrote:
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
> Changes v2:
> - Drop else condition
> - Move Required and pinctrl property to dedicated if condition
> 
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 116 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mmc/mtk-sd.example.dts:104.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250120184728.18325-1-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

