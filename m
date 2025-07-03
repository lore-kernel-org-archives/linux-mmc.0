Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBE2E6139
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545192; cv=none; b=W1utJKwZ7HZcxnyqIo/Ga/VJGd2OqJ4FU3QveZvPfG8sSIPmwNZnL5PxE+t9t7wjDlULhoHv1Oi01mkZmd+QjY9nEpiqkVFHCKYaCposkRXb6mDIMsB8cxiTQoSUWvYLGjRUINMBEloF33KYxVY5hHA1T4lBm69hc1ZaYGCcDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545192; c=relaxed/simple;
	bh=z8FZnR4Rw/qWdYY8qz/fLFF2yrmytUH3WBZHq3bugK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSRiR1JWCHtAb8yWhq5lVaop8UoAAvefoqS3giRNTiNMdhZ3I63gH4uwP79eHMJbii9XHEFuys2FSO9zDfTeOLNvwCPtErnB0GD4/i3CoQnVc0iGfWzY0Eo/bAATHzNYkGrdoZDjIKsjN+zWN+r5Z/F5Hc7EoKoyHZtux+IaTwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLH/Rf98; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLH/Rf98"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e77831d68so58624017b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545189; x=1752149989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2wuby6dihOR3rr2SUBYnQ0Uq7yXMHWKxft/QT/79xE=;
        b=eLH/Rf98JC/HMuL7KJZBbT6Ya9KGteDjP9Kh4ZPe36Q88AcLivWi60GCowxr/Cg9jv
         A01pT5MtEtQAV5EzJkZP67t/lNJ58hKDUHG/bgyi/C/ysSjB6HamHtUYS0pkjDs9l4CP
         eyaAnYETJ0+8ztO1TwB644c+dSA7Os8yO7138nTREOR4e842Oh+JavV4rQlNkcPLTai/
         uWD90AxCTZPRufjnJnVQqXR5YML7gm0pY8g9svTI+N7UFDd2WDbcpboSW9V3BXLEJqRe
         zQjqL1J4UuMyv0esy4cn3XLr8cjhtdrhTKEVjm+T4k/zIRafPCKG2CYPEJ7SYF4NpPTi
         y1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545189; x=1752149989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2wuby6dihOR3rr2SUBYnQ0Uq7yXMHWKxft/QT/79xE=;
        b=AZq2ntt86+T/ohAg2G+ued35nG+45Vqd2YqvSkshnD0H/xR0WTxH8ckDrIdQdKbIge
         K5uM0L4hJbz3oAwj41e24qfH5R6R6AMF9VelxoP8FH2qrGBOWkNPd7/FUpqQi4W6W2uL
         K7OptudAJUBGCri2FB1+1Pcq6rIH++k0L/cJsBuM4dCrNnp1RzUYQBPbj2FrXWsqYFKD
         +8xW0H+ampNm1iCJidBvvt2QECLkCX1yxPc82oNoDkSHSjjSqD6MwL87AUH5QTTyJj5j
         2/Qqvd4dUqE9wpwPL58iG64im5M6hrxe6yyK32Kv8E+5PG4A8jHzNdXdCKo2YnxK0jaQ
         LYew==
X-Forwarded-Encrypted: i=1; AJvYcCW8xck8kZq+4jgPwU69T73JcyhAvnobCw/kOqia3yhNNzbUquNHHOmp5w6qAIhkSZYiwt0tSbB9BdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vZGc2jVUHM1/bbJM9UAD+IgFi0dy1oWlDRtjkvQelD72Rl0q
	WB8mBQXQonIItu7XHaMAON1lNw43qR6c0ZSAE+hOXgWxeyRFLMWp6PovP33kkXGRvis1rRU0s9n
	UvbtcpKU+b7YiFnpTsCteA98nAuDgJF0xE3/uaqtEEQ==
X-Gm-Gg: ASbGncv6b3I0FjRiwsseV8VqvIY/FKMqSTRGPwdWUh3Cm0HoKlWiafSukLQzZ3h16V6
	7Myggg0QeMH3bnywdwJgk6SPf0+LULysS58XOcgACRdir9XQPo6a4UwGqjQPE89vCHun6BeUKP/
	yOLXPwINoVAXWY26GbQcNgDnc0qz+l6NEQf9iRBqdQYy5d
X-Google-Smtp-Source: AGHT+IEeRTEttwsTQvILUVHrceCqzM9cMbjNTuLR5NzW92fxDyMdJhdnzbpkuw2WPjwuUny5S4J+pKNydZxICX8WeYw=
X-Received: by 2002:a05:690c:14:b0:70e:2cf0:f66a with SMTP id
 00721157ae682-71658fd7204mr50507077b3.6.1751545188852; Thu, 03 Jul 2025
 05:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617164914.158091-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250617164914.158091-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:12 +0200
X-Gm-Features: Ac12FXxJYgE2tX-oOlBR7QzPvk6TF-AjaS4HJVIbxSdXpqqJydqW899apydF_zo
Message-ID: <CAPDyKFqWmqO=Lw9yfLKV+zrwegGe_oCk3h2SWxPaU+_s2XnQjg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: renesas,sdhi: Document RZ/T2H and
 RZ/N2H support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 18:49, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add SDHI bindings for the Renesas RZ/T2H (a.k.a R9A09G077) and RZ/N2H
> (a.k.a R9A09G087) SoCs. Use `renesas,sdhi-r9a09g057` as a fallback since
> the SD/MMC block on these SoCs is identical to the one on RZ/V2H(P),
> allowing reuse of the existing driver without modifications.
>
> Update the binding schema to reflect differences: unlike RZ/V2H(P),
> RZ/T2H and RZ/N2H do not require the `resets` property and use only a
> two clocks instead of four.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
> - Added the high speed clock to the clocks list.
> ---
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 85 ++++++++++++-------
>  1 file changed, 53 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 7563623876fc..ba15ccbda61a 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -72,6 +72,8 @@ properties:
>            - enum:
>                - renesas,sdhi-r9a09g047 # RZ/G3E
>                - renesas,sdhi-r9a09g056 # RZ/V2N
> +              - renesas,sdhi-r9a09g077 # RZ/T2H
> +              - renesas,sdhi-r9a09g087 # RZ/N2H
>            - const: renesas,sdhi-r9a09g057 # RZ/V2H(P)
>
>    reg:
> @@ -129,59 +131,78 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - renesas,sdhi-r9a09g057
> -              - renesas,rzg2l-sdhi
> +              - renesas,sdhi-r9a09g077
> +              - renesas,sdhi-r9a09g087
>      then:
>        properties:
> +        resets: false
>          clocks:
>            items:
> -            - description: IMCLK, SDHI channel main clock1.
> -            - description: CLK_HS, SDHI channel High speed clock which operates
> -                           4 times that of SDHI channel main clock1.
> -            - description: IMCLK2, SDHI channel main clock2. When this clock is
> -                           turned off, external SD card detection cannot be
> -                           detected.
> -            - description: ACLK, SDHI channel bus clock.
> +            - description: ACLK, IMCLK, SDHI channel bus and main clocks.
> +            - description: CLK_HS, SDHI channel High speed clock.
>          clock-names:
>            items:
> -            - const: core
> -            - const: clkh
> -            - const: cd
>              - const: aclk
> -      required:
> -        - clock-names
> -        - resets
> +            - const: clkh
>      else:
>        if:
>          properties:
>            compatible:
>              contains:
>                enum:
> -                - renesas,rcar-gen2-sdhi
> -                - renesas,rcar-gen3-sdhi
> -                - renesas,rcar-gen4-sdhi
> +                - renesas,sdhi-r9a09g057
> +                - renesas,rzg2l-sdhi
>        then:
>          properties:
>            clocks:
> -            minItems: 1
> -            maxItems: 3
> -          clock-names:
> -            minItems: 1
> -            uniqueItems: true
>              items:
> -              - const: core
> -              - enum: [ clkh, cd ]
> -              - const: cd
> -      else:
> -        properties:
> -          clocks:
> -            minItems: 1
> -            maxItems: 2
> +              - description: IMCLK, SDHI channel main clock1.
> +              - description: CLK_HS, SDHI channel High speed clock which operates
> +                             4 times that of SDHI channel main clock1.
> +              - description: IMCLK2, SDHI channel main clock2. When this clock is
> +                             turned off, external SD card detection cannot be
> +                             detected.
> +              - description: ACLK, SDHI channel bus clock.
>            clock-names:
> -            minItems: 1
>              items:
>                - const: core
> +              - const: clkh
>                - const: cd
> +              - const: aclk
> +        required:
> +          - clock-names
> +          - resets
> +      else:
> +        if:
> +          properties:
> +            compatible:
> +              contains:
> +                enum:
> +                  - renesas,rcar-gen2-sdhi
> +                  - renesas,rcar-gen3-sdhi
> +                  - renesas,rcar-gen4-sdhi
> +        then:
> +          properties:
> +            clocks:
> +              minItems: 1
> +              maxItems: 3
> +            clock-names:
> +              minItems: 1
> +              uniqueItems: true
> +              items:
> +                - const: core
> +                - enum: [ clkh, cd ]
> +                - const: cd
> +        else:
> +          properties:
> +            clocks:
> +              minItems: 1
> +              maxItems: 2
> +            clock-names:
> +              minItems: 1
> +              items:
> +                - const: core
> +                - const: cd
>
>    - if:
>        properties:
> --
> 2.49.0
>
