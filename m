Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF551DE2B5;
	Mon,  7 Oct 2024 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331106; cv=none; b=YHi6GQqUhH8/xXXJeiA0uawKqh1+H0Dhq2KB4XZACkFM3vGIMmnijkxsDhH5cSyrOysJkvzKHhkj+SI6F4JJwR4oS6at/zdcENvq89f3wTGR15owcy4IXMGS/1dSgHt+cpXRTd+8dsU3bplMU7VI+IlRSTvRC2Mq0OaehMctCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331106; c=relaxed/simple;
	bh=jwOtX6r++WHZfnmg4IDHl8MDobeXzZie00SaaYI+nvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqUR693hl+mvlpsq+knT/4b1mc1gCxbrmXAn2pk8UG+L18Sg2urJmDyiGG/kSkfgnOEWFLQrop7nTRrbS222WrFMshPr4mftq//jjmSNtXCdq4xB9N7xV8XkQWAd3XCFkBgUzMjqazQm7iRd2rwnjvcASOebo3YlwZcOknU3vNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFHd2I5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFHd2I5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B81C4CEC6;
	Mon,  7 Oct 2024 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331105;
	bh=jwOtX6r++WHZfnmg4IDHl8MDobeXzZie00SaaYI+nvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFHd2I5v9oyhBk6X701IKJE9K2+pCm8O3PXbH7/KPCARtxeQvkd0kN43TGsmA2TVM
	 f2f9brH2ct0GI3bFc38XjWgIUn07Y9X24IXVQmSqtcLCo3FZ13ZCHp2envrM1C9Y6b
	 JbPk6QehjXs6FwnjWrA63o5XoDSf0hM+NwZATILeBpMB9DGccNd2V8xZ+rQoZ1U8ps
	 i7guyJfpR5InQeQv3t0kb4gaCH9it+pwOGoQ6EGsxQqc6/ON29zp53hro5JuEkWesh
	 Y3mmu0e80D7RYagj7mlB6/+2mAAq7xQyhUZQT4WhxBhx8eARZTeqSbptzt9yVwcly3
	 7p88L6cHQKkmQ==
Date: Mon, 7 Oct 2024 14:58:25 -0500
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
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
Message-ID: <20241007195825.GA2296490-robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>

On Mon, Oct 07, 2024 at 04:03:37PM +0200, Neil Armstrong wrote:
> Move the common MMC "slot" properties because they are shared by the
> single-slot or multi-slot controllers, and will help defining a simple
> mmc-slot bindings document with proper slot properties and nodename.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
>  2 files changed, 360 insertions(+), 341 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> new file mode 100644
> index 000000000000..e02d3cbcc271
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> @@ -0,0 +1,357 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC Controller & Slots Common Properties
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |

Don't need '|'.

> +  These properties are common to multiple MMC host controllers and the
> +  possible slots or ports for multi-slot controllers.
> +
> +properties:
> +  "#address-cells":
> +    const: 1
> +    description: |

Ditto.

> +      The cell is the slot ID if a function subnode is used.
