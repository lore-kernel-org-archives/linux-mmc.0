Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FCB271A7C
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774529769; cv=none; b=lgCsxYmccwIlRo40HBLxDaR5e5cAMvMp/CoN2M8AsNM8+0ttdm9rJ6xQH9YkiccyVD+NX6E0JebK5Ktd2qVRyneEUK6Xkes2s+/Znc9dDD8DQTyBVEJjDashS9s1Q3fSxgQct5UyCvUTIJ3XLL/kTT8NIC0n0KvWbrJbz3wtUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774529769; c=relaxed/simple;
	bh=f5JciFCLHuQRid8O58UfBpq58kWGNO3IgcP/oZDy9Qk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MJ473gmxXmQ/cyQdXOiwKqyK4MrRg9ejeO09DnLJb6yJ6xzTWG5c0EIHTPCmFCXAvlKdkL1z2BwV+RZqOj4gMWppFWf+0fbA2A9HkxCP5ilMuSCqwa/owwmYz6RiYDcvlMw7gq9dcyMC7y3Nr2oqdoNko5KQitgQI2Z8KbZqAXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBBeooUG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBBeooUG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so7876365e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774529766; x=1775134566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx9U8ru1kAXiSx+zB+95J2U/zt+/QpX2ZNGpavJgFb0=;
        b=lBBeooUGTcVMGUmYIIsgsZSVPt+kb0NROOP2ua1CkbSAunz0UEWFqciKka5DHiJm3R
         O/uzQE+2V/GBKfZlgYTJwXLN3QEA1F/sWZ1LPsbY4SyJY0hVIcNYk5BRGmUyS5Pyrjmd
         g2yuP13BsIAJX02ezQqRVbGy0JIlywtB9n22uD4qWJCF2ENXPz8ALbzF8IepY9i1H0m2
         mIhC240MsYDabE7I9q1surjkDbVFzXNu1p2jEymBLadwWLGo6ZnF8fzQOw++HrmMxd0F
         Arl3XPWdqHHKLy1bJr8sNSQi1DU4L2taVsB2dlcifqU5w9O0DT+4noNKv2hSfwqKRR0r
         SGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774529766; x=1775134566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx9U8ru1kAXiSx+zB+95J2U/zt+/QpX2ZNGpavJgFb0=;
        b=osp7AiVAqBUOExidvaz8K02ftmz4/Ogk8FqidYy0hT+qXRxo4gbXt8TbsJacn//jW0
         nfPwZyiddP0bdAfmon1er+btrfDWlScpfEF0U6iOqjhcrcUo+xGCPrnggwv9P/iDDnVQ
         EmFfAp67J7YlpmQipx+Vz44W/C7WPMpK/O/NhGm/iy6TeaIRE6wyteA8ocDh39v+EaH1
         v25VEzKa4qt++IX27HlRPSJF933/u3qRBzLYNPoTxZB3NBx1jQM74bzO5xrn+yvlYy0c
         w4A/FKFwDzitBv8nBAjHwoWnNeSwSEP22cML3MuZOZL+eQdeXdTDcT5c3erGnU4/TA9Y
         58/g==
X-Forwarded-Encrypted: i=1; AJvYcCXnCMkSA97Agn8bBB6eT2xjpE50paUTAq0Lv6UExNfLRv58PghfJSOuUuuk1CFm1VGpb8LmKRHx8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDsVZQRtz9Zpr6C2GXgYSs0mxYpDNQOyLt0aFWndL5biDaPaL
	uUAmf/zNUa6raEjORVEZqBXWgoxsdjKudD4V0vCJjAJQt+wOlfobzrQGk0RfyMbjb0g=
X-Gm-Gg: ATEYQzwFEN6gPafjmlQ24g6wB1G+vpvWHNVg3ywh1lXrrZF1dPfZH9T407nnaD6AAZs
	RnlBsRBGOjdgs6OnuNHl86Ueu+u7f5Pxw30NUykjItL9Aq2nfh075i3KVm8b7ITTQmVBrtYBOPj
	fet6AuHaWMyAv9o3CEJVqW7CP2qqlhzRo+Tb6mO1oy2TXWcJf5X2kLwVmJv025LV49c8rKmED7O
	zf+BI7QaiSUXNQEPD+oo2FdIPJ5S6tE4DPYtQfZA9an0/Yze3LjppmBLXkn8/iKwcgpy0o/nP2Q
	JUiwqm4yLEfRV1bQYtBSBQ1fCDK/knmlIGTC6QBze/wMMT2PwXsYOWeZaPTHVNYW204tisbgTdR
	ur1AQ+/bo2m/8jgmQ6esUqriGEBLlhshJLO8jpEHHWONGEEqX0y1jYzS8/orDuyqgPasUFngIhG
	HAyZMmRK/0pN5WO2kUIzD7wYVcIeB7LFy/m6ZtGt3IZqtjadk9fsQGFJxHtbwjb5/5acDkK0myz
	rb7Sjs=
X-Received: by 2002:a05:600c:45d4:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-48715fd5277mr105962645e9.10.1774529765762;
        Thu, 26 Mar 2026 05:56:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm8088573f8f.31.2026.03.26.05.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 05:56:05 -0700 (PDT)
Message-ID: <9dcb5e67-6a30-4ca3-b324-a57faee7d767@linaro.org>
Date: Thu, 26 Mar 2026 13:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
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
 <20260326-add-emmc-t7-vim4-v5-3-d3f182b48e9d@aliel.fr>
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
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-3-d3f182b48e9d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 10:59, Ronald Claveau wrote:
> Add device tree nodes for the three MMC controllers available
> on the Amlogic T7 SoC, using amlogic,meson-axg-mmc as fallback compatible.
> All nodes are disabled by default and should be
> enabled in the board-specific DTS file.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 39 +++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 36d13371f56ba..fe1ced0a58967 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -374,6 +374,45 @@ sec_ao: ao-secure@10220 {
>   				reg = <0x0 0x10220 0x0 0x140>;
>   				amlogic,has-chip-id;
>   			};
> +
> +			sd_emmc_a: mmc@88000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x88000 0x0 0x800>;
> +				interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
> +					 <&clkc_periphs CLKID_SD_EMMC_A>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +				status = "disabled";
> +			};
> +
> +			sd_emmc_b: mmc@8a000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8a000 0x0 0x800>;
> +				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
> +					 <&clkc_periphs CLKID_SD_EMMC_B>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +				status = "disabled";
> +			};
> +
> +			sd_emmc_c: mmc@8c000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8c000 0x0 0x800>;
> +				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
> +					 <&clkc_periphs CLKID_SD_EMMC_C>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +				status = "disabled";
> +			};
>   		};
>   
>   	};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
