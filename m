Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3074236454;
	Sat,  6 Sep 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149668; cv=none; b=jlUrsEsdjJ6OGvtXBq+2M2ditYYSCnQ1/6v+z36mxwU+8voj55FoveYRJB8721IPUZ9NFsR5NFq64nc3gtSo3+Pv8pbCBdZ1PnqyMRY2r3vf8hJEwsgSeEMg+ljZ983fLWt9UBeYH+KiM0u4q9cMJBmfFzNu1klZjGV818yJ9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149668; c=relaxed/simple;
	bh=pB5gzDkI54l/i7k+HQWL1W/NVxinOhdCCa3CZsrFBvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1k2Ou94wKz/M8PCyP1HONh8yA0PUiiTHSCvFit/RbAOQ85PoE/Li7q0FN9z4lJru4vhPAELZLB4wxcYtvEWJWIlsqFP+6JHfKn3dmZv/cZsiAZLvPOmNQUKiC9hwqN+3t8yp+f5Yctmz4mJSyZaOZBz72EFtB8nYD+So8wliGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXrsRRFK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXrsRRFK"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e8005bso2569171a91.3;
        Sat, 06 Sep 2025 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757149666; x=1757754466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qm481bSQYAGrrJTiOApTZn1x56uPIBxlerFApUFgOH4=;
        b=DXrsRRFKiWpCNd+SODcexWgHBR+n93SCdYQkBd63WlXHzp3/qVWz40EnX+JEozb2xf
         BMKZEYYDtCmBhuAmXqSwM4ePvwZ7c5vS6VsoERsW4F06/L5TeuFQMnfx9/SKdGeQ0rXf
         eZSV0YFfNydP9LXiHoL/lGu1uDhn/YkvrFLR9kBT79r+zQfiw4w/1CI9vB55MOJGoWYC
         jLS0l+a35vnu2iSjMlAxwfFX4k9JJHYsx8q38iJ8H047K5RpjTEilTyjWPnj9Ghraru2
         dU2Q5XEWfaRxl25SXqidD7la2XxzhLTAAT913eV56LmXR/fQMsqjmfZ6Jazpt7GSkL+q
         ZKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757149666; x=1757754466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm481bSQYAGrrJTiOApTZn1x56uPIBxlerFApUFgOH4=;
        b=EAX0dUDccIyJdhwCAF2O4yjPsB1w7msB5wHFDKK2ImdNLZ6Vslk0+OVofEgPsIL77z
         4uHXyEykluCFrY8EA9dTZAJ48tFNxV+u2HAwOzbZjS6TWlosarGmKynSpSJbX+IK/Oy3
         1kdQiGlibvVKQ1kHA8QLZCbwoB7LSVkJfm0fhoWGejcA6i0AU4MJ0rlOPJLhjqJXbH9I
         acr7YdEhXa1HRnD3Si+tDRDLuBPxM0VaHvTJVpnrwikO7Viae+oLU8U6KXzIZx7CpZnS
         gzdLj0w9AY+QmWoJYhX4klu5Muc11ayTr1FnBYPN61B7KqgGozAkr3Yx5+VZcU62hzmO
         xlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX3qcdCbdsY4QdwppziDxtxXe/C9CDA1oCzHluTKtiEM9wQrrSCLslO+pmZB7Ywb3cYL9eezNofETS@vger.kernel.org, AJvYcCXTFpiuX1EBExxT6J4/COvot9AqpncGRqz5T130O4YagNXHOatgqdbLFbOsebi335DC/rSUytFo8jX74OnX@vger.kernel.org
X-Gm-Message-State: AOJu0YykP2FZqZs4te1KolvSpj7Uo3Qmfg89Q8+MvWQZxFnrIqMAlPbm
	wrAGIaakFzefdIOqGb/2OQUmaZq8umBAwXYASG89N+FiuZ8o2Plj3nPC
X-Gm-Gg: ASbGnctB4a6O7NQrwtMRGY113jWhDH0jJD4o6FLuRBGobWWMpi+b83Ly1pJi+RCNSKq
	oqxK4fExOUVwcSkBJSZQSMCKZN6kvxJeJASUqjPfMir4g4oq1wNjd/ccbgpfldahccTXj5Qb3SQ
	HlR2mYKCFbuf6JmzSjoZmPmeATNkH0nWBJWOlST7dcE5v3PO+EjwJlpXlQw+6O9h2smZodXXyS+
	mVeTTPyVt+OSbt2NWhwtfyAEbNY81bkMDN3c0i9EtuQlS+P5g8pVW/H/DAOMd4XwZ/ZZPgBwyys
	QH11xd0FBHrkQoOiHjAcio0iEA2/5+Yi1prTeRUD9MNyOjMzpKZJAE8cI7zE29AI9efzYCTeT3R
	x36yH8SPuY9gxDt0g5LrkhKkY+ZkBn6TtoOX308fCfMaojV5VQF5w/PYazziCVNw3hMYy31Q=
X-Google-Smtp-Source: AGHT+IHsJy6fckfNdVqhio0g5uj49cCKhfMsP8mPLpj8wPdCs5hRVrDe1PvRXQ/LrCtN7V2HOM+6XQ==
X-Received: by 2002:a17:90b:3812:b0:329:87b8:9fc6 with SMTP id 98e67ed59e1d1-32d43f2b307mr2472287a91.16.1757149665993;
        Sat, 06 Sep 2025 02:07:45 -0700 (PDT)
Received: from [192.168.1.17] ([223.181.112.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm13698277a91.19.2025.09.06.02.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 02:07:45 -0700 (PDT)
Message-ID: <877881b6-7d45-47ef-aa99-1827019a7c69@gmail.com>
Date: Sat, 6 Sep 2025 14:37:40 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-omap: convert text based binding
 to json schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com>
 <56bcea70-6180-443b-8c9b-f5d2a129c73f@kernel.org>
 <cded96da-fdb5-4a50-9382-8f9f19589ce8@gmail.com>
 <5d3802bc-68e8-43a8-8dfa-14d5b2b9e624@kernel.org>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <5d3802bc-68e8-43a8-8dfa-14d5b2b9e624@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06-09-2025 14:25, Krzysztof Kozlowski wrote:
> On 06/09/2025 10:43, Charan Pedumuru wrote:
>>
>>
>> On 28-05-2025 13:30, Krzysztof Kozlowski wrote:
>>> On 23/05/2025 19:05, Charan Pedumuru wrote:
>>>> Convert TI OMAP SDHCI Controller binding to YAML format.
>>>> Changes during Conversion:
>>>> - Add patternProperties for pinctrl-<n>.
>>>> - Define new properties like "ti,hwmods", "ti,needs-special-reset"
>>>>   "ti,needs-special-hs-handling", "cap-mmc-dual-data-rate"
>>>>   and "pbias-supply".
>>>
>>> Why? commit should answer this.
>>
>> The above properties are not documented in the text binding, so I defined them to resolve DTB_CHECK, I will write the reason in next revision.
> 
> You revive discussion from 3 months ago...
> 
> Anyway, explain in the commit msg that properties are already used in
> the DTS.

Sure.

> 
>>
>>>
>>>> - Remove "ti,hwmods", "pinctrl-names" and "pinctrl-<n>"
>>>
>>> Why? You just added ti,hwmods, so how can you remove it from required?
>>
>> The property is defined but is not required by all DTS files and the old binding says it is required for all boards, I will add this reason to the commit message.
>>
>>>
>>>>   from required as they are not necessary for all DTS files.
>>>> - Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
>>>>   "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array.
>>>>
>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
>>>>  .../devicetree/bindings/mmc/sdhci-omap.yaml        | 155 +++++++++++++++++++++
>>>
>>>
>>> Filename: ti,omap-sdhci.yaml or one of the compatibles (or anything else
>>> following convention that it should match compatible).
>>
>> Sure, I was following the name format of other files from the same directory here, but will change it to the compatible in next revision.
>>
>>>
>>>
>>> "ti,needs-special-hs-handling" is already documented in other binding
>>
>> Well, I didn't see this property defined in any common.yaml in mmc directory.
>>
>>>
>>>
>>>>  2 files changed, 155 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>>> deleted file mode 100644
>>>> index f91e341e6b36c410275e6f993dd08400be3fc1f8..0000000000000000000000000000000000000000
>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>>> +++ /dev/null
>>>> @@ -1,43 +0,0 @@
>>>> -* TI OMAP SDHCI Controller
>>>
>>>
>>> ...
>>>
>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000..e707837bc242b055bbc497ed893a91c9b24f2dde
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>>>> @@ -0,0 +1,155 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mmc/sdhci-omap.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: TI OMAP SDHCI Controller
>>>> +
>>>> +maintainers:
>>>> +  - Ulf Hansson <ulf.hansson@linaro.org>
>>>
>>> This is supposed to be someone caring about this device. Eventually
>>> platform maintainer.
>>
>> Sure, I will change that, I was following the names of MAINTAINERS from the list I got from the command, "./scripts/get_maintainer.pl Documentation/dev
>> icetree/bindings/mmc/sdhci-omap.txt"
>>
>>>
>>>> +
>>>> +description:
>>>> +  For UHS devices which require tuning, the device tree should have a
>>>> +  cpu_thermal node which maps to the appropriate thermal zone. This
>>>> +  is used to get the temperature of the zone during tuning.
>>>> +
>>>> +allOf:
>>>> +  - $ref: sdhci-common.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - ti,omap2430-sdhci
>>>> +      - ti,omap3-sdhci
>>>> +      - ti,omap4-sdhci
>>>> +      - ti,omap5-sdhci
>>>> +      - ti,dra7-sdhci
>>>> +      - ti,k2g-sdhci
>>>> +      - ti,am335-sdhci
>>>> +      - ti,am437-sdhci
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  pinctrl-names:
>>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>>> +    minItems: 1
>>>> +    maxItems: 19
>>>> +    items:
>>>> +      enum:
>>>> +        - default
>>>> +        - default-rev11
>>>> +        - hs
>>>> +        - sdr12
>>>> +        - sdr12-rev11
>>>> +        - sdr25
>>>> +        - sdr25-rev11
>>>> +        - sdr50
>>>> +        - ddr50-rev11
>>>> +        - sdr104-rev11
>>>> +        - ddr50
>>>> +        - sdr104
>>>> +        - ddr_1_8v-rev11
>>>> +        - ddr_1_8v
>>>> +        - ddr_3_3v
>>>> +        - hs-rev11
>>>> +        - hs200_1_8v-rev11
>>>> +        - hs200_1_8v
>>>> +        - sleep
>>>> +
>>>> +  dmas:
>>>> +    maxItems: 2
>>>> +
>>>> +  dma-names:
>>>> +    items:
>>>> +      - const: tx
>>>> +      - const: rx
>>>> +
>>>> +  ti,hwmods:
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    description:
>>>> +      This field is used to fetch the information such as
>>>> +      address range, irq lines, dma lines, interconnect, PRCM register,
>>>> +      clock domain, input clocks associated with MMC.
>>>> +    pattern: "^mmc[0-9]+$"
>>>> +
>>>> +  ti,needs-special-reset:
>>>
>>> I don't understand why you added this. There is no user of it.
>>
>>
>> May be, but the DTB_CHECK failed for some boards when not defined it here.
> 
> Then maybe should be dropped from DTS?

Okay, should I drop the properties ti,needs-special-reset, ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the DTS and send a patch series?

> 
>>
>>>
>>>> +    description:
>>>> +      It indicates that a specific soft reset sequence is required for
>>>> +      certain Texas Instruments devices, particularly those with
>>>> +      HSMMC (High-Speed MultiMediaCard) controllers.
>>>> +    type: boolean
>>>> +
>>>> +  ti,needs-special-hs-handling:
>>>
>>> I don't understand why you added this. There is no user of it.
>>
>> ...
>>
>>>
>>>
>>>> +    description:
>>>> +      It's presence in an MMC controller's DT node signals to the Linux kernel's
>>>> +      omap_hsmmc driver that this particular IP block requires special software
>>>> +      handling or workarounds to correctly manage High-Speed (HS) modes like
>>>> +      SDR25, SDR50, SDR104, DDR50.
>>>> +    type: boolean
>>>> +
>>>> +  pbias-supply:
>>>> +    description:
>>>> +      It is used to specify the voltage regulator that provides the bias
>>>> +      voltage for certain analog or I/O pads.
>>>> +
>>>> +  cap-mmc-dual-data-rate:
>>>> +    description:
>>>> +      A characteristic or capability associated with MultiMediaCard (MMC)
>>>> +      interfaces, specifically indicating that the MMC controller
>>>> +      supports Dual Data Rate (DDR) mode
>>>
>>> Drop the property. We have standard properties for this and there is no
>>> ABI for it anyway.
>>>
>>
>> Same here, the DTB_CHECK failed, so had to define it here
>>
>>>> +    type: boolean
>>>> +
>>>> +  ti,non-removable:
>>>> +    description:
>>>> +      It indicates that a component is not meant to be easily removed or
>>>> +      replaced by the user, such as an embedded battery or a non-removable
>>>> +      storage slot like eMMC.
>>>> +    type: boolean
>>>> +    deprecated: true
>>>> +
>>>> +  vmmmc-supply:
>>>> +    description:
>>>> +      It is used to specify the power supply (regulator) for the MMC/SD card's
>>>> +      main operating voltage (VCC/VDD).
>>>> +
>>>> +  clock-frequency:
>>>
>>> Why is it here? Nothing in commit msg explained adding it.
>>
>> I will add this change to commit message along with the reason.
>>
>>>
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      It is used to specify the frequency of a clock in Hertz (Hz). It's a
>>>> +      fundamental property for communicating hardware clocking information from
>>>> +      the Device Tree to the Linux kernel.
>>>
>>> Redundant description. It is not a fundamental property. It is a legacy
>>> property.
>>>
>>
>> Sure, will change the description.
>>
>>>> +
>>>> +patternProperties:
>>>> +  "^pinctrl-[0-9]+$":
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description:
>>>> +      Phandles to pinctrl states. The numeric suffix determines the
>>>> +      state index corresponding to entries in the pinctrl-names array.
>>>> +    minItems: 1
>>>
>>> Why exactly do you need these?
>>
>> Some boards have this property with multiple pincontrol states, so had to define a pattern property to recognize all the defined pinctrl properties.
> 
> No, that's just confusing error from dtschema. Look at other bindings -
> no binding defines type and description for pinctrl.

Okay, I will remove this pattern property and will define it like normal property following other bindings.

> 
> It just means your schema was incomplete.
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

