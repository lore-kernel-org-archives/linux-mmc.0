Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33313B7A3;
	Tue, 24 Sep 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209807; cv=none; b=luIWqg4QHN3srjhkCM9gqVM/fXA0Z92RPmgT3N/xD7+QtFziBYG/lePGuy9LJoQiemaG4z7tIwkft42guR4x81dm5+Te+16FxGJOPRYFIqIUwI444NJTIflawq4xW7IcYBzyya6+2Qd/5vaJXcG1eOA/Izoh0uAv85/H5JpUu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209807; c=relaxed/simple;
	bh=2u0zeg+dHBdxKoMgMF1vko+I8IQky5fnMmQgoOzaaEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhvoET2Z/SySwLrKp+7Xx/QyWDrnsJtiThjdGWJ6aqzsdkH5ylAhAWR9Fmex+dW+UJCHrr2Eba6wc7lYT1TxcmtdaA7sKgFryAH/ASgUMpZ8FffgEJ2aOaLRJTGTF3GLBcdvrvNHynlF3yvVSLjCs+WnQiLylSDwnjEfOchLFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhrdvOit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhrdvOit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008CAC4CEC4;
	Tue, 24 Sep 2024 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209807;
	bh=2u0zeg+dHBdxKoMgMF1vko+I8IQky5fnMmQgoOzaaEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhrdvOitcuBAEovMd5FLA8/jNrjkcFLI6ze/m/bUC+tgG1KdEOhNsqUbVrgWyWRem
	 PFR4c463Nem9cI8uj1VUlAYthS3VUcAY2MqSZpq1l7qiBkhBz2Mcc4EKrvcUifzqO8
	 Nj3HxXWnueDWNP4zELMGFPx8t7Tu/iJyPEw+sA6numO+MzZnhOSbCM6ZdD/WXgtxXH
	 P3Hpzz+a1Bv3EWJ/YA/xQUpl1TDifK24yCj/nRsEuEVpPlcbvE/La1M/DEVkTURKDX
	 ApGFPJMJi07DIbVulX7ef4eqKrP4xMarslXJVmneuCAwcEtQQDmO4vn7W57YoJnFXR
	 JES2/7uISerRQ==
Date: Tue, 24 Sep 2024 15:30:06 -0500
From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: document mmc-slot
Message-ID: <20240924203006.GA283611-robh@kernel.org>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>

On Fri, Sep 20, 2024 at 10:38:04AM +0200, Neil Armstrong wrote:
> Document the mmc-slot, which is a subnode of a multi-slot
> MMC controlle, each slot is represented as a full MMC controller,
> the top node handling all the shared resources and slot mux.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/mmc/mmc-slot.yaml          | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> new file mode 100644
> index 000000000000..c30eda4fd2a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-slot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC/SD/SDIO slot of a multi-slot controller
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +properties:
> +  compatible:
> +    const: mmc-slot
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc-controller {

mmc {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      slot@0 {
> +        compatible = "mmc-slot";
> +        reg = <0>;
> +        bus-width = <4>;
> +      };
> +    };
> +
> +...
> 
> -- 
> 2.34.1
> 
