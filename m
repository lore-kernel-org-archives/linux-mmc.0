Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F832451D7
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778732; cv=none; b=GV/teNdirEHTtW3gXCgDvdKEBo8srkh8dNiNb6i7izbd3IUP3Wi1bLTaESuUjE6HsR/FJQxE0iH9GACH9HNptmrJbrRRCrqtCyQWPPiB6JpWEgc40E7QR4CplWkVCrTq184RBNFgtNE8Cfo2AHNeSyumXwJQh1kYdppsCHx6++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778732; c=relaxed/simple;
	bh=1wvMq+p0b0LHsuXs2t0D9kgHbJ0JEDZN1CXO+LT+A8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnzPakUlfrO4iY63pXJ5be76lVnTOzQQvLQsxuUi/mjXUBhRgfG37UCa+YISe5rnZ5Z63sMZSILNziV+ya1cladls2tn6WlBqgrr65kK9hsPVdeU/xm7xGJlhDVEguzkhp/9uy8Pq5y89WP7vVl9xsO/FyUtXuSk6eiQBjPlRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcwtAeGv; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcwtAeGv"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fd80f30ba5so45991287b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778728; x=1742383528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dadpUZC9V5c7MYnunblVKwFOdnOlHudqlcLRPnjOYeA=;
        b=xcwtAeGvbeg29VdHPHF52EjNcGWPoR5CC9+YRm18s3q7zZx05h0nuhdSDn4PXwNQ36
         5AnU1v+RXDRuvZkw/Xie1Vqmug+Rml08kdNbIZMj6wn3cdZ+1loJQX17nIOr9rpuyFfi
         XNDuAPYl+b5bWJpTQJSlVhTTd2gV91T1WdxY7yy5vaIiePk5G56uIXnp/traCZSElQqi
         G5xFeCKjYIeynp1l7fqes58uKFQiDmxkoTTb8zOxTFk71+WPqmza8wTAl2BidF3nbVY+
         e38nuRQq7GEW3wX32WF8RYyaSvLLRvrigdRy7JbQeIEZlrrwq09gL7KvFYT0/3929tZp
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778728; x=1742383528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dadpUZC9V5c7MYnunblVKwFOdnOlHudqlcLRPnjOYeA=;
        b=ZfDq04vWFv2OUHbpHHBj2WuTxg0TOdAhF/ZBk4o3lpZO7oOo+F21KN+al4udN0lrZN
         WteNYQHqmGbO1kYqivPl0rgArUFjcbSSh//VIoukQV5+zd3pk2wycPb7fj4oNInf/lD3
         jqxibfSvlh96h6J/gKCugXuhXA/ANY+jQKCaRycT9K0ijLiiHzU34pZtyiIz8jEI6M+/
         HKLWP7XYo6YmOi6LRkFIPxsdO4puaSKdAto7RPft1yfCynOHhT2VJWsKV/x4On+eCGBd
         UcB2Ml3tCapOTiVT2GYZEqNfoVegbn/WIgLgoNl6YPEkYf2CyODmj8fhNNR0K8niZC57
         iMsg==
X-Forwarded-Encrypted: i=1; AJvYcCV3ySdFnnU5xwt0inpNVE4Dd297UssNjsrIN+2g/mNHsZ1LhuevlK+CSKvXeskfaMF0Uum6U9saYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzemWfmeeF/Sh+EfCLIB2YHmArdY/5RQg5kVZbeHtZp82+7+mBk
	6ClacxnEaXsBLyponoGT0OylImD/HLhKE5B2UBgL7H0oA/XODidMejTQcor8TEyn1YMVHYzY1x7
	SbXs8/xHRsSQqhYQNj1omk7qDfZgyW8+P9SKPDg==
X-Gm-Gg: ASbGncuGbvq5DuDEktPEe/zI1/lM3zxK5kr3luaofcDHXxR4tHJ1ZyPpXhxea8LJWEz
	F0Wg+zK36zvDBO7raqOZg3MR+e0ipxpM8acGc2HG1ZVVtJIYOUlNdskzbJKlL7c/BGgiBsUezuX
	twbg1GdKpZUtX4bP4ARey8OH8zcPk=
X-Google-Smtp-Source: AGHT+IEkegzJ/XAYlghTUeG+wVwA3ds93Wxe6yvoeV0jHqydpXmTqXQvt4bDvlouPz1OikUEEzcCwOPsAA9n/cL6aTA=
X-Received: by 2002:a05:690c:3802:b0:6fb:4c11:61cf with SMTP id
 00721157ae682-6febf2e67e6mr312924957b3.19.1741778728184; Wed, 12 Mar 2025
 04:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309055348.9299-1-ziyao@disroot.org> <20250309055348.9299-2-ziyao@disroot.org>
In-Reply-To: <20250309055348.9299-2-ziyao@disroot.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:52 +0100
X-Gm-Features: AQ5f1JoG4yNR3eqoseTNZhzIg7tVbmXvgNO4DfacKMnpZftoLIoMXOX2r6zD6_U
Message-ID: <CAPDyKFp2UzcxfFz=8sREkj3x4DvfkfxU3utc0+e+uPS78Tn-+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mmc: rockchip-dw-mshc: Add compatible
 string for RK3528
To: Yao Zi <ziyao@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Shresth Prasad <shresthprasad7@gmail.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Chukun Pan <amadeus@jmu.edu.cn>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Mar 2025 at 06:54, Yao Zi <ziyao@disroot.org> wrote:
>
> Add RK3528 compatible string for SD/SDIO interface.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 06df1269f247..ea0feb733e32 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3528-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
> --
> 2.48.1
>
