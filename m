Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3516248868
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778738; cv=none; b=CzTZsT5hsL3z7i4LJAQrY83Bu3D1Kx2c1o6hb8MN20D2mMbtHwiH9NnfoGTwA2hkkR9RfIDSVPR0Rz1BVht5Z/vGMmguHE/PR/Cu9yX5d5bRlGNk3X/WPioaFoYpyg2sOcBvCjyR4SeGTY2h9dDQxT+wlXaqhutFZIY8qKSKTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778738; c=relaxed/simple;
	bh=zKSN1MPByApvA+OUlh27K1FJwz3QmJ32fWxe2xd1RGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwNBNblJjM/AadQCw6WhFFP8+YS/jDH1aO5/PQ6ceFrUqkZkoOUVif5eKyGyjlgyTiWrjKN7dvCDkDbpKJOBveR3A+PFNjsHqE3Nkleh6M1LeVerRyT2uyiJkXWoM8z8kewuBVLWhN887m8qJNKeCMglzk7fhR3vRcwxgPcGxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gG+nA5gF; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gG+nA5gF"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fedf6aaed2so7925707b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778736; x=1742383536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMmWW278S3Hwy+hLP82+XTpci0VAB4ee7BNXBj9aT9k=;
        b=gG+nA5gFGMz2R4SdyWQuaCtp8g2v2CEodV1WJcKH+wGfbQCeSscdnGkGFVMsnZ1uLv
         e/DOYpg1YEmS+ZtIPwPPosz0F+PIW2rFhhkqEgfwhEJzloohV9dpMxk1V5czDjLffHZc
         6bEBKnLNRPZYpwtOEXuk7ToGAAmWCqq7Mp4e5GiYq4g2U1po+JiX/TQIGXTWBX6IPHpa
         JVRi/Xen+ahRyvHQcsK2oCQxswMAA9lyPsYLS+pELkfRE0KBwNaOk2JpgDFssfgk+gEh
         r0UZvU45kZA5DpgwmWLDAB54tmo8nU6iFmYGSB/8elSirMxLZaLSTmbL4v3fcZK9+fJJ
         KyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778736; x=1742383536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMmWW278S3Hwy+hLP82+XTpci0VAB4ee7BNXBj9aT9k=;
        b=VhVNm+KLR4j0ADmun1AeK8PCyZiSc3GGqxHnx7UDVvws7BuMRlPi77s6wcl4yHLbOc
         6yMfItWZoaw85I7vyKvdZTA1PdFkA0whVXW5vmfjHIOlDwnCW6qW80JEPdz91opv2PoJ
         RnRK5NRAyUXaxOtHeFRphCRACyH0ItN8FdflHhW3ahx+xKmmLpz/9vllC/72oPV2AdNr
         9/QOLcdMg0QZi3KwAR9oMN8XU0U8b88fI+tNCFsjwZqAkFCDK1TLdTLiq20W2u+nc77z
         NQm1lu5DTI2ZSq/cTD5gZsgjljl/t1ec7xuc7ETL024QZO1bdM3GgY9hBhpNb3a0fMrS
         Wlrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8QuGFX0OWnRTCh10peDgphTB7nIOJlIU4YUtdaFIbFT/Y8wbkhkqm9QwIVFhJunVOHvvLNZM/8Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rvqY0qtHlVoCnqZF2egpKR5JHxawTBQc6JYDARsKN40ZbYvH
	cFpDNixHr2C5AaY4uo1UPTsdYYqRng9G73duuli16ytCYOx1jBcLXIBcDGpBYtNV8PoWTEyvgbb
	apq170/gEO8YBd5e742kwwaKREYm19lxekad8cQ==
X-Gm-Gg: ASbGncuIqFE9S5qQ0z+HS59v/PF5kVhqUcSGVMC2NyeDTXd9H4uJpn1WLdNVGLhtkie
	HsuVnUbIgm7A5AgbG33+0VshbZwg0cvlDJnPRLVMpciP58NMTrzw0lEJ6+LEWFctQzIuVhqvrGq
	zs5aQCCsMH8qr1xr6aby05BTFzAAo=
X-Google-Smtp-Source: AGHT+IF+2TUj0AijHF6r+vPxRqI/7rfE3ie+f/dBAlUG+gV7qBwbChu82fS6cFOmTtK6ezNyic5kn3RkBhCY6+/TI2Y=
X-Received: by 2002:a05:690c:7207:b0:6fb:b38e:207e with SMTP id
 00721157ae682-6ff0a33c8f8mr83949777b3.14.1741778735829; Wed, 12 Mar 2025
 04:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307005712.16828-1-andre.przywara@arm.com> <20250307005712.16828-2-andre.przywara@arm.com>
In-Reply-To: <20250307005712.16828-2-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:59 +0100
X-Gm-Features: AQ5f1JoiQnCX1EBg93UaXE5EJlbj1n7TONyL__Rgw9VQ-gzhs1UrEpRxnqBou7Y
Message-ID: <CAPDyKFpFgNjy+Tu7ZKB05m55HAf5RQ+AFPgk+6Q8_g1xu0akng@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: mmc: sunxi: Simplify compatible
 string listing
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 01:57, Andre Przywara <andre.przywara@arm.com> wrote:
>
> New Allwinner SoCs only occasionally update their MMC IP, leading to many
> pairs of compatible strings, though there are sometimes a number of them
> being compatible with one particular SoC.
>
> Collate the compatible string listing in the binding, to group those
> being compatible together. This makes the list more readable, and allows
> for easier addition of new SoC's MMC devices.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml | 36 ++++++++-----------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 0ccd632d56200..8e4c77b7e4ab9 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -30,38 +30,30 @@ properties:
>        - const: allwinner,sun50i-a100-emmc
>        - const: allwinner,sun50i-a100-mmc
>        - items:
> -          - const: allwinner,sun8i-a83t-mmc
> +          - enum:
> +              - allwinner,sun8i-a83t-mmc
> +              - allwinner,suniv-f1c100s-mmc
>            - const: allwinner,sun7i-a20-mmc
>        - items:
> -          - const: allwinner,sun8i-r40-emmc
> +          - enum:
> +              - allwinner,sun8i-r40-emmc
> +              - allwinner,sun50i-h5-emmc
> +              - allwinner,sun50i-h6-emmc
>            - const: allwinner,sun50i-a64-emmc
>        - items:
> -          - const: allwinner,sun8i-r40-mmc
> +          - enum:
> +              - allwinner,sun8i-r40-mmc
> +              - allwinner,sun50i-h5-mmc
> +              - allwinner,sun50i-h6-mmc
>            - const: allwinner,sun50i-a64-mmc
>        - items:
> -          - const: allwinner,sun50i-h5-emmc
> -          - const: allwinner,sun50i-a64-emmc
> -      - items:
> -          - const: allwinner,sun50i-h5-mmc
> -          - const: allwinner,sun50i-a64-mmc
> -      - items:
> -          - const: allwinner,sun50i-h6-emmc
> -          - const: allwinner,sun50i-a64-emmc
> -      - items:
> -          - const: allwinner,sun50i-h6-mmc
> -          - const: allwinner,sun50i-a64-mmc
> -      - items:
> -          - const: allwinner,sun20i-d1-emmc
> -          - const: allwinner,sun50i-a100-emmc
> -      - items:
> -          - const: allwinner,sun50i-h616-emmc
> +          - enum:
> +              - allwinner,sun20i-d1-emmc
> +              - allwinner,sun50i-h616-emmc
>            - const: allwinner,sun50i-a100-emmc
>        - items:
>            - const: allwinner,sun50i-h616-mmc
>            - const: allwinner,sun50i-a100-mmc
> -      - items:
> -          - const: allwinner,suniv-f1c100s-mmc
> -          - const: allwinner,sun7i-a20-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.46.3
>
