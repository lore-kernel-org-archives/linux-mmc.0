Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E621DED4F
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372262; cv=none; b=BY2IWm1tAWzEd3qtc7sP55SXybLTqek8f+1TuGU8+qaIXalVMTdiAmL8ypwnpxtgxb6gZLYfk1fdvLB1vG8It5nCWNs1sh4to8L26pf6ToNn4Ft1RBNucgAupdIohABt0qsYT3Ig8TYBypTBgo952TUHLezAmL1Zv6MM5zSWOEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372262; c=relaxed/simple;
	bh=k5wKtozUOXcwormKspYI1NDZ/jqQAW2HSmCajtiDnW4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aDanHj/BPokjLZr5xjWcd4jh5cX3TgTKQaBG0RxbQ64I8s07cL+gjq5d5TRl2YLYkrBMorH3XQu+w7yV1Cc1QQEELzr/upDBQOselKef0DmtXGkKNiC74s7Y32th0gHYRXnCs+TgSz2KfnTJLsprocwB+9uGGSGb9uTnn988MnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYRY6JJ+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYRY6JJ+"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3297b7deso116147f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728372259; x=1728977059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1VM20ISJYt7dKAhB6XtLtvc4jaMUUz1mm+hI9Gbj9M=;
        b=tYRY6JJ+4emHLr2KTLwUmoDMiJSfEO9MX548tPktW9j/iOx0vJuvGlg4FjNam4APbG
         MpA8eE/kI4Dh5tOMhNAZyO45VAXG3ZnLwgCRDZIlCCwCo/LUeUObGrSh1flkAi+D1EhK
         UR4SXBrYIwVqtRubXOZrwlYTOoK89ss5d/ppXKL10lcit/tRnYud6qLzakSomU98vSMQ
         Yc8LB350pEPanUZ/afbq6JycB372CTjfTSMdtm2pQBuBcNoVcPH0HHq8rwQQzBUVvOHk
         7eWQ4l3ui4YOueGqqMYSVHjkxGXHb6/yhNvuEeOBB30ACRrTuoiN58+lyFNoLEihQz1i
         mn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372259; x=1728977059;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1VM20ISJYt7dKAhB6XtLtvc4jaMUUz1mm+hI9Gbj9M=;
        b=mTgLnzaySOFHv2yyIT+Y5mMkY1e6tv2lshTLjMTXOA9/rvNWQPgHEWfbqyrfm6/KQM
         Cs5ILMi0zhVCrAGXUJz+Ohk3fqLNTzHrr7XlcyrLUKtNLHTzFd2TQ6ucyqAgZFNgux6F
         B9IU7VO/9MMvt90iI3AEcaF/IUfkV/dgPB+FkSIhb3QATB48HH5iw3RH1dGMI+jQM1nB
         pB5QUCQCaT6AcUwHSU96Y7xjcJVgvi/TuKGWC1p5HHMbRO+zF+p//Tin1wHb3jyhY+N3
         gCsYX+RuT+iH7tBJkNCI6H6Ftrcy4gajItukp/8WJwnNsE7CUSyz2NKm0qrL50+QPuin
         shAA==
X-Forwarded-Encrypted: i=1; AJvYcCVBylEzAvdqU3+Yuc4ny6V2jNdeoNKDEqxNHnAyVzy/4HQl3yTFw+Y+Rx433PmOm7ke8ZpqXuEnNT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3neEW/qRxkT57nsOJDl897wfy46hg+vmgYJGpoBrN5Ws+7Sb
	KqkWxl15pRUW7Ls4Q8d3jDoX1qAFWwKDgEqwMG0V7lh8dtHk0mpDv7NUgw1ji/I=
X-Google-Smtp-Source: AGHT+IHhT7YDIaN7Kvo+FOkIhUP82M2DN1YA8Z9gx7LKSdf9ce7WfEWZNpKl+nbSFSxeivLT+cBNvg==
X-Received: by 2002:adf:ea8c:0:b0:374:c287:929b with SMTP id ffacd0b85a97d-37d0e6bb291mr8352957f8f.4.1728372246814;
        Tue, 08 Oct 2024 00:24:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19? ([2a01:e0a:982:cbb0:4595:23ef:4ba2:2d19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e832fesm99893515e9.8.2024.10.08.00.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 00:24:06 -0700 (PDT)
Message-ID: <a8c4648c-0941-48f0-ab5d-c3abfc130aaa@linaro.org>
Date: Tue, 8 Oct 2024 09:24:05 +0200
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
 <20241007195825.GA2296490-robh@kernel.org>
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
In-Reply-To: <20241007195825.GA2296490-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/10/2024 21:58, Rob Herring wrote:
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
> 
> Don't need '|'.
> 
>> +  These properties are common to multiple MMC host controllers and the
>> +  possible slots or ports for multi-slot controllers.
>> +
>> +properties:
>> +  "#address-cells":
>> +    const: 1
>> +    description: |
> 
> Ditto.
> 
>> +      The cell is the slot ID if a function subnode is used.

Right, so I simply moved the yaml definition, shall I fix it in this patch,
before or after ?

Thanks,
Neil
