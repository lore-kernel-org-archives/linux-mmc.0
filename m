Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C566A
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jul 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224543; cv=none; b=gufAlQ9NyJybh3mzYpxoFF7h8mdufBzbueMU46moGYso2YYnIvZ3172BgifOicJm2QorTED/LMG6P/YsuSS9DqdkJK3IwodUvB+ZhsSJOEQbo7nnxV6Wvxm4gUsZqkVc8fUUGAa2tRYq3FUN3O9B0xKrpQ6+0DTMLBNZ5myXoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224543; c=relaxed/simple;
	bh=+gjrXwaLbg5dyM9XbloxcRlPhV5n8Y3acUiDKTctzWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH1Z1GWmSIEntusc1ihtVDUQIN+Ko7dL8AHBFt6UBFzVQwmbdDkyHTPDn5C7HYNhXH3FZV1zyaglgxqtD0C2YqND7DObBjae2M+5VlM9CqyvTJX+KvUsP/vaF3hp/+Aw+ltpARH2iDQQrHGO8xc8PxjZqKk1ZFrOV5oB0N7uiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHPuvcCt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHPuvcCt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42797289c8bso51453595e9.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jul 2024 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721224540; x=1721829340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y83H8RmAx7QVV9p+l8NUc1S/UNvUCiNXkhTxZU2ZpRc=;
        b=oHPuvcCtvwEla13wL8dP7/hWMLoL7Ugk7pe5X/b8VOA4Kew0Ok5fplEew4W7Y4sAey
         04REuvZBoIhngqowTlnR8zrbxaKud/oulKpDBaSUuhbmMeF7qq8Q+/44nD5686rPdpbY
         dr//9TIdayy0hQV5RpmMUTgDJPAm8KwhbMuIcxujXZ82I+Xy8TRVMyHpybE0QSl32rr/
         y/sg1y3kTy5NTSsyHzA6dA4d5Gy6ZKYqOEkxunvdSG21JQWl4AQ4rhoDUbFFsBI7TuOp
         Gr6drk+Yz8JoPWHCga/Rzitel3MhZUIFsdpilJWF3rrlTKitPdHfxRtJHK9I2Rc7DBIU
         bx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224540; x=1721829340;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y83H8RmAx7QVV9p+l8NUc1S/UNvUCiNXkhTxZU2ZpRc=;
        b=jMGuQNTVeMktLMEXb+6PClBTV1ySgaZC7PB1m0LaIUkdSsKUbbEp9euCyTEyv0tC0Y
         d5hbs/03unoTR7Z3XwRjwj5o2LGiax7jeusDQ1SZ1+vj2OYWeA5PhZ5HRAqEUv3x8OkX
         Jy/tqf4FnALCX2zYibY0kgSZDLx+PgZceTnTuSJUmJRXe0IXTXo1Qh0Nk/uCNOz0adsC
         zHZLHTf+yI/QerHuFMaOmJMyaJ+rPF6mAGwoP9ozGDgDANOwnxMIEvik7xZyJ7fzMu2Z
         JxelvFkcNaAOJJyMH0EgiVo2V7JUIDDKlYEhRmwQrhOHg1u4+vCSksdHJR2UPDVWMFHu
         Xx9g==
X-Forwarded-Encrypted: i=1; AJvYcCWLvlhQLUjuECRnFspVgKjSRi+Yx/QlWt9jKUHeFNTNawfBu+6CfJKS3T7yfSITN9hFZyKz/pExwipi+b8wwjMc4HdCEc9TOV7K
X-Gm-Message-State: AOJu0YwNA3f3WJumg4JfxXSbjGi0BfcyJj1C2yT4ilf21J3JDPDZ4lOX
	9SEx4tLh/cs0OhvdNoalmHmufQs2PvVtOPoXDT4gZ+uKHc6Xswaqov3140aD4bE=
X-Google-Smtp-Source: AGHT+IEOn6Lwjz9UGc6Bd48U+gnMDgs3sLUKiAjRWOATS2nwM6Fo4EkCFno7qAwuBenAB7Azyt3kyQ==
X-Received: by 2002:a05:600c:19c7:b0:426:61f6:2e38 with SMTP id 5b1f17b1804b1-427c2d0fc43mr12890225e9.35.1721224539936;
        Wed, 17 Jul 2024 06:55:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb449sm172590745e9.35.2024.07.17.06.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 06:55:39 -0700 (PDT)
Message-ID: <38be7954-5274-4c30-ab99-c076cfc5c563@linaro.org>
Date: Wed, 17 Jul 2024 15:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>
 <6e5ad808-f4ee-45c3-a1cc-009f2f1010b9@linaro.org>
 <MA0P287MB2822C4FB66C0CD31BED2E3B8FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB2822C4FB66C0CD31BED2E3B8FEA32@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/07/2024 10:01, Chen Wang wrote:
> 
> On 2024/6/18 17:39, Krzysztof Kozlowski wrote:
>> On 18/06/2024 10:38, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
>>>
>>> SG2042 defines 3 clocks for SD/eMMC controllers.
>>> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>>>    and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>>>    source, so reuse existing "core".
>>> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>>>    existing "timer" which was added for rockchip specified.
>>> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".
>>>
>>> Adding example for sg2042.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 69 +++++++++++++------
>>>   1 file changed, 49 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> index 4d3031d9965f..b53f20733f79 100644
>>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> @@ -21,6 +21,7 @@ properties:
>>>         - snps,dwcmshc-sdhci
>>>         - sophgo,cv1800b-dwcmshc
>>>         - sophgo,sg2002-dwcmshc
>>> +      - sophgo,sg2042-dwcmshc
>>>         - thead,th1520-dwcmshc
>>>   
>>>     reg:
>>> @@ -29,25 +30,6 @@ properties:
>>>     interrupts:
>>>       maxItems: 1
>>>   
>>> -  clocks:
>> Widest constraints stay here.
>>
>>> -    minItems: 1
>>> -    items:
>>> -      - description: core clock
>>> -      - description: bus clock for optional
>>> -      - description: axi clock for rockchip specified
>>> -      - description: block clock for rockchip specified
>>> -      - description: timer clock for rockchip specified
>>> -
>>> -
>>> -  clock-names:
>>> -    minItems: 1
>> Widest constraints stay here.
> 
> hi, Krzysztof,
> 
> Please ask you a question about this widest constraints, I write 
> bindings as below:
> 
> ```yaml
> 
> properties:
> 
> ......
> 
>    clocks:
>      minItems: 1
> 
>    clock-names:
>      minItems: 1

So 1000 clocks is correct? You can always look at helpful examples from
my slides... or another example:

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132

Best regards,
Krzysztof

