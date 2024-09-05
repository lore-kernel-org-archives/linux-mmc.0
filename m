Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ACD18787B
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531545; cv=none; b=IM1uQ/7P98lmrJYlqL8ku2drwlnlRWjkAMpT4ZatdfKGsT3+KCfPtpqL4wOAV2eVZR6etIQxsutHz/iZRdc0T9D9C7pVTQwNEItedxsu6wMSl/6xaQyBL891sQLvi+7HiYIGKtOaZumKSpuTBNZDPPj9ywDg7G4N0rzbmSoOR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531545; c=relaxed/simple;
	bh=N5GZ6QaGpaG9BOOZe8Qz5x7aSLENpOxDadCaaNOcHSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHMtwbZJO3DaU5reY3lE8V9Sj6u+1n7jscZNh4AbyhGxRaP2pF+Ia+/c+Vg2WAgr0FhmjqVd8R0+OLXCu88mDBhGFqY2SqezHOQHrvWxuexjeyCO/zWY3Edo68qNg0XglbmjivJA6d89QmUZlXb4aaK2bfQKp1z4jioiCp0WB8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkQvnH6a; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkQvnH6a"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso658806276.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2024 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725531543; x=1726136343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbvNzEhcUc2/e6npSPa/SUaLRFH3LWeQVUSLoJZyzEA=;
        b=UkQvnH6aI8Ixws4yVjH6aPFhAfs2u57fNBIg4e7czby/ooCZeirQE1JOGCy5Jn5iw3
         MKcor4WraYEC7VygGMlgYaRlbF026Mw+CboIHN/1qaguwQTXNVDyFMo5/Yodl2TOrYlv
         FcUcJ8n+9/mTVhw7MtCUl4tqSLzAbrQkmSEyDsdFwal1eSKWCM5Py0xCeMMBicRYHXsS
         spo5T294LZVDsY5K8AAv4ZGVaA3SXGAamUgSXDzfVXNoJP/MDh/OUrp/10hhqnnbjebP
         kcMG6dH0KJSgC32E/2043dvCmWCw39eelSRe5BwMu+gBAcEAJ8fVP8Fm1vZPq9BT3KHy
         vGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531543; x=1726136343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbvNzEhcUc2/e6npSPa/SUaLRFH3LWeQVUSLoJZyzEA=;
        b=i8n2JmDVaego/s0KuB9XN8JG+tIXcRkJnfEfU4Ler9WaH6sPGpiGLE9GnDAQDGlju0
         qd5RComjfuguSSMgT9RT3am29pJy8weQezuDsSejjjSRXGjbseqDhbrdRPSpQkAFcNbh
         zE6e2GtgXWFBg9gE2+cdpvJ5QW5MmgWS2eBgQXGQc2IAJ7TmB+aIjAWD4RR/rEleJzD3
         1wN+Ovnr724uisS/emomu1CJ0mdioqxBvFi+pdkLl9gpm14WEDKJKqSVyXYCN8w0uov0
         Idkfv+tUJHMz1FBEtIig3ofKVADx3KICtgdIAc/tYcRhbaVowXhbpdcdsisT/Lmgo1Z6
         5iBw==
X-Forwarded-Encrypted: i=1; AJvYcCX66zL1Dv7cAJ8itj+2qkeZGhfRCzp5HlzBCJQKKy5TjihxuCAZA8sh798ZK0vNunPl77I11XgsmKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIKmO3kwfQJg00PTi8SBC+nEaA5Geh/OULX11ii7/k0IvbFGB
	WlhDFEiHM5duqpqT0PJpyF5qiNzOWc9bdLh9XgNAT3otPCACtrN4AqUrplKKo2ftaffxjWgxFpk
	WCYJsscNY+7ZoKXaG2tENaSpoXKEd+dOcMT+yaw==
X-Google-Smtp-Source: AGHT+IEfkmXdZbiQFZA2SCdDFNC5ZztKbmifchwoAz1t7Bhire9A/0dhUzANW4hoWsdcwjCWYY1qjZMm+Dtgf/DNne4=
X-Received: by 2002:a05:6902:2406:b0:e1a:b361:4d9b with SMTP id
 3f1490d57ef6-e1ab36153f7mr14748193276.24.1725531543111; Thu, 05 Sep 2024
 03:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904203154.253655-1-detlev.casanova@collabora.com> <20240904203154.253655-2-detlev.casanova@collabora.com>
In-Reply-To: <20240904203154.253655-2-detlev.casanova@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 12:18:26 +0200
Message-ID: <CAPDyKFp1iOUdp=pL_xpP0DNu24Z-wC5SYhwzNy5CcEkz3XWWyA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Sept 2024 at 22:32, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The device is compatible with rk3588, so add an entry for the 2
> compatibles together.
>
> The rk3576 device has a power-domain that needs to be on for the eMMC to
> be used. Add it as a requirement.
>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 37 +++++++++++++++----
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 80d50178d2e3..c3d5e0230af1 100644
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
> @@ -97,6 +104,20 @@ allOf:
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
> +      required:
> +        - power-domains
> +
> +    else:
> +      properties:
> +        power-domains: false
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.46.0
>
