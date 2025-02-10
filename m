Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F61C3C01
	for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181109; cv=none; b=HECK9a0PPLjIjXACeafysbtaGtidlUg4jzBdXV+ZMWdfzwm3dBbFGi/xAmBLq+snkUeupO0CvypnMSQ56lMDn+gY8F78blCmcncrq1i6spaB0YMYCPpBMmF3kgiWp34trCTunhu3HaLH5X7gyCNVlIkoVvr03+a3AKIC2oh5ZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181109; c=relaxed/simple;
	bh=OTbzl0pPIRsh7XzBft5GDjqFlKsKgb7fO1CIYcnyWyI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SG+YFPZI6unatE+K4ZdK37MTL6gfWqwb5is67L16Nb6NxiwuEwZwGOkpmNNRQ0daLcEls8CgOp0m72jqcDMZZ5Zfakdj29UF8h1eydwyAGRUBuehID0pwEzQOcpfySUjIeXZhdFyW+2u0/s1BjcM27+CaZms2PLy5HiHRim6/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5y5mVYf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5y5mVYf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4368a293339so46324795e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2025 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739181106; x=1739785906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyOzPnDD5nV6TA3iG57NOHGaY6BlLamnSYD7hNHtszo=;
        b=Q5y5mVYfo8Fs8nxIR36pf9JW+b7sN2uWqaeaqHgoIbc3nBhmLFEnu4cyeHoas6Lqu8
         +/WQa+ry9iiUd1UiU3GQJJxznpY+XzFog3wSA4LgKfGh/Yknp5RdWw8MwMdlZ+96eL4Q
         RoijdlqYwAMdVDBwAsbUv8ML6dwml3Z2ppDt24XBsZI9Gqtn7jDUlpImwcx6bIHquJC0
         KgQy/B1uv7Aa0qWw34xjwm3JMIeg79GI48wS6W6xjO5v9dPY4HXn1nfgyMBd24I5fOCc
         USw8Y9UVGPZML/vd0jDRpPy0dUrBdjZiZT2hwk9lJaIklu0IHDOuCLct8Z2uyJvgMjNj
         suag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739181106; x=1739785906;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OyOzPnDD5nV6TA3iG57NOHGaY6BlLamnSYD7hNHtszo=;
        b=HsMqHiTKeBAYFL6iLjPy9L1mQ46hW/79ziaYTGFCtiMN8AMAQCpZFeGnMs7kwbfNGS
         SXtq2PGcK7XHNXSCrsvFFDtBi2JtESpJAGFD+azf+oNyzqQDSTlA+A9DVOMcEDNaV9bj
         taRjhQs8CTUDamgTa6DY/BcVupcNxCf8Y95OYDYrSMk5IJ1ruLzMwRDc1yECXWc7lyGE
         VKshdAJILAeQ9Bgk+XuM/2EslCd5E8lSz1uku8A28MdYaOthlcZzLOnw7PiRifGgRkYt
         D0EmX+NM+vhSihhO8ryGu9q1P1mqaUBdPyApNmYuVw9wTb9rmeffD4wDEwmeSsg0MC3D
         cuQw==
X-Gm-Message-State: AOJu0YwABovbZsa3iiSFBcyVk2tKLrMIf87WVgjD9jholA/cpal8zF5x
	vCbEP3FTrMoe/xN/SCHG+6qWu6g7f3RxfCWNJFaEjE9wE9CCNShnly6D8eyEbr4=
X-Gm-Gg: ASbGncu/JsWrs1vYs56sZZKwE2BJeYAfsGAryruuUgw8wTWgFIcF0QoHE4YDEbNQbZZ
	fcIrB/gfvrMhati5mn6UxwovxsSs3c9vSY7SuQRTY6fjdF3CkArTVIMISllsVDt4Lw950mwckZs
	2BpAbMFZmc0JsJgm2aCdaIhpUO6h1MMhkc/Sei7SH9MlJLJAZaHvxULKchVH0v0wsoDozcIp32U
	mOqsq9z5hwKnExBLLL8kh7CtX71AmLntmbZj2pf5GR5hHS332u0RebVgwwwlRi2ee7cVBaStAUj
	g2cAuu4dvsEYasZFQuOS8PWVYBdMM/sRpnPgL3XgWH9ZoQI2sbEwU9HUkilS0mb2oOyV
X-Google-Smtp-Source: AGHT+IG2G+0jkkCrFzcyOswfbkjejbMcC59iHCIyTbbyZg24kwvnpZM5H9uQkhpiqY1F6e5Q+1GToQ==
X-Received: by 2002:a05:600c:511f:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-439249a82dcmr96610705e9.20.1739181105553;
        Mon, 10 Feb 2025 01:51:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5? ([2a01:e0a:982:cbb0:8235:1ea0:1a75:c4d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394127afcbsm37731515e9.23.2025.02.10.01.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 01:51:45 -0800 (PST)
Message-ID: <c0f9424a-664b-4d77-b8e9-1938e49746fc@linaro.org>
Date: Mon, 10 Feb 2025 10:51:44 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
To: Dharma.B@microchip.com, ulf.hansson@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
 <f6d7ffa0-6c08-45fb-9153-5e4aad1ca86a@linaro.org>
 <003ffa44-c88a-4234-a54a-50cd1140982a@microchip.com>
 <7180babd-302a-4f86-8770-bdd9f5c773cf@linaro.org>
 <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <7de20917-3176-4e80-8ccd-9c01c037cc9a@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/02/2025 06:28, Dharma.B@microchip.com wrote:
> On 07/02/25 2:47 pm, neil.armstrong@linaro.org wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> On 07/02/2025 10:02, Dharma.B@microchip.com wrote:
>>> On 07/02/25 2:25 pm, Neil Armstrong wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>>>> the content is safe
>>>>
>>>> On 05/02/2025 04:48, Dharma Balasubiramani wrote:
>>>>> Remove the compatible property from the list of required properties and
>>>>> mark it as optional.
>>>>>
>>>>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Instead of moving the compatible string to the other binding, just
>>>>> make it
>>>>>      optional (remove from required list).
>>>>> - Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-
>>>>> dfc747a3d3fb@microchip.com
>>>>> ---
>>>>>     Documentation/devicetree/bindings/mmc/mmc-slot.yaml | 1 -
>>>>>     1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/
>>>>> Documentation/devicetree/bindings/mmc/mmc-slot.yaml
>>>>> index 1f0667828063..ca3d0114bfc6 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
>>>>> @@ -29,7 +29,6 @@ properties:
>>>>>         maxItems: 1
>>>>>
>>>>>     required:
>>>>> -  - compatible
>>>>>       - reg
>>>>
>>>> If you remove it from here then it's still required in Documentation/
>>>> devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
>>>> so please add it.
>>>
>>> If moving the compatible to its specific binding isn't appropriate (as
>>> per Conor),
>>> and if removing it from the required list here doesn’t seem reasonable
>>> to you,
>>> then adding an unnecessary compatible string in our DTS files doesn’t
>>> make sense to me.
>>>
>>> What could be the solution then?
>>
>> The solution is right but you modify the meson-mx-sdio bindings, so
>> simply add compatible in a required list for the slot node.
> 
> Okay, we declare compatible as optional in the generic mmc-slot binding
> but make it required in the meson-mx-sdio binding, which inherits from it.
> 
> So why not define the property directly in the meson-mx-sdio binding
> instead?
> 
> It feels like the mmc-slot binding itself serves no real purpose.

It's designed to be reused, the goal was to facilitate migration of
other mmc controllers bindings.

Neil

> 
>>
>> Something like:
>> ========================================================================
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-
>> sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-
>> sdio.yaml
>> index 022682a977c6..0d4d9ca6a8d9 100644
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
>> @@ -60,6 +60,9 @@ patternProperties:
>>          bus-width:
>>            enum: [1, 4]
>>
>> +    required:
>> +      - compatible
>> +
>>        unevaluatedProperties: false
>>
>> ========================================================================
>>
>> Conor, Is it right ?
>>
>> Neil
>>
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>>     unevaluatedProperties: false
>>>>>
>>>>> ---
>>>>> base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
>>>>> change-id: 20241219-mmc-slot-0574889daea3
>>>>>
>>>>> Best regards,
>>>>
>>>
>>>
>>
> 
> 

