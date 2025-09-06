Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AA21255E;
	Sat,  6 Sep 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148207; cv=none; b=KA5UNNNHtX7wGxSGLeaKXQGeou6ZuhBPRAOV/FrtIG6zuzGgXH1C5WiyOhRUbn8wQD4sNLnX30JtvBz+0rY3ZaBZQie2+wSdpxr8FjPO7bn8Q9lAIS471WtvzaAg4fP877JdS4fVuiyhCCTGFRoz3h9C88SDWkXdr2gl2FGNeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148207; c=relaxed/simple;
	bh=JBUwNvePY9tPSjswVA5Q1OyexMAyZc/ozllbB+ZIi9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6SX1WSdKvrFkJW/u8gNNbJYC7ztqB06dyesBCSpoBT4XMUVzQyeiVHh94l7JGPP0u2HTr9YH/0N4HpyEXDBjjKVQW8Srv5el29GYBmGgfIsaT4zl0JdRm9sZcY+cS/zvjys5SI1DRO1JJUW07h5BJfREBi1Vjk0DEOa6wPcvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC+avwFk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC+avwFk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cd340377dso15556645ad.1;
        Sat, 06 Sep 2025 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757148205; x=1757753005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUxg25b/EmUgBouz0OK3qfXoIthYuIKfDrjuK1Vg/tw=;
        b=nC+avwFkJMT7nmGL3ybzfkNCNKCKbjTtWwfWNF00/k/XCoedydVgyJxVgxAdiSUEUY
         D1Z3IZwTEj5G6UyAv+ekEMThQ+mNvJbTWqH/fZTLu/mXdgcW9XxwviZvFUfKmVI5mwlO
         o/4FqSf6XKGPzV2twTvnwWtTTL3Q+FmUZJ1Pb5yDpiBFjjQBqNfDDYo7YzLPWT/LXWlL
         x6Bc20N6p+IRfhk10Ugw1ziqprV/ZrWwJSCorai8YRRhAqaW2k1kf4fWwFUJNb+tmKBG
         0z5EOrs9dxiREtq7mk0vA29Wq3r2H5ivi8hYEBCsVwoxCGcC2p/yeIgac2AuIXgF1bCd
         Raog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757148205; x=1757753005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUxg25b/EmUgBouz0OK3qfXoIthYuIKfDrjuK1Vg/tw=;
        b=IPbkrPz0OKqiEa2URy/d8Tq8TZSVimruH50Jbs8/0w4YaBEWB2YCH/I5WGacpIEcD7
         a7NjcPRcPxfC6ps5lz2qTYKqCHcTXnATYwg3SE2ny+ML/9ZjbXRz9uji16FFl825XDhE
         OP2o4gXspOAfqoJA9UxVpYrNTOhyQL29jUpXRkymFtz6XhhsCdXi/iElYADY9bVihuwi
         NdMR0b/TPaikq0eNmSG6VRRejXC1mIvw+KX6NCtq3UV+LUqquMTRHIQroTYe76wrYmbd
         IZP4olTyeHOUBSbjOhakDWml6cU3bqs4Bhc0GAE7Djfnm/W+CDAasihmgtN4VRBr3OD8
         xdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSibzPhuz+PQ+DLf3/ZUGTWmCpba8kTBfgixdxL3gdu82zxfbpHVqWRF0E2Qf2Ec8GhdA1Le/OpxEv9vvW@vger.kernel.org, AJvYcCWAb5K5G5+TceNc1d83Cbqa0ZfpbfuA+BtbJo+VCxhhVm/Qn0rC5fa+E56HydP6EjlgYXTW2dv4Bw+K@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb55Q+ziBf1smH2QE5H2JmUMpytZAB0eLGcCkCKKXkoXDvm/An
	YCpP3FHHbSP+IOJv5TUtF+LiHuu1E5yMNgNdScZfYt4cJACwhZjHrUmPXEriUg==
X-Gm-Gg: ASbGncu4QnKp04SSI0eI+O9VsbNHJKwnJQ0bo7kE5jgTO2Ulr3TjQe1nwd+X1KDFB3O
	LTDjk4XswwGWzDxlvo3Jr4zCHPKdobgfmT46MVUlx3Ge2jpBy5IiDLv8UZks/V9x2utKeUBNJBu
	TSvpMur/aj+QuNQRHG6uVJQ6YDYeMQ3P7Zy8XMnHlThLO3KkEn/qScVxwPkgSCH4Vqd0Lg+2Jru
	U/5QMTyYcaEMrUFr9HhfJFm2f4o/eoQZpu2LJcVgaWKMC1qmt6eAmW+cRvwHaXy7uuzTySTO0oZ
	E16psrrMr9BR1rtfCKK5LP0PVAV75LE6Eb4ZDAI+Y096vq9gd3Gn53IWg2bjyr6YFwCzaRGe0RH
	uGgif5fsuHda+kqbXi7LEnMOXGtfRvgc5D81HoKCOjMNx/Gi0mg==
X-Google-Smtp-Source: AGHT+IFNXRXlikjcdI5zfhceTJKEBRPRslKPpR/yTm5tAnF4qcgIlvJI9+pbZTminrPeBFYZRYCIJQ==
X-Received: by 2002:a17:903:19c6:b0:24c:e3d0:c802 with SMTP id d9443c01a7336-2516c896521mr21672045ad.1.1757148204554;
        Sat, 06 Sep 2025 01:43:24 -0700 (PDT)
Received: from [192.168.1.17] ([223.181.112.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9669a0e1sm89046975ad.56.2025.09.06.01.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 01:43:24 -0700 (PDT)
Message-ID: <cded96da-fdb5-4a50-9382-8f9f19589ce8@gmail.com>
Date: Sat, 6 Sep 2025 14:13:17 +0530
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
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <56bcea70-6180-443b-8c9b-f5d2a129c73f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28-05-2025 13:30, Krzysztof Kozlowski wrote:
> On 23/05/2025 19:05, Charan Pedumuru wrote:
>> Convert TI OMAP SDHCI Controller binding to YAML format.
>> Changes during Conversion:
>> - Add patternProperties for pinctrl-<n>.
>> - Define new properties like "ti,hwmods", "ti,needs-special-reset"
>>   "ti,needs-special-hs-handling", "cap-mmc-dual-data-rate"
>>   and "pbias-supply".
> 
> Why? commit should answer this.

The above properties are not documented in the text binding, so I defined them to resolve DTB_CHECK, I will write the reason in next revision.

> 
>> - Remove "ti,hwmods", "pinctrl-names" and "pinctrl-<n>"
> 
> Why? You just added ti,hwmods, so how can you remove it from required?

The property is defined but is not required by all DTS files and the old binding says it is required for all boards, I will add this reason to the commit message.

> 
>>   from required as they are not necessary for all DTS files.
>> - Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
>>   "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
>>  .../devicetree/bindings/mmc/sdhci-omap.yaml        | 155 +++++++++++++++++++++
> 
> 
> Filename: ti,omap-sdhci.yaml or one of the compatibles (or anything else
> following convention that it should match compatible).

Sure, I was following the name format of other files from the same directory here, but will change it to the compatible in next revision.

> 
> 
> "ti,needs-special-hs-handling" is already documented in other binding

Well, I didn't see this property defined in any common.yaml in mmc directory.

> 
> 
>>  2 files changed, 155 insertions(+), 43 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> deleted file mode 100644
>> index f91e341e6b36c410275e6f993dd08400be3fc1f8..0000000000000000000000000000000000000000
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> +++ /dev/null
>> @@ -1,43 +0,0 @@
>> -* TI OMAP SDHCI Controller
> 
> 
> ...
> 
> 
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..e707837bc242b055bbc497ed893a91c9b24f2dde
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>> @@ -0,0 +1,155 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/sdhci-omap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI OMAP SDHCI Controller
>> +
>> +maintainers:
>> +  - Ulf Hansson <ulf.hansson@linaro.org>
> 
> This is supposed to be someone caring about this device. Eventually
> platform maintainer.

Sure, I will change that, I was following the names of MAINTAINERS from the list I got from the command, "./scripts/get_maintainer.pl Documentation/dev
icetree/bindings/mmc/sdhci-omap.txt"

> 
>> +
>> +description:
>> +  For UHS devices which require tuning, the device tree should have a
>> +  cpu_thermal node which maps to the appropriate thermal zone. This
>> +  is used to get the temperature of the zone during tuning.
>> +
>> +allOf:
>> +  - $ref: sdhci-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,omap2430-sdhci
>> +      - ti,omap3-sdhci
>> +      - ti,omap4-sdhci
>> +      - ti,omap5-sdhci
>> +      - ti,dra7-sdhci
>> +      - ti,k2g-sdhci
>> +      - ti,am335-sdhci
>> +      - ti,am437-sdhci
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  pinctrl-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    minItems: 1
>> +    maxItems: 19
>> +    items:
>> +      enum:
>> +        - default
>> +        - default-rev11
>> +        - hs
>> +        - sdr12
>> +        - sdr12-rev11
>> +        - sdr25
>> +        - sdr25-rev11
>> +        - sdr50
>> +        - ddr50-rev11
>> +        - sdr104-rev11
>> +        - ddr50
>> +        - sdr104
>> +        - ddr_1_8v-rev11
>> +        - ddr_1_8v
>> +        - ddr_3_3v
>> +        - hs-rev11
>> +        - hs200_1_8v-rev11
>> +        - hs200_1_8v
>> +        - sleep
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  ti,hwmods:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description:
>> +      This field is used to fetch the information such as
>> +      address range, irq lines, dma lines, interconnect, PRCM register,
>> +      clock domain, input clocks associated with MMC.
>> +    pattern: "^mmc[0-9]+$"
>> +
>> +  ti,needs-special-reset:
> 
> I don't understand why you added this. There is no user of it.


May be, but the DTB_CHECK failed for some boards when not defined it here.

> 
>> +    description:
>> +      It indicates that a specific soft reset sequence is required for
>> +      certain Texas Instruments devices, particularly those with
>> +      HSMMC (High-Speed MultiMediaCard) controllers.
>> +    type: boolean
>> +
>> +  ti,needs-special-hs-handling:
> 
> I don't understand why you added this. There is no user of it.

...

> 
> 
>> +    description:
>> +      It's presence in an MMC controller's DT node signals to the Linux kernel's
>> +      omap_hsmmc driver that this particular IP block requires special software
>> +      handling or workarounds to correctly manage High-Speed (HS) modes like
>> +      SDR25, SDR50, SDR104, DDR50.
>> +    type: boolean
>> +
>> +  pbias-supply:
>> +    description:
>> +      It is used to specify the voltage regulator that provides the bias
>> +      voltage for certain analog or I/O pads.
>> +
>> +  cap-mmc-dual-data-rate:
>> +    description:
>> +      A characteristic or capability associated with MultiMediaCard (MMC)
>> +      interfaces, specifically indicating that the MMC controller
>> +      supports Dual Data Rate (DDR) mode
> 
> Drop the property. We have standard properties for this and there is no
> ABI for it anyway.
> 

Same here, the DTB_CHECK failed, so had to define it here

>> +    type: boolean
>> +
>> +  ti,non-removable:
>> +    description:
>> +      It indicates that a component is not meant to be easily removed or
>> +      replaced by the user, such as an embedded battery or a non-removable
>> +      storage slot like eMMC.
>> +    type: boolean
>> +    deprecated: true
>> +
>> +  vmmmc-supply:
>> +    description:
>> +      It is used to specify the power supply (regulator) for the MMC/SD card's
>> +      main operating voltage (VCC/VDD).
>> +
>> +  clock-frequency:
> 
> Why is it here? Nothing in commit msg explained adding it.

I will add this change to commit message along with the reason.

> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      It is used to specify the frequency of a clock in Hertz (Hz). It's a
>> +      fundamental property for communicating hardware clocking information from
>> +      the Device Tree to the Linux kernel.
> 
> Redundant description. It is not a fundamental property. It is a legacy
> property.
> 

Sure, will change the description.

>> +
>> +patternProperties:
>> +  "^pinctrl-[0-9]+$":
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description:
>> +      Phandles to pinctrl states. The numeric suffix determines the
>> +      state index corresponding to entries in the pinctrl-names array.
>> +    minItems: 1
> 
> Why exactly do you need these?

Some boards have this property with multiple pincontrol states, so had to define a pattern property to recognize all the defined pinctrl properties.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +unevaluatedProperties: false
>> +
> Best regards,
> Krzysztof

-- 
Best Regards,
Charan.

