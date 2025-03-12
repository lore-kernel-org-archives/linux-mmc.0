Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3981423F411
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778720; cv=none; b=oUoevrpDrEegeL6vdHKBrwE1C+eqkHOLRQ3j9SX6oIR5Oa+YGc8hVUOSsnb3bKvDupT+fOaOeUMxZw9iLJ0AZPx44iFQhkLnQcq/0hIEUHabtFdhFICKKHNRGcpeE0hk1Lv7abV5Ko5vcwtoEm6hhOHj8RO8azwC9CFSsVzGMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778720; c=relaxed/simple;
	bh=yMvqv5UmFT7AIpq8F8YeUqicsmsyJRqccpHBeoe274Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4xXn3l3bxlM08Qze5EMvkl4afdNwNweHGv17YYaeihIGr3EdULTqvSSvpnievwg4FmVxsPmi2ZxdsZs4FmlEa6tE0OfB7Wm8dMKQvtMi5lhvdw+QlM6l+2JULTXDd0lzTg8F6q0jpum1pj4zX518h3ueoE14aaRDeedjdcyZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8tTnLeS; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8tTnLeS"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fead317874so58265467b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778718; x=1742383518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eq7CbEnzO7luGgtEaDN5nrJnBFu8hWWVpatVuYHiagc=;
        b=c8tTnLeSGtlwgoeHahliIAdX75n6agHaNt9LmL7xRqe2mJIgZ+0x10HWALD//U0waE
         HQO2NXxVI4N21D96uTQGiJS+EuD+han4zrgnZG/y5ZWb/HI3O2H+ICwUwSjHwXzVt3oR
         /80NXdBAWtQZ3QPWei8ngdvJe83SkA4KFsRjuB7+vH9kjVDwGy1bS9yr8n4fWmGNVvRf
         iRH9jx/nVG94cFoCKszqImXQsntqWJiMTy4DZS/xqutW8FynZQy+tquQETcIXFVgdAU5
         zSfe2pxdfInPXjaMDeJvhFYlunxtujx5FK83WnxIrmPUgUc2mvymTnkp2MyZNG6gy0FU
         bbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778718; x=1742383518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq7CbEnzO7luGgtEaDN5nrJnBFu8hWWVpatVuYHiagc=;
        b=B7nL4LDi3iJ5EwD2m7xQo4SCQJT0UidrNZP2rI8M5tgnXvDRUZ7LYCtUIbXDAMAT9i
         Av3d0dsCIhLMx5jXjA5gm9ITvRtaKVGI3ZvK1sANdOvA4jmsMxjjR98QzbWjm5fZF2uV
         RHBBZ0iAtHwQnIKi4dOi6+xqokre0euPU9K1L8tnplJ5Ec4i5DW5Sv+bbtzS+14bp6iU
         zC0TcrFa9FRO/yy9f4xQ88L7a3KZwWjKX38souqD3BRLX/5CA19K3dMPur8pyo6W52qh
         L7Iuw5OlF2//X8Bm3kC9Nh0jubzyY4nafvPn1KdTntmUsdBuyNXYX/j6mAVq7t/cGw98
         nxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIoxKSSHmEhIbvgfJkaHYisbm0IYmG8T6UyE724OBKXukEwUhrSj8Pzx44wAhccmBjkLDya4yViVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytrYBV2/DW1mK3UalVClVkoKpTdH1Ze1JuRitDxSJVWQYHMiu9
	ygrJKPLfLO+ek4y74YYZMcPNgX/sN5FGuFiJe7Cfd/pOO7AOnx1yVvNCeLNrkkmR28suHZ0YKqo
	9F4RkPkM49rwpfH0yBXCo1LKH0bH8b2F0Tg9BgA==
X-Gm-Gg: ASbGncv5YU9L8IDPHukvdCAYzhBqEts9M7v8bYRERanC/Xby/RSXMv874Rsbr53VgF3
	mSEKwuVkiv2zDqJ7MlkDuUDBuwvKf76KilDc12LvhWB7LZWKoZRgSHw2wMhVmOWkACqr9Brrfwv
	ZXNWWIkTkLuFBj/wySM7p4keaL2EI=
X-Google-Smtp-Source: AGHT+IF6eG8PozRnESEd+R3ZnvGLnXtUo4BkvfgZwwoCUSGgHtU5TC7KInrEna3NWKS8wRzqC2uVDFF7ZV4wfbroPfU=
X-Received: by 2002:a05:690c:6f12:b0:6fd:9f44:f3ab with SMTP id
 00721157ae682-6febf2f2438mr302004087b3.13.1741778718231; Wed, 12 Mar 2025
 04:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227111913.2344207-1-kever.yang@rock-chips.com> <20250227111913.2344207-3-kever.yang@rock-chips.com>
In-Reply-To: <20250227111913.2344207-3-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:42 +0100
X-Gm-Features: AQ5f1JpJoF0WsaJEsGs8Ev2GK1W0qmOLgd16kceh61tUecpXUlKoJF3fFSj3-Bg
Message-ID: <CAPDyKFqmODGkWPA5Doc_6HsfihxnoABzu_1QvR=03dqXZRFmpg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: mmc: Add support for rk3562 eMMC
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:19, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> The eMMC core on Rockchip's RK3562 is the same as the one already
> included in RK3588. Extend the binding accordingly to allow
>
>         compatible = "rockchip,rk3562-dwcmshc", "rockchip,rk3588-dwcmshc";
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - Updae to fix dt_binding_check fail
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index c3d5e0230af1..2d5c9931f623 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -14,7 +14,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: rockchip,rk3576-dwcmshc
> +          - enum:
> +              - rockchip,rk3562-dwcmshc
> +              - rockchip,rk3576-dwcmshc
>            - const: rockchip,rk3588-dwcmshc
>        - enum:
>            - rockchip,rk3568-dwcmshc
> --
> 2.25.1
>
