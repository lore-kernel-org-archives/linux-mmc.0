Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5C298CAF
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529626; cv=none; b=QildlcVr9aN/ySgnn2COElQSRUHa+k8GSpVtJu94GF2NeTOLHV1347RHrs2zaZdEq289u3XWZjandwQ0boa9EC1mAsnH1vxmqKARDX+o2QskARBsreCSaH3Bdoh/6sauL0GigkaighRZN108fqkR3K+8hhkqjfEAFybQLZ2JIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529626; c=relaxed/simple;
	bh=K7REFKxf3ZmDqskE93hAofwp3IRmFswPn4QHXZyGQOE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ocziuozBzUSf6nhUk9Y3fQ89A/i50kDGEaU42XGRbmIvyALAM3eVZjoFkYp86ACr0+G5FfVNAnGCf0WSxuJYiRGfQJhggzjWIfYGg4PdMn40ngzPpHspqIkwG5CARhTyhrdRnQpykDvjMUD4n7xVXgoVlKdrNURF1rAFjtYk/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFnTq4zk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFnTq4zk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so9540585e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774529622; x=1775134422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovqx3H1R8dcVYTy4TlcGAentVJA1WLMQBInCAVMEjmQ=;
        b=iFnTq4zkWf9yJQmTvAUCTngWJhxf3Bsoyux1cR8XZGbFgyYid2pZUwkw2oOyXH3Whg
         4oUPkc0xK2/s8Tq+porYrScGaSVIte2b6P5hEG2Ekkb9DFkcydBlRqs/z6VKkwJZBxwn
         rykgA7cPuIHt6WTwxrV4Y9pSyVBqQYbGdHaBlWjsNKYe4m/o1XiO2WxHMUVKxJVIyxcd
         bwwZeKIBNscYTd4D2cbJRKok+tZUI5NBEx2FbD4Bqc1H8/WMHkDzPegeF5gNDlCj57DB
         FGpy6RUMY53GgMIhuU+NzLmqo/63Jgm6tWdWhcU2y1CKtM7DHOYLnzUO8GeeW8rQSLmF
         W7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529622; x=1775134422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovqx3H1R8dcVYTy4TlcGAentVJA1WLMQBInCAVMEjmQ=;
        b=Oq6f/YrRFspg1ATeVEBlIYVQeryNBa6NdRxY4Fbk5Dk/1T6oGGMHDvI1Q1VW4p+TXp
         1hOAEt21grwBhuWC9FXAU6ya+M3J1b91HCSewD7ZD2NgfPkvdsbmYXkCvoyzxz2XkY9O
         1rb7EBnzK/uCqCdJ0EUIHTmNk1JyyeZirLlkkmU0qbWV9r/yRl2CWq6yGDFKvxoYlqUx
         Kqi9+EKJlGn44iFHe71SkKgkw4DHuJWmNisdEusuAjBTxdMf89OXc/0iu39zkULNvdYP
         ZH6JguKOO5lzxlca7xauobXJnlOJPtrbEdLjB5qpKiNr0QxwqE0pVkQ+aBKnT+omOP+B
         rAVw==
X-Forwarded-Encrypted: i=1; AJvYcCVH4JGi7icNFCKIVqBOiPi8PCLYs2Ne+UF1uVHUGvOIf5w2CeuYZfWIp0WU6PqN68VT/Vvn74K1Q8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw1noOF7ViMVYH4vcuX1CXMsXAqk20G1Tdir9IarVI4ko8M0X
	43QkdWTqpiyPU8Pti+pCsYcIGzor/9OChGhhtayjyl3KZ/gRv27dfeaEz8ckXY3VnZM=
X-Gm-Gg: ATEYQzw5uQLaexxRSzUaPf0RogWpFfCDigKrDb4MEzTGS0FITipkznIqsPvWf/ziSf+
	RtlwV9swB4CYhTL4s70Ux63jrKb852seTv8tJDUUnp4MgMCoAQgdHIgxxpK0DsrjJ5dfZI7z3x3
	Rwae7/XbzrQjrtpqVbSgCFK5QbAw5gAkBDwuTHag8ozLIm0j0vJenkmE3g2bYaVh294XJfgQ2ev
	5qjrs4L5xdP94rp/UDN8KyK5dVsnyxQfV+bND9VqkDw9WmZVj1gW/DfPuKWkkB6zJdeTmid6W/w
	vlf0NQzHupTEyP5RvB4DODa397kHN1o6Q60QKreA1NsdkM+zFI2J656JrLuu1rXYDz/7rdu+TG2
	ZdFuSEwU8MI5LbO477mnHg227GcrisTj6jAs+SjXNrevlTE6KRpLXBBKsuWTHQemKPliq9IV6pM
	7rBXzBbUANkiS1oFExFJA9hXWIoXs61V4BxJ4s/WeVIqtRQMgiJmlbbw+zp5bOgITXgPS5pLguL
	VfXLoM=
X-Received: by 2002:a05:600c:3b16:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-48715fc3a88mr110847475e9.7.1774529621762;
        Thu, 26 Mar 2026 05:53:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65dc4sm30763025e9.3.2026.03.26.05.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:53:41 -0700 (PDT)
Message-ID: <c03db144-539e-4c39-94f8-14b112783077@linaro.org>
Date: Thu, 26 Mar 2026 13:53:40 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 1/9] arm64: dts: amlogic: t7: Add eMMC, SD card and
 SDIO pinctrl nodes
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-1-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-1-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 10:59, Ronald Claveau wrote:
> These pinctrl nodes are required by the eMMC, SD card and SDIO drivers
> to configure pin muxing at runtime.
> 
> - eMMC: control, 4-bit/8-bit data, data strobe and clock gate pins
> - SD card: data, clock, command and clock gate pins
> - SDIO: data, clock, command and clock gate pins
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 98 +++++++++++++++++++++++++++++
>   1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 6510068bcff92..36d13371f56ba 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -250,6 +250,104 @@ gpio: bank@4000 {
>   					#gpio-cells = <2>;
>   					gpio-ranges = <&periphs_pinctrl 0 0 157>;
>   				};
> +
> +				emmc_ctrl_pins: emmc-ctrl {
> +					mux-0 {
> +						groups = "emmc_cmd";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +
> +					mux-1 {
> +						groups = "emmc_clk";
> +						function = "emmc";
> +						bias-disable;
> +					};
> +				};
> +
> +				emmc_data_4b_pins: emmc-data-4b {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				emmc_data_8b_pins: emmc-data-8b {
> +					mux {
> +						groups = "emmc_nand_d0",
> +							 "emmc_nand_d1",
> +							 "emmc_nand_d2",
> +							 "emmc_nand_d3",
> +							 "emmc_nand_d4",
> +							 "emmc_nand_d5",
> +							 "emmc_nand_d6",
> +							 "emmc_nand_d7";
> +						function = "emmc";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				emmc_ds_pins: emmc-ds {
> +					mux {
> +						groups = "emmc_nand_ds";
> +						function = "emmc";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				emmc_clk_gate_pins: emmc-clk-gate {
> +					mux {
> +						groups = "GPIOB_8";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				sdcard_pins: sdcard {
> +					mux {
> +						groups = "sdcard_d0",
> +							 "sdcard_d1",
> +							 "sdcard_d2",
> +							 "sdcard_d3",
> +							 "sdcard_clk",
> +							 "sdcard_cmd";
> +						function = "sdcard";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				sdcard_clk_gate_pins: sdcard-clk-gate {
> +					mux {
> +						groups = "GPIOC_4";
> +						function = "gpio_periphs";
> +						bias-pull-down;
> +					};
> +				};
> +
> +				sdio_pins: sdio {
> +					mux {
> +						groups = "sdio_d0",
> +							 "sdio_d1",
> +							 "sdio_d2",
> +							 "sdio_d3",
> +							 "sdio_clk",
> +							 "sdio_cmd";
> +						function = "sdio";
> +						bias-pull-up;
> +					};
> +				};
> +
> +				sdio_clk_gate_pins: sdio-clk-gate {
> +					mux {
> +						groups = "GPIOX_4";
> +						function = "gpio_periphs";
> +						bias-pull-up;
> +					};
> +				};
>   			};
>   
>   			gpio_intc: interrupt-controller@4080 {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
