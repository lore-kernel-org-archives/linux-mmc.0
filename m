Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD8204C1D
	for <linux-mmc@vger.kernel.org>; Tue,  4 Feb 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738656856; cv=none; b=MCSkztfcMIWUaaxTmFFgOq9sm2k8eEn3kQ2Tvh+U4+C/yeZE2GRORxOZyPUiL1WwNLuzD69joK1ppAoxI7hR+nWjy7G4ruTUXRpRE3/zQvAvO5eZ8gib5jJpOinYacLF3zki3VWxa+QM5KyNi4fQped5Lsu70F/Lvkbk7gqupeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738656856; c=relaxed/simple;
	bh=B38rBSSh08CHoCV0k2KcAyPTOBqx1I5X9BaZL3HUXJI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=avdHnJjnJQTVuKrePQiw17NJXjzGowGeyEO/7Eiw+JEAm2MpuhqIuslTYlR21i3HG50AtdDhksSRJAwqDl6rL4TbgANRmY/T46dN2Xar95bw3YyfR0flspBQaivRTnt5TE72y397heP3hYcSi8naPauOzsaLiilN4lUyGkJenfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8nyURpS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8nyURpS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43621d27adeso35801495e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2025 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738656853; x=1739261653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sCR9UpdvPq54knP20h3bb4wqIzkXCrYqODJJrs8Hjo=;
        b=F8nyURpSxkSDL4F2SnV2XfeHbxR/eag7Xn+gpDj4DnxsI5IQmCST1+cQX1bhLPNkCJ
         Iuhx/BLw3sP8OEWFT04bl1Tw4U6HGbmhhP9MNnuw7Add88WP1zsDE0q5RDT2GRyFC4fd
         2acCDuU9rOLPNRKN3MJGcx7I2zcHyKM6tPHuQwNEpAKUK7qJU27/8fMP6vzO1TtSdot0
         SrwyICgdqvjat07+IrMfI6Uv7eJ37yf0eEVUMAenoRQY+UVX4sGM6Dh9v1kSMpDh4RNi
         Ht3AypZG7o20cp1g5lF/3lijE32Oxd4S+3jVy7sQreG3HhnWatY8JzPvxajj5kf1pXYO
         xSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738656853; x=1739261653;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8sCR9UpdvPq54knP20h3bb4wqIzkXCrYqODJJrs8Hjo=;
        b=GU81USnTlGeXV48hZGYW3p1wk5HR8NRSCsbKjIlok+ssAvu9duoCcJe641Y8ze3Edd
         GuAIufwINXuEVzNg+1GGW9lwRasDnrUBHrhu6OCl+rf0Xa+J2b5zs34CCgaCEtdDTZPa
         0F96HxnFk8AvuC8SQnQ0Qo9kJOBQsYKTWBU8Cn6zSPcnFihoJIkivd3KnHAf5OqsdvOK
         Hfvvph5dGGr8As38e/7vF/mfwko+6woks1RzX3kFlZ7h1D7iEaw6MCsHYmXcumgTSMjB
         kX/AHBMvxtMK4FnTRGVTnhRSlZyfeQEGNI2iVY+5yN2LZrRZUsxl1WqQS2rJTp0cnnjj
         8gXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk0jCm0UX1/E0FfHcL6soPxCyRPFE5Rk9/9i06KexBMH98ISWXRkqUQ+HsxLBFjVsioKJtP6VtDD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylx2MXEv8g+aVPzA+lXtNajrN3PlueEATD/M1mZQcWvu+lROt8
	ZCl3OiyCBBm/7x9dV1LBOgV44rx+kfSW7yKIT9iPYg17V0dKWh2aekXL+4rDoPc=
X-Gm-Gg: ASbGncuaDM6YwKVhbNCRMm703OJ+8adxB5vG/5MdBvjut6MwK62YuP2M+uglOgj75FE
	bJ9y363WETjPDXxuS6z7rtFiLtiqwWO1MWuu5w1V0spGaEyaBAfGE/L4KvLUEGATYIiEciriVMh
	4mKRWYw1LXlbXEES3Fig3rjzmw6wVFL3nQg45QmHFraZWvOGNnOmprptg/UYlQ2nqE3OTnoqJKf
	FQDjteK1GlIJBzJf+ZZMFr7vRk+k+lpM+exe2TOWONvAMhnzDYWuk6kNQ1uosdArRY615eJv2RQ
	UrnniPr0Q4rUN5C8eS0vfzjSFyF/yrNCk6JIAjDpvmca/ICPBRmp+NFC1HnmcP2MbsRk
X-Google-Smtp-Source: AGHT+IG3tRoGmZu1OmIgYWpqEIVgV5wfqw0l/woeaKBkcCKJ2qcs0i4efob+omaMPGS57HdE6nfnIA==
X-Received: by 2002:a05:600c:3510:b0:434:f925:f5c9 with SMTP id 5b1f17b1804b1-438dc3af8c1mr200771315e9.6.1738656853012;
        Tue, 04 Feb 2025 00:14:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8db5:d196:bd48:5fbb? ([2a01:e0a:982:cbb0:8db5:d196:bd48:5fbb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dac5a3e79sm900306f8f.63.2025.02.04.00.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:14:12 -0800 (PST)
Message-ID: <3ecf58f4-38c0-4435-899a-400df62f5d51@linaro.org>
Date: Tue, 4 Feb 2025 09:14:11 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
To: Dharma.B@microchip.com, robh@kernel.org, conor@kernel.org
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 martin.blumenstingl@googlemail.com
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud>
 <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
 <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
 <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
 <779651f3-e5d4-4de8-878a-84653735e5cb@microchip.com>
 <f312c7ff-8d9b-4317-a75b-ce3d0f94a7ae@microchip.com>
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
In-Reply-To: <f312c7ff-8d9b-4317-a75b-ce3d0f94a7ae@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 04/02/2025 05:24, Dharma.B@microchip.com wrote:
> Rob / Conor,
> 
> On 20/01/25 10:00 am, Dharma B wrote:
>> Hi Rob/Conor,
>>
>> On 09/01/25 2:26 am, Martin Blumenstingl wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>>> the content is safe
>>>
>>> Hi Dharma,
>>>
>>> On Wed, Jan 8, 2025 at 4:11 AM <Dharma.B@microchip.com> wrote:
>>> [...]
>>>> "One issue is 'compatible' is required. Either that would have to be
>>>> dropped as required."
>>>>
>>>> Instead of just dropping it from "required:", I removed the property
>>>> itself and moved it to another binding.
>>>>
>>>> I will send a v2 by removing it from the required, will it be fine?
>>> For me this is fine.
>>>
>>> My understanding is that if we drop the compatible property completely
>>> then any compatible string will be allowed (for example: compatible =
>>> "random,name"). This is because mmc-slot.yaml inherits the properties
>>> from mmc-controller-common.yaml which itself has
>>> "additionalProperties: true".
>>> However, if we allow it but make it optional it means that there's
>>> only two valid states:
>>> - no compatible property (on the Atmel / Microchip SoCs)
>>> - a compatible property with the value "mmc-slot" (as used on Amlogic
>>> Meson and Cavium Thunder SoCs)
>>> - (anything else is considered invalid)
>>>
>>> Rob, Conor: can confirm this or correct me wherever I got something
>>> wrong.
>>> I hope that your feedback will help Dharma write a good patch
>>> description for v2.
>>
>> Shall I proceed with v2 by dropping the compatible from the required
>> property list?
> 
> I hope this email finds you well. Just following up on my previous
> message from 20/01/25, as it seems to have achieved an impressive
> feat—perfect stealth mode. Either my patch is so flawless that it left
> everyone speechless, or it has been silently sacrificed to the inbox
> gods. 😅
> 
> If there are any concerns, feedback, or a secret ritual I need to
> perform to get a response, please do let me know. Would love to hear
> your thoughts when time permits.
> 
> Looking forward to breaking the radio silence!

Just send a v2 as RFC, so we can comment on it.

Thanks,
Neil

>>
>>>
>>>
>>> Best regards,
>>> Martin
>>>
>>
>>
> 
> 

