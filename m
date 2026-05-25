Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43A3F65EF
	for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727512; cv=none; b=lQQyi3KvZyKdZBInCJkHgWJshy5XbR/pqrH9tMim3b1LqZqUCQZpbPutFyZOy1IAYi2mGPACpLIzn5mfLqtBf58x3BiQlIDR39g8+ycJFLsvE5YdAF+4+dg3pL88swi/sLhNjlRqhUV2x7yZXZP8X1ApO2hKmHqaJiE51ehhu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727512; c=relaxed/simple;
	bh=EufRUTTTgzWj+WK9k6gGFUGuDih7TCDOpQBoQIPNfYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUtAFk4sGRBvcPmHud4/MOl9rK8AiTFEFJtFJLz0QljmrVbNhI2T8fmziXd4te76Kevkc829w4mQr9jl/dZQ4B2nv8rGHO/6CS+gxP8KTmFtdMCCkiE/NG/FmnhBBk0jZdQ87OcSB169YgOxx0kFZaU0vhPHaoFUxzg4d927EpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaiFeZoT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaiFeZoT"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so5892238f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2026 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779727510; x=1780332310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67F6STg17M288NH/Kzfu1U3GX4bjSdjuVgcfWDSoVZo=;
        b=BaiFeZoT/kphvO2gUYbBYGEL6+/4u/bfHYiklbdA+oEsWaewaeyOSE5PgNfyHzhjPY
         dNWRCeoVeo11Juk8jVYBuv86kVbb/Qv+jRmyOWuYzFjVnU0KOoa1iVkUNK+9xkqQPGjO
         LRJ4+lZ0KTYSXCw9EyEpDt5+OdAbXpwsXY09UzCY+etF9YrXcgSm0nMIl7nD25OZosun
         zLR9t7kk5QitM/3ZvatZuU+3CwAasM4mv8NOU7JlWfHzgtP4Jf5/dW0myw8kbBrh/6xS
         pZWgzEZ79+DoUuyxjvGYUvsHIJgJ4DHBI10Afb6E+fRkpt+7kK9wjwKkjHvfSwLq5QJY
         wJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779727510; x=1780332310;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67F6STg17M288NH/Kzfu1U3GX4bjSdjuVgcfWDSoVZo=;
        b=AL6WruFd6JgJ/cvnASaIILsgF0vWd6V/tL1SNKPGAWczbAFyM9JwlSjkSAyPYsr9Er
         LzBDH5WEUusX6/ntSZn6sDlRLGJ1JSlPirEHmwBD1blecs7l6iI4iCKn6MAs3lbbgylj
         XjA/RRG08m9qXOBO667UJUmiTtza320M3Psnv4EzB9W5VurVogs3OIniBxwVTMxYk3Fc
         KpD+V30T2CfiQcb3MGopBoJd0TEq11e4hFuKXDdC2Gexp0pK8nuxDyW93JrUkw/aEx6I
         byiVRfoYrTvBN2XH9TCrDehpvTQLZhjaMNTw4audCAOopm7OUuLgUgiU2iL22AaCK90H
         0Z8g==
X-Forwarded-Encrypted: i=1; AFNElJ9inVW1RJbzrjIwHxUCS70eY/2jYWEQN07YDyRxOgnZyba1T70LrrMcSAzvsD2PWB6eHUohdtFc0jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdPzAjgDkXywl9bY8hoqcNAMJHTPZR5l37T78sHug31AwA0Na
	9z7k4d/gvS36M00YnAr5A498ScncaFBrFAOqbgFRwVFdzrH5Pma6EGCO
X-Gm-Gg: Acq92OHqm4MY+AGcBbDO3ilDdggg34i8Z3L+boYbc61XGBQo1oc3fUtrZ2dmRjmh0nq
	KkY2DgrMkSeNCj9JVxvD1AVV9MU3j2Or2imBdPC/5nF2Ic3s6ub3kmwWAGOtc/YezQ6TmadhyZR
	2yJ2wo3LwhexbCvSinL8WVOVoYYpVOjdh1m2Ym96zSE4nUvB3zwgHLBPgxbXXvvWDd+VV87xGaE
	MldpMihxvgJdRviftvdIBHcToAHvvmwoAcFQcdY4cdw39sKuHH0K1/NTgU0AYY+d0BoEE2D1oBc
	yPi7uUNT3klCGMlDb75mS2B4dA3NJVaBd4PuvXZnLkCWxKymb8pBHA8vZuKIJQRo3G7RvSn6veZ
	2XbDm82LOEOvdSIjlw1KjlmJxx0fLXzoldr73deuznnN6y+UXZkwFdKSEBeGGt4uKC0QxAl22RI
	4EYYoxwOnzCGANOxW7z/yUjQIWVAlzIWWCbZKaWLLAleXbYyJVw24Un0G7+qtkSPQ=
X-Received: by 2002:a05:6000:2c10:b0:43d:7a97:78b5 with SMTP id ffacd0b85a97d-45eb38d63a7mr25843635f8f.33.1779727509412;
        Mon, 25 May 2026 09:45:09 -0700 (PDT)
Received: from [192.168.0.40] (a89-182-131-96.net-htp.de. [89.182.131.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e363sm29230186f8f.28.2026.05.25.09.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:45:08 -0700 (PDT)
Message-ID: <8b9c613c-df1a-4f44-b15d-cdcc21905bc5@gmail.com>
Date: Mon, 25 May 2026 18:45:07 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support
 with UHS modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: Yixun Lan <dlan@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Ulf Hansson <ulfh@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Vincent Legoll <legoll@online.fr>,
 Margherita Milani <margherita.milani@amarulasolutions.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
 <177889984452.2298656.1074391459031404894.b4-ty@b4>
 <7e68e745-0d70-46db-9475-38d3dd5b9cf4@baylibre.com>
 <6b945153-5a7b-415e-904a-1c350b7d52ee@gmail.com>
 <86ac46cd-b7bc-42cc-8c29-996ae21f3654@baylibre.com>
 <CABdCQ=M_E1uHU5WTXCn2mXaxf3-+7M9gXCL=tp1qBW50jf7d5Q@mail.gmail.com>
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE
In-Reply-To: <CABdCQ=M_E1uHU5WTXCn2mXaxf3-+7M9gXCL=tp1qBW50jf7d5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Iker,

On 25.05.26 11:36 AM, Iker Pedrosa wrote:
> Hi,
> 
> Sorry, I've been on vacation and I haven't checked my emails.
> 
> El mié, 20 may 2026 a las 13:11, Trevor Gamblin
> (<tgamblin@baylibre.com>) escribió:
>>
>>
>> On 2026-05-20 03:53, Andre Heider wrote:
>>> Hi Trevor,
>>>
>>> On 16.05.26 2:35 PM, Trevor Gamblin wrote:
>>>>
>>>> On 2026-05-15 22:57, Yixun Lan wrote:
>>>>> On Fri, 15 May 2026 12:48:58 +0200, Iker Pedrosa wrote:
>>>>>> This series enables complete SD card support for the Spacemit K1-based
>>>>>> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
>>>>>> high-performance SD card operation.
>>>>>>
>>>>>> Background
>>>>>>
>>>>>> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
>>>>>> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
>>>>>> currently lacks basic SD controller configuration, SDHCI driver
>>>>>> enhancements for voltage switching and tuning, and power management
>>>>>> infrastructure.
>>>>>>
>>>>>> [...]
>>>>> Hi Iker,
>>>>> I've picked patch 1-3, for [4/4] I think it should be merged after
>>>>> https://lore.kernel.org/all/20260513071958.29574-1-a.heider@gmail.com/
>>>>
>>>> Hi Yixun,
>>>>
>>>> That makes sense. In response to your earlier feedback I had drafted
>>>> a more
>>>> complete dts after another schematic comparison, but Iker and I
>>>> discussed it
>>>> and opted to avoid changing scope too much. Andre's series includes
>>>> the bits I
>>>> wanted to add and more, so that works out.
>>>
>>> I have 4/4 rebased on my series anyway, do you want me to send it?
>>
>> If you have an update to make, please do!
> 
> So, how has this turned out in the end? Andre, will you take care of
> sending the latest version for the MUSE Pi Pro?

Yes, in fact I already sent it last week:
https://lore.kernel.org/spacemit/20260520130624.1763487-1-a.heider@gmail.com/T/#u

You should have received that (unless I messed something up) ;)

Thanks!
Andre

> 
>>
>> Trevor
>>
>>>
>>> Thanks,
>>> Andre
>>>
>>>>
>>>> Thanks!
>>>>
>>>> Trevor
>>>>
>>>>>
>>>>> Applied, thanks!
>>>>>
>>>>> [1/4] riscv: dts: spacemit: k1: add SD card controller and pinctrl
>>>>> support
>>>>> https://github.com/spacemit-com/linux/commit/2d77e577109967ef65f269c1fc1d6a659d4260fb
>>>>> [2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support
>>>>> with UHS modes
>>>>> https://github.com/spacemit-com/linux/commit/2585c60ce2f977b13f14a67d1e3ed9c73fd7f381
>>>>> [3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with
>>>>> UHS modes
>>>>> https://github.com/spacemit-com/linux/commit/c76e2f058cbcab84e4a703f26857a58bdf6a0042
>>>>>
>>>>> Best regards,
>>>

