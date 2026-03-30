Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66E3A8747
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857333; cv=none; b=s+gGBYfHxyrz2ICLlD8WbydlDUv/A07/afQjdYWEpxT7GMMhj7Iy0oUNeMcmNoJ4Bl4vCzt0ftDDfvNWviAvb3ENhqqnnYTP+pBkknwiqds+/l7h0/qgGo/6G9E1BClO9zZW+i4EwFMj6fVgP7XBGCz+oG/AXejVyezw2lhlqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857333; c=relaxed/simple;
	bh=MPDWBPm36fsWmva00EjlRjN2FTdNLYptQaxhTf+7Fg8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=luj0ywW5rZLfWwU1IfrL44Iinz/ZlUpEdmdhbcslDs7rYISr2gTr9cLeaY6qSL+mwiOhascXc868c38gSA6OY03EszPjoiPJ9NW81mr7AHs6ObFkE1nORiRTbB/GBXjgxkCusj/mPR1G2MQMRVUb0aCtHeSiZGlt5WeQJ+HxfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7D0YxSi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7D0YxSi"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso41267475e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774857330; x=1775462130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUItjZv34EZ10kX4LACTE3wjNz+JATlDo11i94BXg48=;
        b=D7D0YxSio7A4uSaBe30ZDn2zK9/eMSYJn+lo+a1N32wH0m0Tc3AG0xavE23lwL+sXo
         SktKSKq6PdxQz8dnJ2QZG7e9b4uZaMTvDtgk4dLzW3aJeHsWd7wVtEzKlyvHhOY8Alrc
         TZgJksYCX50uVaJ34GzXmi8+VHo+o9m8EI4hu/tD6ctmvsgpPCMo1JkHoZlhcYaC0WNO
         eWmHojJd8TMP+3+5+32WAMSHxHs1Ew3oLFdbaHg2Pz0vXxdgCv/j07oU08V9x+m9WbQh
         JSc7myNEoq3kPyKfp+TCGs49uNJYLYPPyHIANwryONs+d9RGqq+zKYMijnFWlgb1vPgH
         wx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857330; x=1775462130;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUItjZv34EZ10kX4LACTE3wjNz+JATlDo11i94BXg48=;
        b=Li+6rMrzzt9s7Zf2LsD4MmNtMHapXMfpbpE72S4bRjppTspfzkcnt8Ht3cxoHW5VZc
         z2pXqIUh+5mHzQrjBAAztDQtNOHT8EF9fYqxS+O03k3/nNNcwCfPxczTIDXzWdAoFmOr
         9saUUFcg9/W+Xt5tN6Lg8MMvmbQokCxtKz36KiO4jz6UOj/2ljYmxPXukBD/CQ3yIiy0
         9ImfTti02uHD+9AI+SUkZwU9jQgoSpT3DRC9CAzndv3hw8de+z5wAwrFW877CNVw2Pty
         P1CFlBmx7warMeBgr90MMYcamTMTMYCngrig4Ll9g1eOrFK7acamJmqMomMnYk63RX6G
         Igjw==
X-Forwarded-Encrypted: i=1; AJvYcCXxFdgMxoFOEll+sJXn5hQm7XKnxiqh5efU+5VXJjxFms5O+I+capNJHSIkm2OFMkHmgo9f7FXvJXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBokLK+QvxAN9TXdDT7Ar0Wv/29FZeiu3YoaB/AE9t1EmG3zE
	WhJkzuO11iKdolfmvlzH2x/9rghpBrPYIdgXaoALYmxRAIQFFnnbI7kUlSG4FOheoH4=
X-Gm-Gg: ATEYQzyMRPW+atDEcf+52j7ZZDN5eKTZgk0SFRJicJVdABVJY+2rZp9418Jtd48fYks
	lCF7vWCgp4pBU9vpTy/fqdyghNtnUtsfMHtWxje/pRXF4C5llTUHoWv8kChNP4CaVj87TqBgiUu
	ORJtI2nzGz1oVg+k5K7+4yYpQIBhY/abfGz1DFIBHunCspD1eiPE6HkQVzEV3U48acKpsq5/dpd
	4NrRvklx5PAcUGy7sZ/YXcumvt7+E4t73bZhUtOHObOmP7DLZL+cDFf3Hh8XcZODTZdN0MVeekU
	ydThfSO5SRvjlpvvb5LPok35eEkaGBPggXiJg7Z1Mj4oXmugEZseNocAlD/uFV4fEJkJl3uZLId
	7Np7SDr6XQHdpH3d32o7qRpVzpUIyjZ/Zz22nddug3I5NxzAp52Ql97F4fh7P2IhvTgjzNHr8FO
	EDkXw9mg/hyTDWO8eRDZubTkKY4vcHYm+X59akRKWiwJw2F3zIUp/uaa09NdrD9w2GACFobMO6/
	aZ5uTk=
X-Received: by 2002:a05:600c:4f91:b0:485:3f30:6250 with SMTP id 5b1f17b1804b1-48727eda62emr178938295e9.20.1774857330208;
        Mon, 30 Mar 2026 00:55:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0? ([2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48735faac9dsm60393575e9.0.2026.03.30.00.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 00:55:29 -0700 (PDT)
Message-ID: <416d42a6-8d99-421c-91aa-e705f23576e2@linaro.org>
Date: Mon, 30 Mar 2026 09:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 6/9] arm64: dts: amlogic: t7: khadas-vim4: Add power
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
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr>
 <20260326-add-emmc-t7-vim4-v5-6-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-6-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 10:59, Ronald Claveau wrote:
> Add voltage regulator nodes describing the VIM4 power tree,
> required by peripheral nodes such as the SD card controller.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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

This properly is invalid, please send follow up patch removing this,

Thanks,
Neil

<snip>
