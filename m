Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C78206945
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372310; cv=none; b=TjM9Q0jtyG2e28OJo4DmzairGKBKX9Ys9j6vBlaI1GVUAl0vegI0ph+bGVhxau0zplFxUmQj7QdczzKrjR46Rz5Z+pACxhPNwtnkqFNQQn9myLugPEH+hK4zExZt9kUEc4iSvYt4Tb+Us8z4ZShBVWOxQcylTdA5VXfZ8A/6S88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372310; c=relaxed/simple;
	bh=T1Y4WwrIh2YEiqFz/MV6PXScb2u9aOaPE/ZxQO+KPiY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJJ/YkA3UOBVXK4K6xsWfccz5us8tmhxmrNdIjI0W5DhKBkVVmWm68c3aRtNZGZprxufwZ7fdtu44rlYu4bToY0PtOWSsG2Ovd6I80QOPqT+EJpyuBppu4n2z3FQNNldPTY2yVoX2jvLeVENBW1NSInEqDQNo/uJR5djAkajCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kc44xN9t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc44xN9t"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e5e758093so46185445e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372307; x=1728977107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e0vB/xfUb5KsKbGyPnOatGTMRs7uojzkUVkiPqJNdc=;
        b=kc44xN9tt+fpFPyQBRMWs0JSVRBpaS3z5QriLq+Hl+OXx02vqZ5igb14/1Qas5NUnY
         KQ/NwANUJfKWwLgUTz+Zf5JnEkEi/O/+YhWWYHJXoY1Mf/Vm0zbFTGUSK0G5QdT+N0IH
         93XU3cQiWaxQV9yYM/t53MPwDu3zrXugYXDY29eMYC3WqlAXIwDM5vW1amiTwBeeJsW1
         iDaGIHYS3sKEADVXHO2JjQHRsW5d0N67miPC19dU7or8Z8GqNhdN2OvWBQ+xldDHK9AI
         dZdQ0oYDMcS4HAb9pNXNsrUVt/clkwHfJvU5K2AJOOWt0I28xCmYXkdBtcEsa+TBhiXW
         nmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372307; x=1728977107;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5e0vB/xfUb5KsKbGyPnOatGTMRs7uojzkUVkiPqJNdc=;
        b=ZVHlPbVs1SLjRLh7jAn/WEMSEkuZHdKbFj6TDpP1LEgU1NsAC1tpDmcdF8dqRRUtfH
         HPPQnTtL9TwJL1mbWYyFzomy/BiFUkk2tSrvpdqz3sJIv5UsLD3xw+kVOXBlOhFrsjUn
         cI8q2lLAHMa2mnQV/EPtJhaK6iR9xYM8LwyFayC0hofY98LBdO+QWo7CFQ1amPGCnYd5
         jneqmbH5lkrt3h9YKOYM9I58w6C6h8U9ahVR+3vYOHTvFnDbiLE9ABPaih0RPnO/7LUO
         GTd/RyJ7lJGNNjOAaRVeWaWCBfZEgzV4+SH8qC/HYBFbQUQO5stlWOTFXItK01EGgY96
         l+rA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBPTzntZVQW/2fniXDx0IoR8sXsE9rled2vq0AGv1J7Vv7usHJ7+GiiZjthGWycSA/qjXzdWFSN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtpsxgVS5iXaVx2kPGKh804AodaHAqAZFly2uese90i6WYEXa
	bolFubQcvBhN1zVsQPPmXwfkl5ao9dG3EM626QNjpXoMWT4KfUzVgMEa2JjwM0I=
X-Google-Smtp-Source: AGHT+IGKJyKn1CkE8ieX0UPcPGOpB+0hJcZaEl/FBijOrKGtn1bkOSUkYtwO+y6Clre3YaP2L94JBQ==
X-Received: by 2002:a05:600c:3b95:b0:430:5406:a60d with SMTP id 5b1f17b1804b1-4305406a73amr4563595e9.23.1728372306816;
        Tue, 08 Oct 2024 00:25:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8a25csm100160435e9.17.2024.10.08.00.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:25:06 -0700 (PDT)
Message-ID: <356bf96a-862a-4b66-bb63-92127ef5d84f@linaro.org>
Date: Tue, 8 Oct 2024 09:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
 <20241007200230.GA2301832-robh@kernel.org>
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
In-Reply-To: <20241007200230.GA2301832-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 22:02, Rob Herring wrote:
> On Mon, Oct 07, 2024 at 04:03:37PM +0200, Neil Armstrong wrote:
>> Move the common MMC "slot" properties because they are shared by the
>> single-slot or multi-slot controllers, and will help defining a simple
>> mmc-slot bindings document with proper slot properties and nodename.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>>   .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
>>   2 files changed, 360 insertions(+), 341 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> new file mode 100644
>> index 000000000000..e02d3cbcc271
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> @@ -0,0 +1,357 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/mmc-controller-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MMC Controller & Slots Common Properties
>> +
>> +maintainers:
>> +  - Ulf Hansson <ulf.hansson@linaro.org>
>> +
>> +description: |
>> +  These properties are common to multiple MMC host controllers and the
>> +  possible slots or ports for multi-slot controllers.
>> +
>> +properties:
>> +  "#address-cells":
>> +    const: 1
>> +    description: |
>> +      The cell is the slot ID if a function subnode is used.
> 
> Actually, this comment is wrong. When slot is used, this is still the
> cell size for the mmc bus.

OK, not sure how it should be fixed, and it should be fixed before this serie.

Neil
