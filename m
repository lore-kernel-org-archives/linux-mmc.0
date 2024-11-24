Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520E33987
	for <linux-mmc@vger.kernel.org>; Sun, 24 Nov 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453568; cv=none; b=lEir28Xyq61fF94pORvC9pa8Rfk7JFNh+yfn9LaMg8BhsU4niHOsAcN9N//j+xmxKA0JTewy6gOfw6fHOzhbA33ojAs5tiO0Y96abuVSqD7xR7sLybIUAjOPaiRWpcjzbf2NrhZiCLnvXJ9u9VwBgRvnWxjK9XZb2YWQe9ur7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453568; c=relaxed/simple;
	bh=579OTAxxCTsdzuh+nLXM4qxYrJpkNNqj06Nk7dWiucg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agPEnEYav/TzeMPiTpeg6/bpttab+9UrNBf1jZAbqJ0709ZWvudhoTBLZVnC4E8q5eRbX1Yt2O09wtRbNe4X9vt7rZONLcuGR9A2HFOPaxgO1UTxQjFcz19IXU7lg6TM1uK3MNuWmy7BUkxyLp75j5aHY/YpPvea4bC/C2nnnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HOCOk5UP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HOCOk5UP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38230ed9baeso2572644f8f.1
        for <linux-mmc@vger.kernel.org>; Sun, 24 Nov 2024 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732453565; x=1733058365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=HOCOk5UPZKkjXEZ3v14KiQMmAAGJcntS3/JT4Fq3QD4zOnvudYybDR2ooMkWesSgIa
         bNKg7jpn9eNP9/J2CXlRT891DqkzTATJFL10cELoo5QaF0hKpyIzcQOLyc+gtY5zqTs6
         yTCGtSoOIfg/HyXUqJ8jRKCdR9UiYRkQkJnzkHiiEhyy9G/GfPNhfOTgT8FGqmuEUuaR
         US2ve565Xs9ri1J03HdcvO+Oh+gDGDhyM4DcMGAiiEA0RXIxYM8waaLpKoZlghLltFgr
         o8j6dxvw4MHCuOOtO+bMuoFpoSz1GI0mYZ+btL4CWDOMZrHDK6jN4Jf2ekfOeTWV8pX+
         5PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732453565; x=1733058365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=npovWKHq9w7XyV0TNiSEcYgYzAip98DOk9VB3rsaqPL2LarnaRo7VqnVHoyeidIphj
         iTOdsL0NW8WV2eBoaIJYxp+3wYsVTodQx8pgX8LJXFTtDR68Y4huc4kKEA8OT1wZbsa2
         t3gVpQ7xAE2XBZF9yieL8g3wLe8AwprS24cZxDfBbrgrWa/z4CO6nUNy0fYATj56lSuA
         sZc8PMnqpJjRl/Iqc1AcPB9XY19P9uX4Eooydvfa1dm6jyxRryp8qxFj0OXLpvQeh4yR
         tAPidQA0WnyNk24QTC44WMcv+ELpmrJ/SQnfcQQ9dVycY4olwH6HwumIBRJnzM7BdgZR
         XyNg==
X-Forwarded-Encrypted: i=1; AJvYcCUhhLAI3m/1wYlgfFFdUabryHGl6T6SLfhEW5+PiQHk9N5zYr+abw47g/aAGDlUUHa8KgnJvh7LgfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxY0wAOfblhOcD02TOdiFMCllP1HZPyh8tHzIDeL6k7AJHHsH4
	uNKbl19oQmd21cywrtTiJWAWp/OykMcOCZXeroEQ20YlwELWTw2z+EYroT9q6jM=
X-Gm-Gg: ASbGncu/pfrvTfEaBt0SHg/2Sby6opvD4fAiw71aeaXn1yLJ2hL0pN73vLvo8+2yYAX
	7osBUQcjKujzrWfFeJK6fuE2S+tfhxi7dqyUpRtCYpHYHrxrZkgjiISgB1pva3rOS397pUJ0yGB
	1oikClDGaJhhs9R29ZLMxobVtQIZ/B2nr2aaxVxHQCPqgcRG2CRNxzpDZjK+dnBLTPv19smieh1
	2gblS5Rtlsb0PhAolhTg994ze6UBL/TL1Goc9oHmz/cFUJulB3AVOiVrg==
X-Google-Smtp-Source: AGHT+IE/ekA4n5NRsUPfRrSQ4WEQs+2aEfMt8e8Vr2hUc52ItH2CCdtUMuUey9X354G87nt1GQ6+6g==
X-Received: by 2002:a5d:64cc:0:b0:382:4503:728a with SMTP id ffacd0b85a97d-38260be41c0mr7533295f8f.53.1732453564522;
        Sun, 24 Nov 2024 05:06:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5f59sm7682760f8f.10.2024.11.24.05.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 05:06:03 -0800 (PST)
Message-ID: <55685905-7a28-4796-b386-1212bc1abed1@tuxon.dev>
Date: Sun, 24 Nov 2024 15:06:00 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] ARM: configs: at91: sama7: add new SoC config
Content-Language: en-US
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
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 19.11.2024 18:40, Ryan.Wanner@microchip.com wrote:
> +config SOC_SAMA7D65
> +	bool "SAMA7D65 family"
> +	depends on ARCH_MULTI_V7
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL

These starting here:

> +	select HAVE_AT91_USB_CLK
> +	select HAVE_AT91_UTMI
> +	select PM_OPP

ending here are not needed for this phase, AFAICT.

> +	select SOC_SAMA7
> +	help
> +	 Select this if you are using one of Microchip's SAMA7D65 family SoC.
> +

The Kconfig changes should be a separate patch.
