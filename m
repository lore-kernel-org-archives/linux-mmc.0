Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A5241129
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778734; cv=none; b=O/1bTrh2kCz12q1ARnIh0CQyqwDLe0SSdkH6LHGULbw4bUkifnmiGUwiPLOMM4dBSOXnUtIxiRl4q5/f/lOo5qgRUEaNiCND08x+YomJ57GdM1mUij21C+6uqa7Ns3hxFNDB23+omNROoaInXwx+4TTbV8f0tME3QlN/5bJ246Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778734; c=relaxed/simple;
	bh=u09mix5wsyGZEee0OTLlbwtp/i5wIT9Jdm2M0t59Fs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buaDANcv0LQTLjW/EjOeCfM3qxApm6bVWw/FxLPS1KLr6FeKS7/yBT/TJoKZTXfBB5C5s4OA3DQn5JdMDETJqsZ8LKNPgRQf6HsCyGlImUBGBzfhuSMGmiuL86dixH9fVbkgxZTYaxPL9fMNSnnx3WbpE+RYk+M4O2fP+jaJBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGnJ2JUZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGnJ2JUZ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f6ca9a3425so64881487b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778732; x=1742383532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6/mrslkYIqtp2+mq8p2Qz5J6MxbjiXwBJqUTb8Ezm9o=;
        b=iGnJ2JUZrW2FGn1w6nR37KHuN7NGjmwSWyi7AJDrE9Qcd7cugwvA3uEYLKURXg1VRK
         BtMNQrdkfHUSiexHhD/qGXBlT7o05BYSvgZp1nQSnb2iKd32SncyaKMCBw18s9EeIZME
         oxG8GAwy8X1O+VN0gZhKH90rtqhVT/UKcOb70ANL2m3zXoMgNe37tRnWsFKXlUog1FyG
         s9bA/jPxa/FMobh4O0bDX8eYgMC9lPq5uKk+KgFvj4HiJbP4r0me9mGSW9NE/MHyMHf5
         czsEi/kKjYQbngMZd+ny+0igy5rtaTmODqlPfe1RHgl/YOCmpcpc5+jbQuEfp66dzFx1
         eG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778732; x=1742383532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/mrslkYIqtp2+mq8p2Qz5J6MxbjiXwBJqUTb8Ezm9o=;
        b=VqrRljV0np0tgVKAzm6RcCk2Gp2C06/jbg3s8JwJQ9S9xzFFzUb61kyMN/Mf8ch15F
         ZUVslWj+oVB/J0voogD1ajMTQmJT5f/sj5BAOFTL+3zIzV0js/ex75kBN78S6x4wwu4B
         u6Vp1qZdSaQ9JUn313MmDd05kQaVDHkxJ6YGKzDEoj8Cs0vT5p8kOTqAQ1R0P7OunRp5
         HxXYSyKMs0Y+SpW4/Y2UQQDg0vOdCVgCo+LVKiBP9Ni0ujK0cDNKIN78/uL0RHRAOUFd
         vzRAHAYXrxW7nNZ5CseT7DqOQwOblG6siOktFaVHN1x+24tNV8LXdgOKB+t0hi54PQ0S
         vG4A==
X-Forwarded-Encrypted: i=1; AJvYcCUq5jt5c0e3A0Fu8yi8NkKWJnga9NheSZsHRbQjnpmLqszHrYMQolYSc/ZEDmPqnUe8hZDOIW/MTtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbS0ReOFQ3Q4mIrv1OHPQaOgTMZi8xh2h1X5onYzSWS+S0V3p
	EkYRivdOG+GisTf4K5Z5rT30CG5NFywZaNVaJTRvklO/vPflZkhWYVg5pjnl7ofZdYKcwTmHtgX
	rZ+JRc07SILjQp3Eyu86w4rM/qYYcn24Y7/Vvyw==
X-Gm-Gg: ASbGncsgDuNqucO0sTIAyUnO1LdRfdOORasVhf096q3+BvRJj0xHmP8ANlUiBvQ76yj
	6QO6/w11CN+MSCih/4MyZCJAlTddZBg6mL/lb+6mPQXKWWegCeRCqxMMZHcJF5ll8l4rBy9jEGw
	0xpLjtyKzX9ktAQEwZaWYdLaIvl+TAF+RxndQJfg==
X-Google-Smtp-Source: AGHT+IFk3gFp/cUReNnM9kzAsWOkTCM5MEQl/tCtb/z5liDbrUseKz74jkUx34wnEgejhu/lLK5rCnP3CIxzHqyLHXc=
X-Received: by 2002:a05:690c:4c02:b0:6ef:652b:91cf with SMTP id
 00721157ae682-6ff0927951fmr104983367b3.27.1741778731810; Wed, 12 Mar 2025
 04:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305214108.1327208-1-jonas@kwiboo.se> <20250305214108.1327208-2-jonas@kwiboo.se>
In-Reply-To: <20250305214108.1327208-2-jonas@kwiboo.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:56 +0100
X-Gm-Features: AQ5f1JqH2hRXUwfz_vQkPX8i5gK9j7RB0dP4G_O77fuesZmjypeV_Lu2vr_DSTs
Message-ID: <CAPDyKFqY+0MGsdZDBJ1AoDaDGrnXN=Gu3JNjuK0LoHfjT9JxiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible
 string for RK3528
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 22:41, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The SDHCI controller in Rockchip RK3528 is similar to the one included
> in RK3588.
>
> Add compatible string for the SDHCI controller in RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index c3d5e0230af1..fb2115e805f5 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -14,7 +14,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: rockchip,rk3576-dwcmshc
> +          - enum:
> +              - rockchip,rk3528-dwcmshc
> +              - rockchip,rk3576-dwcmshc
>            - const: rockchip,rk3588-dwcmshc
>        - enum:
>            - rockchip,rk3568-dwcmshc
> --
> 2.48.1
>
