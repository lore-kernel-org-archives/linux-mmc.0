Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E03101D4;
	Fri,  6 Mar 2026 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760072; cv=none; b=cMJDFmtKGz9ePx1w01zWdXtBmgSqmSluSrPlHA238wMuzpnq/G7v3Ch7CqRbpMh9yPGyaZe6mzTqptBr/3YidhlvNEndwEl96b4eX8HzFaKueW66N5AdsA5Tb5OPHfFaYsej6Vpw90CsCLhgADk+MhCu34mTmklkKdfFC29sPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760072; c=relaxed/simple;
	bh=qK1Pb6PRMN/5EDxvXqpnSPidQtcYgcosLSdYEdyfatM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Fn0hMqjgoFipWkhKEcxJJuotMUOaLoFMWxhUGaBd3tMOZ28nZ/dPs640kCzBD63UGujvIpeQinSMgpR9GxOd+Ohhzt07XNhdxCDlIvmxn1KsKIAOxBDH7jxPDaOK1na/4/engiUqkMVJ4rXmjEIYwrtoPx6RJyALshn8nghfIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVyGZAvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVyGZAvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324DC116C6;
	Fri,  6 Mar 2026 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772760072;
	bh=qK1Pb6PRMN/5EDxvXqpnSPidQtcYgcosLSdYEdyfatM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KVyGZAvLUG+NSKuzln4XZyGN8vBdTQZCO+wfrI72GYmPmuT59ZhGLpwL2675wNms9
	 t0eVBagXnb2DSWMQDLH5eflZgku70KfBUkjUWw+YCWdC6d0FKRgV2zWhgRkCwicupb
	 Z9VpW3lZZXj6Yd5iOpnc4B/iL8okqwFpmkEZv/MEYVJ3BD2cYcew5e8CBA5GSFZ7r/
	 WpodTtVWnu7GVfsCcSSwysVZx5KcY5Um8kY7gnHb4/QfRSTbuypExZbbIBd6gQyeAS
	 vJl7qct/qLdcKP5bQH3JRSIBbLuPoSPM4EA+67xPuZU2lXstWAPiKL93SoaaGqVxE7
	 t0V+Z2wcXt4VQ==
Date: Thu, 05 Mar 2026 19:21:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, 
 linux-arm-kernel@lists.infradead.org, rjui@broadcom.com, 
 conor+dt@kernel.org, krzk+dt@kernel.org, sbranden@broadcom.com, 
 linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
 devicetree@vger.kernel.org, nsaenz@kernel.org, linux-kernel@vger.kernel.org
To: Lee Yongjun <jun85566@gmail.com>
In-Reply-To: <20260305234703.38490-1-jun85566@gmail.com>
References: <20260305234703.38490-1-jun85566@gmail.com>
Message-Id: <177276007097.977010.11624734015908520209.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: allow dma-coherent
 property


On Fri, 06 Mar 2026 08:47:03 +0900, Lee Yongjun wrote:
> The Broadcom iProc SDHCI controller supports DMA, but its binding
> schema does not allow the 'dma-coherent' property.
> 
> As a result, dtbs_check reports the following validation errors
> on the Northstar2 SoC:
> 
>   mmc@66420000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>   are not allowed ('dma-coherent' was unexpected)
>   mmc@66430000 (brcm,sdhci-iproc-cygnus): Unevaluated properties
>   are not allowed ('dma-coherent' was unexpected)
> 
> Allow the 'dma-coherent' property in the schema to fix the validation
> errors and accurately reflect the hardware capability.
> 
> Signed-off-by: Lee Yongjun <jun85566@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml:46:3: [error] duplication of key "dma-coherent" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml:46:3: found duplicate key "dma-coherent" with value "True" (original value: "True")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.example.dts'
Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml:46:3: found duplicate key "dma-coherent" with value "True" (original value: "True")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1605: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260305234703.38490-1-jun85566@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

