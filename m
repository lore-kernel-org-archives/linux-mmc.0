Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1147DFA7
	for <linux-mmc@vger.kernel.org>; Wed,  6 May 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075762; cv=none; b=qBK6lNLzBi7nPC4gH442/gzYcJQw6f0wAY1EEBsktYhBbqYgkTtf2ftDvsiaOGWl2ogFSJa35uF9RPDFL0Tj3efrEjou4/2+eXrEkd0+ZCy5dg3BxZ+GRmlbQmBRpz0v/LWckVU468ojDYaTfRjXeMF/XYrSdzoGhaupfjlfHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075762; c=relaxed/simple;
	bh=XcLrxU6hNruep/5Mhx3tarBzPKestSx9/PV2ZEBRHHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQNiAAPSnJ3S8ICf6rOpY1XXdKpYO3iXeA1reUCG8qKpEnDJvUsUVvr9KAesjn6ryV2e2r1ojnfhYieOPoRRM5OOaXYUh2b7sBBbio5THy1UsOVGsSmAB3e8Ak657X/EjQcAIXu3J/R9ir+Q3Mo35c4v9WSo9e5CN5zOXiJ3PPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLavsInj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLavsInj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so4126434a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2026 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075761; x=1778680561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21im18CnslCvYwXS2NJ84S3pXykaNCx3/vuExYBK0cE=;
        b=WLavsInjlhIZmPR3Ac8Zgb15aC4S/NDZrr4OP2UnPYBjUxFiz/CJ6rZmJiqksh1yhM
         qq6AUZ4GU10Y4OEQ3OM7sWtUeTNEs5o5UToriPlFTUCqMdHVQFMrnXKebLhw+yr49jpb
         8titwrXNiBEk/3XLEZWTr3NaegCuVJLgFxLtBM+amf6ZICNjtGdnL0e+PAPNkRavXivs
         LoabUPRZpYV3VFHTrMMvBVmsDD0WRIIog0l6fKRnBadrFwPB5/SCAtfWqo5Z7elqXe92
         wpeNTRXhfJs5Sf5PHx3MCxls4O9hXtcUZyXu8XXwCo010puwLa4mndyQvpO2muQHYP0U
         jQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075761; x=1778680561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21im18CnslCvYwXS2NJ84S3pXykaNCx3/vuExYBK0cE=;
        b=KxgbU2hLQkmmyGK22LTZIsJwbXdpWVgOcXjydj7m9K0BK3E5+fOkltIG3FaO3okj4U
         YLu1nXhNqwRgP8zf1UBA8hWdzbHalCmsxKJp/yoWbFMUoYU74DD5TS/amoublRzlD7aB
         OAqu8/fhyZGFsvH52FCkwvhXjAn0KaP5xawqS7jiBFraM+j7oNbQQntho614Flc0pG8K
         Diu4ZYnfX/UFTUW0qEW+MZNy55LRsTZHWMA5RgGZN5VzPfcGhE3hw10XJAwW7RON0xlN
         ZEdugTdbG7S/NZ12WzZ1c6X//PjqTJ/rIZ34t2CcS4L88fUj1rwq+MAAGzi0KKwdBxLx
         nCGA==
X-Forwarded-Encrypted: i=1; AFNElJ93e4vrNpN1u9XdOF+wopshzuC6kA7J3C5hUl9mw/+y8nk1ylFmHmV3lI82W6Jn+NXQ0EEUDFp69As=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXECG8sjKhvXXg/wnV5of0Q0V5wWkKrcfbQJC2nlpjSdDJEf8
	xwuj8Mgh5kU4/OEHP9VtagWPqur49pQmx7+bcr0i7zNzBhfISACO+e1Q17oUow==
X-Gm-Gg: AeBDiesG4Pc+hqMHE1xG0VR+Myhs8QRmbv3CERHVRLmabGE1IwM9UXb/3Ya95V4xpNm
	EfRPmpF6rC1zoyzncVNdt1sQT24Drc5acMvIIO5hB2AvPjyUp+A2BWqHkmjr4vhOEbvXu7y4y5o
	PFt/SxlpWQ8ZErMs+2NFK4C3vCV/i0Sow+JWZ6AFwdpdxvTeI2n9C230aPCdoHiCD55OrdQ2CQh
	gI6GDIvjAwiwP0HtDPPN4rWknqLT4UgIAVcZ6s8vccyUCPeRQpsEj8ZuTIJCEqe1Yp6UKiZXmCY
	YxP0bh0Ru6ii6KRGYb7z04Furks3Hxj3dfrEinP1T2GQnZ68gSjDLbO3woFJoBrGwZ2LG+M1MWF
	v15O/o1x+8K+/oW8lBShq/xGK049wDjy/31hQoWKnqtFHdEWZ0q/3/I8IPDceLwAHHvkli/1GoG
	hdjiqMbAPk904VFzRjr17zoDXWWj448XNySWH8pprDm396SzsVs7CRycYp
X-Received: by 2002:a05:6a20:2443:b0:39b:ba95:b127 with SMTP id adf61e73a8af0-3aa5a83151bmr4200206637.4.1778075760634;
        Wed, 06 May 2026 06:56:00 -0700 (PDT)
Received: from [192.168.1.3] ([60.243.224.75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242b811a5sm2326811a12.20.2026.05.06.06.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 06:56:00 -0700 (PDT)
Message-ID: <b386707d-944f-485b-8a06-236c1242f5ee@gmail.com>
Date: Wed, 6 May 2026 19:25:52 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: st,sdhci: convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
 <20260503-st-mmc-v2-2-11ae3216d2ce@gmail.com>
 <20260504-rational-gleaming-clam-aeaaff@quoll>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20260504-rational-gleaming-clam-aeaaff@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04-05-2026 13:13, Krzysztof Kozlowski wrote:
> On Sun, May 03, 2026 at 08:35:30AM +0000, Charan Pedumuru wrote:
>> +$id: http://devicetree.org/schemas/mmc/st,sdhci.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics SDHCI-ST MMC/SD Controller
>> +
>> +description:
>> +  The STMicroelectronics SDHCI-ST MMC/SD host controller, which is
>> +  compliant with the SD Host Controller Interface (SDHCI) specification and
>> +  is used to interface with MMC, SD and SDIO cards. The ST SDHCI controller
>> +  extends the standard SDHCI capabilities with platform-specific
>> +  configurations such as additional register regions,clock inputs, and delay
>> +  control mechanisms required for signal timing adjustments which are
>> +  necessary to support high-speed modes and ensure reliable data transfer
>> +  across different ST SoCs.
>> +
>> +allOf:
>> +  - $ref: mmc-controller.yaml#
>> +
>> +maintainers:
>> +  - Peter Griffin <peter.griffin@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: st,sdhci
>> +      - items:
>> +          - const: st,sdhci-stih407
>> +          - const: st,sdhci
>> +
>> +  reg:
>> +    minItems: 1
>> +    items:
>> +      - description: Base address and size of the MMC controller registers
> 
> s/Base address and size of the//

Okay, I will remove these words.

> 
>> +      - description: Base address and size of the MMC delay/auxiliary registers
> 
> Here the same

Okay.

> 
>> +
>> +  reg-names:
>> +    oneOf:
>> +      - items:
>> +          - const: mmc
> 
> Drop three lines above

Sure.

> 
>> +      - items:
> 
> So this is just items like you have in "reg" part. Same syntax.
> 
>> +          - const: mmc
>> +          - const: top-mmc-delay
>> +
>> +  clocks:
> 
> Here and:

Should I add minItems and maxItems instead of items?

> 
>> +    items:
>> +      - description: Clock for the MMC controller
>> +      - description: Interconnect (ICN) clock
>> +
>> +  clock-names:
> 
> here: Old binding icn is optional. You need to explain in the commit msg
> all the changes done during conversion.

Okay, I will write this change in commit message.

> 
>> +    items:
>> +      - const: mmc
>> +      - const: icn
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    const: mmcirq
>> +
>> +  resets:
>> +    maxItems: 1
> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Charan.

