Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7D15B135;
	Mon, 19 May 2025 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631303; cv=none; b=LHA71CIkFiHTNbOVZaVYAl6U1+nPmbxd5BE3exd0+fDZeMFGWLeu75GEKRoI8mqSrMKcL6eSXjmRg9dNcGulLv7OSREDpyDzNZ2vlAaGkjZJcgTuy24zvcYg8Rgq3B2RmEFJOnlGBs40Q4A6LVtACaUwUauxJDLnqF4ibc8gAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631303; c=relaxed/simple;
	bh=+5uQRfunz6MK8/PF2kn3g7bE2yl482T3Sfm+L9qP65U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZjxaEDBGpkLH6tf3xy3H+Ssh1APR1IBhKcvYb9K7gozxVOBlwTxXeJLxAzwVq0l6yrRl0NxyZvezO8jD7RVa6JgqYgH4wMG/FeWc8f0ILxmPR5wrpfaW+gVUCxz35XgiruEhSgA1vW2LwGemqk2/rbI1Y+drYbmbczbsD86ooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuuJkNFa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuuJkNFa"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b074d908e56so2492260a12.2;
        Sun, 18 May 2025 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747631301; x=1748236101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwD16IY+mV1vOg/kDG6DOdFjfPbkL9odEag4Ga7a+G8=;
        b=LuuJkNFaNVtZQH22rYD7EKrrGVzEHfe5d1nR02WGGjrufWutnxN9T+91EUjHi1/F55
         y4HOc7rlbKGiv705TryzmDLdDPU1V1bGwQe1bFLosad19zyvYlkNc44BBIeI/XE0y77X
         07w8IhzMCM6A6PSVAbd8j43LW9+h2e3+hE5TyXOLEppm9AiXSN7twYzXWZ5vwCtMcM53
         mkWDjS5wSSaZU2teKmjBrwFtVkQyODuyb1euZGa/j+D1yB4Q7GBcSktlbEqiSrYXpNmm
         UzHvqydmDNAeG0lrVd1peD4UFvXtQCBWjWjFJu5ijKcXQvxaQdPFWVQYW0KX/sQUYp6q
         21Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747631301; x=1748236101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwD16IY+mV1vOg/kDG6DOdFjfPbkL9odEag4Ga7a+G8=;
        b=sp+OyrDl3Fpu7xoPjow8mMQSI4eh7Dt2SZSlTwMeVQgUCZlsWWGAVAIx/glsBEe0Xg
         koTiQef8UeivApVQuRXl/v58JOLuxLZuNbsXA3PABlRGNe5cVzp5SmAXPCIRLb45NfsX
         2/yrPboGOD1xF1A2UGz7s132iO3WDVLxdlgn+IC/A08cV61qhmKC4fcJPU/G44OHQ1Eq
         ho9lYcgOndW2gm5uRzGNfijbgXeYLKiWku8tzqReMxnOK35oWa3GLLO0fFl2lFVLsweD
         sAZ+NszB9Wep7QASVrCSxWyRmbHrbY7JHWrfIl9a1ZI97rzEJpEQNyDuAzpqzpK58BQw
         XQyA==
X-Forwarded-Encrypted: i=1; AJvYcCVtvNMXL+5UlWVJ2itV59Dk6nV3VI3iGxlvdpa5MmUT2CGdxOfNAVkiahTNxcXj7AqTKkGvVsHv87O1@vger.kernel.org, AJvYcCW3LZJFdi+ATLay1QwTUx9SIbb07eDGe2jYfnLEvBC6jQoBTN6Mer6xODf4sWwFFCE+Nmu3xn7kXcB09Ec9@vger.kernel.org
X-Gm-Message-State: AOJu0YyNF+fMlxiOofs3CiSZ2XCyReZIijN65tr/1txfS3ycX431cb4U
	c7jKa+c8xP9nrDtL9HPUz2p6XcbMmSFnbtTHLRS7WNwNS1YRB7g0q5PE
X-Gm-Gg: ASbGncunqA+9qRyMMCJe7vGqletGtNBmOivm1HW1Qvf8s3XjDBf0Crfz/SU+Mv5q2VE
	bsIiTG//C87+tOS7ReFNRf7rOKrjt5DYjrB3tmDKe886EaR09llGshyyIXFTo7o1iz6ubgA+oNT
	anpDv4FiFHg3DXS9NiHvZ8xuH9dmd7HBVdMc7Lx2ILc6DKHE4tQeVgyPmaZJkFwW+QEIfx0qx00
	oyBhD9NQGjZ1iZnmVH5yC4RQ42idvT4K+WzJFAgt3nwxm05KLQrrbIE97h113h2odE+eXHKwDnG
	DAof8xP5PkibJNeGALpZrlbkyo2Gbot12PTfAy2CwNSYQAGZSyGzDZSCdxMkEULWdaUQjCxuv1+
	nvUayqHds3hM=
X-Google-Smtp-Source: AGHT+IH1Es9V7bpGSmK5k3mh2cazGmbf4vrH1kHrZdJfLjtCFQhaKIOHJ1kkKU2QJM7iDgNER1ixxA==
X-Received: by 2002:a05:6a20:728e:b0:215:df90:b298 with SMTP id adf61e73a8af0-2170ce19eaemr15743817637.26.1747631301368;
        Sun, 18 May 2025 22:08:21 -0700 (PDT)
Received: from [192.168.1.6] ([171.61.103.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb081aafsm5322931a12.47.2025.05.18.22.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 22:08:21 -0700 (PDT)
Message-ID: <6065e339-704c-4081-b4be-ab86417b9ec7@gmail.com>
Date: Mon, 19 May 2025 10:38:17 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: ti-omap: convert text based binding to
 json schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250510-ti-omap-v1-1-588b0ccb1823@gmail.com>
 <b18bc629-6bf6-4490-be98-033b771ecda7@gmail.com>
 <ecf3565a-e0ec-4848-a157-d0b5d1770b11@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <ecf3565a-e0ec-4848-a157-d0b5d1770b11@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12-05-2025 01:48, Krzysztof Kozlowski wrote:
> On 10/05/2025 19:20, Charan Pedumuru wrote:
>>
>>
>> On 10-05-2025 22:07, Charan Pedumuru wrote:
>>> Convert TI MMC host controller binding to YAML format. It's a
>>> straight-forward conversion of the typical mmc host controller.
> 
> 
> Not really - you added properties.
> 
> 
>>>
>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
>>>  Documentation/devicetree/bindings/mmc/ti-omap.yaml | 61 ++++++++++++++++++++++
>>>  2 files changed, 61 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
>>> deleted file mode 100644
>>> index 02fd31cf361d6ed893ec2f9eb8368b358ab2bae1..0000000000000000000000000000000000000000
>>> --- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
>>> +++ /dev/null
>>> @@ -1,26 +0,0 @@
>>> -* TI MMC host controller for OMAP1 and 2420
>>> -
> 
> ...
> 
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.yaml b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
> 
> 
> Filename based on the compatible. Didn't you get exactly such feedback
> already?

Yes, I will rename it.

> 
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..3660f54550e0ee46d3a7cfa3f531d95802f1e2fb
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
>>> @@ -0,0 +1,61 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mmc/ti-omap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI MMC host controller for OMAP1 and 2420
>>> +
>>> +description:
>>> +  The MMC Host controller for TI OMAP1 and 2420 family provides
>>> +  an interface for MMC, SD and SDIO types of memory cards.
>>> +
>>> +allOf:
>>> +  - $ref: mmc-controller.yaml
>>> +
>>> +maintainers:
>>> +  - Ulf Hansson <ulf.hansson@linaro.org>
> 
> 
> No, this is supposed someone responsible for the device, not subsystem
> maintainer.
> 

Okay.

>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,omap2420-mmc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  dmas:
>>> +    maxItems: 2
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +  ti,hwmods:
>>> +    items:
>>> +      pattern: "^msdi[0-9]+$"
> 
> Missing type: string-array
> min/maxItems?
> 

I think the type can be string, will modify defining type and maxItems. If it's string-array, the defaults can only be "msdi0" and "msdi1". So, I thought to define pattern with string type.

>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - dmas
>>> +  - dma-names
> 
> That's a change - binding did not mention it, did not make it required.
> Every change should be explain in commit msg.
> 
>>> +  - ti,hwmods
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    mmc@4809c000 {
>>> +        compatible = "ti,omap2420-mmc";
>>> +        ti,hwmods = "msdi1";
>>> +        reg = <0x4809c000 0x80>;
>>> +        interrupts = <83>;
>>
>> Forgot to include irq interrupt-controller header and use it for the interrupts, will change in next revision.
> 
> Header does not look like used...

Yeah, will change the interrupts format to take header format.

> 
>>
>>
>>> +        dmas = <&sdma 61 &sdma 62>;
> 
> But here you need two <> phandles.

Sure, I will rewrite them in 2 different phandles separated by , .

> 
>>> +        dma-names = "tx", "rx";
>>> +    };
>>> +...
>>>
>>> ---
>>> base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
>>> change-id: 20250502-ti-omap-12655fa9db3e
>>>
>>> Best regards,
>>
> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

