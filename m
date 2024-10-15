Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252161C760D
	for <linux-mmc@vger.kernel.org>; Tue, 15 Oct 2024 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981294; cv=none; b=LVXkJ5IktB//aRkew5lEVRBQFeuQyhnw56HE5fkrmb5GDPBZikdcI5RBmX71otmveKBi35cwWCNa9QAGhEJiSldkaqiTuLn8cb2/IP5Anv6p1B32wxmHq/0yQBUTjCWt85cygsbW8B4iwcClfzpwzeAXxi+YQil6ZhzYzexMZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981294; c=relaxed/simple;
	bh=vfA3cFKeX79RXE2IbVW0LNxACXUY0WHdztmLtARPTk8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R1z4yq++F7kymsA+gUcJVxU8pp8TIU9yql+V/p/Aycx1JhyK9gRYW6uN59P2rynLkwS3LgiZlrtiYDoC6+HgtzaW2KZsBNV0jAJIB3H1NC3Zn8On3k6XpiM7ojhGhXoXQ2B4h0thFrump8KIlG/vQCWFdFY5j6FZ2PbF/mHPnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Srp4aN+o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Srp4aN+o"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d5038c653so3157443f8f.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Oct 2024 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728981289; x=1729586089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUF7jv5c/y05IM3ShRlS4OQ3zoxaQbhTTM2rs8WpeVc=;
        b=Srp4aN+oZIBIA+ASBPx9u3mfD34SW+lW7+sOnJoBdaRruEemkZxCqly7vT76S1CEmk
         BqJV0OJVTEY3w5v9QRiR+dzwd/1QI66Qd+BJ3SVPo7g3yUIMp7LAG+7qZdn7mdz3k8PI
         TCNy+fqQVZx5k8jW5h/VyRLu6Rel8/6UlLLGqIyssGpMFCZYNrN+tfppmyiK0QD5U71f
         WHDSyT5R6QnztTjzf6BE9mMFH68ni0GWnIi+hfZP6HcQ26rcrWu+ORO4f/vzKR2ZI7yX
         P35OK2+vue/GWMGCQgXn9gZN+nxd2dn4vTIhAxzhGsxE84bf5VJeei2E2I0QcqBzrYCs
         2tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981289; x=1729586089;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oUF7jv5c/y05IM3ShRlS4OQ3zoxaQbhTTM2rs8WpeVc=;
        b=Gd8IoH3ugkTbvhR3cRuldzI7dpgs3m/LIgNBfsJb7UmG3opCKPFyG9rZNOQP9HU6WE
         9sm4VEJtxU2DI/5oDTdFCy69lNG5Lo8fF0vg7HCJI5YPHHZGpHdkz0zLZGTOEMN+KzXT
         SReOeh+7oboCPeck7UHqabANDweH+OTxOytQkh/d6fj0Jfyai18uaTvA/3XnJkfbF4Ru
         gMqfw/91lxNgTChXRBrlCv4q3FF/ogVz3vQdKZawDUN+LBLGf3XwNKdq8mZZrRzrk2A4
         X5JeFdL5FSyrFioEiTtqpyXHZ1NGDX/heRtFyJajiHteWkKePPpTxdLaql/hjPFXKerI
         E2gg==
X-Forwarded-Encrypted: i=1; AJvYcCUNlVhz0JQzntgS4uBLnp7Pa0a4Hhi67SS0wNqnLljdOOkw60qAHQ6ibcnVDv2EjQD5s84nx2/x0dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtG0TouNpdestU5fuU5j1IvvMnfr8PaVweDaVQRDgTV4OUcWM
	CcsHzwCm4MHv69zSzdLlR7kf6OF629O7a3BYLSG95SklTLZXWTVPaivNBj5Dbww=
X-Google-Smtp-Source: AGHT+IEE9Bf4HgHbwmOabZF6YFKnn15l5Ozto9RbXwA5IBzSiR97gav6hVgamHDCguQUrt9TO/528Q==
X-Received: by 2002:a5d:43c6:0:b0:37c:cf73:4bf7 with SMTP id ffacd0b85a97d-37d551fca59mr9456233f8f.34.1728981289440;
        Tue, 15 Oct 2024 01:34:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e686:73e1:36a8:3467? ([2a01:e0a:982:cbb0:e686:73e1:36a8:3467])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a06dsm974468f8f.5.2024.10.15.01.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:34:48 -0700 (PDT)
Message-ID: <43bb5d15-b045-4621-8795-15e7522bc884@linaro.org>
Date: Tue, 15 Oct 2024 10:34:47 +0200
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

Hi Rob,

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

I don't understand, the comment is still valid, MMC slots can have function subnodes
aswell, perhaps the "slot ID" is confusing here ? here it stands for the MMC protocol
slot ID, not the physical slot of the multi-slot MMC controller.

Neil
