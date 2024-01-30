Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8D6A33D
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616438; cv=none; b=FIyL4ELTCg+UBFbShcwfp2gWiMJJuZ3R8HW09OPKEH8a2QmNJJ8n99pZu0RLwYQhKZXK/5LB8nheFSh4S8Ljh5rntqp7bjztjZqiGFzVZloyPBjQaUpNhguATMMks0Y8h9ibAvSdJAvt4AaNg/eTt3Ouc42fn2cyiPQmgCPZQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616438; c=relaxed/simple;
	bh=aqLoaLelYrZ0pN6J3JgWRUokx2Qipds2wpILb+2lTaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieMVOGGQ3iYvVsejiNm0INXqWVO99S0ymrbOPRbzGtJ1ye1gfPcZcHjz81/v4A9pZDvwcU1WX+vI0kmsKnliKc6nNRs5UoKBfVQ4R6HT8jxbq2HHeiLcdrM5gXiaLi7erlDgHHYcgZe7INnAbPxOVpLmFx53NbjL8O9XUnUStbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EitumZmA; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EitumZmA"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-602cf7dfeb1so36884767b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jan 2024 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616434; x=1707221234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ni+AcgcmH5VfHuLV4vej2dAUosTsEP3zAXkh9xNEVJs=;
        b=EitumZmASj/hbXlDHVOV3rvfDO7KKwP8PDgm9mUi9TbNQlMWYDUoUVGffSjJfJkcPZ
         sEe6JQGAH+NQZGQlI1bo3PKB40tGz5HZ433Z/VEoA2g99SBcHN6JHvJHRgU7HH3yEIio
         Vwu9lRu6tefLfQtNAsQ5ER2VIPphcVtEsN9neCJMPOO/z5Ruw+n+Hj5TblpfbRwKGAoO
         Oi46lKcT4s1655AHTC0xh3Vx4Ul4ZdiejYL80eWsstlTDdcDtEG1MFYhflCQwoNZUOcq
         wlUqR2b/3B074v7js67FLbJfKkyQzDjMria5EzCNLB2rnzKJo4Ae10PHC9YNuUikxxmh
         RF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616434; x=1707221234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni+AcgcmH5VfHuLV4vej2dAUosTsEP3zAXkh9xNEVJs=;
        b=Y7wan2neC0f5JI67LPS+u0o1mhpHsWqWEa2jnaxmg84p5k6D6+fsmXEV8i34DPasoZ
         VyK7PUu7R8lol/1p85cZGkk4X5YdnNM9o+nepAx82DsCCPsbga/PVqErFXpTzNfoVulQ
         WEaHKgH3TDKVnL5OZVAGy3gY0Wc4YXSIQs/pyUe86se0KdBStS1gMeP55+QB+FlKJTvS
         HyN3D2IjcI+QHF01gE3DlICcD+OWPrtuph0RtYMlS7Okizq40OFzljr8t5OcGiLTx82/
         MTDVOcbToTyq5Z3Bx4J2QCo2Qchvu9CRwoL8Uw1u79tqTfTemrrNa8qVH/6gb3ZjFpLo
         F/oA==
X-Gm-Message-State: AOJu0YyCKsd8lMMeD5uWZCZ9awnOccrG+01CMAK0YsyeIPXaKJCJwBM0
	3OMaMmOs3RdVuS7IZ2BQNOo6XXOoZPOgPuTqNHT9kMzneWo9yDBcJTPcgztwlXsLLcVYAoSjpun
	bxEQMXC3nfrpzgXGk4W5YOa/dDERzwuGpddhmOY7x7XYDoqQNLsI=
X-Google-Smtp-Source: AGHT+IF97Y3Zh8rHlO3hLK/Mjk8VaO1x02zLVeiWpylwm29cwlDJIb7s0wmiWbNu9aGN2bxJSqi6HG5P+NxiatS5//4=
X-Received: by 2002:a05:690c:fc8:b0:602:b21e:876f with SMTP id
 dg8-20020a05690c0fc800b00602b21e876fmr6088229ywb.0.1706616434091; Tue, 30 Jan
 2024 04:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122091623.2078089-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240122091623.2078089-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:06:38 +0100
Message-ID: <CAPDyKFoBPpXTakO0wBXrW0nqZb_xbonqrVH9xQX+pSRWt18ZHQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add i.MX95 compatible string
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:12, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Same as i.MX93, add i.MX95 SDHC which is compatible with i.MX8MM USDHC.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..f3c5aa64affc 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -55,8 +55,9 @@ properties:
>            - enum:
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> -              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
> +              - fsl,imx93-usdhc
> +              - fsl,imx95-usdhc
>            - const: fsl,imx8mm-usdhc
>        - items:
>            - enum:
> --
> 2.37.1
>
