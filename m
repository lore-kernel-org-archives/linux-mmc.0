Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1A1FECD8;
	Mon, 27 Jan 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978077; cv=none; b=MeQhsgWEpUpHxwurJWotS29qhP09HiEpCbCwa1GyM/LQtcuU19vX93kh61+Sk9nEtzgCvQ+7auRdIkoEEa+JdamGYT3cuERLbUeh2SuGHAemtwd9fOTFnjq0N77OoN5MAiNB3Y1XZcVwgwEVTqsFvTl30d8px8DBzBK5irkL4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978077; c=relaxed/simple;
	bh=41k1zKHv/452l9ieSjVuoTmdAiQRorOWqSk+Q2bFOWY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkntRUhrUhmLTM4dk7v0F9BTfx4QYYYhilFZ6n1qoaOA8gpRtp3ODyBS0IzA+HxM/+Nc95ZUS51XS67EkLcW3c+zjTrcL8Q3snoD1/e81ueKheVVyUPv5SZu+WUGMEndz0fG4X6FUeVkOEQOzHGaJXCDqo6x5Ae/WdfAp+WU9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0X4XQFS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0X4XQFS"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43624b2d453so46788735e9.2;
        Mon, 27 Jan 2025 03:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737978073; x=1738582873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v0wE4P228NG5zm6ve2xonCuTbgzrvTUWCSJfyvGiQ0E=;
        b=W0X4XQFS1b+kWfrtbso23/imQye012DfarnYIYHIRq2V3uSGfDvX3/UhdDxk02Pd69
         Zvco/5dU4DUEzYJWuUnH70/NEqTSPRWgovrkNENjoTLDeMSZUqUGew/bzyLLRL0kDhlE
         IzczhtRBot58b9R7XUHUaxQ2JpAg8AWaWc/UfpuelaDd6APPYVH1+w8YlrsBj+erS4Gc
         xOf7ODethP9KtwV8kny/3t3ze3m96ZB6llekx656Hao1j1dGaZZpjwG7cbYVlbPSlHRF
         HkL6ni/Ym7BFkCoWrmCeHS80IzFyaX6IRP+zhOt/nooI3ALMS1xKEX5XcCrOdxv3P+dk
         8rIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737978073; x=1738582873;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0wE4P228NG5zm6ve2xonCuTbgzrvTUWCSJfyvGiQ0E=;
        b=Y3glBpqJwQ7V9mJiGrwB273Ss3f37NIZzkiIUB+37Yrb1zYMWC7cz7eBYtIoEP+Pd5
         d6PHmkxk3FcHW8PXlmMt+dhIXCv/zsuusO91e/e4qriSLl9ElJBWRK51zx7soM4H7zPY
         1WBmWc/xIu3+7hAqwWjnsKLq3ei4uCkXRch2t31ytGCd7871zbIApXgjI+4ltmbHGQTR
         CLGxfsrb+EZklsZGjrYR0rl2j618ZNgUBJSM9EQSs/Q9xMnJaFdngrB1rQx1uADJVZ8e
         gqjm/m/jpc+Pott9wFXQi7kciu+Ebj6qIdaEuotxOxvXP7fzLkx1DQYRrdHO2jmpm1lG
         xJrw==
X-Forwarded-Encrypted: i=1; AJvYcCVVDBPe9Rm54yIIEOP63rpx6lojWfbDxXgkz/jwXHOwfFvZednvgCWLAgwFVZLhAL/mXo4L6clAgEBopPjp@vger.kernel.org, AJvYcCVXLX5bD0t2RDzV87PSclcU35hYU+ctEzGjxsDGjDrkcHSbWxZQPYLRX5q57QP89wPQdDutcBf5sgTl@vger.kernel.org, AJvYcCXM62Zk1XBQIgW96vgujsZ32/yFaokrc/paQTZdXnkleFmEUp2EDB1/NXvuXtA9JF58UE8eneIwUvIX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VstaUE6lGf3Sa2aXPcI7aflBWkzp5LJd+mk6PGY/2I67XpIr
	lKKdKSiCpa9W1rx7gkVnJh5jEDG6032FHDxDPTjU2cg/jEstFELS
X-Gm-Gg: ASbGnct1VYAY19icIH4r0X8BX/gJYIBgPaUnWELwIv4EWA2eNdNT5+RFlFCMEpMpAGb
	DLr4UMwsKDvyadADJW4t3aDX+3/4tM0bFOVzUViKAXomsemLeZ6YGmd1yPoOLQzX4omNz3SlrCl
	T4M1VdFnX/9v2jvg21dCwzzz8aphqmbuxkcH+WvzHZBF2e9i4GgXJ1s61qNyTTYphbFDwE3soNy
	hrWtQtpC1A/KU4Ph3dArzGeDeYoVg+hUJ0h1h+fqo+Iv9kYJ5k0rPA50y1ZXtAOlww48+QKj8j3
	xlMefGZB37v0TWw6Dn0QqVhuCzkKpzE8sjn+
X-Google-Smtp-Source: AGHT+IFBKfZ6lr05IuG32kozsCnly6M7wesKyPODFe2rVTS28RG+C7fl3v+/QSC5xC9yaXhf65GrcQ==
X-Received: by 2002:a05:600c:1d20:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-438913e1b1fmr447704935e9.11.1737978073350;
        Mon, 27 Jan 2025 03:41:13 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f367sm128606055e9.7.2025.01.27.03.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 03:41:12 -0800 (PST)
Message-ID: <679770d8.7b0a0220.b6f23.38b4@mx.google.com>
X-Google-Original-Message-ID: <Z5dw1q4hoSsDWjNA@Ansuel-XPS.>
Date: Mon, 27 Jan 2025 12:41:10 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
References: <20250120184728.18325-1-ansuelsmth@gmail.com>
 <20250120184728.18325-2-ansuelsmth@gmail.com>
 <20250121-zippy-umber-fossa-abbfb0@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121-zippy-umber-fossa-abbfb0@krzk-bin>

On Tue, Jan 21, 2025 at 08:59:19AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 20, 2025 at 07:47:02PM +0100, Christian Marangi wrote:
> > -			pinctrl_select_state(host->pinctrl, host->pins_uhs);
> > +			/* Skip setting uhs pins if not supported */
> > +			if (host->pins_uhs)
> > +				pinctrl_select_state(host->pinctrl, host->pins_uhs);
> >  		} else {
> >  			dev_pm_clear_wake_irq(host->dev);
> >  		}
> > @@ -2816,9 +2835,12 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
> >  	if (IS_ERR(host->src_clk))
> >  		return PTR_ERR(host->src_clk);
> >  
> > -	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > -	if (IS_ERR(host->h_clk))
> > -		return PTR_ERR(host->h_clk);
> > +	/* AN7581 SoC doesn't have hclk */
> > +	if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> 
> Please avoid coding compatible in multiple places. Not only because
> above check is slow comparing to check on integer, but it just scales
> poorly and leads to less readable further code. Use driver data with
> model name or flags/quirks bitmask.
>

I implemented this in a more compatible way so we don't need an
additional compatible anymore. Soo this series is not needed anymore.

Should I flag these as not applicable anywhere in the patchwork systems?

-- 
	Ansuel
