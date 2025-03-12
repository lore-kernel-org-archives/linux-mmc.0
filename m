Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0A248861
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778741; cv=none; b=KN3aE1+gbiZO4hsv3rEfiwiyFjo+KTyDPpccHPjVqW4A5lq9OYDXNuTdDM2J6dsidtihycKyVrjGDNjIK+iQ3dlUvAmwsqv69L4ypNf6hHrh8Y6HLkSY0nJXG5BOnh0sg/ip/Szp90SveREjhAf1vYB6B5fPev4A/E5Yvc5+/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778741; c=relaxed/simple;
	bh=2mAjhQ38xaV59CAo8Jko5V6MNwT7CgxOmLCldmytZvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kijDUpAv1BWjwW17maLENR1t3/mrkCxf0SP/NJUng5S8Jck00k4itW3W5r7K3fKhab8q26ZNbioWUxRNhHfMTvu+hKhcTxKNgxS2/uaeY5DKX+Q1bJOcG7q0m15D9hpeIIXuKsokrYO4kfEL8NNcaPUGtYhAYGTQDlLHodJJ/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxpRm+nE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxpRm+nE"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fd9d9ae47cso61426777b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778738; x=1742383538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CiJA8cEstxgkTU1mTKMy0JGKZ+R8iGVjaXw2iJxWSRI=;
        b=jxpRm+nEkoXRMGyl6NreHJi5FcZFYUPeFG3nP0OILD3JnWXmlhFnwctheTqM52YIK7
         84Vh/1Mr+0H6zJ0w8xmQ4roiTVEopTFZ1mD1TTLCbxuONE6Ob+RRTYq50dagGU5tvsZh
         YNfxCwhAcovKC5WmUH4se0D1kCGWYVPYJ1I3hOn/YgNn5NHx+HVeImF+alRgDVYmcd7L
         HAB+I3y33GKkl01wvMOQd8EsDVlxbWK0E3Dw9fuhI5h3RKuuH/wgD1kwm6zGczR5x+gU
         ftAtJYUcY9Cq0KGLU0iEjSDlMbULqZ7A9MdNu0By+zp8ZQGV9ktavjvoCwZNgtB7ToEC
         DXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778738; x=1742383538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiJA8cEstxgkTU1mTKMy0JGKZ+R8iGVjaXw2iJxWSRI=;
        b=ws1h77dKqYY8a9Q+0ZgXRSEauM+Y3gJPGWIvqPsFHfnTXnvGwc++w8pbxBOA94Xv0f
         okegZsEJ0lOOih685ehiMKDXcBd4GHPi9R5gWmxVCGBRouPrnud1s8Hq/vHdE1ZNF36C
         wssKwaKz+0U5+N4tyzn5FDHC/je5c+zRC8/2L1xhy8UaY9JdIOitr5uuQ1zuGL75Swpd
         KnryWrIEbXmBvXvgsf69S0UP9FA21tZXqu6zwqedYE/3nPWjURLR8cQFF/zNlHdHyK4J
         9OjW4rPjbz5XsND1ntWgcfS2N6r3rRVUdA2gPzUwjpzPKyt7kTX8qk9SYvAPBwNen5XP
         2Ubw==
X-Forwarded-Encrypted: i=1; AJvYcCVLWabPL27UMyfwbukZfK+trdXPcAYnnJDf/Ob6jQ9ENtOlyb4G1onb6wC8HADDK3sAv/HN5r+gEbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SBq8IoybBj3Ytj94TBOh5dcrPtvBHMXff+qxgKd+xbDisJp+
	AF1YsCFCgLWgqIHl1N7l49vMMC2I+9MR2B7dGXdUep9ZJMe3IhqN4/xbBJWJy6n0QfSsVgKAN/B
	ZX7J6djzukVAtnWjvIsk4+2+irVQ2TE7jpNCJnw==
X-Gm-Gg: ASbGnct9YeE7ngVoevWj6ZoqZhF3nglDwJ9qlo1x0eJIImhNr9odanurAPHzDLgQQYp
	tLLVdeLuJxCTa9OhOaY7MMVcSVnZdt9yFhCmM+6S2jUtwCyEJ3uImFlV9V1d8fVTfKWLicz0Tne
	fFR/r1xD5x6PjHVATqIG7VNbTD7kg=
X-Google-Smtp-Source: AGHT+IFsXLs0G0P0sl4PUE6UPS3JqqtQHaqryQbTsh+V2XVD4bcZpoq0lGo1l4XslguvHjeCee00G9KHRf+J4fl/2ps=
X-Received: by 2002:a05:690c:4b13:b0:6fd:33a5:59a with SMTP id
 00721157ae682-6ff091eaa41mr105598827b3.18.1741778737979; Wed, 12 Mar 2025
 04:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307005712.16828-1-andre.przywara@arm.com> <20250307005712.16828-3-andre.przywara@arm.com>
In-Reply-To: <20250307005712.16828-3-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:25:02 +0100
X-Gm-Features: AQ5f1JpRnOY3arJkwpPqmP24JF8uLy0s3IwIKNA_9eLVMdzcVYtTB4PX7y_pSng
Message-ID: <CAPDyKFoFesrcYPDNDsvU_mLdkTGE2=7TCFrYkdFW3bp_0fLSMg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: mmc: sunxi: add compatible strings
 for Allwinner A523
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
> The Allwinner A523 uses the same MMC IP as the D1.
>
> Introduce the new specific compatible strings, and use them with
> fallbacks to the D1 strings.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 8e4c77b7e4ab9..9f3b1edacaa02 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -50,10 +50,14 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-emmc
>                - allwinner,sun50i-h616-emmc
> +              - allwinner,sun55i-a523-emmc
>            - const: allwinner,sun50i-a100-emmc
>        - items:
>            - const: allwinner,sun50i-h616-mmc
>            - const: allwinner,sun50i-a100-mmc
> +      - items:
> +          - const: allwinner,sun55i-a523-mmc
> +          - const: allwinner,sun20i-d1-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.46.3
>
