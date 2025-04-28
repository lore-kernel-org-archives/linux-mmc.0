Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CF27A92B
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857303; cv=none; b=qRnZ+8aieaGpukG3mQkU2yLypr4uSJ9Spm+01FTk4dsLsPKgXcGoZ/4CmnslX3Pz4pPcrum1cRKpvFqldbEzAi7xb5fC4lDISvhBJA33E6AAWFd7WbWlmo7pv3Sfw138mOFlFNKnhjuXvV7w31JAVKqlBC9kkItBxPvuhxVMyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857303; c=relaxed/simple;
	bh=auYuhBEBTtdaYxBsQTyC1bAABv5AWq9SeRu6eAAMBK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhfU8zqaCwUelImFKS8SSiFF927JGZWFMg2JYueeY2WWJGl0qbDUyOWeqmyXxjGTCAV7AysAMIMi6go6NeZI+FhQhufIaRbFlQmCNHN4KTGQ00qcs5KtVPQPnKZKjKpyGPXvWGFZo230AyT2HHQRQC4TmcfED2H9mkgrjV0XJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+cBk43u; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+cBk43u"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6feb229b716so42132297b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745857301; x=1746462101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ozyYaD4uyMvYAeC6ThRYIW6+h6QCpMFE1Z79BTTe4Ys=;
        b=G+cBk43uXyde43df0g/psr/69DICK/8s6E414h3WEvUL84teCHmmGtkm5uFlOHPfM/
         7XU1z0iHJGJhS2oxCrvvocQsIhF+jIskBWAfqWlBptYCQydy+q8enOjMTHzluHa/srEz
         DjrVWfQegDLxAHW0+e8xj1Ae5QkGJGSDnVm5OzmCC9skYJMJ3hFPEEn6u7nv+FN9po4S
         bPgNNqx1kDNCgMZ8oUO47PDKwtiNEoGillr2ery0eSqkh8RcFRCEbYZ3HZScWQlNxZ1r
         rlbwutJ5gh3QmeDPczZPLEFLCygXwXaP1yyLSGGstjpSyZX4ylWCxsgwrfBXrPB3rAWx
         3rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857301; x=1746462101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozyYaD4uyMvYAeC6ThRYIW6+h6QCpMFE1Z79BTTe4Ys=;
        b=ETM2hGzkVZf1tfKAeVGCQJsQD2JXELkDPLA7jdDV3M61lobM4XEOMTwjEANKsHNxKP
         yC/yH16jP0dGt8qmxFrR4TMFXb+3AKpOwlUYbXj9KDliVG4pjH1a9aMug7qmQp8Om37v
         6LLBDIRWvKP08HFBDHVoA6UUBzLZg7d8fiZE+Sjopw/GN2VXOzVPE+aEHhC8fXReFwVQ
         ZCNuxIWLZ7nani7ofWA4AVMtBnPX1LzBBNYqBhEPnqHQyZNWDbWPR1gJ68ZQv0qhjyGo
         3Brekrl308rUBFuWUVSLvtKyUn4x+ycQdYCSPgrl13i7fyHNHAY9jCsaGX6sY5MO+ZYt
         EsKg==
X-Forwarded-Encrypted: i=1; AJvYcCUxo9w/TI/fmPr16Q2p5T1KzDqDBqxfr0zCvdHM3Ux1DPi5tI/wEENoYt57QqMp1VGS4dFJmUmqLnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJnMLr4OGcUwDFWdXDN+vFSvUy4Xwy/lu0WHf/sDOozQmpJ4I
	XqGn5aXl9c2nkYR/9gr9np6gTNwvJOhl9LRcsembnO7i0HMNEsDU1rzBmyBQD99ZJ36UBCU8JJH
	fjVfByXgR9n82IS/YJ7RHiOxhHlQeO1GaafeGfA==
X-Gm-Gg: ASbGncubXjoneLTwy74FIMK+kjgG50MKupNNsicj6PFo5bwWbTjrbC4bd+MP86NxVtV
	JDx1vEBHoFiOUb+NxkXJcXC8Arj50VQ+qFSW9Kl4GS7O9LKF++VNX26OZacgaHrq5X8RS4DSVXn
	oZYcMnqaFow1OScf9y50B9XD4=
X-Google-Smtp-Source: AGHT+IF3Nj6mWpTWBj/+o4tJL25s0CN8hYakvk9PwN70OV0ov5/0UD6xzNyRF97ztJi6m2LHGnOwz76IAO3Cf/tDFG0=
X-Received: by 2002:a05:690c:7304:b0:708:170c:a699 with SMTP id
 00721157ae682-7085f239adamr122430517b3.27.1745857300782; Mon, 28 Apr 2025
 09:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416120245.147951-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250416120245.147951-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:21:05 +0200
X-Gm-Features: ATxdqUG1v-Vp3M3iAycu00z5_FRl29-cbPTsX6LqWTtDPHUaj3lI0F-RZsKBbmI
Message-ID: <CAPDyKFrjaEk49O4T1dfaxmA1OSsFaF_iH3U73mq-fWnbBiRaVw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: mtk-sd: Add support for Dimensity 1200 MT6893
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chaotian.jing@mediatek.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 14:02, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a compatible for the MediaTek Dimensity 1200 (MT6893) SoC.
> All of the MMC/SD controllers in this chip are compatible with
> the ones found in MT8183, but do also make use of an optional
> crypto clock when enabling HW disk encryption.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 0debccbd6519..6dd26ad31491 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -32,6 +32,7 @@ properties:
>            - const: mediatek,mt2701-mmc
>        - items:
>            - enum:
> +              - mediatek,mt6893-mmc
>                - mediatek,mt8186-mmc
>                - mediatek,mt8188-mmc
>                - mediatek,mt8192-mmc
> @@ -299,6 +300,7 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - mediatek,mt6893-mmc
>              - mediatek,mt8186-mmc
>              - mediatek,mt8188-mmc
>              - mediatek,mt8195-mmc
> --
> 2.49.0
>
