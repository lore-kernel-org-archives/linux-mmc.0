Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746123624BB
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479931; cv=none; b=kncQ1UA88k731EQYIsIkFjzrX0mAk74nv6Elghm5jZAjs7XYS+Sjjudap3E0fvM44H3kYcoAnZW6hOUJ6quLQt2ICnTzjyOIeD3xuXY6rZDwTsy+J3sdg6kLp2/nnC2d7aQUAFKcFg6LG/LRySABhChefAsOvMunEy8RmdvrkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479931; c=relaxed/simple;
	bh=34KGTKVHVeHBF1mUoMa8kaJ38TlGQ15s8VmpnV1gKgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fggwmXmvAqDdP6vmdThPuR/3OOYnI9zOtia8vMljQku4nnxcFZCF3IiU1JZL+DcpFlOF+RvsEyQT++fMpiLVW+SLlW4lMZmmVP2HUeysSusQwwKkMs00uEQtGEPlzhrU290QNGQzFk9N1pNT+RV3Gjkngc1b70RlaRNGliiHEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sj86MMpg; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sj86MMpg"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640d0895d7cso6954679d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763479928; x=1764084728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxHLXotX/VR/smtmuGtjLAN5l6lgr5iFZlYRIN9JEyQ=;
        b=Sj86MMpgu7xSHyQHSNTpw1C7fEl38IcKoyh4wC87f/5bCwmxyvRWVuq4GvfRfuZLyb
         DgCGXMnxOw/pGrA1mEoZDAnAc4Kl3wlZ8/UNzIHYArNvh4tHtlyHE8MIRK9A4LPo17OJ
         xhn+fMh9vIWBvbHgt1XzRCgO466Qers0Yj0fAJ4i9De55SiiBajKKtfkmIep1j7iW6BL
         F+NUoshnNm6DlHfCeG3oujqar/hsHzB53vYC8iUMNsQ3cdtJPeduk/bI8qMKF34lM2+7
         +0vmpkcvJ8iC9/BtWeniOrcCeIYRdNI/ElOuDOzrkUyAX8T4m6LKqgv8yO5+4CUa9wPX
         ikzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479928; x=1764084728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxHLXotX/VR/smtmuGtjLAN5l6lgr5iFZlYRIN9JEyQ=;
        b=HcUwe6nHNTgPO9/pBu0Edp7HtCzGba+dkCSlTT+2VHVtZjBGbh0xc98U+I5Y1oDWbY
         GS6gVYF8z20cN2F06/sSo4X1lQKfEEm0SiUS0uvNX3rEbdNgMFKY4NauLFGvhrV2dEoK
         0UKxKz0bzPEBN2ZVZ6CVJ6juW0IMitwfguHyKNZjbp+KzyYER1dY9tDf1mkPthXwyby7
         i5UwrdZd58sYhG/N1hE2gdIWG+wbDz3+BsEUY6jJQDeCEimJiMGpOKGJdvgbcq7JtYxF
         Lt92GoNLJIwab4sR8VH01PDi8pPeun8UypzS07HY2aX5W5eT/R6zuhZjrrWfDpOYpFvx
         Oz5w==
X-Forwarded-Encrypted: i=1; AJvYcCU7cD16dFwCyZj7t+aN2dY/kvRXai8OXCj92pUXp5BxCoOExRSVPScUyylXizr+A3oi2bxsN1oTMoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSt9nj3W5eHE2kV5gu/1KLexviDIxCcdGoLDVS3IVxQPzeQY4E
	NJoYJ5OOm65BoSKcs/pfTk5BJrU8KS0HrCB5AIHDOSCTuZq90vUyKJDTGyZqGKKiW9LUQ/gRNxM
	NT3xzbZ9enYod1FY8yf5sHFUdbMUrLXd0W/Awpn9txQ==
X-Gm-Gg: ASbGnctHC3a2mK/4kX1cdsTlZZmevOXoqN4MctulOnZS4nPLzwWwiyDIhgBf2cTkvyN
	XHu9SMog5rvBvHLywwUH7tKH1LDRBCZVuKvBanBJ3CworXL6xA+8ZaSjXwyAru6oxW5K4ezpqvb
	vy/SM6gjdMUnl2v73hDXWaQm1i0GitDat+vjxkvBebjg8GztnqhJdlIc1Eqb0jkQwjPWqhRBUdB
	27U05Ob3JOMQJ+l/MLmgm7sGYEVlOG09UTcXfDQhVxPSNiz/r/2WzRYj0kNs7opQWUkV3qMhmqk
	B75/sU2jbVkBOidWtA==
X-Google-Smtp-Source: AGHT+IEc8GglvCIsD6cGrALsj9LLh6N+Jx7VKw+16XtXMLh8fZV72joZEMGSMeUR4bEuhwbV7IWYBeRgua2rFcuL8iQ=
X-Received: by 2002:a05:690e:d86:b0:640:d597:4170 with SMTP id
 956f58d0204a3-642132db3f6mr2565633d50.0.1763479928233; Tue, 18 Nov 2025
 07:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115122120.35315-4-krzk@kernel.org> <20251115122120.35315-6-krzk@kernel.org>
In-Reply-To: <20251115122120.35315-6-krzk@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 16:31:32 +0100
X-Gm-Features: AWmQ_bmXlb23IcHWwlaA2kdC6A8acUsbATP4k59c9PPxA0jX-7QbyyZj3x6u5n8
Message-ID: <CAPDyKFpquaBo64eKvMPiCPdKrPkYc8fhpaOmFL9KN0UzFs0xkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mmc: am654: Simplify dma-coherent property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Michael Tretter <m.tretter@pengutronix.de>, 
	Harini Katakam <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Nov 2025 at 13:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common boolean properties need to be only allowed in the binding
> (":true"), because their type is already defined by core DT schema.
> Simplify dma-coherent property to match common syntax.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 676a74695389..242a3c6b925c 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -50,8 +50,7 @@ properties:
>        - const: clk_ahb
>        - const: clk_xin
>
> -  dma-coherent:
> -    type: boolean
> +  dma-coherent: true
>
>    # PHY output tap delays:
>    # Used to delay the data valid window and align it to the sampling clock.
> --
> 2.48.1
>
