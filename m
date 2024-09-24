Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC541552ED;
	Tue, 24 Sep 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169313; cv=none; b=D7eGDemPbY5Ek7+OES6/VyRWVujZSS17OfATn8quHi7xTRWNcJoLFgv21FtM/13rKw4HnPei+aJGASQrkkmofLJN6U/qzNQtuyuAmXsB8DHDQXB1yIKQcbyh/GVyFMD4DGLJCNgwV81tmBs2qnaN40Cab730R4PM4WfTiURlHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169313; c=relaxed/simple;
	bh=2KVuSiYdwxbydC/A7uEWSSCNb1LsPPeJVYNuNNT1jtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHWB83K2O400G7YNi9jQVsglAwn26Qq7SlRU4P64Xl+Mfsok10fPVq4aNr9BYr2PBGgDSy+FfXc/CaULBcTWtg33XSn8Tdgkyd7vMY22EK18aRDxvatjMdKH4sVlVicUR+jnCZBo/0EXjg7+Iq6U6YaXkBW70fx6IQtUsmTbs4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtkeOj0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtkeOj0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1575C4CEC4;
	Tue, 24 Sep 2024 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169313;
	bh=2KVuSiYdwxbydC/A7uEWSSCNb1LsPPeJVYNuNNT1jtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtkeOj0JCO59riq3o9U7q6HoDynCZ1sHI7fJLReBh3tlc1BFCSnjKd3DU2py+0Gdl
	 MJnTRjoRAPJdvcxv0U6KK7S63atk/TaGkYF4PClyYuDbWPBJcWp7EVpSQXsutDNMB8
	 mBLnYOQ3XZXMn+Rsr/TDCpSGmP0+wreQyaeKuWMjyHyP3JTiIyGaGHrEVAuUCpSRQe
	 Mekys1F9NomtKLjEFb3fenl3Agt40AD9Ettn/OjTuiL1IeFmHnbZGg7DB+GmOY/TgB
	 YeeQZB5ccTK4+Ee3UXz7TSKohcXZdX2lhAe9zmV7fTjVKlyWB47nEHu3riDwPaXy+w
	 MBrUwq7FEa1cQ==
Date: Tue, 24 Sep 2024 11:15:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: document mmc-slot
Message-ID: <5o2q5kmchnr3e4opmtp2xq3xqlzkq2hudecd5fszamoav4twhb@o3kcftkoxwzg>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-2-5aa8bdfe01af@linaro.org>

On Fri, Sep 20, 2024 at 10:38:04AM +0200, Neil Armstrong wrote:
> Document the mmc-slot, which is a subnode of a multi-slot
> MMC controlle, each slot is represented as a full MMC controller,

typo: controller

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

description here saying what is the MMC slot, e.g. what you wrote in
commit msg.

> +allOf:
> +  - $ref: mmc-controller.yaml
> +

Just to be sure - the slots do not have dedicated resources like clocks,
resets, power supplies, right? IOW, it is indeed one device which
exposes multiple controllers?

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

Best regards,
Krzysztof

