Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A291CC8A2
	for <linux-mmc@vger.kernel.org>; Wed,  4 Sep 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454968; cv=none; b=mW7sWBp2cd2lx5oA0kSJkrFU0xamRV0YV+UjFU3twK1giH+Ax7/OcRYJA4ZqLD3FOPknYrLWLVY56VMoehIgRjyQCvhXTi/8Z/Ea0vNsXM0Km/EZxNXnBmlvtOWWaCE1lnTxuDpqQhssI8LqoraDFeymoE7UYmE9q9LZw9grWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454968; c=relaxed/simple;
	bh=+FjBNCFfIpfb5Si6eAO7PZp1GV3OdKhG/HDGkDFPrGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vbwv7EZ2dGPjNKdXH8LhF/KlsH4/CBlrGTRKkEmYrGWLaXaXpAeFvxRctUgxrGY73IiJwzORFuUki3/YM7tt70vDTl5R7b1PQsMG/1PIcxawHTOor6xEObvcVHrRiqQ6tOCvefJJESd/1VUS1sRzyiF+hYP9hpVl2VKKuIdnojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNBkZDMh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNBkZDMh"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53346424061so1327684e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2024 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725454965; x=1726059765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtYWncFU/TUpnWR9nR6aQ7AxX6rK7y4tKEhZ81nCBhI=;
        b=QNBkZDMh/n+EWMwVhgnOtMn6OukeiPeKo53dHdKsRHjfBQp8jh1ht9Nj3UevorOAnY
         XHf0lNlb5YlMQfZcYwrdpZtkAMUUsqyJXgRGwPbP4H9Shr3ylTADCAE4hc1xeZ2KRWZ9
         IIqUacfbimwJTn7/Di5tcLd+IHqNBO4fCFvAQSH7lvbKmz87VdzMUGhfOXWshWrMpV2T
         2nrtcJ/NnFm/wwQPVadZh+P5yPsmkVmOV/fDVqqx8++1bs4YargSIVPOseH92QK0afJ9
         k34rxwS2XsJXfPqV2sInL5TT91DbJT85hBjAtX7pfohgmApVEx2aRV3Yc/daaYdfhhDc
         liAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454965; x=1726059765;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtYWncFU/TUpnWR9nR6aQ7AxX6rK7y4tKEhZ81nCBhI=;
        b=lADEbCLOpJ/+OZa75xGO3ZYOgTq4FrTUa2sU8ZrVzzgq5f3jRpC6iFxxs0Ttj7RYJM
         2cPZZ1lKEyFaAkNxJW8ls2GADY4Z3ez+33AXCymzby9uiyOsRsf/PAKkS24M/7fe6JpV
         1XQrPofBQzR6R2yhQUaMt1PKB7fTQQE24rNekD97SRheeY/jbfBmIvNvmK/tRv9HaoCk
         cp6CVTIcp6QKJA32n/OBnUMKPEMd/fv/mNTWo63zeAYkma9OtPEuKZQQO/RQaywbetFD
         4OKnopA18LZ4UbOimSU4jCgxqtWvPC8f9eeaghOZrnQR1h3L7Pb9UWqcH/gifiKkXsRX
         pwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDxh/5Fnv3yqbXMBCqYjKi3hMMCVAD4C3bB2W5szKgFuYm8SnteNFHDLqKdXF5kEFHiLBcQ1JmopU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCoiVTUGb7YcPsqRlkRZLDaIAuQu+xB4A9g2sB+uCa4ACE3UN
	vkSc+8GLOd9L2nn8CbUF4ZyDc/FciWHhakslb4AUxHiVVRLgHxlDEHJl7w6zpZVasGDC6K0m8RY
	w
X-Google-Smtp-Source: AGHT+IHB5OQx2TRFRrZchnBllj8v9C9YH3OX/H8dJQsivrnIOs8zZFmRq2vDbZo3P3cTWXKZV2DaAg==
X-Received: by 2002:a05:6512:334e:b0:535:4d89:5b52 with SMTP id 2adb3069b0e04-5354d895d38mr3679602e87.1.1725454964676;
        Wed, 04 Sep 2024 06:02:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9d54f98sm13458385f8f.69.2024.09.04.06.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:02:44 -0700 (PDT)
Message-ID: <0d4d40cc-9885-4933-a6d6-933e4705a68c@linaro.org>
Date: Wed, 4 Sep 2024 15:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Add support for rk3576 eMMC
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com
References: <20240903145615.9302-1-detlev.casanova@collabora.com>
 <20240903145615.9302-2-detlev.casanova@collabora.com>
 <ag7hzh4crzuqkvborkqz4elastaodaq6e63xbssztfgoz5dhka@6bsjq3v37u54>
 <6077666.lOV4Wx5bFT@trenzalore>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6077666.lOV4Wx5bFT@trenzalore>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/09/2024 14:56, Detlev Casanova wrote:
> On Wednesday, 4 September 2024 02:00:27 EDT Krzysztof Kozlowski wrote:
>> On Tue, Sep 03, 2024 at 10:51:36AM -0400, Detlev Casanova wrote:
>>> The device is compatible with rk3588, so add an entry for the 2
>>> compatibles together.
>>>
>>> The rk3576 device has a power-domain that needs to be on for the eMMC to
>>> be used. Add it as a requirement.
>>>
>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> NAK
>>
>> Drop fake tag. It is impossible to receive a review-tag from me on THE
>> FIRST version.  I almost never provide reviews out of mailing lists.
>>
>> And since there is no changelog here and no versioning, this obviously
>> is not v2 or v3.
> 
> That's because the patch was from another patchset[0]. Only this patch needed
> a rebase on the mmc tree, so I sent it separately. You reviewed it here [1].
> 
> [0]: https://lore.kernel.org/all/010201919989e3de-60b56341-85e0-4869-89d1-362407c4f2ec-000000@eu-west-1.amazonses.com/
> [1]: https://lore.kernel.org/all/m5ua5jnbv4u36glqt2qrps35asuqfycxedgjrfhodi5bvs2r2h@xvy4qxt4gx74/

Hm, ok, changelog should explained this and the versioning should
continue, including history of this patch.

> 
>>> ---
>>>
>>>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
>>>  1 file changed, 26 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml index
>>> 80d50178d2e3..84a667f0c526 100644
>>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>>
>>> @@ -12,14 +12,18 @@ maintainers:
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - rockchip,rk3568-dwcmshc
>>> -      - rockchip,rk3588-dwcmshc
>>> -      - snps,dwcmshc-sdhci
>>> -      - sophgo,cv1800b-dwcmshc
>>> -      - sophgo,sg2002-dwcmshc
>>> -      - sophgo,sg2042-dwcmshc
>>> -      - thead,th1520-dwcmshc
>>> +    oneOf:
>>> +      - items:
>>> +          - const: rockchip,rk3576-dwcmshc
>>> +          - const: rockchip,rk3588-dwcmshc
>>> +      - enum:
>>> +          - rockchip,rk3568-dwcmshc
>>> +          - rockchip,rk3588-dwcmshc
>>> +          - snps,dwcmshc-sdhci
>>> +          - sophgo,cv1800b-dwcmshc
>>> +          - sophgo,sg2002-dwcmshc
>>> +          - sophgo,sg2042-dwcmshc
>>> +          - thead,th1520-dwcmshc
>>>
>>>    reg:
>>>      maxItems: 1
>>>
>>> @@ -35,6 +39,9 @@ properties:
>>>      minItems: 1
>>>      maxItems: 5
>>>
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>>
>>>    resets:
>>>      maxItems: 5
>>>
>>> @@ -97,6 +104,17 @@ allOf:
>>>              - const: block
>>>              - const: timer
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: rockchip,rk3576-dwcmshc
>>> +
>>> +    then:
>>> +      properties:
>>> +        power-domains:
>>> +          minItems: 1
>>
>> Why minItems? This does not look right. I don't get what you are trying
>> to say here.
> 
> I'm saying that for the rockchip,rk3576-dwcmshc compatible, 1 power-domain
> node has to be set.

The top-level property already says this. You need to disallow it for
other variants (:false).



Best regards,
Krzysztof

