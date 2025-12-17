Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008A33556A
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979136; cv=none; b=JyIjmtmHvLdydovRDN7paGX0zSs3LBsnkgCcB1ar4k4VYxmF1nRYUDUW6/mpKUASSqP2bW4nOVzW100jt+pfOteNfX9YxCU4IQ66Qd39Ku7lMp8LcBF9qIlj/IyAv56C3p5ShJum2IDJRuYH3X+x6eqy3Ha++tNJz7DBwBBwN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979136; c=relaxed/simple;
	bh=XxM58hwtj22qUnWvSSNaFcxRSb7qgw5fmCYbYwzSuMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3Q/AJDSlRbTwKAycYq7J+IpbH5UQt4z85MG7kl4HaA1x1Z/yVN52s4ZRuuLrFe6/ZxDg+JUkV+3mbMwhH4TsYc530w3ZkUVD6stI+RGMTsl66XlqymWKtGkEMwhoHM7LFHHrtsunjEAW+i3Zz1zUSZqM5mMUWU63n4QKTBGwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O29D9vXF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O29D9vXF"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38007fa1efbso10509981fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979132; x=1766583932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQgu+jrAqJ7zlM3HKiPD0UlVUjyuw7aGjbTjK4hdIhI=;
        b=O29D9vXFvj00cLDYlivHBmr1U0hp1bM+Mh0gF3N6X5uFFMDpT45HPNtU1lZmz5W5Gn
         gjM07rDtNgrdNhEDb+wtFs2KLrR2xaey3qv2uKICn2L+3TBa4O7zdnu37+guBPgSMwz8
         ofdQkXt+xpGZUN5lQ6vOgwCZbW9Ty7HAfEYltvEAEl9zyf1hZxXmaVnzjb+T16FZmVCJ
         jBYgtUoOzJ3elqWEsJ0yNvA25QF7tcHqKIY+XwCnCYW8bTxdvCi92qCJmLA8QOV/C9nx
         SZSM1wvTiwtInaLXpMOSNdGA7KxNMa6M1VreqGfSX9+vjDTou4saRRxR6jMae+9MS/Vf
         fLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979132; x=1766583932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQgu+jrAqJ7zlM3HKiPD0UlVUjyuw7aGjbTjK4hdIhI=;
        b=DvnRKwKmm1uGteRWXISFiNFeA57jPBAD0wazS6wz9D1Au7Yu/4mezzWdc7A5irD/Sc
         Hl1YXVU2oUYnuwv4ezqJJ0y7L279nr/na8Nv5RKvNQR/nhOc1oQWgSvskIzpHG/G5pAZ
         D2QxrQr8GFj/74mJbisVBZ3T0E2xevOF/pXfXiDam0sul5zCo8J4kPKgUv0gbf8mkn65
         Yt8UeTxhFVAZtG/GCsp4dXB5/j/XZDBvu7TTB7JypXILQJiOlCELQAR9xBztuhQCb+Zw
         oGJ4g6/iYQS+LSrULVx3sD6W/Ef8+wZVByMSgovdWOaVVZLc3UBZM35xTJhoafiXvZrY
         7WHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/bJsIyCh0gehoYHbSgzGgUNgjFsaNHD99kGeQQmNASrpZRDPklu/mNr6Z88qaEF1dF43jIZs3xa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVsKmEN2Xl9OvrOyxC7kpdjqcjDNQeA66WxSp0+9ioTu85QVC
	0oe7aORoviRimARpVoKpo5EeFHEqLxwNoABq/QdN5sFX0qpu5D7a3IuJ+JQUG0nd893fY4v0TA4
	4eSxrFmyqI6fUIJqADvTQiQNvlWu8Psy7VLAvtkSyZg==
X-Gm-Gg: AY/fxX5wdMWekHw5Qtrkv6OKSyCzDJqdrRtWsmK0m6GT8X8kgxIgqvhBYAGOz5yr9NO
	D8m6k8AhfYKe9OSBxcDq+vlPQ3TE9YmKioUd0+a+NQtGLwbE9DE/AXxZEKOMKVDTSJb1D/C8SCC
	XuD6hxy9xcGv2uSLXTiRhQGGcy76aDj1nG41dtEYZKDddTxOooWNN7RQT9wdEAOeN2KR0p9mCp/
	aUuJnwfpznR7esTJ8VJmrtrFM9B0Q4f30xNNLehk3+2Di89ZclgmNnbjCYzO9B4EUpRAx4=
X-Google-Smtp-Source: AGHT+IEfRhud0B1pWkJS/wAztFbIm6G//tZdQx6+V419o86fVM7qO0JyYtfpWDj0XjAhgMoqylfDNYlBEY4htHAkmmQ=
X-Received: by 2002:a05:651c:1546:b0:37f:d484:599c with SMTP id
 38308e7fff4ca-37fd4845ca8mr49758851fa.28.1765979131922; Wed, 17 Dec 2025
 05:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215212751.3321878-1-robh@kernel.org>
In-Reply-To: <20251215212751.3321878-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:44:56 +0100
X-Gm-Features: AQt7F2qF8MEC-0OIk53PCkMR8aldrM0ymw1ppI8HGcJSnzd3fJG95KQBdaDGnfc
Message-ID: <CAPDyKFoyxOBgqQTTJLFZ5W9iZj0gEiBDAT-V3h_zejqbG1mx8A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdhci: Allow "dma-coherent" property
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 22:28, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The Arasan SDHCI controller is DMA coherent on the APM merlin SoC, so allow
> the dma-coherent property. No reason implementations can't also be coherent
> and there's not an SoC specific compatible, so allow it on any platform.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 8e79de97b242..d6b6fa6dcffb 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -121,6 +121,8 @@ properties:
>        - const: clk_ahb
>        - const: gate
>
> +  dma-coherent: true
> +
>    interrupts:
>      minItems: 1
>      maxItems: 2
> --
> 2.51.0
>
