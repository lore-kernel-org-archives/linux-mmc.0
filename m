Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D882C7E;
	Wed,  4 Sep 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429632; cv=none; b=d3ucxSW7CYTgyCemlXYT9zEn1HnNgkNsVmmxkYxZstxJHte2ihIjtHTmdplm6nV0bB12YLWcH5xgSP6x61OTWTO+/5t6IYGBEPtGGZkbezINNRR/xkd9X3sFR+s9++xKg7DkQx5x94RD73+j3YI6nDY4pQfI0UcDwb9mlFHBcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429632; c=relaxed/simple;
	bh=80nMPbKKCymfqe/JoqK6bu0T+/Yfek+Xn+fKFYHtb40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duMizqb6u8V6+ktYoNaTzmEGGykFwl92N2zZlNqvc0K1CwN9eN6uR5siY0ctSe+RVW3BlcGQUbckOHpQ/3lKm3l6ceOZDLwA5ZERbZ+Pbj/jISutbYvf/Spt/5Xg0wEI4yy020mx0pEAnJdhQjIzzsGpw9vWRYXVMehFxbrg9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4844CC4CEC2;
	Wed,  4 Sep 2024 06:00:30 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:00:27 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
Message-ID: <ag7hzh4crzuqkvborkqz4elastaodaq6e63xbssztfgoz5dhka@6bsjq3v37u54>
References: <20240903145615.9302-1-detlev.casanova@collabora.com>
 <20240903145615.9302-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903145615.9302-2-detlev.casanova@collabora.com>

On Tue, Sep 03, 2024 at 10:51:36AM -0400, Detlev Casanova wrote:
> The device is compatible with rk3588, so add an entry for the 2
> compatibles together.
> 
> The rk3576 device has a power-domain that needs to be on for the eMMC to
> be used. Add it as a requirement.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

NAK

Drop fake tag. It is impossible to receive a review-tag from me on THE
FIRST version.  I almost never provide reviews out of mailing lists.

And since there is no changelog here and no versioning, this obviously
is not v2 or v3.

> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 80d50178d2e3..84a667f0c526 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -12,14 +12,18 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - rockchip,rk3568-dwcmshc
> -      - rockchip,rk3588-dwcmshc
> -      - snps,dwcmshc-sdhci
> -      - sophgo,cv1800b-dwcmshc
> -      - sophgo,sg2002-dwcmshc
> -      - sophgo,sg2042-dwcmshc
> -      - thead,th1520-dwcmshc
> +    oneOf:
> +      - items:
> +          - const: rockchip,rk3576-dwcmshc
> +          - const: rockchip,rk3588-dwcmshc
> +      - enum:
> +          - rockchip,rk3568-dwcmshc
> +          - rockchip,rk3588-dwcmshc
> +          - snps,dwcmshc-sdhci
> +          - sophgo,cv1800b-dwcmshc
> +          - sophgo,sg2002-dwcmshc
> +          - sophgo,sg2042-dwcmshc
> +          - thead,th1520-dwcmshc
>  
>    reg:
>      maxItems: 1
> @@ -35,6 +39,9 @@ properties:
>      minItems: 1
>      maxItems: 5
>  
> +  power-domains:
> +    maxItems: 1
> +
>    resets:
>      maxItems: 5
>  
> @@ -97,6 +104,17 @@ allOf:
>              - const: block
>              - const: timer
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3576-dwcmshc
> +
> +    then:
> +      properties:
> +        power-domains:
> +          minItems: 1

Why minItems? This does not look right. I don't get what you are trying
to say here.

Best regards,
Krzysztof

