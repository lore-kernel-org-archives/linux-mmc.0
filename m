Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32440207A30
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153045; cv=none; b=Cw6t4eFUWXoxBdu9xa26kF2cz3NNVy9no35t2hi9NkX/OpcFpgI0Rn9+svAOkWznrTjoUL8jEoAGaUQ3z2RBmwzv3ZuUzh5enKkQUhHvFl/cjQCiGjVfeD0mh2cH6E/MwYt2b2Ta2s1rz+T3ExOL/szRSF4r70/obxFu06QIoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153045; c=relaxed/simple;
	bh=emBsO7UD/fsFeG160T0J2TEDqg+OGFUi4iJaEE8IBNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oALW0sjuCjSVUWf1TS6c55nGwK7aVJzqEvEl/ExTpXjqbAGpJbg9mbggPwXgpIJC/zzzgtWcLnJmTNLGxFvK211CsFb+9E6V0qmFqEzYiUrWBTp0jCuorDPJQTIYjZ2QYDDsGx1LhPkzKc8uKAZZXIAWZsYxQX/3bMzAJtsOq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkRyrnDG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkRyrnDG"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef9b8b4f13so9191977b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153042; x=1733757842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBidcxxw0LkaUAD5/9IMQ9Iuz+pdOXkp8f04uFCwiXE=;
        b=DkRyrnDGRJDp26VILXj//3dtmFDuGra1t1T6iCCb+ftjsGYAdDdbSr1/CmY/Awpgt2
         DR6vcmaGeKlb2yWBJFqkY2+ZfmxImy9Wft+W0eq3m12r+zLLq09lZFiAyq3O1QBBiG5n
         A2+7iSTqfPI6H4QSDggQPO6xkchnjJ2I+IPOooD1yZ2hctRDynsDort9qvyiWtSaFtc5
         8tqFCRllsC/gYw4YmUijD67mUOGLj+6YGKmQhFiEkEFOBUiSSTvkQ+4/BdwYnOIPbj5x
         TZmvuGljRo5V4zi3L8hAQ1j4BM7JYJ91/ZoGUDtAFvRcQ+oIbth7K/46e8N6FWwCghKn
         drNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153042; x=1733757842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBidcxxw0LkaUAD5/9IMQ9Iuz+pdOXkp8f04uFCwiXE=;
        b=FAILvFlCamajMBF6jygRo7rAnBK7oyiITmQybHgrm9ItTOQwLGxNV/s7LFeVOvO4n9
         E5m36Dt/5sUOzvV9vNuehfe8hs7fXt1mbnnAG2/0RhzzLKcrOL4PU5bfwaVjdDcUavS9
         l4SSCaLzul5KqmqSQqmGgJjkdshKgxzHo92iGp7WABWwdepoKvt+aCrh0FoJF548KrQb
         m9YOkjzcBmUZzA50NUzHo/M/LdGgD3Ei+n/jufuKIhEfjfl57bjNuYY58Ljr1Tbq2F1h
         t6nrBm4N2i8we3fFSa35zeqnjJwpLibyYLec2JZqo7p/uQRafaqfhLlAUbQPHgWz+wkQ
         O2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXfKaNXsDGSUPrMmoa8eWPLSeehltIdIFDJDoKbfWzWrP/n9IauUdGJ1JtDjXpKz0U5S/71c5O0fAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfUtlYk62302CObFNNHnjydM0e4vqDyHtL+7vQJWq9tLjR1Ktp
	2jx66Or45sag7PgVp30j43qeihmnMqSQyf/bRJx17XoTcjmnNJcLxAcN580scEkhbKCPK/wNmvk
	KT2HlHxP3ucCeVaFePpiig5Q1ltYaTtCxyy0cwA==
X-Gm-Gg: ASbGncuJhxXiXWynCZV5BMmATncbkZLROQHF7gp5FhoUoHhpgbLaCe4RHk5cYtofnVs
	fPr65xhHR/6QNbS7R0nPSOp2A9jXnT1CG
X-Google-Smtp-Source: AGHT+IHloKnYMU2YPvEvU4xjaTsmIlSJr7XS8O22fOpOceAV6w9xzQeEE9Oq/ecfzP79HELT5y0lhlpm0hWJnPxFg30=
X-Received: by 2002:a05:6902:11c2:b0:e39:890b:a55c with SMTP id
 3f1490d57ef6-e39890ba7a7mr14479567276.20.1733153041992; Mon, 02 Dec 2024
 07:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113225602.1782573-1-robh@kernel.org>
In-Reply-To: <20241113225602.1782573-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:26 +0100
Message-ID: <CAPDyKFohGpnh0fCgktbeSatKyrD3Za7TsvnyB03xDmHh6AxKtw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: marvell,xenon-sdhci: Simplify Armada
 3700 if/then schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 23:56, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Properties are supposed to be defined in the top-level schema and then
> disallowed in an if/then schema if necessary. Move the "marvell,pad-type"
> property to follow this.
>
> "reg" can also be similarly described at the top-level with only the
> number of entries restricted in the if/then schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 48 +++++++++----------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index cfe6237716f4..3f48d8292d5b 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -38,15 +38,9 @@ properties:
>
>    reg:
>      minItems: 1
> -    maxItems: 2
> -    description: |
> -      For "marvell,armada-3700-sdhci", two register areas.  The first one
> -      for Xenon IP register. The second one for the Armada 3700 SoC PHY PAD
> -      Voltage Control register.  Please follow the examples with compatible
> -      "marvell,armada-3700-sdhci" in below.
> -      Please also check property marvell,pad-type in below.
> -
> -      For other compatible strings, one register area for Xenon IP.
> +    items:
> +      - description: Xenon IP registers
> +      - description: Armada 3700 SoC PHY PAD Voltage Control register
>
>    clocks:
>      minItems: 1
> @@ -61,6 +55,17 @@ properties:
>    interrupts:
>      maxItems: 1
>
> +  marvell,pad-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - sd
> +      - fixed-1-8v
> +    description:
> +      Type of Armada 3700 SoC PHY PAD Voltage Controller register. If "sd" is
> +      selected, SoC PHY PAD is set as 3.3V at the beginning and is switched to
> +      1.8V when later in higher speed mode. If "fixed-1-8v" is selected, SoC PHY
> +      PAD is fixed 1.8V, such as for eMMC.
> +
>    marvell,xenon-sdhc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> @@ -147,27 +152,18 @@ allOf:
>      then:
>        properties:
>          reg:
> -          items:
> -            - description: Xenon IP registers
> -            - description: Armada 3700 SoC PHY PAD Voltage Control register
> -
> -        marvell,pad-type:
> -          $ref: /schemas/types.yaml#/definitions/string
> -          enum:
> -            - sd
> -            - fixed-1-8v
> -          description: |
> -            Type of Armada 3700 SoC PHY PAD Voltage Controller register.
> -            If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning
> -            and is switched to 1.8V when later in higher speed mode.
> -            If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for
> -            eMMC.
> -            Please follow the examples with compatible
> -            "marvell,armada-3700-sdhci" in below.
> +          minItems: 2
>
>        required:
>          - marvell,pad-type
>
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        marvell,pad-type: false
> +
>    - if:
>        properties:
>          compatible:
> --
> 2.45.2
>
