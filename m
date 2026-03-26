Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A734C140
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515212; cv=none; b=WBz/xuUr0cOxyEoRAU6YZhqIolJasfMGcoTi9xv++zOblmHyBUNKa1f3w0GJeKXuGAjp020niufL1f2Y90VifP5Lhg+kt3DvG6R4+guyxWKiHmB9nXadGFCcTYdBCbxGkfqAlKtGADbNs4XAGx5Q1FF3JwxNG+xiWGyQdOh3NX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515212; c=relaxed/simple;
	bh=B/doHcMx8ilgyWReYhj/P7ozTG2VrbfB8uWLrQf7sIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KdMOIV/D6M5nubATNDoWIen65VQxt6MvQaO+jICZe4dY0mjtFDXyHxFceAXzb3c70GEDeJ88VYVLyO3Xo8UzdjvcXexhJxEs0KcfuDQ5b+1uP5skZC+c6tuG4BZ+HkITDAdmhB4Ofjv1oygGilY1mooIejUKBfKDZ95BKNSHqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OcVqGIC6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcVqGIC6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so6841415e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515208; x=1775120008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0QdGIGJmrLd5pDRPLgO89nIX7dVoELnsj1kn655mmo=;
        b=OcVqGIC6bY7evf15cXY/EhBJrUMqzjWFSbnKOU9WueKiPtYzPDKITGe6Yqw3FpmE1A
         4EW+N6RDPGqIvC0hyhYish4jAHQSnF2CI8bFOJNL7LB+QPddwi2zuXFcBWKgc7WGvo9a
         KHplIYGog8bmAOtnOQwJIUojeQPeZ84W2B2nHQzBKFM1+cbdVe9Lf3qKrZj+b1CUmWlB
         bYk2aewhT5Q3GIlXCKVddw11y7JRaZZ5ztJjKTHg9oR94+bnc6tZ5EPDJhwO/5VelQOV
         AkdGbi4HmByegV19XCkZWVkajYoGAg+nZMokV7RNWXUaO0hXu83bfL0Xaqq0+mZ0d0d4
         DchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515208; x=1775120008;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0QdGIGJmrLd5pDRPLgO89nIX7dVoELnsj1kn655mmo=;
        b=J/NY11Nkvr0Is5/npnaFLdj6FtINda1SY8GBifu8G1ueIgMVcBzwlVss16cZ3jzIZK
         ObIuH+Ap1GOF7YrbgBT6NmEgZfw2T8LmXt3hMcP1SaozImK2odnW2NBiz1A0y/KgVe/F
         6vqDGK0ZEawrxzHxcodBu+OC4lHvucPDV6Yh7wVjhSngnYC5MM0/cCnQZzhN1E2SOA2R
         LX3hj71RoQ2WX9Dsj98povK9G2/aColSe+x8V+Q9eBH0deiS2nO4GdyzAgHlyrFFfFVS
         K/nQJybS18fWO6+o/I0tQSmJmGKePTSC0bdAvh6DnjYvyhlGxYFfWm7/Sedo9FZcju4I
         /dGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXId6bs+v056iyq5uU8DlNkcvVFIeAvK66wAcqg4WqpHKRz5MJYYrszTmXo5DiwtHVdesbpnsxXts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyarPVHvhq6Bi1dgT4GJG4Jti8WLMowevPqPwwt2yU3XkLgLDpE
	rKDt4ziHO1SWHFw71yc/5XdKwTC4CTN5MVchft/D2BshNJUszPX3Kmo/M3OIpcefN4w=
X-Gm-Gg: ATEYQzya5hgnv/nx8YfYuQBJ18gBdmvVYJ3+DQB/vf5t3jtswVrh5lky6+ljKMTN0O2
	7vOOa0x5Luo6+xj/4G+Bhbh/pqk7ihBAptJ2VXJskef1Zl81X5lwRXhUmRe3IFfzqzwMXqkjFVQ
	X/qqEoz+nlzlByJB69pC55i6jihSl1BiRBpgtTdOPZ4/C0SAjMDAqYKzggpbzItAvwZ1hVDnlES
	awfA4Qbzl3VTOeYoHTcdZAaVa5v4Z3LHJ2jq4ztiDKXAadbGKFPnjAbUaw2/2pOEfCJLbR53dyk
	LimORMQFcg5Qkwr3A1qevPnKyx9C3HW2CuwQ0Pskv1YDS4aKCYJVDV6np9xHQsTwC5BQebIuOAu
	KvzBFgP6MveN6tWOljLk9UMscqi40qeiAhT1Sc4GbQSSw+HKzd2LbnrHXe6FwqDxcr6/BRvIgdA
	PT5dwYjz0YITHfQcZgL6oKHND+8X29/YU01Bl2Tnj3N0bCNJbDDLWTUdMz4AGhfa1yed7FvJn1d
	GSNYJc=
X-Received: by 2002:a05:600c:4705:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-48716083231mr103005895e9.28.1774515208194;
        Thu, 26 Mar 2026 01:53:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65989sm29792335e9.2.2026.03.26.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:53:27 -0700 (PDT)
Message-ID: <3780aa8e-5082-4494-aa9e-ca84544bbdb2@linaro.org>
Date: Thu, 26 Mar 2026 09:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/9] arm64: dts: amlogic: t7: khadas-vim4: Add power
 regulators
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-6-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-6-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 10:15, Ronald Claveau wrote:
> Add voltage regulator nodes describing the VIM4 power tree,
> required by peripheral nodes such as the SD card controller.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 90 ++++++++++++++++++++++
>   1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> index fffdab96b12eb..2450084d37642 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
> @@ -6,6 +6,8 @@
>   /dts-v1/;
>   
>   #include "amlogic-t7.dtsi"
> +#include <dt-bindings/gpio/amlogic,t7-periphs-pinctrl.h>
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "Khadas vim4";
> @@ -45,6 +47,94 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	dc_in: regulator-dc-in {
> +		compatible = "regulator-fixed";
> +		regulator-name = "DC_IN";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	sd_3v3: regulator-sdcard-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "SD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		gpio = <&gpio GPIOD_11 GPIO_ACTIVE_LOW>;
> +		regulator-boot-on;
> +		enable-active-low;
> +		regulator-always-on;
> +	};
> +
> +	vcc5v: regulator-vcc-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_in>;
> +
> +		gpio = <&gpio GPIOH_4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vcc5v0_usb: regulator-vcc-usb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC5V0_USB";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc5v>;
> +
> +		gpio = <&gpio GPIOY_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vddao_1v8: regulator-vddao-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddao_3v3: regulator-vddao-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&dc_in>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_1v8: regulator-vddio-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vddio_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_3v3: regulator-vddio-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddao_3v3>;
> +		regulator-always-on;
> +	};
> +
> +	vddio_c: regulator-gpio-c {
> +		compatible = "regulator-gpio";
> +		regulator-name = "VDDIO_C";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vddio_3v3>;
> +		gpios = <&gpio GPIOD_9 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 1
> +			  3300000 0>;
> +	};
>   };
>   
>   &uart_a {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
