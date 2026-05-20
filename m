Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639C3DA7E0
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275500; cv=none; b=B3efVeMJDPIVvmNfQrsuDMpQF3YQF3TEEMcQEywpNlkBnWVFnL/zM9wGg0vNCSd1nRZjH7TxEFEk2Jaqeo+WMp5AwYBne/SfgSsDhhgkKTLEnrkCRTyqcM5uupYNU2xz8A8e3IzofrrSa+pXQd+lFZflaevUzH/OrNOFa5SGiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275500; c=relaxed/simple;
	bh=cfAIhH8OlC/rUFBfMHcfbIEw1X3DBJ4OiDfy5zoYzMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORM/QzioC1L532/ArVV8NwewD3wsj0PJYi/ekGZe70Iu3ifRvo2SrF0bFVaevrX6bGR/K6jkna65z1j/MWg7HPrhHhVhvp7mnz7/J5r9q991/yoPYhZmk5RFbTd72aJBlDNBYh/fKGQcI5vGB+E8EUqLJv5/ugV6/0amIuSN+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=HRs3QHil; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="HRs3QHil"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-911449d9d03so567097185a.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779275496; x=1779880296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIkzPbGJvuJiBs7z1ji9U2DALkh6krIE8tTV4POiT4k=;
        b=HRs3QHil29I/u+1orVRsSwdHu6prg4wSZbVhHdL/zsHLvYK9P7l2E0hR5hwc8m6IVS
         /tHf8X+RzCwBpX+B/4UtQyQMa+iXxj831o+f1/WwuvMvZ2Xot6ZqR+6ltLULJgMBdzd5
         JzI9nlxdXCqHZXaEOoRefY2zH4VwaujwX4cWiXsqHTPq/QT+mV25am8AcWOyvCbie0A0
         Vd6yaoPjL1knK2OJBrdjFij88E0ypq9nUpq1Gb3UZfnOU5rI20Mq5K1wFj+OJUUOcqYa
         Wc3KItyPcViQLb+d7CNxa7oekRGtcp6lwPT42mvWjHF4fi0Ko/H1JN+FpPYInlAYAk6Q
         tAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275496; x=1779880296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIkzPbGJvuJiBs7z1ji9U2DALkh6krIE8tTV4POiT4k=;
        b=VRS8K5CDPcfbpexYXMtQkTUNAUF13i2cZeyt4cs0qR79DiQFzjtTPgopr4UQ9pfYM0
         glDJ3jFU+F4DVNjoYTMDyHLLV8nxqDpPq/MsPvBKaWvhksoWskYdaRxrcyjRPS8xdxtq
         jqB9G0tkgwpfbFMVdYc8sPxw3u6CYPuyFCH+/SPf+yBJxtZVLfECHx0pOvh8uWFhVaB3
         uCtCs7fOqcJdme9BrQ1tSsEfBNziexL1BoAdXOkfZMEi3fT0RlxTSEJ06nCBUrq6N9Mh
         ZgrG0xv7w1/nrz4J3IHDj3QBcDaSYK9VjupPPo4Z+m/hFms1Plrb0x4lPlzvII71oiLL
         oaGg==
X-Forwarded-Encrypted: i=1; AFNElJ/T/hpPoAf443jXZSqVR7XXLKftv+tHHoNg0qeRIJklrUVeJmw6PkMeyrZHYoL1kJ7SdlJF4anqlQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr+6TRDfVASucTfnGXf3j4xwZpqfWydweAL+FtRtPgb8bVI5a
	uLLiL91hZTmMxpnl/xGGNBPMNzgX2TJoyfOLgNYbIT36+i8f1fuuL5NetJneXy2b6h0=
X-Gm-Gg: Acq92OGU7rn/ebw+Y/obxVHa2KpfgVCX+C3oacDeYL65i6GOCNk6N1w4eDqTp9fsXFG
	VdbdsDhkp1GEwIpQi8Uebi6quOSm2jlHMkY21cSxAuRAtdkzDjyBxp2GEK25bULzRmvDrShD7Ri
	bnFZ0DWNLxQSUz1DR+xli9DIOH40TsZgUghAwf4wKzBIOx1MMB5XfeQP89p4AlxtNTz+0KGX44p
	f9Ydufp7NTvnK3bCsoS4ypXQHnMlOJoezAr1bdg7gnlkUYVm4f87n3RTVfn7lDjgMZ3Pm7xXrj+
	QShDBItSeyWql0Tzf/EGAok9thIxAjaa3CtStLMDg4oCIENfqQkBmNAyvc3LNzImVVWgeGTnASr
	tvThIkGC/BZAGibwAmrukg5NeUZiTzGm2Nb5VTwSaiSij5c71xiBKxUh66A7W7WUIc0hoECb0Me
	V4nKu3BAi9Vs9dYsN48kgbQC3OjWtQVZyL8tH2g/ZEmydLjKl+NHXQXWTFnuPW8BJ608sFotT2L
	LNt
X-Received: by 2002:a05:620a:1a0a:b0:90f:6d8b:2654 with SMTP id af79cd13be357-911ce332987mr3395608885a.22.1779275496216;
        Wed, 20 May 2026 04:11:36 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:9cf2:2d6b:fbf2:991c? ([2001:1970:3847:e000:9cf2:2d6b:fbf2:991c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9138a830c89sm1320813985a.6.2026.05.20.04.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 04:11:35 -0700 (PDT)
Message-ID: <86ac46cd-b7bc-42cc-8c29-996ae21f3654@baylibre.com>
Date: Wed, 20 May 2026 07:11:32 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 0/4] riscv: spacemit: enable SD card support
 with UHS modes for OrangePi RV2
To: Andre Heider <a.heider@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
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
 Aurelien Jarno <aurelien@aurel32.net>
References: <20260515-orangepi-sd-card-uhs-v10-0-094af27e310d@gmail.com>
 <177889984452.2298656.1074391459031404894.b4-ty@b4>
 <7e68e745-0d70-46db-9475-38d3dd5b9cf4@baylibre.com>
 <6b945153-5a7b-415e-904a-1c350b7d52ee@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <6b945153-5a7b-415e-904a-1c350b7d52ee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-05-20 03:53, Andre Heider wrote:
> Hi Trevor,
>
> On 16.05.26 2:35 PM, Trevor Gamblin wrote:
>>
>> On 2026-05-15 22:57, Yixun Lan wrote:
>>> On Fri, 15 May 2026 12:48:58 +0200, Iker Pedrosa wrote:
>>>> This series enables complete SD card support for the Spacemit K1-based
>>>> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
>>>> high-performance SD card operation.
>>>>
>>>> Background
>>>>
>>>> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
>>>> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
>>>> currently lacks basic SD controller configuration, SDHCI driver
>>>> enhancements for voltage switching and tuning, and power management
>>>> infrastructure.
>>>>
>>>> [...]
>>> Hi Iker,
>>> I've picked patch 1-3, for [4/4] I think it should be merged after
>>> https://lore.kernel.org/all/20260513071958.29574-1-a.heider@gmail.com/
>>
>> Hi Yixun,
>>
>> That makes sense. In response to your earlier feedback I had drafted 
>> a more
>> complete dts after another schematic comparison, but Iker and I 
>> discussed it
>> and opted to avoid changing scope too much. Andre's series includes 
>> the bits I
>> wanted to add and more, so that works out.
>
> I have 4/4 rebased on my series anyway, do you want me to send it?

If you have an update to make, please do!

Trevor

>
> Thanks,
> Andre
>
>>
>> Thanks!
>>
>> Trevor
>>
>>>
>>> Applied, thanks!
>>>
>>> [1/4] riscv: dts: spacemit: k1: add SD card controller and pinctrl 
>>> support
>>> https://github.com/spacemit-com/linux/commit/2d77e577109967ef65f269c1fc1d6a659d4260fb
>>> [2/4] riscv: dts: spacemit: k1-orangepi-rv2: add SD card support 
>>> with UHS modes
>>> https://github.com/spacemit-com/linux/commit/2585c60ce2f977b13f14a67d1e3ed9c73fd7f381
>>> [3/4] riscv: dts: spacemit: k1-bananapi-f3: add SD card support with 
>>> UHS modes
>>> https://github.com/spacemit-com/linux/commit/c76e2f058cbcab84e4a703f26857a58bdf6a0042
>>>
>>> Best regards,
>
