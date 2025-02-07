Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCB189BB0
	for <linux-mmc@vger.kernel.org>; Fri,  7 Feb 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945759; cv=none; b=CLcZALc1JMR4csQeYMP0FzqNwxrmhvD6LAP4q+VoF7n+Bura98rqIC0MY+g2xa+7indSgCwomwdSGpAMlboB4NLXIwUzTN4qzbQRCy27NM0k8m1Rv7ZzRfJoN/IRXU3Ady6Sz1mQVCtDsQhZX71/Jz2pXhNHwSzY4Wy8LBnze0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945759; c=relaxed/simple;
	bh=57uHeJssUhSTwboeRjLbjHP/8gebXbxQ08iLQ68S9QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSJp/p6Tt01lvSQyP7bgQsY8JTMHj6jcWSoxNwF73k8wZUWxVxJChM+3Qujj/M+n9ppbRKoVxvQ37S9v3fAzNUxlzg6CceHfSr/4QOJPEEEUT5r0CG5A3cPxU5HfmRbqyfxMouUeS260s69ZKqUiCM2qcmZtm36sLOeraavXe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mtEJ1Sr2; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mtEJ1Sr2"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f34101f68eso471401b6e.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2025 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738945755; x=1739550555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5z98lSfe6WwRG+wC0Tg6PRqMgic/o2qF3h3J+ulLEk=;
        b=mtEJ1Sr2l7/lIK8nvmtXf2sOSfDvQGnL/msUKLZ4fK99Rd4clSOcYOIj0eFfGaLOdX
         PhbPZ29bbmJC0xUP5e0yRlFjkXShnUq/dnZ/WcJcZ9M7t7eYficY5G1lTOMk0+/DyFz7
         e7suiMpue9zPF6ivH9gxewbO9CUN2xj5AcJLrNAWv/c297UzMkAI7UiZLl1csBec2nzX
         TKEh6k+Px2lri8jnJt3ooEj+r4MH63cF5+lZ0wLdUaKwV8lZvZ4i9cjd0QcxPZu2haAn
         qI9z/jykdLqcHLrqXuxBKAy1uKVNi2IOwAJY0Rl1NN0AWeZ68C+NE4/maNTj/grV7fSA
         H/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738945755; x=1739550555;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5z98lSfe6WwRG+wC0Tg6PRqMgic/o2qF3h3J+ulLEk=;
        b=trjv/XjuySBuhls9UC7vw2O2Q0yyIm+9uZoPZgCxZsFtICKs902luJ91OTQmRLxiS0
         N1dCwKw0bh6YlKCS9rfFybt1kdFWnRSsxjo9mXHgQSue2p4QxKIdB3D53V8vcOi4p5zd
         3+yfHrqHPCGgRqDltUIGKaOQUtgKwI6DGxTwYiOHBmgLIv6W4Y0NKEQjftUlpmfy6i1q
         2NcfdNae1LrTxPDF30Eeu8RmkbjKGfUfoRpXAdABrYqjjgqdQaEaUp3tWmLWugJHrNQz
         6ZzlVu4RVAIU2fg9z0rfYtk0vdge9jkelN2DkU5G3FPUlvNe3CSHarKh1a+lh+4qFDlJ
         MhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMjLVWgU1YqdHus4NnY1RdvPca5MsyqRnBVevrj0AanGzQx5A75FDk5DDUuGvROtP1IxFs/11Msc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNPv48++s+9tXovzxAk8kDGA3IhkxUZ66C8d2E0dbmQN8aQen
	3Wm/9I+O2/CND/KxDU8aGIR1D7c/kjEzw7Y3zIt6U8KEFOLLUDp8CKs+BY2cOmk=
X-Gm-Gg: ASbGncvzaqB/eBUAjYpfxrR/Vy20h+D4nXmHdcKadVp8K61nR4YYPACVxLFWEDGt1/8
	e5RCGlzuFRlK6A9qbhOLFWmepnVCrX2Fqq0JDh6yMBowmyuDLlNot0xJYT1Uqf6ZB+lL7J27N4i
	FWa/GTp5luEaEfPOb9ozrNGyAEh7OBUSXjPREZ5xSvu6jz+0JqjioKivW8fcwwhGUZ3Z8WuFHS6
	6ZxMFhv+mNG7adYh8a/g3VRNttTWwrlDDvBK9v2d5YPiYDNDQkQGMt+GmN75gPz+Fjh6XgTYK43
	Tpv12L6XqHjfcADYKrIEfySMhs9kYfcpKRq/7XLk3a476OMWBViC
X-Google-Smtp-Source: AGHT+IG7StedQ5Vnf2T8W9EtvcPrRVDItpyl7T3DBHEMIV0RzDgNrv3XTiomaadolzmBwJACvP6VXg==
X-Received: by 2002:a05:6808:30a3:b0:3e3:bd1c:d584 with SMTP id 5614622812f47-3f3922d9a38mr2709674b6e.9.1738945755147;
        Fri, 07 Feb 2025 08:29:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ed6220sm756084b6e.15.2025.02.07.08.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 08:29:13 -0800 (PST)
Message-ID: <74ec33db-6721-4b86-86a6-e18b0a01fc47@baylibre.com>
Date: Fri, 7 Feb 2025 10:29:11 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] gpiolib: add gpiod_multi_set_value_cansleep()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-1-1c5f048f79c3@baylibre.com>
 <CAMuHMdU5tt5_t2SfYO3OUsHenu_0PhpKeLHktNdCx-W6zCEymw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdU5tt5_t2SfYO3OUsHenu_0PhpKeLHktNdCx-W6zCEymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 3:10 AM, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Thu, 6 Feb 2025 at 23:48, David Lechner <dlechner@baylibre.com> wrote:
>> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
>> parameters than gpiod_set_array_value_cansleep().
>>
>> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
>> cases, the first arguments all come from the same struct gpio_descs, so
>> having a separate function where we can just pass that cuts down on the
>> boilerplate.
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Thanks for your patch!
> 
>> --- a/include/linux/gpio/consumer.h
>> +++ b/include/linux/gpio/consumer.h
>> @@ -655,4 +655,11 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
>>
>>  #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
>>
>> +static inline int gpiod_multi_set_value_cansleep(struct gpio_descs *descs,
>> +                                                unsigned long *value_bitmap)
>> +{
>> +       return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
>> +                                             descs->info, value_bitmap);
> 
> I am wondering whether this needs a check for !IS_ERR_OR_NULL(descs),
> to handle the !CONFIG_GPIOLIB and gpiod_get_array_optional() cases?

I don't think it is strictly needed, but could be convenient for future use
cases. If we add it, should it be:

	if (IS_ERR_OR_NULL(descs))
		return PTR_ERR(descs);

or:

	if (!descs)
		return -EINVAL;

	if (IS_ERR(descs))
		return PTR_ERR(descs);

?

For comparison, gpiod_set_array_value_cansleep() will return -EINVAL if the
first argument is NULL.

> 
> Slightly related: shouldn't gpiod_put_array() (both the implementation
> and the !CONFIG_GPIOLIB dummy) allow the caller to pass NULL, to
> streamline the gpiod_get_array_optional() case?
> 
>> +}
>> +
>>  #endif
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

