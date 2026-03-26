Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93D351C32
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515167; cv=none; b=CPlO+j1VaDE6pbLrvJ5sscF9GYFmtwJUIiIctmocb23zBXQlcQbbeF2dgAWpSeLDHPPLpZI7xeROrRYSoow+MmLE5bHnm/yODXzwN4QAV2JdkEYoXYyc66x2383eoWQiAfcLL9GisyoXuuT3Ozcm1OYDu0zR0409eg587a9SQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515167; c=relaxed/simple;
	bh=mR3j7kj7vROwQ5ag8Pn7MdYIgcgh1ubte3V78Ak4zlc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YQXzOvmzjnP1JFV2Ys8Jnw1Xap2n1SZ/sFlmVqCJq9cX1q1x1aTd7KpD6E9wgCrM8e/5DekHHdRZVgtPzBg6zrs3wueojiDvyIS2XgHEhBZFAiUYzq7oC3EgytZ6oLpN/1S4mOI9TNxZqa1sXA6bp2G/6ptGAoHOQ+HtP9JZs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8aoUrOv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8aoUrOv"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1333846f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774515164; x=1775119964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmPvkIy3tf1J6J+2oDH92ejHRFaN+YHsg5wdlsi6hv4=;
        b=o8aoUrOvy7H1Zpb/oLeuPGFh86XcySAajaA70S3i8O7JWQVtQwyviaXTrf0OgggFlA
         DgatDn4/e7wL/JXUZbEKULev0QX5WCJi2XOjoFPzhEPwsFJvyIHaLBXzIcdcSiOZxwpQ
         QWOByI0zjQilZyxS/5o0oL91VItMALz9w1rYyNZnEUurPrBoUDezXBH6M2UQ/MEvVBK5
         h+MIkRptd3cfuqIfTeK6V/Mj3JfXAC2PgVdrH1fyPPNB7jLldtbG4Uz8cSQRqdV+s9T4
         FSCoMqgUTK7myv58P4+pcMAChx7XMLOsp4TyH9T1jgxbbfS3ob68KFgp2XloRQnLva0Y
         hQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515164; x=1775119964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmPvkIy3tf1J6J+2oDH92ejHRFaN+YHsg5wdlsi6hv4=;
        b=bWJO2J0tL7ybYchyAviXWPmmxZbvaEqM6EEXi8onDVUlPpmpMfRv+hXIbLH6sT3gMu
         4CllpLegjWJertTK/f/zbdNkBY3RviQdYqryDxiU0Pr/r5Ls8sBXjD81XtSR1pDDNUH0
         Ha+Za0u5WgSY1tY2CwSUxwqeFnRM07dM6787LTmNrpxqMHPIyQg2Lm5pD05YAg8fA/oS
         2QpWALSS8Rr1HImVXq3hz4XPK9WzmA4UTsiZIj6C3L4UMoR0t06GaZmaYwJaHsXvXajB
         LFgD+UsRYr8dXxcpybo9ZsNxVOOxCPIFt3sNldsx7oJCStfu5N72dk3+44HDEo5VxoJx
         2ewA==
X-Forwarded-Encrypted: i=1; AJvYcCUIw391sjJOZeR+2k+Wo9zjjYaiuz238ksU3gEzygfvFfCkEgbeIGZNBbDQMbXij5NBdtwNiqNuKyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQCqLVC3lpCoVnGLOnZR54u1V4zhmCdVO7VGmL17OjBbbBYke
	iWc/BcOEqYSBs3qZGhkSHoThHiVXINr0ZCpPjK0vzi836/WuspcfTHMlk0QuX9n2Las=
X-Gm-Gg: ATEYQzyPY0Jz688ymSPbgTltM2rSDE1MW6UJl/siJ9JcTkWAWCfv1ygvVHqNe3x1c9t
	TOwKZtFG9Ro+d8xAQ6XnvECOTM5UZ1d9JHF8xfaWQIiQ2zoNPrY/2qGvYEo8alGJ3GROew/bAi1
	Kp6apHMM/SalVao7N1a413ZSq8PDOqahgUE3Pn7Nw5q/R+fI6znO2qa9b/PPQ07Tltkgv7fs1FY
	ImrcGRBIQjHcd4W5xidlDXSArjCdHXTtv1/CrAx2WS4k6wGPfZHANWfQORryDt75uvl2bpEtokT
	jybRjMRBIFoPQISlDUGn66a2zhb113CqIhmToJAUcr43KRa9n9XaEuaWM2V2vVSH9ttNbp0fFcY
	UiDGXghFaEFcV72dVD0wLXQG55trXnDQNRrPG6Lbn+OmWBkKf0tguAXc51m/XYTWfSjZipv6XGD
	4ZX4w9XqnhYvmReJo8jrE01bJgIM3uKaXquGb5BaDvMVl5fwJ6Sgu8gG8ly+zVmYTfBxpv1nGyA
	FYPHaU=
X-Received: by 2002:a05:600c:4e93:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48722bd529fmr12331585e9.10.1774515164267;
        Thu, 26 Mar 2026 01:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:8431:f88b:714d:f78d? ([2a01:e0a:106d:1080:8431:f88b:714d:f78d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d236a9sm36907265e9.11.2026.03.26.01.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:52:43 -0700 (PDT)
Message-ID: <4b2ba22d-7d0b-4c71-ad83-46d198718fec@linaro.org>
Date: Thu, 26 Mar 2026 09:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/9] arm64: dts: amlogic: t7: Add MMC controller nodes
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
 <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
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
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-3-44c7b4a5e459@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 10:15, Ronald Claveau wrote:
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
> index 016b5429c8d1b..62c87d0ef7065 100644
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
> +				status = "disabled";

move disabled at the end of the properties

> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_A>,
> +					 <&clkc_periphs CLKID_SD_EMMC_A>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_A_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
> +
> +			sd_emmc_b: mmc@8a000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8a000 0x0 0x800>;
> +				interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
Ditto

> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_B>,
> +					 <&clkc_periphs CLKID_SD_EMMC_B>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_B_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
> +
> +			sd_emmc_c: mmc@8c000 {
> +				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
> +				reg = <0x0 0x8c000 0x0 0x800>;
> +				interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
Ditto
> +				clocks = <&clkc_periphs CLKID_SYS_SD_EMMC_C>,
> +					 <&clkc_periphs CLKID_SD_EMMC_C>,
> +					 <&scmi_clk CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				assigned-clocks = <&clkc_periphs CLKID_SD_EMMC_C_SEL>;
> +				assigned-clock-parents = <&xtal>;
> +			};
>   		};
>   
>   	};
> 

