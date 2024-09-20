Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39A47A66
	for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820906; cv=none; b=rljJsoISpEEm3/mBFAkucYKpce9UVqqfC1l3Ti8t6nsKouXvRq+5PowohPIkF2TVXGxUWjeJ0uhQdy/v3aPZPggtMGe+SgQwJrrVykp3Y8Dr3yHJiEqBmndZYlC1hs/6s0VhXihmJlbTTHH28w78SHX1HqrpspdUBrfUV067jUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820906; c=relaxed/simple;
	bh=NScGYUd6179Tb5vwg/DqqbnXhiOkYig3H5YIrnsrsfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UQ+32JIgvaYlG8CdMa87uBbHua+fIRoFs2g49YVryUbFxMATNQhiRXcSYUUwdUmH1Ii4cujpk7p/F6oOPwCi9kkVlrLnp2l/FuEumvDYDMq+Bg0i83o+z5wyB05JOvfL152DymdgH95kSOUJiO+mJoYfXXU1LRRsrXolS0cfmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jMO+YoMY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMO+YoMY"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so15935375e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Sep 2024 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726820903; x=1727425703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSY/XwkbAFk0AHpPR2dqnekk1R5T+r9ialJRBpwsOMY=;
        b=jMO+YoMYyMqhHa2sAPGJqMw3GRTPVCUXEYGoECjdyY13PAiQB2m3M0VDT3zU/k1BYh
         PPEaeO29pWb3oB+TQEBSs+dXk2N3CT0rpMejPMC3yPjqGTgmIfZV8M2WXhH4TCB5CuY+
         2FlhCf1CjDdhSclm/MOMrhu1sUgKA/CviSiN3obUfUhcUGXt5af+FPNNr90enOTFx2fY
         QF4N3zdNfa1tSQ6Xs/yqgoydmKBlvlroxgrb9bBunXJzApc+CkKCwuSK6YBpkLYbqBwT
         2kN9EIP+oZ8R8QqMqB/MRocrtL1DPr8hHxIXStvmZYA8idJAcpfFJYzY6hH7BFAgyG5+
         CLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820903; x=1727425703;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSY/XwkbAFk0AHpPR2dqnekk1R5T+r9ialJRBpwsOMY=;
        b=hSS1ERCtAhpO7FiV+Gus2AaVBSly8bSXTYPLr6sbrigLNYn65yYxhHwlovVq45t+xf
         2DRaP6Pr/YmbsBDvRmMPFy+MwJPti6d86ON7nRFjUeY7cWFWLr9liWOXPk7g8ZXgCyCH
         jhKnCMJfNHXZoMlRd5vRJMnApSgN19Qm0RxJPQ/2rmwJbfi6xiRFH+K9vDKzheypANpn
         BUEYzpGJgqnSMJ4OdnIvSDsUzyMQleXwkn+se1rvJoqfZutOuKNajXbyu5IsMxMMItUD
         crnV6qZuwYfRvCpsrRFRiBwFa4rikxtUXNTbqsHJkqdVKHK5L4CGmmTXVAcDdDgW1z6C
         TnIg==
X-Forwarded-Encrypted: i=1; AJvYcCX0B/a73QCDP3UuErCsisUkLSchwtT246QUFF1avynNKabEp24M3Z9kf9Yks6FEYP764k/DzIpooo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dq+qjM2hKYYNlsM+8QAGfLlrDm6NzYM78fbs4Rehw/HZBn//
	/iBRzpAGk83keRWao2puDJJ0ZXADMz/2EKR0unIyO6R+ufZ4q/0VcF7x/5HGpSM=
X-Google-Smtp-Source: AGHT+IEwpW97abutw3SvbbD+fpsLM/YqBbH/+ujjWdJHEh1aCbcZ94oU53Wv3GaurPQr/FG0QEN0Gw==
X-Received: by 2002:adf:e84b:0:b0:374:cd36:8533 with SMTP id ffacd0b85a97d-37a43197db1mr1010222f8f.54.1726820903286;
        Fri, 20 Sep 2024 01:28:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f? ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7809e0fsm17044622f8f.110.2024.09.20.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 01:28:22 -0700 (PDT)
Message-ID: <e8906af4-e769-48ea-8ec4-779ca4be9b8a@linaro.org>
Date: Fri, 20 Sep 2024 10:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to
 dtschema
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
 <20240916174030.GA835203-robh@kernel.org>
 <9394d785-5954-4d44-8ad0-9b57fbecde25@linaro.org>
 <CAFBinCAbb5rh4GZZhjFA1jSGJAPNC80vnUY+PC9AdaApLZphmA@mail.gmail.com>
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
In-Reply-To: <CAFBinCAbb5rh4GZZhjFA1jSGJAPNC80vnUY+PC9AdaApLZphmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2024 18:33, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Sep 17, 2024 at 9:13 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> [...]
>>>> +      reg:
>>>> +        description:
>>>> +          the slot (or "port") ID
>>>> +        maxItems: 1
>>>
>>> Aren't there limits in the number of slots the h/w can support?
>>
>> Good question, let me check
> allowed values are: 0, 1, 2
> 
> For the remaining questions: I also don't know - so let's see what
> Rob's suggestion is going to be.

I did something, I'll post it shortly, no idea if it works

Neil

> 
> 
> Best regards,
> Martin

