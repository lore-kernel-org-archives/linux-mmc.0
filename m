Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BE159204;
	Thu, 20 Jun 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718927602; cv=none; b=Zfee/lDHgeegpkpCb35lHm1/lpyGzvseDUxmWnRuObu3dwWCd+O2Um/G3dDQ2sKHIXCEDXDgSK2etXHrtORdGtvz1iBSsKcAPawZfOI4A6XJ38ReRGWy7hLz1UL3hoK0kZnogAiXH888VZ4Sy9enjGw+6Lci2g9/yYjr1ByDdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718927602; c=relaxed/simple;
	bh=avSQMYIEEY2W6DAs/05THz899U39RFvYlSgTBTcgimQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T10XoP/AWUMGtFH2OqicJ/GFDMo45dZ8+VbR9I606IrA6dT6YiTOgJOVbmO8pwZtSxJuRPFAzREUDNqAR/9cTbEjkkvMSEcHo1k1rOCddJRXgq4Sd4edXRsbFZT7yyfPXnIqGbWqT0JCx306bAbat9+UWL+LD4MjCpqj/qnvZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDGKUdmK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDGKUdmK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70601bcfddcso1431270b3a.3;
        Thu, 20 Jun 2024 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718927600; x=1719532400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pmtddJthMQKvJgmwUwcCqsfsT87mXd0DUJUxKPzoExg=;
        b=KDGKUdmKydRstmyJaKjS35uE5ewwIEGbQd0cLg9JlhghG0EoJdNQ3LqEMvEgtDgsaL
         ZeIT3wCbGfZzhJudLnAMZamx2uP4S3Fdm1EoS2eSKQDORi1/n1oe6x38QySPcQymWIM9
         uoI7tNzRYgZApIej1GjD4zkoqu2PigHmO67cR0aul27LIP3ZvmJjfgTQY4PKVmuwBJgD
         S792hae7sTHjnNjKrvtsgi/+16HgxEog78UMESRibXq93hndHcPkLKbLx00f5aSwkJnL
         1pjfhzoQ3pIMENGDBK5F4zv3L9YLS3FRgtaQ+FvLJI386aRh9PCKFEI2ycG30g0yWmjr
         65vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718927600; x=1719532400;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmtddJthMQKvJgmwUwcCqsfsT87mXd0DUJUxKPzoExg=;
        b=fqm5pPnGTZjmxkIP+6qX/4HjPkDajzydtT5ACS5Hn/K45XS71Na1fhfYaPzE71898h
         MiWMZECbTKbdw34QP6lTfb0N2At3a9iFrCcCOHBXxjKMmxbrJhKmcUkt8tUc6CIaxK1L
         32orVK4uW+i8BstyuNN96DhnfQy0O4TJJUnhnOXZ87nTp6WQpurzamV6aURSj2nHeFER
         EufOvIekR8HnO/ec3EL3nHHjOkuEkON2ft9NfW2dAjT1iafDABmFTjSFDWDz4uJDo6uG
         XhrCPslO+g22HSs3XqyrULjtyIVDchHOiMuRBUVIlFBdRRY1hr2j2OTqJASeGLVzatVb
         e2UA==
X-Forwarded-Encrypted: i=1; AJvYcCWwahcPUm+3pRWeA2wghJki4lcVWXhRP9FhXOXyeBRHumqUSpMnbssRBLN52XKu8j/fC7FplQmikVbdKFYpnqx5PvhfBIq9DhICXkuNvef6wEDMQq779Se+MIDLyTl7nxEXrF6QBmZHkVe9wTJR4jY5PBYhAoyfZP9QYD2fP/wa0hj97A==
X-Gm-Message-State: AOJu0YwIqEbowRlOpWbquh2gtWv9v2kq1Sxwo3jpo9HylrRmkHPpqE6O
	6MD2Eey/CAV8YB5vb/ueIcU4nLrj9t26k4KOPAJpc3bRnTZ5Mh99
X-Google-Smtp-Source: AGHT+IFl3mGlSWyDautXUIxFZI07Ej5Fg9/SYd7TZo9A403tsBfjofIAmHGJpKVRmou+OtVc2sq2jA==
X-Received: by 2002:a05:6a20:47dd:b0:1b6:f34c:95b3 with SMTP id adf61e73a8af0-1bcbb60fca3mr6195673637.59.1718927599987;
        Thu, 20 Jun 2024 16:53:19 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc8efbsm1769175ad.306.2024.06.20.16.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 16:53:19 -0700 (PDT)
Message-ID: <42ec842e-84c0-40fd-b6fc-e59d25ede89f@gmail.com>
Date: Fri, 21 Jun 2024 07:53:14 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document
 MA35D1 SDHCI controller
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-2-shanchun1218@gmail.com>
 <3d193f01-2c8b-4d6c-8139-11f2d9a34d2d@kernel.org>
Content-Language: en-US
In-Reply-To: <3d193f01-2c8b-4d6c-8139-11f2d9a34d2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thanks for you review

On 2024/6/19 下午 03:29, Krzysztof Kozlowski wrote:
> On 19/06/2024 07:46, Shan-Chun Hung wrote:
>> Add binding for Nuvoton MA35D1 SDHCI controller.
>>
>> Signed-off-by: schung<schung@nuvoton.com>
> Since this was not tested, only limited review follows. Please test your
> future patches.
>
>> ---
>>   .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    | 106 ++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
>> new file mode 100644
>> index 000000000000..173449360dea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
>> @@ -0,0 +1,106 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:http://devicetree.org/schemas/mmc/nuvoton,ma35d1-sdhci.yaml#
>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 SD/SDIO/MMC Controller
>> +
>> +maintainers:
>> +  - Shan-Chun Hung<shanchun1218@gmail.com>
>> +
>> +description: |
> Do not need '|' unless you need to preserve formatting.
I will remove '|'
>> +  This controller on Nuvoton MA35 family SoCs provides an interface for MMC, SD, and
>> +  SDIO types of memory cards.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
> Drop

I will remove oneof.

>> +      - enum:
>> +          - nuvoton,ma35d1-sdhci
> Blank line

I will fix it.

>> +  reg:
>> +    maxItems: 1
>> +    description: The SDHCI registers
> Drop

I will remove description.

>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  pinctrl-names:
>> +    description:
>> +      Should at least contain default and state_uhs.
> ? Contradicts constraints.
I will modify the description to "Should at least contain default. 
state_uhs is mandatory in this scenario."
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: state_uhs
>> +
>> +  pinctrl-0:
>> +    description:
>> +      Should contain default/high speed pin ctrl.
>> +    maxItems: 1
>> +
>> +  pinctrl-1:
>> +    description:
>> +      Should contain uhs mode pin ctrl.
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
> No, maxItems instead.

I will fix it.

>> +    description: The SDHCI bus clock
> Drop

I will remove it.

>> +
>> +  resets:
>> +    maxItems: 1
>> +    description:
>> +      Phandle and reset specifier pair to softreset line of sdhci.
> Drop

I will remove it.

>> +
>> +  nuvoton,sys:
> 1. too generic, what is sys?
>
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle to the syscon that configure sdhci votage stable

I will modify description as follows:
   nuvoton,sys:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle to access GCR (Global Control Register) registers.

>> 2. typo: voltage
I will fix it.
>> 3. Which syscon?
same as 1.
>> 4. Why you are not implementing regulators?
>>
I will add "vqmmc-supply = <&sdhci1_vqmmc_regulator>;" in the examples.

This requlator is used by regulator-gpio driver.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - pinctrl-names
>> +  - pinctrl-0
>> +
>> +unevaluatedProperties: false
> Hm? And where is ref to MMC schema?

I will add as follows:

allOf:
   - $ref: sdhci-common.yaml#

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +    soc {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
> Fix your indentation.
>
> Use 4 spaces for example indentation.
I will fix it.
>> +        sdhci0: sdhci@40180000 {
> Drop label
I will fix it.
>> +            compatible = "nuvoton,ma35d1-sdhci";
>> +            reg = <0x0 0x40180000 0x0 0x2000>;
>> +            interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk SDH0_GATE>;
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pinctrl_sdhci0>;
>> +            bus-width = <4>;
>> +            max-frequency = <100000000>;
>> +            no-1-8-v;
>> +            status = "disabled";
> Drop
I will fix it.
>> +        };
>> +
>> +        sdhci1: sdhci@40190000 {
> Drop this example. One is enough.
>
>
>
> Best regards,
> Krzysztof
OK , I will remove one.

Best Regards

Shan-Chun

