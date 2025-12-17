Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EE1DE4E0
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979141; cv=none; b=vFE+tQsQY1mElGZqq2RcZ9FmhxV5ggmBWkNNhXaUFG8ehA/k9zsgkwGxGDMjanhxSoO7lONMtgbRnR1fJvM8QQgXJKUEu1mlMgU7bWRfJGYGkjPGEFIAOBpF/qgEy9IohJRGIGALTzF7YC6NfjF6lvv/Owcf/0yfY4s3NqYgxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979141; c=relaxed/simple;
	bh=+zAuUq02Bgcmg/0k2UZ03T1O/rsKv7Es3qJ+xUU0dEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak7APJmXVStGFQzA8zCwJOwoZ6FRt6YEQb035DKBaJhjpOJIM8RR17kkzfZYGe51JVj5e+m3aJuLX4dYsw4jw/YdiEU8gAVVBsSZxORL9kMiIq5b5FQqvNbwJ22EMrRlAxhQhDXJn22T2KT32nA2lnyQYdPYqRoc9mcfzjHeO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEFr3Oo/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEFr3Oo/"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso52648431fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979137; x=1766583937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Am0LHG9AFMTHY53IOE1ujfJ8n+RIbg6P8g4jzIMdmU=;
        b=EEFr3Oo/RK2vFP/WdnKzXfQvIQ+gKnb+9n1fZtuIpIp482aNv6rJjul0j68YqrGudo
         o8hNlgL89D4jEg6LvkjZOGdbEytT4mC+A5WTUch0DcpPWBtPSen+9fpkTSBHti4UZzDu
         QT1vLBCdRC/aMytbcOj2d8CoZ10lyMnWgYxDfGTamsKhXiaw8G/kGVJCSinxRNZtn4Cn
         7qH8+y3TpVTcskdmi/XbmouCMVMeVxHKjhb1N4LTrUF8X2XxKyCIi3jOxW7vscFfucKM
         1a7EO5lgCK0CZe/KkeLF97PhH/UcwfrOG7ilR+azLck6uMWFcnTDGtXHB7PKa/bvtnn1
         tUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979137; x=1766583937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Am0LHG9AFMTHY53IOE1ujfJ8n+RIbg6P8g4jzIMdmU=;
        b=Ro5IHFAwxgacvS/46mmz9xt03M1h/6J43jOmo/g/fSZ2VgBbo7AO1Uk0HBrGiVGGOB
         goyTaPgU13fikjKp1jTiWWvdf6NGInPUSbjpDqh+1iB8exXl14ALD3Dliclng4r5OrFB
         sqd4Pa4qitYFxmeBeiKlWwHBMPrvo84Y014hfrjD+V+HCEEXygVMqKHXMvjrxJmhH4/s
         Kqasz5jLHHj6CScGo/SYVZ6jY95TZMNLRPB0f1TVsYKU9PMWDA1Kq47jce5MzPGqVFEx
         DZlfh/v6xAjzuH4Mv7y6Zc1FWW3NpGGSYDtbBZALr8ZYv3s3inAtX7syXzKmdq/uqp/G
         1L9A==
X-Forwarded-Encrypted: i=1; AJvYcCWRyqaw5cPJXHE96cS/ubngsRvBK/XkxsQN1hekta7vwb5uoFzyCXyFoTereDQA1rcua4FmO2Z4gPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrAmwhZ78+wfuDlzc9S+7XSTS5K8c/BpbmSR4oUbtHZw9cf+I
	0vvdY27OcllMKM3Fd4WC5ZuILEOEX4fvMiEWlOiPSBnZt/x9OPtDslUIxfqQhmpoOZ3GWyRvjwX
	iyOzgZ2Y/rIDgGs5hXajgKiR3wlLoax7sPXU6h0qERg==
X-Gm-Gg: AY/fxX5U/PgOJLs/YOkft/qDR99DqGEWQsk1molnCEfInnbdUC+tVl2HO/hL4AVXJ7M
	N0bKsnaccOU2SPNd+5N82jBF2cPngpKK0PJ5XmtcdvWoI4v0Z2jyz8KjcfZuP4jEPSjxm9Rbyrx
	b7DvXzOn5MIWxcGG5DKbwo6YyMQ/so8WCXjQK30hzbdFHL8eiNkxKIyKkV178OD5ssFI9QNZgkk
	aoqENktGetgGGVtiKyqQ3zlr3W7cEQtVZbg01moWjnzuQmr33dH+0vaOGiFTCCStdgrv3Y=
X-Google-Smtp-Source: AGHT+IE4pUbxjRyhy6TNzG/Nfd5tcjceyB6SpLIAjY9OMlINt8NVyYcF87vH5C6t0W6FjsUPLlCSHxNZJapmN0vvQKs=
X-Received: by 2002:a2e:bc12:0:b0:37b:8bee:87f6 with SMTP id
 38308e7fff4ca-37fd08c6eecmr54455011fa.38.1765979137280; Wed, 17 Dec 2025
 05:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215212736.3321550-1-robh@kernel.org>
In-Reply-To: <20251215212736.3321550-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:45:01 +0100
X-Gm-Features: AQt7F2qrXt3fjvzfhy2YNvWmdMIJYPs4GlYbGWjBbEeh5dwzllyrWc_OzDcLLbY
Message-ID: <CAPDyKFrQ0Pm6524L15wrtAh_yyH4URWUf-hVELKsKYt=DiQ_WA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: Allow "dma-coherent"
 and "iommus" properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Saenz Julienne <nsaenz@kernel.org>, 
	Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 22:27, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The Broadcom iProc SDHCI controller is DMA coherent and/or behind an IOMMU
> on some Broadcom SoCs, so allow the dma-coherent and iommus properties.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> index 2f63f2cdeb71..65bb2f66f8cf 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> @@ -26,9 +26,14 @@ properties:
>    reg:
>      minItems: 1
>
> +  dma-coherent: true
> +
>    interrupts:
>      maxItems: 1
>
> +  iommus:
> +    maxItems: 1
> +
>    clocks:
>      maxItems: 1
>      description:
> --
> 2.51.0
>
