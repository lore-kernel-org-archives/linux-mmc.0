Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49DF1DB377;
	Sun,  7 Sep 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757227992; cv=none; b=kVigXm7/27NbMjBwCCqFF3fiBOeE6zeuvPxTwVsh1kaj+E8BLGEIAXd4gGbR47yGYmIeeM4bixtvbZ6kgrN5egzxkY2Q/oC6GJijSuefS1BlBM5ru1Of7oEloeLRm87cHnO/lBodaa+QtC64gbVIUu8XSXWWg1nUH8AyGRB27fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757227992; c=relaxed/simple;
	bh=svksw43izxx+5A2+J4leAUSiXS7AhpSutpwM9U9mSZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybh3dLW++mFoI6o/ajkEOOD/TIvn+AlZl1ZaJMQfko7ChBA4enjrRipxZWdt5zIP+14qBJ+DO92eEdmF4v+ilFcFLpqFY3cW+3Oql1TSNmR1XgyUFzqiLFTFPtCseDd2+mWO0xr7oG62RrQhnnm9Yyaq1DYP7+L52rEOaWvcBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elV00ns+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elV00ns+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24cd340377dso18878275ad.1;
        Sat, 06 Sep 2025 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757227990; x=1757832790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOyGW3yOOAL+eege0XOWicEcKrCBOJ/yJv+n7inWSzU=;
        b=elV00ns+YojRzt1VDqfsB8j5AnFPKKJKUHJpx0q57HeJ3WKaGJMjJWMw1bZsvsyc3l
         HgkUj/wz2US+Fw+4UKV1Tl7rTdsjfbpmAiRCMlraEvq3wg1O+T6oQBAZxsAbLdwdAXh2
         MbdpQ2x8msFafKMmTpAio8fvbpAg3FnJ7KDByXhtp4MzQz5gxb9Dd4IV7jUx6eeDqni6
         ASprt04hdzgLWiaNxUPx8p5d5X0oWaonmdJ1UYCrqlXTWTE5ygolmK9sjnRJZWG6N9J4
         womnGy8XYB6bHUizKdxQTSbmN+zwjVIcGUHLyVAgFY8193qzaEhoRc2ue7qBwi66qVKf
         Xhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757227990; x=1757832790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOyGW3yOOAL+eege0XOWicEcKrCBOJ/yJv+n7inWSzU=;
        b=BDY/fRfG1ZYsktDBJVmvbd/GGTRvh6oZ8QGhzz3uP86C2A6c56mBpPlDSVfPZzuYFq
         ACrpWl0thiVCOSRRkjx7lRgrai3lrLySoD0bge2F8M2FzMKK6tGfrYD0dscW3oQ3ZRPh
         /Z92UPo70Y/ynhEx9Lk3CEvoYaSBFgE82o5YOqGyzoYm3gd95XgRpWNziozxBg907ORM
         Qj24CjBiyNLWeqhxs3XUROc2IlxWa+bZu1eP9OsrPs00vdERGrl9TqfCrhGrb3LC+elA
         rjzewczQfeoUk8urV1GD0BmkVNxda/fgyoEJNsyNkc1e4LWm/l6qgjf0gMUBwagVbR6J
         YZgg==
X-Forwarded-Encrypted: i=1; AJvYcCWT128xZ5CAKMgC66oxvSYz5XhIk0WyPsU729YOshna8jvChnPnp1sCHGVaay2gH9drJghkeaWBu+unvZ1u@vger.kernel.org, AJvYcCWuKJ/i8wJ35y5utPoDt5CGtOIkYT5VHCfBi+CEtU5YJtOxVmkydSGN82I+mSNwE1NKQStxCLHjtA2m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VkcNU9sNyAtMh/iKzYbSQ/8meWjBweSi9cfjS5M+bc3HSJxi
	jmX6mDFEAtftWiA46Q18Vtc2w0KtiVbFp22Nx70RPN2L5/UzuuINKgHY
X-Gm-Gg: ASbGncsYTivnfvkBGEUPizOuU3/wDmeAQ6YCEMR/HNI8jRWEQJS/A5xQdM+p6thDA15
	ARTZL1ghOlGBaR6cUsA3DzBMQQb4n+OlFaI0wOAZp+LtVa6WId41WJqHjSLOr6N9apMVqk6NrDm
	PExUkjOWELfCC2aK3vxxFkFlCgJRjQ9IqQYPq840Abl0PuA8+M0r9jViMzonlLkqk9mxWcmzKoa
	XRH/kCSEJN+Mm75uA7+0fwB1RKJf1cD0a+0gl1ejiigt3BfDL8tGftxggANDGJzCK5eT+q8rade
	CU25zplW6E2LjtMPiHlhAOYXGd3GETcECLqEzV3OTinWfvI56RPYvd2m7yBostmPbIGqSni8oD6
	8oSrBp262LMY26qsqQgaCVksydr1JKL7qIdjri4nhF1o8wxz6AfM5b4h1uBZG
X-Google-Smtp-Source: AGHT+IH9fUTIn1sDqo1bULibKfaXKESE84JfENot24hXA+Ko+2HbzH3bbh27x03Wpn+Bm8QT9oMIaw==
X-Received: by 2002:a17:902:ef07:b0:24e:e5c9:ed0e with SMTP id d9443c01a7336-25172099d9bmr56116775ad.43.1757227989875;
        Sat, 06 Sep 2025 23:53:09 -0700 (PDT)
Received: from [192.168.1.17] ([223.181.116.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9304b7eesm111044255ad.102.2025.09.06.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 23:53:09 -0700 (PDT)
Message-ID: <048d1b86-1575-4e31-b5cf-b6f72b2843fa@gmail.com>
Date: Sun, 7 Sep 2025 12:23:03 +0530
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
 <5d746239-83d2-4316-82e9-4e7ae4f3422e@gmail.com>
 <93f7f1b7-8c04-4d0e-9e41-6127651bdca4@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <93f7f1b7-8c04-4d0e-9e41-6127651bdca4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12-07-2025 13:59, Krzysztof Kozlowski wrote:
> On 12/07/2025 10:22, Charan Pedumuru wrote:
>>>> +
>>>> +allOf:
>>>> +  - $ref: mmc-controller.yaml
>>>> +
>>>> +maintainers:
>>>> +  - Rob Herring <robh@kernel.org>
>>>
>>> No, I really doubt Rob cares about this hardware.
>>
>> I will remove Rob from maintainers and add Ulf under the maintainers.
> 
> This should be someone responsible for this hardware, not subsystem
> maintainer.


Sure, I will search for subsystem maintainer from get_maintainer script.

> 
>>
>>>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,da830-mmc
>>>> +      - ti,dm355-mmc
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 2
>>>> +
>>>
>>> This wasn't in original binding. You need to document this in the commit
>>> msg. Also, list the items.
>>
>> Sure, but what list of items for interrupts?
> 
> List as a verb. You need to list them.


I searched for interrupt-names for mmc node in the DTS file, but there isn't any for davinci series.

> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

