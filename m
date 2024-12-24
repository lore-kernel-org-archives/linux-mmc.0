Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B5CA6B;
	Tue, 24 Dec 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048441; cv=none; b=AzvndNgE2PHu4+7S9EJ7QkUvmMgWg3gWM0+3iPn7tHreEc33zDyVm9egPNRSi1EHpYuRFJlL1AyV8G55co8rEo1JzPRC6Qb6KJ5yWzfJz/EQMnKsKXwaMVgRf9PX9fNezyTx4c/CmPLbWjaV5yJUGRfp6447rILmzO6mEFPKSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048441; c=relaxed/simple;
	bh=BDmqn2yg0LljaDjaUOqEaPKMjrMz9JxF1qpU4+qpxvA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=RPYao5COjZlvVuH8xD7kSguYJ2XJK72E5XHFyderDSAD/KrS4O7i62fAlLyIlniD88tfcl0jX4F8z2/p75Z7ithiXb0mbGrx0aELA+uIkTZexa4EBav7kHp8lGR04nmNHRju7tbu74hylHb7s04Fea1MLOK0x3KIhvpCu39MLR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8Spp0aF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8Spp0aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E5C4CED0;
	Tue, 24 Dec 2024 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735048440;
	bh=BDmqn2yg0LljaDjaUOqEaPKMjrMz9JxF1qpU4+qpxvA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=J8Spp0aFx420ef5Z5lKvAmfRAJeUW5yi09ehDwgO8ioa/7blWWlPmWmGjjeRdU5IO
	 ZtSaU03NOM3h82UDM6nD0aA1H1CRvg7UjxfXxGjaXesmU/V+JqbqMOdsmQmXAHze2w
	 ygBX+rHondbbLjWqSW23I0mJPKXhZmB3L+nWSQJUTZkWFKvgdBtWZ4Ff9HtcmUO99L
	 aLlm27G0fIGQJJL67NscCvk1f49fTTqWZvHfghjE7zlFvXX0em4aPErrjUeM2tof46
	 Bno85QYJEy69mVZhkloBZcJbxyOXF9cigOlTFDOvuFa+RqRegHH3nDMle9afTZpiZh
	 ZEngmtsuGeJHA==
Date: Tue, 24 Dec 2024 07:53:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, heiko@sntech.de, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-rockchip@lists.infradead.org, 
 Jisheng Zhang <jszhang@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241224094920.3821861-3-kever.yang@rock-chips.com>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-3-kever.yang@rock-chips.com>
Message-Id: <173504843871.166750.7360390752630982498.robh@kernel.org>
Subject: Re: [PATCH v2 02/17] dt-bindings: mmc: Add support for rk3562 eMMC


On Tue, 24 Dec 2024 17:49:05 +0800, Kever Yang wrote:
> rk3562 is using the same controller as rk3588.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml      | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.example.dtb: mmc@fe310000: compatible: 'oneOf' conditional failed, one must be fixed:
	['rockchip,rk3568-dwcmshc'] is too short
	'rockchip,rk3568-dwcmshc' is not one of ['snps,dwcmshc-sdhci', 'sophgo,cv1800b-dwcmshc', 'sophgo,sg2002-dwcmshc', 'sophgo,sg2042-dwcmshc', 'thead,th1520-dwcmshc']
	'rockchip,rk3568-dwcmshc' is not one of ['rockchip,rk3562-dwcmshc', 'rockchip,rk3576-dwcmshc']
	from schema $id: http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.example.dtb: mmc@fe310000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241224094920.3821861-3-kever.yang@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

