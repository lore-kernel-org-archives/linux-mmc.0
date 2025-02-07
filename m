Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E21EB1A8
	for <linux-mmc@vger.kernel.org>; Fri,  7 Feb 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941797; cv=none; b=nxcZI1knWTBZQuIkYtMeBNOiLd476ZRJdfnjH+pjXULvDsuKYJMxAb5sls8MhIBw4aqUOqR9WhubpZxGZZ3WuGHyVDAqyGQU3PKwmJmqoryfF+mzs+mXpWofCgfUo0XZ6mFQL4HqKJQ13ITD5zzvFONnqbHS+0GJLUhp2ycJF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941797; c=relaxed/simple;
	bh=JDDbmK++u5Zrrl9i4wETB+fZ6+WtylkQrpDbOxAMbWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/YXVOAJP9Fi3PuVpwcgsDCZ3Rk5hxGjUb9jkHAEKK8R09lBNmWvTEE+hzI1UFO4Aqgi35dr4DZ3191+M56OzkI74Ql2eh/yZmO7jiuRmVOcNxYGts+hSddIDJr9Tttu6x4aVrtSEmhzrKGq8L6fSvBO/zSng0SF59KX1BCocp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dL5tXQN9; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dL5tXQN9"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2b82b1bc043so839217fac.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Feb 2025 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738941795; x=1739546595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKN8sjRb3wgYxS8vD82nCdPhJYpZegmXytH3ZuvLDaU=;
        b=dL5tXQN99tpWF8iJr8PDD/x7JBvxCw1n0YxRCcqPSFnvPpC7pz3PL/hYn91vWQB0Lt
         PZ+YGjJPRvMOtCt8XuOsWuFMiBIr2RD5IvXR6mjqKscso6rFMGbhNJ1G5MGrXATFbpfa
         VRbiSVly/+dXXwGwD1F+9fcauRK/lcPtiyKuMiFGHGzuW5dhBj3e3WC6bCiqAoyuOliI
         TzBamMlWWZOQmTpDeCDQ2jegAqduAHVG1KqRiD/u6gqi6cFOo8bwhGGFnLZUJxCbVubd
         OMzJuQnB26STASsbn1P2y5yqqihWcI+LVXiQ57JzNDbcJB8FV+q3D1HXZajrsTQxKz0A
         d1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738941795; x=1739546595;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKN8sjRb3wgYxS8vD82nCdPhJYpZegmXytH3ZuvLDaU=;
        b=pbvpcSUDVC/8isHvzLIeUp57LQV50ZaCcPmR9j1f0lOGhrhLsRFlvIJvWwyl0qEq/S
         LK+ye4ZJOkWVKayN3kmCdaVLWT/3W6laLLh8pYUL0ZoaLA94qr8TwUSR5RvPRyrQc9RB
         /KJJ2A3o+Hrd+OGA1HB5UzrSBlmY9WZ2W4f2rYsA4V2bKgZg73kIEaNbxBhyVfjnose9
         P+vGx2QFgAKLHOCi+j8AD2DFQEHQUULT1zlR2+tOt1k2GQZMWCwljQZWH5kdfBjrLQOl
         LylCtlnyIJtdI5z3ZoVgIBadIuvRaC3IpjNpQz9Axdt/Ueln5ANmdbqbXkXkN+rg3Nyf
         txHA==
X-Forwarded-Encrypted: i=1; AJvYcCWzSVf4hv9XpI7DzRzACqFmlP4hIvEHNH95glWGYT74ILyCeg/b+/7sNgmlbbwmmzeZEr+ZxXc0ChM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dJaY2r34bH1caqXJfKYQVo/V7Ab7RVvAtqyupLRy7bRxJ1Oh
	g9WLwrYuzXRuM+Opr7OJQ8MW2CBVy5FR0vRLZygd+57vYdk6mZF5ApehWzjRW5g=
X-Gm-Gg: ASbGnctGcTCn4ujVV6HmzFOGLRu15WpA0AkoeVIfKHCITq0mfGSDU9QHQcFO2SJm2G3
	xfb0QLBOFmoTnEpULDzZJd7DQvKVgVkBQDi2x1fJUUAv5oRBcs1wWEZFba8J2gVTDqEOuO5w0ef
	ArB09C7HHlpqDZkBlFndlmHVXKs7O3EiiCXrfN6cmIH3QKX8WPa2K8eq5LcS1PIJPGwOkHdayvf
	JO1+RowrgGZp9mqsRNBE7B9NDuBBaipUwW0T8phI5inkDnGBt9OkfYsC0Q0GhtFT9oZL/sHdTVH
	T8oV1cFHYEZjJg7WQxxfN6xpzk2+E7ut57hwgTfBCsJcdCrIfnh/
X-Google-Smtp-Source: AGHT+IEEGiDMzanhY46VT0zPfUJ5PNu5OgiAyh3A5rsLRVIHkXKzWkfKjdhXcmoVPsTyGbzMvvecNA==
X-Received: by 2002:a05:6870:169d:b0:29e:4340:b1b with SMTP id 586e51a60fabf-2b83ed06682mr2385084fac.9.1738941794664;
        Fri, 07 Feb 2025 07:23:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b826261c16sm829675fac.40.2025.02.07.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 07:23:13 -0800 (PST)
Message-ID: <945b338c-8fe1-4082-a20f-57f8152e8f80@baylibre.com>
Date: Fri, 7 Feb 2025 09:23:11 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] gpio: max3191x: use
 gpiod_multi_set_value_cansleep
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <20250206-gpio-set-array-helper-v2-5-1c5f048f79c3@baylibre.com>
 <CAHp75VcNJzPH8to1Y6NzPMXnH48Ve4LJ7oid7_wEHtwhO82Fmw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VcNJzPH8to1Y6NzPMXnH48Ve4LJ7oid7_wEHtwhO82Fmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/25 4:34 AM, Andy Shevchenko wrote:
> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
>> gpiod_set_array_value_cansleep().
> 
> It seems you missed my comment.

Yes, I must have been sleeping on the job. :-/

> 
>> +static void gpiod_set_array_single_value_cansleep(struct gpio_descs *descs,
>>                                                   int value)
> 
> This is not good namespacing. Can we change this while at it?

sure

> 
> max3191x_...
> 
> (I would go with max3191x_set_modesel_pins() to make it shorter. I
> have no clue why the function repeats so much from gpiod API naming.
> Is there anything else which is named in a similar way? Perhaps fix it
> by a separate patch?)
> 

