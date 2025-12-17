Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB591DBB3A
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979132; cv=none; b=mMwGLWR7PEMip2ul86asNiduzSLzgAIkpj4PEGWX+zjzKpD32qAmUkxXzNAAGW3j7DKtD+Ayc56qlIx3245ZijxYdllr4Vol2cHMsvVRIkUVyr5gHPbCNtvn8D/a/pzharROKmEolHnMaccO8QXxg1roPrZhQJOpvqlLjQ/YjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979132; c=relaxed/simple;
	bh=JZdXUdAOJEWuzpYTsxKZ9buqrf2lUMZM1PsEcRK3b4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsrEAtVWmBmgyG3tRIvjbEhSLbqxR0R1jqK6+CgxJeZKT7HIFVJhhVj023SWGUmlgXgeiX2rbcUfMuijwq9qSaZQsbgULxPUhNy2Nn1Yz84s3jMuoTKNzGgFi14pl0CWLJ4tQ05twhtG3dztJyOfDEiQBIux7R4GxGeWEEwbK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3GeGGy1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3GeGGy1"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-598f59996aaso543828e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979129; x=1766583929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BODOTxNk8AcmqAwPaMr4JkxtG2Ivnc3fhYwzzaB1YDQ=;
        b=t3GeGGy1j0kFfyV38QeUXteXIDC1ZuQbBu+WHdU1O7id++7jU/j4A2CXJFKJct9e4B
         Myaz59SruEkyJ0JCvxEH5jz6ZNNEc96EoTk7gOd4thm2dJ/srX4h1sMWuIrNvTKMxdSq
         fG/yyVmdV5Df2AdR8Tt57Tzgl7I9POJ0eGbYyhjPf+q2AkE1ux5Whc0yGhdUDBmR7h4H
         zozu3V54aQlWxYwhWiU39TkPWjzbo7XECd2kbF7i7fuDK7Y/QpOQSnnikM27GLz7Qftr
         kialZWGeh3BjMdF0SI++LDYDZPRrH+AjgbtGzIEBQiBp/HjuaBcMojhCwmMzLiAT1ucs
         Ub1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979129; x=1766583929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BODOTxNk8AcmqAwPaMr4JkxtG2Ivnc3fhYwzzaB1YDQ=;
        b=uwTpZ6w8Vbvk/EDAHTWsnZjI+D+ixnXcXWz5E22dNSttgfj+3YWtIUwO+SpZyxtSxS
         fExES2kfVXyLPjxCcYhd3AQRQUSeYCcocXalAd0Ky3q9bfPBeSkcfxKZc/Lgy/zoNlUR
         aFAm4m8BVpKRNNlrhXFN3VsPts2yrz7PIgcNv31rQzMCZitya/Wbnf1lw4ppmemt6zqB
         UdIqXWLJg9bZYNDYJ3sbpX/VHz6h3h9+bbwC74G4jdZTy2UvrRNpvmerGOkYdqxFDgXh
         sZ3QHPdb0E0ekHO0O+mi+FCfvrljpFYW8eO5XOx1mTbtD+CCCI1AbuiIpUefKt5mCcRR
         VnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1Rgu7ubBxc3QupfrUjjv4hCYsO0lwgTg6sh+zaXfeP1Sk8bxqpPLUH0YKc915cY2rrFFtReKkI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFixwomSaz2AAUXWTkKKEC811dYVC006j2DXFbs9uPuzz7d96+
	90pkTPmzeZ5VxdzPet6gMU+oMmDdCpeF9AOx0tWjFhrTfquEHTbc+vhk8o5wC1rn+72kTqRrIRV
	m6louxGoyBl+D36Zkch06FXyrzNodTBjlvSelPVYF6Q==
X-Gm-Gg: AY/fxX7saUwzfnvkTBDtzg+knyU5Z31cG7ifAoxQDtTOEtMFHmRx7+X2uXQowA/MFZx
	+VNNFlDfPva+qD6AOvJkmmFlo2Ef6gWPVT39canfgNbqC7Px5DAfRio/eMMnXBbBs5OLNu1Pt2I
	kF0jr8HULlzxHBdxPL7vlGJ7LIERJytvxkBE6y9xoYTRBiLtcCLYeROQ2j6oUEo7bUUyOn02Zct
	KFHeyd0THvUB0IgL3iNgxTwrYn0oWrp2vxT3WOWK+OgysqpEgetM2DhWTbWs/rLDSPcxyM=
X-Google-Smtp-Source: AGHT+IEb4QbT1qJizq+A7uWazmE4LS47vI2CUBXKM73xbojPF6bkoElbfnixbTNGFJz0DbbNowU9Knm45YZtBVAzyzo=
X-Received: by 2002:a05:6512:4011:b0:595:7daf:9425 with SMTP id
 2adb3069b0e04-598faa6375dmr6274719e87.28.1765979128707; Wed, 17 Dec 2025
 05:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215212728.3321308-1-robh@kernel.org>
In-Reply-To: <20251215212728.3321308-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:44:52 +0100
X-Gm-Features: AQt7F2pBXb1zmev-hjgOXmdMYKCYte5-L19B0sgKMXKbmpuJfZCdUzB274-nN80
Message-ID: <CAPDyKFq+k03t9b7GQmH_QcKNqPbKCfNqGMX4kaYqjUS7u-PbmA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns,sdhci: Drop required "resets" on
 AMD Pensando ELBA
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 22:27, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The AMD Pensando ELBA DT defines no reset for the SDHCI, so it is obviously
> not required.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index ac75d694611a..6c7317d13aa6 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -134,8 +134,6 @@ allOf:
>            items:
>              - description: Host controller registers
>              - description: Elba byte-lane enable register for writes
> -      required:
> -        - resets
>      else:
>        properties:
>          reg:
> --
> 2.51.0
>
