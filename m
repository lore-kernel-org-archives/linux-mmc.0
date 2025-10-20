Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B12FBDEA;
	Mon, 20 Oct 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960118; cv=none; b=HIYGJyiN4s0ximsQ6NhPRfpaXUdbJEFUQCuR7CzmaH0rVTeqppOvB2eTJhCbGh3asFeV7/9MjIQOA0D2Q1c+JbNRdSwG/LckaPux5lK8Urrylcjblfn8p0cXTQ6hLOtIiobJgMlZE6XkNz/FkEmATBEWL8+KkKOTYDyOVK30P9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960118; c=relaxed/simple;
	bh=OmRJtAyMH/0v9J8nQVCQldqM14idOu50BxcbfyNn8Ao=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=thWJcSP6WZhPkkQ5wW1CVg1CgMe97gHZuoTmsavbSxo/Q48LDGhgYkd2rx6927FgC/iWnI/YWCZZL9ynIeGGEd9JC2n/4RvkZh4j8iM1luxZJnDq+xdisUR0+J6gyhsaR4xOcFSGkk3EvDJfxnnuYUGim2xLqMRASuA4vRNWprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6cikYH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6cikYH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C2AC113D0;
	Mon, 20 Oct 2025 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760960118;
	bh=OmRJtAyMH/0v9J8nQVCQldqM14idOu50BxcbfyNn8Ao=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=c6cikYH1j4WBJmp6eixwxUNQtSo6XoJQrg1LezBGOlR2gVnQvhEdenSHnmI0GUBW7
	 Dr+Zx7wprfUbE4a1BTixv7sjxluTHJylHv7UPkHMkpsfdI5UBFJGYmlh6Wc805XukK
	 sSxThg2W4YJZSwADSykkaHGjqc4q1RP9dYLPhIbTfxIUryNXe5GImhqlNCuh/v4S+W
	 HaptJA3RJCktxzSNdgwS5Pu41Jx8xbVkBa9eKGa7XF9+Z9G6GDGj5bC56vRots3kHn
	 yYRy5TfU0sDVfAUZQ0h8dI5xchC2ZznwGJi8vPlZcF6w/VYfjf1O7dOPkZ04kM3dEi
	 YE1Ew2eVCXsIA==
Date: Mon, 20 Oct 2025 06:35:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linmin@eswincomputing.com, ulf.hansson@linaro.org, 
 lizhi2@eswincomputing.com, devicetree@vger.kernel.org, 
 pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com, 
 jszhang@kernel.org, linux-mmc@vger.kernel.org, 
 zhangsenchuan@eswincomputing.com, conor+dt@kernel.org, 
 p.zabel@pengutronix.de, caohang@eswincomputing.com, 
 dongxuyang@eswincomputing.com, luyulin@eswincomputing.com, 
 ningyu@eswincomputing.com, Conor Dooley <conor.dooley@microchip.com>, 
 adrian.hunter@intel.com, linux-kernel@vger.kernel.org, 
 xuxiang@eswincomputing.com, krzk+dt@kernel.org
To: hehuan1@eswincomputing.com
In-Reply-To: <20251019115238.320-1-hehuan1@eswincomputing.com>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115238.320-1-hehuan1@eswincomputing.com>
Message-Id: <176096011380.22917.1988679321096076522.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700


On Sun, 19 Oct 2025 19:52:38 +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/eswin,eic7700-eth.example.dtb: ethernet@50400000 (eswin,eic7700-qos-eth): eswin,hsp-sp-csr: [[4294967295, 256], [264, 280]] is too short
	from schema $id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/eswin,eic7700-eth.example.dtb: ethernet@50400000 (eswin,eic7700-qos-eth): Unevaluated properties are not allowed ('eswin,hsp-sp-csr' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251019115238.320-1-hehuan1@eswincomputing.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

