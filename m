Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F571917EB
	for <linux-mmc@vger.kernel.org>; Thu,  2 Jan 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735815142; cv=none; b=bjISKagsStUxdivmcAT2frGtSVUQLlrV/J3OeZGbo8XfZrrQHDy2cS+qQuOP9gwX8WvMfyeC5hvIH7nkYpP6Iuf/h5HmCwMOiKol/xNoO+ikp2QltMTXlZfyYT8RLrlszQ0unEUxspw68uZGtLAFWk80VKf0BoQJQdXUGwLke/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735815142; c=relaxed/simple;
	bh=mMF/3PAWbT4cwYrfbRt7SNtYsxbQwYPfM12nGDJoqPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVPgrXJ4jhVo7BByNo9jAPI+LpxgjMuDJ67+gIDLl1wJJKT1VHlEbi6mVN4D5Y4Ca1MLkEAODTQXBHZKWE6PNcN2daSTnProMA7UvAK+fE+rpCAzLNqlz+VbyWFDMqgRjN8jJFYdVEUb1pchLXsAO+0LCz1d//mVzO/js8fJypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X1hbv+CW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X1hbv+CW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so5676601f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Jan 2025 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735815139; x=1736419939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze9LqpjCGSWa0yPDrI54f/7UaaRjSHcJ6CR6aCivtOE=;
        b=X1hbv+CW1mIXR5inMbIRSMeXu/iV+kika7xeuUAOOc8Pkj93e35QOzK2BTqlo9rkB2
         RzdHFjnLfrc+iu2Fnh95De/rfhyxa+S2od0M4ya4jmKc+3yOnguowXtB7ze/BfM7isYa
         1Pea5NJgMQSJfZs/yE/VahCSiqq1qRkPGZmaoaaEM3go+p0yh9aamPbIQDfpHJ2VN6lx
         3qeHQowwLBkOlN/2rmEVHPOtblNIoI3zN3Y0obd8TjBN5F8adYUPZoxLBJGjbzkOlXRH
         5eHJ6o8lkPYKCuK2NXcoXSm1ajMVv2XlO8+FxA7Hhd7eZKr+jGxO6f1drnVJWpW9+RKu
         73eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735815139; x=1736419939;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze9LqpjCGSWa0yPDrI54f/7UaaRjSHcJ6CR6aCivtOE=;
        b=XJDIEXuaiBrHU889n3/pdf3mYL4j61i2TtnMzcSA6rxSEQC+SPva5k/+BZhj+Zv7tD
         C44pP6hhwuNA9dTPJPXXSwu1FIr8DwPkyiWf9w1Bh6VtxP14+fGP6qvoAX9Ul1a3IaWQ
         vpBgw2p/Z0JJuDs4tyDB/Ed8hSzltE3NuoIEtu4bjdkc7+TUUd23hS2WbY75nrh+av9F
         qncLB8r7J8m+R+xpC7p1NaloMgLWNa/DgfLDA4jFhipi+hTGzgRea/xXt060I696MIdp
         WrafumLoSb9jwAag3VDNKCml1vrQEeUYYaL2TpL0wlYe1QYdQQY8r5dcUzzPWbmuw1Xf
         CV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWljqMv9pwzA8DmDpnk13K6KYYiFBoHrBcYu0FLAXkkjeBJQzjelgDvAIWLQ3UeclTH7iqg+21hfIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbSZddlwVtJvIj9xHWlfAY691fANVtC5MtcmYzr27VPd4EXLZ
	IGbAZ/SGfXL9K65o7P/FxaJof8qrq6BycNeS7Rhe55NbMbz9IMuSFsRr6I/EQmM=
X-Gm-Gg: ASbGnctk0mBXzSkBMdmQxm4JeoZUlueOvRvgkX4xXSkCeZSt73m+pz39C8f84O79Y3F
	Vbyux1VXRRlDfkEdjZdejJl6Bok2kA9kojhcFs5CODdChWMWsXn7Wb0NG7uQUtEFrieZAlyUDhE
	Pxzz1qlt8ecMN+h233K8/ptbwhRLHLj5yIyVt9iB/sgVETiC3mY6wH7T0IE7jXTO4viWxothRky
	HrdTK3M/f5LuxjK4SD1AQTbBLmDx1euQ9KHax1eo0Kht1IsXOOBYDgjGlEzvJs9jw==
X-Google-Smtp-Source: AGHT+IEAXmh4Jm/fooPniPUd+cP6NsbK2SR6lviu3UydjCwVbdG5V5GA3GQCHI+v0JTIHRvlmZHUzQ==
X-Received: by 2002:adf:ab0a:0:b0:38a:50fa:d582 with SMTP id ffacd0b85a97d-38a50faf3cemr11500112f8f.59.1735815139109;
        Thu, 02 Jan 2025 02:52:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm490098515e9.33.2025.01.02.02.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 02:52:18 -0800 (PST)
Message-ID: <70aab1bc-1427-44ed-b516-843429d0bdfa@tuxon.dev>
Date: Thu, 2 Jan 2025 12:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] ARM: dts: microchip: add sama7d65 SoC DT
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
 <3f63aebc4b31da1b631ce7e6d76aa0046deeda6a.1734723585.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <3f63aebc4b31da1b631ce7e6d76aa0046deeda6a.1734723585.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 20.12.2024 23:07, Ryan.Wanner@microchip.com wrote:
> +		pioa: pinctrl@e0014000 {
> +			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";

Please also update the documentation with the fallback.

> +			reg = <0xe0014000 0x800>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +

