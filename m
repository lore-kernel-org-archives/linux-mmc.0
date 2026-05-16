Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6ED30648A
	for <linux-mmc@vger.kernel.org>; Sat, 16 May 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934909; cv=none; b=UxwtnPUzuPauvos60HqCjNe/qXx2Csk3wO+/u65ZM+hga5w43GD4wrnOBEz9UQ3qhVcj5aFS77MEoBzgkj1shNh8R0Fnif1HgxxHXlSm6JzTGdhx7l01SoppEZVkEXHLTCYgCJe/muHSUIJ0CMODRz3UO1biqkcL8Rfan2m2UA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934909; c=relaxed/simple;
	bh=/0+rB3LCDje5H1GWAPmFkRfOosbuwDC1QTWFKmh24Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXKV5zbqhz3A+NgTFl3L//7PYHVhyxMGHlhk5ZcKx+WqzlBCITQPiSVYraSGZ8Bu7F4H8YozslUOhNauHD+WF86WwuhaO/KQpeBVxLnKGL3oUraLSzGYBlc+c2ZTenCliDI44EXNepTJLLaWasrW9ASvXOdA/5VJHh89CNne+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=tRzxLUfl; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tRzxLUfl"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90ea08cc5ceso179401885a.2
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2026 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778934904; x=1779539704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlYX20Tz7KrUA9/+ib940qbKVKDUFNbiWx/P6UgmXqc=;
        b=tRzxLUfl7WKi7iPmFaARqPkpgb9BshebIlYejfpOws/ALL5c6MblM/r7I2D/E3kIYR
         mJyDXi6DlOORYPHugG2qBKloV48ks5PwzBSu5yPBrVokNy2UpRZzkUzn/KHbB7ShHa3K
         tsAm81MH5oENssNUCdT5zUKwEXDa/eNLAP7gQB0oInMMRdcyZFJVqnGEs3X5jIlrn9UQ
         dA//omAOVlR4cESoLwRsmedQLUgeEl3dOhwJx120JstiN5eizs0xIX0TPiCMqmGXnucx
         mSYaxPayEVmKvNt3hHDeaRSGHqpxxoYyEmvMeUyaBTNv0psZ2uX/lP+dG/SJmkU8ANJ2
         Dlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778934904; x=1779539704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlYX20Tz7KrUA9/+ib940qbKVKDUFNbiWx/P6UgmXqc=;
        b=phZVSeDveHCRMj7cCDYg1C0oOCFBnQ8SMsCmBqO4jf4WTLgPbdIqEFAiT38ueswBLt
         R8jirwz2xMVI6qm7yYc5CqBBy097guz81brEOpDacbiU8JdSBjw/PSURafRgT7+vVxot
         8qca0QjnVVI1x7kQIqsNu+v4g2lHmXMtXiAtppvTgJa3zdG2BrlMw1HkVLTU+HjvGAz6
         s33L0Q+5V6qyrScWKg31CzR0uWyeacct6e8EwqMVaYOACgQlEEvqw7Dm99FqLMqWcE7n
         6MhwPqXZLGpBn2hVXLJxsRxX7DW8p3lIw7BZM3hkFXdOh7fY7k2wTwbb5Yo+oR3g7Bua
         jIgA==
X-Forwarded-Encrypted: i=1; AFNElJ/xdVbjfsUm0JBXqEBgDCuD33l05tpPLd24qWNQfTqLlcs1dcY1ewc10s9dY485qwwqX6dnh/XYdUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bs0xbbqzhudAcvPngq0NzbokbVkQpwjmeyWI3Uou49rL02kt
	Xe3gSIWlDYFavYuUI01p/GKVLZXrc5ohjHyi1ywV7FFZhLpMh5ruW8JAb4UMLDI+NxM=
X-Gm-Gg: Acq92OHsqc5+3pLItMy0oT3AjqBdd0gyh4B1LP5dxn4HN7I80AAbv0GdN4bNSMkDQm9
	2wIdCYIgLmw54SBJF4XfYMoInDVFzodIPGw+PS/cgbMPF/DBDnCHb/ZPRYxXYwDdHU+BTXjbwyA
	aCH7iPmbYSE7yZht00ZEmuAIUOnpgwdeSFl25HkJtZ53ANveOryU9aekY2twV2Dhqaoir4WiV0P
	hOv56gCCs0zH5uW3nvJRl7YHDqCN/LODc+o7fU5jRkOLmPMAEIJXoU3RtHbroweOTuTyBhBOkKs
	S8by4euXLLHaBPJEANowkDGSM0RxTMz1Zq6ebiUJ07A7CkWJN70kWdTn3UcB73nu0lJB3xUDAM/
	C92o0PFy5+CI91CGQVTvPExgQi7DJ4dVwn0CGJzGnCAC2dqu+FJAt1hphOEJy2QVVf00Qqpp9zk
	twVZ710nSE2BFcKY/OGzbnK1fqdjUbV0wX/1B8g41AB4bNtMnq4k3pzbCX5qheeSAehEc7yJViE
	M+uk4BL8V6RoQc=
X-Received: by 2002:a05:620a:7087:b0:8ed:d906:a8ff with SMTP id af79cd13be357-911ce04464cmr1176183685a.14.1778934904152;
        Sat, 16 May 2026 05:35:04 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:9cf2:2d6b:fbf2:991c? ([2001:1970:3847:e000:9cf2:2d6b:fbf2:991c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3776dsm895724585a.39.2026.05.16.05.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 05:35:03 -0700 (PDT)
Message-ID: <7e68e745-0d70-46db-9475-38d3dd5b9cf4@baylibre.com>
Date: Sat, 16 May 2026 08:35:01 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support
 with UHS modes for OrangePi RV2
To: Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Ulf Hansson <ulfh@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Troy Mitchell <troy.mitchell@linux.dev>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Vincent Legoll <legoll@online.fr>,
 Margherita Milani <margherita.milani@amarulasolutions.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
 <177889984452.2298656.1074391459031404894.b4-ty@b4>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <177889984452.2298656.1074391459031404894.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-05-15 22:57, Yixun Lan wrote:
> On Fri, 15 May 2026 12:48:58 +0200, Iker Pedrosa wrote:
>> This series enables complete SD card support for the Spacemit K1-based
>> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
>> high-performance SD card operation.
>>
>> Background
>>
>> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
>> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
>> currently lacks basic SD controller configuration, SDHCI driver
>> enhancements for voltage switching and tuning, and power management
>> infrastructure.
>>
>> [...]
> Hi Iker,
> I've picked patch 1-3, for [4/4] I think it should be merged after
> https://lore.kernel.org/all/20260513071958.29574-1-a.heider@gmail.com/

Hi Yixun,

That makes sense. In response to your earlier feedback I had drafted a more
complete dts after another schematic comparison, but Iker and I discussed it
and opted to avoid changing scope too much. Andre's series includes the 
bits I
wanted to add and more, so that works out.

Thanks!

Trevor

>
> Applied, thanks!
>
> [1/4] riscv: dts: spacemit: k1: add SD card controller and pinctrl support
>        https://github.com/spacemit-com/linux/commit/2d77e577109967ef65f269c1fc1d6a659d4260fb
> [2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
>        https://github.com/spacemit-com/linux/commit/2585c60ce2f977b13f14a67d1e3ed9c73fd7f381
> [3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
>        https://github.com/spacemit-com/linux/commit/c76e2f058cbcab84e4a703f26857a58bdf6a0042
>
> Best regards,
