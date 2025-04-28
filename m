Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BD27A920
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857301; cv=none; b=tDsElpXyL2VUpV1u40DYTX2cUoviv3RTREAsSwYwVGLPaXbt+cxdPUsrMpaag1Nvu421mssLcMIQkKoAd3nd8BLjGKpj1R9unpRcpssgmBXhu0asWKZ8/zdMF1iRd/zyC6Ee19ViElwj0NCEqJjDugSiQPgvg1/+Ifsy3wLqYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857301; c=relaxed/simple;
	bh=VPZALAjR7Zdva25NLVz5KQEgfQ6d4QldoSci+gyc0ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbPbxdtpOvzBV1Ut0ffOvZqJeMoQcjORvipnwbzYYG0Cky8cgM7bQAPspVdz/rAhiky/K9HwuMmKYljQ7/eOBF7bnzSpf7s2rkO9o/po9+X2s2P4+ypjmSTZNn120wPCQEJ3oIdrJnvuA67xO2M15KlKqsfGF1KBfhWrfALX/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xt6cOKoB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xt6cOKoB"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73120cc26fso3081645276.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745857297; x=1746462097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WOhasKd6micKEiWT/MKXPBW1f7I1/Q2+vdBpOz089cI=;
        b=xt6cOKoB4XZo+QMlm4roWVyroBo4inqMuclDNyIjfBylXzBJa3EdRpbTeN6vxRWi17
         AWjY3rmJn7LOzcwpkIgaeznZyMb1+HpTqbRlovBmX9BfUeJX4zitu/suz3tsPW6oCyNZ
         /Zdqn70P8HHDa7s1E993EUv7lP4e8hQy7HIOsmN4rQp/n156vJrVevdBd53hne00SxZ3
         rST48bq48gpdS0v3Xh/gVsdOPzlrVvkWaUhBwec81wjhNpsPpwL0YZVjBh9U7pBMSaVX
         hQx5uv7xaf2ZWY22qChrO4upTYRfG2rJE2THQxHcApDvk0uAY4CgahwdAD4ymyDkVBDq
         CTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857297; x=1746462097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOhasKd6micKEiWT/MKXPBW1f7I1/Q2+vdBpOz089cI=;
        b=ObfEtiDqd91ZrgJwUH45aI2T2riPKmpGUFcCQR1gciPEa644P7vhJ36noo+9lYetqN
         BIn/Ri5wd4j3Y39ndiPWzVGnD7lg00pVeD2CrUm+YlnH4OV28Zr2SBR1kjEV2FuT+ct+
         eb6zAR3UrBzN3D2RS0U/IWoF+psD5qgcfJ3aR+1qhH911BSiRlcbds+A0jhmlPItgokX
         HM+8jkMa+gis+Vmj9v62dhy8jj8/YEAVMDfxVDgK6G+2GEf1THFM6XJcB3Bts/dpSDxP
         RsRREIqwj8OswA3xoKrbHdfi/xtNr5WnwGsy4BdWmBLwhM6/tocroz2YQvaQmiPsKuQa
         4cYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxgr01dv5MWl6hCx3YdfbLODte+V2pIlu72Y8J6bn+JFq6cGPG6LUrZeYgxwFyqA82ZPowvc1xtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrIn/y7FPyHQ/zOv52o8rNyUHbxEV8cyDQlJBXmdib/NtCN3I
	T7KEudi191U9+z5ZT999T9lY8B9YBFj8aSRy2in9ecJCjoqWEMvG46d8299RXT71CPnhIbWo1fW
	p11ZsF6lHEUEUGM/OxKxbOnFMQ5irXlRZdbsFXw==
X-Gm-Gg: ASbGncscFmb0hAJohfw3hID+jecVDTiZfdfN8vjrflJxtNVr2tScz/pHXFuM8VzUZzt
	BJikoY4oxYFsp4q78mdWJB3u53GKTwmZvQSpjiY5SbcFh4aKPKIhQhacDY+5VkdO2YSV6qla+yH
	6Z4O3mpOi8GZ2M5ccD22C6SVI=
X-Google-Smtp-Source: AGHT+IF2+lLJogWYmJ9CklQNKtsYDG7mA++udTlmO/sYgtKfw1zcHF/zNyAnw+6seYbb5sOJx4PEl6rhupOOr/4EHRU=
X-Received: by 2002:a05:6902:15c1:b0:e6d:f0a6:4cd7 with SMTP id
 3f1490d57ef6-e7322febd09mr12474369276.0.1745857297087; Mon, 28 Apr 2025
 09:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413223507.46480-1-inochiama@gmail.com> <20250413223507.46480-8-inochiama@gmail.com>
In-Reply-To: <20250413223507.46480-8-inochiama@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:21:01 +0200
X-Gm-Features: ATxdqUHo5zpHgBeVnQwujIcWP56iQkcuhTXqhu8H3yGRlHLlrSHxM1LpwpFg6CU
Message-ID: <CAPDyKFrM32TVAHzSoMvmO_ZW2Ax=RQmH_7KqSGgqXTOc20UnLA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2044 support
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 00:36, Inochi Amaoto <inochiama@gmail.com> wrote:
>
> The sdhci IP of SG2044 is similar to it of SG2042. They
> share the same clock and controller configuration.
>
> Add compatible string for SG2044.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index e6e604072d3c..5fb347167004 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -19,6 +19,9 @@ properties:
>                - rockchip,rk3562-dwcmshc
>                - rockchip,rk3576-dwcmshc
>            - const: rockchip,rk3588-dwcmshc
> +      - items:
> +          - const: sophgo,sg2044-dwcmshc
> +          - const: sophgo,sg2042-dwcmshc
>        - enum:
>            - rockchip,rk3568-dwcmshc
>            - rockchip,rk3588-dwcmshc
> --
> 2.49.0
>
