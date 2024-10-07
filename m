Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280EF18CBF4
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292073; cv=none; b=Eyqi6VGRK6E6OyoavlRRlEaFiFygprnCLTR8VmyxuN0SL82y+byGZpAx4Cks/I2sZZa0lAvqX0+gE8CDOPZ5/dzfOFZswHpozzJu2RX02LxRJHSTP+BSEBDJWKMdS0oXcCMmAgjFLt5tPssYF076fmustAUvDFPEOFeog4io7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292073; c=relaxed/simple;
	bh=Tvcs9sYQHOdju1uSjxDitPtHC+c46V2B5i6PDIRp4y4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jL4yc/q4v5YW4yciwH8ZIqOWlFB8eCO24gCKKtlAIzpDDvmPKOmjojO3IjnGKQDfa6W4zSywqBJ7JuwUCvQpmrN21UQ7DEZoa2sWS5CduiayEbxuQ8joe46zW4vql2MnLTdUqF4cMhQFnBXFnKoG4NaM0dWoRGwStwj54xW7IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2nEE+6p; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2nEE+6p"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539973829e7so4030785e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728292070; x=1728896870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpuhbLasEadVeMuVqG8sosX+rym3WCHEJ89sUQ5d+fI=;
        b=T2nEE+6pBaCWlzhY1sTtPznE2JDmTOx/HJR8muZGUYMu478SxjPLILAoFNoGaKxGhQ
         28fJsVe6V0ZUiTVZB8YlltDd/MTQ+TA/ALyvmj3qFLDbXI/Ozfkb+o+5jGElygednl/A
         W7Q5bSlZ47LHoZ+IcN1zCO2csrWmfm8nP1/5H0dAoNdXXWMjDSt1nY+V8gAOhQKIGWvS
         RcX/wgDxTUL3c9BM7/U8YzT78FHeG4zowIwYinHVIraRzIgxsor0nVnR3C8r6IE/roMY
         gcEX3RAO7LeZ7VLj5cSqU91q5uoxvubZKD8T5vUg6fSd1HX9olAnR5Hy+wsibn1WkSnj
         vANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728292070; x=1728896870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EpuhbLasEadVeMuVqG8sosX+rym3WCHEJ89sUQ5d+fI=;
        b=LXBPIGGjbPwDDlqRyYzR91gR5wJzGZSWDXl3/0xB1UjRinKcH0XKFj57EHehEY4NSC
         VPYMag0c0WVD0exWfOQiwMdAOYvnbtQyBZ5wyAWdqFNMX2R2oxpDenx0fq3lg9B8KFdt
         O9rqfXZQmj5TuxPm5Tiq++wWfR1oMj2H9Qo2XzssDwt7WB6k5EWkpBm6PY7jdn4NJpZb
         8gdIg+CdNh7HMCX8Ex2+fGAGtISCAC3ke1hoMIOLqtgCH5i11uOc9YPgFPY/Q3lN0B2U
         m2jplmMPPg9QEdurNeb93KcfsNg1tA61GUP+2Py5n/K57e6GznpWCfVX/kQho0qQtt6s
         Ue9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQPUOs7fIOGMc1FuWJRyqhD5D7XSBPDub7SGH120SW5tNTqMKq6zwD3q+ma+W1y7G6YLq6/6NP+90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj7jlMJDlm/MyNcvbLHT8VqqhABhstc52eAJgDGh9dxJSmx3G
	Wu7jNUl9NgLW+Gqz39ZfxZcyUIl95U+4/LgTVI3s3IxPjiGMzvAlq/W95t1BmMyh0CugQO1b3yM
	V8yE=
X-Google-Smtp-Source: AGHT+IHjPdkrn1WCWqVQPWn/3AXhMdcCGbb+rmueJ3DkfERdPUW77sBkwqH9tc7v+VJ0Q+jVuYVwxg==
X-Received: by 2002:a5d:4eca:0:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-37d0e8de221mr6087900f8f.48.1728291609655;
        Mon, 07 Oct 2024 02:00:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7? ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a4eesm5210437f8f.31.2024.10.07.02.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 02:00:08 -0700 (PDT)
Message-ID: <818f287d-4ea5-4899-b4a9-98accc1be049@linaro.org>
Date: Mon, 7 Oct 2024 11:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: controller: allow node name to
 be named slot@*
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-1-5aa8bdfe01af@linaro.org>
 <qt3ivwsa3uaidcgkzbd2ewohbyd6zbzseraihftdhxpziuhnpq@xsne3f4wdfua>
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
In-Reply-To: <qt3ivwsa3uaidcgkzbd2ewohbyd6zbzseraihftdhxpziuhnpq@xsne3f4wdfua>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob, Krzysztof,


On 24/09/2024 11:12, Krzysztof Kozlowski wrote:
> On Fri, Sep 20, 2024 at 10:38:03AM +0200, Neil Armstrong wrote:
>> In preparation of supporting the mmc-slot subnode, allow
>> the nodename to be either mmc@ or mmc-slot@
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> index 58ae298cd2fc..f797c32ea688 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> @@ -20,7 +20,9 @@ description: |
>>   
>>   properties:
>>     $nodename:
>> -    pattern: "^mmc(@.*)?$"
>> +    oneOf:
>> +      - pattern: "^mmc(@.*)?$"
>> +      - pattern: "^slot(@.*)?$"
> 
> I don't think mmc-slot is allowed by this.
> 
> This should be squashed with mmc-slot child patch. It does not make
> sense to allow mmc-slots if there are no mmc-slots.

Right, I don't like this oneOf/pattern, slot@(@.*)? should really only be for slots,
by I do not see how this can be achieved because we can't override properties: pattern.

Do you have any suggestions ?

Neil

> 
> Best regards,
> Krzysztof
> 

