Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F359214A70
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jan 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413794; cv=none; b=i+mSdnF+sez3gtzdLSCCZICXV75mOvAc9+4vRoSzgn3wbsvmhCT0Smz52yvptrJMnnMt6ZtO6tBZ/U6L4c/33lUGXRurmEwbDGbheEcPlxHB1sYRrsJA97QnsFO6+a8sS3Wj6FLH0nFvYTVgej9J4X/+ufsKn41ATNWtwlUf/gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413794; c=relaxed/simple;
	bh=QfTgaoKC6k5LZg8mj2xJfLsTnj4oGukAD029k6OgTLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQm1KuM0KFOgQaeoLS+BjwNAZ4p2MTuPjxJR3ErUpbNPOpDi0sEeq+IhltnBl3/gdkbsziCKVfGKBx0FIIMhGfd3xbGWlhb8dYTa1LKT/Zw9DRv+JTysD9z8psNpkKKuXjyjDaQG6Fl+WKVYVW9GbAttziJ+6B6YPOd8Nrun8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oj5sSXdF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oj5sSXdF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso280168f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jan 2025 01:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1736413791; x=1737018591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDrWR7h2raxJC/jFcGE7XFAhit/WhKwllzn4v6e25aw=;
        b=oj5sSXdFHoL2tb7GWncbFmSriWZwpkWSzRXxuM3cpKiFFDqo4mko3QzDJasppHiiP9
         rICD/WGXVk4e/gmNIlP5LzuWnW4oebvQeTYyTsSXjSm4rHnyuWyLl67usPE0syfeIxmI
         W9iIos95jWnmCMuYEmlpa7C/8FSeUFSQx7lmve7jDVqMKiAkzvC10eolsuXjucpsO+Iy
         4tQ4d1CwglC0AC5KiFFNBUTBCN1TFd0n+4CdYMQGs6P4c3QBoHI4WRCPk/zaSegVo2yF
         XDt7RkUHXWleJ4OH+r58smEIwSc8p6+QIfLKkqJ2whdSh3+GydBkqmVviWr7vJ+TS89P
         8cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413791; x=1737018591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDrWR7h2raxJC/jFcGE7XFAhit/WhKwllzn4v6e25aw=;
        b=mw70dFwvq6hvyHjbKo7wJE0a8c9UwWjNkeJbIYqDG6vceqTXMkwDQDx9GsVp3Asn68
         OMdkUN4YahHQ3rl/XHxe9ib4slcSWk1yYuWA+bC3WMFrStFt2ybmoFDZTQOxWq2jtGT4
         lF7nOfvAY95pgw43q32p8h9sQD/nC18OuQG1udgs4omqlKqQwOYlWxkXeEM8q58ueCiQ
         bn1i4w4U+BzabLQhi0ykOTaWPXL6gWTHTvbdb3Mp/fSCJX1/P48EhYSXLtdyLXHM0kwu
         E0QriIDsr/ukoBPk9iiidMStZK32bfHfZ0xbXrQHcMR7O3+0HrAMVI6OHCUxZloYqDft
         trMg==
X-Forwarded-Encrypted: i=1; AJvYcCVGKkYaPdZqeXrABuF6f7/jKYyX8CQt3WnsfsTpgYyToe2bhSgACp3A8sGa0SYRI4IfVjcn6DyfJFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqPgaiuBEgkYuTWA6osfUwHfZHmQvxnZl2drWbovxlsSr89mc
	ARLvitVty8VE39MHjYBEN/f62HyAdegpUvJvs1NdAeYwivg9yTxyeg/a5oSG1Uc=
X-Gm-Gg: ASbGncssFfviAJIQsq3X68xy9CTjWGvm/kBobY8JGn7bjPtNM63d21gga2MaCETzaVr
	3hlp7RMs/P2GH1Autwrq3SoPHqQ6TXdogbKyDKWihg8d1A2SqgliBXI/+F2rXRWfBvdaF16dNzB
	alvmN+nnV9zE33K/2dNxe5QFrs/MJFrJdKBGqdcWhfXBfJK3k3YSeX/gxbk+SNd41XRVPzG/Lzr
	rFRMrq1nVQGV/1YErM5cygZxfdTs2z+p775sRRZFDEzGzhXv1OiJoPw3OOVNPY3mA==
X-Google-Smtp-Source: AGHT+IGRJU00RisG9i0trOMKvJFYFliD2nOh14yfkZLJb8Z2MdvVwSvtyYD5ZhP9DVJTYxjtT/tgUQ==
X-Received: by 2002:a05:6000:2cf:b0:385:e961:6589 with SMTP id ffacd0b85a97d-38a87303d73mr5153466f8f.20.1736413790761;
        Thu, 09 Jan 2025 01:09:50 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d447sm1227370f8f.4.2025.01.09.01.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:09:50 -0800 (PST)
Message-ID: <36471228-4383-4b01-bbe2-0ec490617f6c@tuxon.dev>
Date: Thu, 9 Jan 2025 11:09:48 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] dt-bindings: pinctrl: at91-pio4: add
 microchip,sama7d65-pinctrl
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
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
 <20250107160850.120537-4-Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250107160850.120537-4-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 07.01.2025 18:07, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add pinctrl bindings for microchip sama7d65 SoC.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> index 774c3c269c40..4b9f3373503d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt
> @@ -6,7 +6,8 @@ configure it.
>  Required properties:
>  - compatible:
>  	"atmel,sama5d2-pinctrl"
> -	"microchip,sama7g5-pinctrl"
> +	 "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl"

Looks like you have one space in front of the line

> +	 "microchip,sama7g5-pinctrl"

Same here. And this change should not be needed.

>  - reg: base address and length of the PIO controller.
>  - interrupts: interrupt outputs from the controller, one for each bank.
>  - interrupt-controller: mark the device node as an interrupt controller.

