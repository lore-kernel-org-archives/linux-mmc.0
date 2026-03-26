Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC63B7B91
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515190; cv=none; b=rQnUjWwT1Evkv02uuHCDW3B0cb74VPqo8r3Ey2vJrebla2UdxDpKPnVc7y8xt+/V3srpT2QPzTbkS47nBQ8fIwMlBqvDN3aDBoxyWNS+SkDxVPAJUH8N4HqRsLxfuNVfOga49IDby2eqS8ojkL1e6UboAbsAYx6K4k7lB0+QfJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515190; c=relaxed/simple;
	bh=O1jN7BD1GGh6tS7iK1iKMQNeemAgg7gH0h2lUJMtyzU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UVd5bmLutXo4gDtu8PUCzQxG6QW72ypuCBVDLl8MYCVnx8TqJDXyJBdKov4Fiu6B/ojGATtMj7aCoXNWJNmou4/4EetiDbiJR8iQVb+eU+fspUmbESx7Pk6uZ8ZLS8ZI2w9SVtUYc+Y813STaOYicfmSThi5RC/CV2boy/VVZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axs6ryHJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axs6ryHJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so6613965e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515186; x=1775119986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDXG9M4VD8sbt4ubZpnvKniIhpg/LpwkxR7DgYK7GD0=;
        b=axs6ryHJXk5TQYWk7R/Kyg7ny8VkbnGVt2IMpuKP+V1GgNsSGWpN+ue/l9Nyj+51y0
         wjAb4BG/0bf+/7K9LZoKW4RX8Sd9AZKp0p/zQT/2J1RwB0v8WaChdzz6xdmDnNHB8NFb
         XflIkk+12f6sjmwKEEBieidkOqqOq0zP1SqYURMQZapvHnGBQGmoR6jRehd+bsoWuko7
         aEgVfP8DHKZIFPkkwz3C2lMfeLQkU2yGu+jXBqRumu79AlpzHTfWvHHocRu0ANszj/rC
         3EmmuDlsxwF6Ast3ADIWIF+GTMWbP+IWfSlQr27xmSSrGqUOBizGgKp62iJDdQbrrt45
         yhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515186; x=1775119986;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDXG9M4VD8sbt4ubZpnvKniIhpg/LpwkxR7DgYK7GD0=;
        b=mZyyByABSiKGPZ+a0vIrugQfGeEIr1XdFj/a3mhvuwNLZE6bJgdVv9ODrJ+f4tBkgu
         aPWVP+kieM2DY6zaE92C4rqulHL4Cfov09zEGEuP+/p2vE1VGDPPwjrdZCV3VW9CuTui
         WOXy1BML3vVBTEcbLjdlh6ILTr5ZGtB0JqzONq29xKGsiax4Z73uyONlX4Zt/zSvVFbq
         XsGzHWAr3UnX+LEeWYCt7kA6BhZiCwX3S12iZv655rNNrmBIq1GNVOqcyjCfBwzdnGZ5
         d6n9VdGInlYrTgRFuPI785nMrKuC3BzVsEnCkqrRmBvydEjZStVIupjQplP6ynmU9/Ha
         cIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXVqJIj2OEuMDKIzTq0f2n3rfTkVVyxFoDzZATtjxkN4TUvbe1o3aXgUu+N8/yRxVnXZgmAItLid8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI2wk6ADquiEqvw7/UGm8gLo/D9S6i3BImSH1tOvHAHy+KdSHL
	DJjOfkVQC6Lxmp2eya7MS55fqNFpVIdhIvj/FeX9eGZnuWg1fBexMW8fQg1TXKzIGNo=
X-Gm-Gg: ATEYQzyWZ7licOhqORdk0IE3RX1rzUhTDNjAFj9pheaTPIgzeuD47x+2l8nY6g57RXk
	CUQFS3QDx4Wkz6KIC2pC/JfxbX6EndBx5ou6G5wqjBZQsYi5h9W+8MLRNWx9oeRjYb8uNJnO7IX
	uj8L6mORPgfZXwoCYZ3VL/nKzOiI4cU8se+WPssziLvLwrs8jSRGuoW591u9DE84oG0m292jCvB
	Bjh0hFxin3CxLwZyixM7dmLJYHrtIvNpVb4Dd+92HQdgK334jzcjSGCtVNyVZ4EsLwlr9Ovql4x
	KZUKftyZlFjlpS4IEQgDWU1qGpydWzUhG7fl8ldnXCZTggFgwvf4cjJKuUBCHOAoY54Yw38uFNW
	chYVBvcFFr/WGEGB/zQHC6UED4o6R3aA3wJcNibKdsIWm22/MaY1KXcXUl1yOhaLU5aEKFJyLMp
	kwWPnT3+MpVwDqGmmnkHhC6HV3KZNYR+piZ+hXI2FzwcMCYiR8RhppGAGlV370qJENQJYZ+SyTp
	/LVWd0=
X-Received: by 2002:a05:600c:c490:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48715fc7437mr97262695e9.1.1774515185800;
        Thu, 26 Mar 2026 01:53:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e708asm5819184f8f.36.2026.03.26.01.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:53:05 -0700 (PDT)
Message-ID: <d39c0e43-8c62-4a41-895a-5384dc365c2a@linaro.org>
Date: Thu, 26 Mar 2026 09:53:04 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/9] arm64: dts: amlogic: t7: Add PWM controller nodes
To: Ronald Claveau <linux-kernel-dev@aliel.fr>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
 Nick Xie <nick@khadas.com>
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-5-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-5-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 10:15, Ronald Claveau wrote:
> Add device tree nodes for the seven PWM controllers available
> on the Amlogic T7 SoC, using amlogic,meson-s4-pwm as fallback compatible.
> All nodes are disabled by default and should be
> enabled in the board-specific DTS file.
> 
> Co-developed-by: Nick Xie <nick@khadas.com>
> Signed-off-by: Nick Xie <nick@khadas.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 63 +++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index eb09a26bcd0e0..581cdaebfe637 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -511,6 +511,69 @@ sec_ao: ao-secure@10220 {
>   				amlogic,has-chip-id;
>   			};
>   
> +			pwm_ao_ef: pwm@30000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x30000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_E>,
> +					 <&clkc_periphs CLKID_PWM_AO_F>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_gh: pwm@32000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x32000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_G>,
> +					 <&clkc_periphs CLKID_PWM_AO_H>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ab: pwm@58000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x58000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_A>,
> +					 <&clkc_periphs CLKID_PWM_B>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_cd: pwm@5a000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5a000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_C>,
> +					 <&clkc_periphs CLKID_PWM_D>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ef: pwm@5c000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5c000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_E>,
> +					 <&clkc_periphs CLKID_PWM_F>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_ab: pwm@5e000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x5e000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_A>,
> +					 <&clkc_periphs CLKID_PWM_AO_B>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
> +			pwm_ao_cd: pwm@60000 {
> +				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
> +				reg = <0x0 0x60000 0x0 0x24>;
> +				clocks = <&clkc_periphs CLKID_PWM_AO_C>,
> +					 <&clkc_periphs CLKID_PWM_AO_D>;
> +				#pwm-cells = <3>;
> +				status = "disabled";
> +			};
> +
>   			sd_emmc_a: mmc@88000 {
>   				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>   				reg = <0x0 0x88000 0x0 0x800>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
