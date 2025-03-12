Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4514244E8C
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778724; cv=none; b=RSaDc9N0yIzFqEw5vOus2iyWZAYzIzDKJXsODkLglDQ6pyg7YxRn8zFji6hRzIJZz1/IHq2cZ3rRrfYMCDrDNjVG1Mg+fBBM0gHR0lEIzhXyOAckL0l7OQIw/Zbt2RGw+8s6V4AyJv45wq8xaNYB8adI11nv8EA3TxvrgpM5doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778724; c=relaxed/simple;
	bh=/RhKTxmR7DPjGeSaHLhrD5HO/cS4tcbus8dYscpFo90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC+K9Jj0sCUIfNsQrQfgscjktDr59ZHt85KwvP8QbqRoohSiT2usOzsixH6Vrh+WWjW/zi3oSk1XbVZrjR5yG7kF58PpvlPkq78qm1m/SDXJcqfbySzlciTknLxYVZNDaphswSev+zwGU19LFf2skgXKEzSVpHe5WtJSDY7Wbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/69/ZqT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/69/ZqT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6feb229b716so59571857b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778722; x=1742383522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EF0zDFUflzONesty7VuCi7dpM8v0C1RgMUVQ/Huc38=;
        b=H/69/ZqTpuFErBCCv93u0JDMhKxcLlcBzo/5RXJr3b+ozudnvvBXNo4PDdbWvBoBd3
         0dSqzGfkCOqdByizKIbXgrV5r+UEkH7htwLMMtMNUDF965MwRf78Lpz4QxcLIWjqtMx2
         /HPNoH4fRTyIbjpkbRs6InH699xDY7VfrMVUL9PueBLKxXKY9gK6YOvXdla6wSO5j+08
         dtj5oKZMeXo+GGuDwuwl0bAFLDJLtDWCPaQEHxhJ9CHjXxOlqjirfPQZL3Qsb6DB616K
         Z6wnMEDSo2YI6j6SN/38nXjt27MDGateU9Z2kGh3QGciOZrvpkRIMrePCO/Xx1S4Bjd0
         Bjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778722; x=1742383522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EF0zDFUflzONesty7VuCi7dpM8v0C1RgMUVQ/Huc38=;
        b=oHMI9VgfKcCWknp3iB26yfxxgUzhI3CEgdgcLBzqE/cIM0HLTxpv+JXh0tCn/YB42h
         k6CW+wC5olp8firMjq/sRJ93eqPH6+lkfRPkOx/lDnMiB2WUsZG2jy7McxH604IrALSV
         rEPvefJ5e9MPN7beYI9XWxh7yE1WfeO2OVA0kXYhN/F/yLGgY7w1btZXcDBKdVcfjLuR
         qWyS3Y9VM4YP8xNQ/SbIfikziaOMN48YPX6ERhfjwFAFbkPw3QYYe/fMXm/ixbduK8HK
         55GawUtUFhDGwjXuUEjiOCUYohaEBZxaPfOIUOwO6nmRU3Ns7irgc4rRB9VCUq3WfSSf
         MJyw==
X-Forwarded-Encrypted: i=1; AJvYcCWefWVmEo+I8pPf4R5RF8HC/ArTFmqq3f9j040FIgG/1VpwWaEDc4TLLcq5ldhfCcuhotzQaIjUdpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVe6CxzZsBzu6yEiOLosYkOOcypZmWA+VDscaU1U8lQh/TSfpi
	WheCOCtjhlTgsk20Cfxrx7iVJ5u9k/aCMLXHgsqIU984GpQPz6USmKjh5fDM7QMPQU7uRPqGuoK
	qhnOlnCTgSMmEC8SdNILvcKuEF8sDCN62BRHuNQ==
X-Gm-Gg: ASbGncsm8ch6OCVilMQ8Rzn55TR+AyCDrLgC7XxDT5NhEYADUyQJPbqd3dvgF2wZ0xn
	01OOIYFMbUNKJ67GpfK4xf0CoIFb6x4nHOAxqiSBlE0Sk8w4FA3AXWJZdCEwYDRPJF+dlpWCmUY
	aMubB/F/IypIWyyIvGQPVTZo+F/W0=
X-Google-Smtp-Source: AGHT+IFqygKUb22qwAr7SdPFa0reMvPuoDMxSiqht7LJBAA6dNVB//vX5+hUcQlzt9SsFOYTACa28ZoSjTZLQK0COho=
X-Received: by 2002:a05:690c:7441:b0:6fd:385d:5f10 with SMTP id
 00721157ae682-6febf3b354bmr296734367b3.35.1741778722003; Wed, 12 Mar 2025
 04:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227111913.2344207-1-kever.yang@rock-chips.com> <20250227111913.2344207-4-kever.yang@rock-chips.com>
In-Reply-To: <20250227111913.2344207-4-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:45 +0100
X-Gm-Features: AQ5f1Jo1-FHRoh7DeYJjPWlq5FRe7dVaoDojoDTMYnsv82KnWlepC9mm2gadUoA
Message-ID: <CAPDyKFqZeup0hKqeHFV6qOMpFYZLQOdj3xT_6PdSNWJiW48fsw@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] dt-bindings: mmc: rockchip-dw-mshc: Add support
 for rk3562
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:19, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> The dw-mshc core on Rockchip's RK3562 is the same as the one already
> included in RK3288. Extend the binding accordingly to allow
>
>         compatible = "rockchip,rk3562-dw-mshc", "rockchip,rk3288-dw-mshc";
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - update commit msg
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 06df1269f247..772f592291bf 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
> --
> 2.25.1
>
