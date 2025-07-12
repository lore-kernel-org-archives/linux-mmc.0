Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9730100;
	Sat, 12 Jul 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308588; cv=none; b=Oq1nacZ2vZoX0INX0UHR7ImMIQVyfl2Scwg6Z0IDi+3xvTavG1K2j6Bc33XLYX07cq9uOuM/LQ7YzOcddWL/Xl0a5t4Av+WrI/8X5xIFL0quP4XGVTwEPRyfZqebrcpKNEdX7np5sZjlgQfudjKycCe5m87POpMqDiZ0jUGKFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308588; c=relaxed/simple;
	bh=v52oQSXwlkoagGiHFACwaC0UZJ8RTfOndYocAd74wxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZJb1r5/Frp9hCJHW7ZM8K718g4TvGc/9wH0X/cfSWfWwBoo4uAiU4uk66OtdesGG+PcGH7IrkuY1SEx0wL7+fPLwrfUYib3zm4+PVAjiM3DrRXhg/RUqTDrb0+UjD7AveIAKW73fmFhyIPaawxqbDKrdMJ9QzdNHP06SKTon+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxOzh55q; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxOzh55q"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748e378ba4fso3453084b3a.1;
        Sat, 12 Jul 2025 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752308587; x=1752913387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKFqUM3pyu0fyPQZg2Nx/WLRvwHFxl0Jzs3sZVxJIjw=;
        b=XxOzh55qv+ZCQrQavtfZnpW42nYr2WOaJYR0GlFACL2cUhTF5wPMd+nf3hG7eSZJKc
         sSRHGrFe1aRVGIGj7Rv6/ZsTGxgW0R9MN7MYbEPOeVesatY7C2y9SmyVc8de2LOAaeED
         7Ln65g/q5KFwUb48Mwf6e7GbWxGeChMERM1ndVmCA8PemWcE10WQyf0hUlYIeCuU0f36
         oh3FtNEd+HbV+6G1LlgqqTQJL88IclM2toUiTftAQS3crHJfnmaOvnsuCeuVU1T9xkAc
         Np6RwbOVcmDcaREAtZNYuGazQ+Krw+eA3Uc3HCOSp8Wu66E7On3GDzo+1NGpYt42Hky7
         9dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752308587; x=1752913387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKFqUM3pyu0fyPQZg2Nx/WLRvwHFxl0Jzs3sZVxJIjw=;
        b=w12V4hlLw3/ouLpMdASoTNYJtQUZy1HIP7w0OnpXyyeIH5uDq8KFaolR0NAXr/ISyC
         PQzVOd2Spgkz+RZFlkdPX+rU9ueHMnXwexY/ezyYfWMLKRTg+YezD7hxO2z+1eAP0OpO
         CXnmFjBxJy0SMEXi0XpYFJRZ1LBZF4PyKRxLBbFKyE/zWI3lad6Bk/mAf9D0AEkF4oiS
         1Anlbw+aHW6tSM51+md8PxBgwUwbSJS6desp/w7qVfGTpUTrd+NKyzOmyOZSU5eb/hFc
         SaQN7keBKMQ1fStJQXLoUiMd2mw1jBAGQPk9x76BD45yr5Oxnt8P848Vx0579WZJJhMX
         VD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVP7EF3eQeizXWqkX+QrqB2lEzsyrrxuhVZTSh0vjwVYRwiaH4/IkqdRbqRcUlsiFtEEOaQ4B9o5qPh@vger.kernel.org, AJvYcCX0zvrlUcmFzve2fkIlPiXpC43V75ceZVFHsN6hwnOfDKdysJPum4dqecIzpRPQiRUH1rk8EJDkGISHOsbf@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5je71PzD1cT8auFMGbrymDvHsqyyen9I6wcTpI+bD19/97xJ
	4SOZTuqtnZKJHlWeq/QxPB37/9Lm4QBj4IlGut6mAj1Uryk1jM0JBUIO
X-Gm-Gg: ASbGncscGPq3lL+FV/4WdzauzR0DTegDSoDPLQUSkxOT558sJnKzHFe2PLpzo+L52oW
	en7VRXR3m8cZy7mjntz/HYKMbAmkMVjDw9y4+g6FW3hdcd2ZoJgEIiN62sL74ZEqoHkPWm0Uko8
	u7XF+RFyNogVGjGC8HA2aKEroYFxgZrltd4G9WoseGIgpBGT9xkMtMEKfdLxilwQ+a00Jr/v1j5
	yp1rs/enJaj1BRgG6VGaluYt6IPTtUt9ySQcslKb535JQXdkvockoT2kvsFFT1rWmRe151OUzc/
	ifzjqpDPY7u5ndyuWhMB74cTjVEp/MpUqGcJ5J3OjEywn/RPM6h8F1ukWB0WlCK4mAt47ya+6zG
	Y93R1EgBB6YLtbvw/epgtKWIVsTowfHs0yUf8rSFlONQsilk=
X-Google-Smtp-Source: AGHT+IFjWvLqIP65x17mTT7dOCbJCC9NkOVTyvExu2svK2zqeFEsGnWtdV7t2JH69w4KoOglCY99fg==
X-Received: by 2002:a05:6a20:7f8e:b0:220:83e1:49a0 with SMTP id adf61e73a8af0-23120903d76mr10602600637.42.1752308586600;
        Sat, 12 Jul 2025 01:23:06 -0700 (PDT)
Received: from [192.168.1.9] ([223.185.130.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b1b5sm7116560b3a.96.2025.07.12.01.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 01:23:06 -0700 (PDT)
Message-ID: <5d746239-83d2-4316-82e9-4e7ae4f3422e@gmail.com>
Date: Sat, 12 Jul 2025 13:52:58 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: ti,da830-mmc: convert text based
 binding to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com>
 <1c7e9077-c213-40a9-92f4-07e813a3d151@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <1c7e9077-c213-40a9-92f4-07e813a3d151@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28-05-2025 13:32, Krzysztof Kozlowski wrote:
> On 23/05/2025 15:34, Charan Pedumuru wrote:
>> Convert TI Highspeed MMC host controller binding to YAML format. Add
>> 'clocks' property to resolve errors identified by 'dtb_check'.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 -----------
>>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 62 ++++++++++++++++++++++
>>  2 files changed, 62 insertions(+), 32 deletions(-)
>>
> 
> 
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> "convert to DT Schema"

Sure, will change that.

> 
> 
> 
> ...
> 
>> +
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +
>> +maintainers:
>> +  - Rob Herring <robh@kernel.org>
> 
> No, I really doubt Rob cares about this hardware.

I will remove Rob from maintainers and add Ulf under the maintainers.

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,da830-mmc
>> +      - ti,dm355-mmc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 2
>> +
> 
> This wasn't in original binding. You need to document this in the commit
> msg. Also, list the items.

Sure, but what list of items for interrupts?

> 
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: rx
>> +      - const: tx
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> why interrupts are required?

It is not necessary, will remove it from required.

> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

