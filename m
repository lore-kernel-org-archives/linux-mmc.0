Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F901B6CF1;
	Thu,  2 Jan 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853409; cv=none; b=d48B5fQiVe22Pom+raBH3uIjCMXwljPuPn4BrAPPXV7Lhh8qG1KkXPokYlCBpLlCZyyQpY4aSpuUIBY9XSZwv8wtAmCQrg+DYUZe3gqRxIlUxHi21MCy2hV0WjWqJtaSjRFrtS5fDpvk1cdF1/OP+UCcH6IqRtSHvYA9sqd/96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853409; c=relaxed/simple;
	bh=XrKOsSEH94NxKZ88WiyNe1DG8h/v1JT99t0dO3oFckU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiE9njIz/9kV3GfppG3fMMvoToR3UJW30GqfQnvB3xASHlgDwRWJClI+I0V/ha0clOBR8GRz0aANzyRbBMGWdt+t3f+ngXvozCPzBvx/xoWH0jfgj1wpZBOdoRuo7I5qLIiqqIuUBRaIcv5i3IMMrEPtFQOz+jKdoyB8YUiFOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZp0D719; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZp0D719"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540215984f0so12433909e87.1;
        Thu, 02 Jan 2025 13:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735853405; x=1736458205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zQ6BfG3c9Wlj7b/dVFQJvkgkqVpLbCApoy2Cv2VU4=;
        b=YZp0D719YY6GgPUc7JKNLNEr1AP7TmpEHZRlQlJgJ7DkdntIHB0ppPEvMqc2aaO0fo
         JQlnr0u7eM4l499zaicdcPL3g3idyeq8Oc+XG6YuJ1tLbHhZCDHfRUy5OuAyRD04vPfV
         7lBBTAeb6czOd2hD1yMolGdk1qATfzP3zTtks8dLusBF32MQ/iqWqlXNk1wPIX8w4Aeb
         1KJ/aTLGhizYXp61R/5i0qEvRcyvSR0a8SqeyfbpCB75TrD68mG/Q5JAUTuAcyThUg8J
         5i1whHWX9mayNXhyZrXEFlRYi+jvBxgk/Mdw/sAimq4GlXjSFcoVoWDwO9sn+fX+6TrM
         kBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735853405; x=1736458205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zQ6BfG3c9Wlj7b/dVFQJvkgkqVpLbCApoy2Cv2VU4=;
        b=Abpea9BSl5ugkCCM7Dn4UCj8FJa/3vpVoQq6hpmqjFtogZaIbxvjI+TOA45njyg3qP
         HfpOpFxESZKxZw1GNaF4SURfuXruZPBx2NXzuC3Rp2wIvOOKEf+Ls331e9ANTUpJytbR
         unNSnDy02+SbRPlcr2MNP2iR6TNuYZ1JIgrk5hrIOd6aUs6kYU5oWYMhdkVQaGFB0Y8h
         QMNzhx78bFLgLbbF+r1NezDDGDqx6RtI6dGNdriT21fS52GEdyHiQhjZG0aUuKoMZYDP
         q5Bfuhz+jl2nH2XN7XXhgm8OjmkZi7V4nCw4oGFAfs55kP1LhsGa+G7ssxtH9qnbc1XO
         Y/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUerAvVk61WDdkVMAHZYFC8LwDoRSu8EbY50knGVojrN+x37KjRAmENhJhuuQQRSymKZ7gTl4PVZG2o@vger.kernel.org, AJvYcCWwLdQnwIT/lfUIafEbAzdCHl5aTKAjJS7KuKpA2yteZ1TbKNF8xpIGR7xFbyFEdhjv7PbH3/nlYRMyDc/n@vger.kernel.org, AJvYcCXQNstHYL0H1hqiuhBVmwO8V5WG+9lHhJgV3/ypaUKijNK4sUlp0hDtSZGk7vey4YU0NZJMkAGnR0h6DfJvRXT3ZP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsVRG0q45tvww9+XqCjDOyGkBYCe/x0x1REqjIHO7wnCR4w4p
	gASlasmHMXDjwLuOceQ1g6hmzH9wVZpolzINK/3PTyU1f4zNcxlR
X-Gm-Gg: ASbGncsaS4JJYPhlYYjmkPmIc6TZZ02s07vqBzfg4v+Nl4D7OXXoDzrtLa20NNGJP1Z
	De1TnaTyJZPh74d3Nl9CJ3XmHwZ0gXzGchP8hHAypfdOO7ka8eSqapljKOPJPAwSPyGDWYCFEj4
	k3kuUE1siW0hXNiTwwDx4EAY9raZM4ndi/RJXh/YdnKChg/MHQ2/Ow0EHBqabz39itFfNwf2J6o
	/pixzRpfLTRiG4O626r6oyu35sj9o+2F9ujYK4hjEkO8PHTkGR/9X2Hwak=
X-Google-Smtp-Source: AGHT+IES1THUTYBi5UphHsm2PEf2/oPPiDWnuTb10lOxgKrUggS6Mf74jKiF5I5s+fQbGGOmg3NojA==
X-Received: by 2002:a05:6512:1241:b0:53f:f074:801c with SMTP id 2adb3069b0e04-5422958eaaemr15433404e87.41.1735853404760;
        Thu, 02 Jan 2025 13:30:04 -0800 (PST)
Received: from [10.8.0.2] ([130.61.158.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542236001e1sm4007494e87.88.2025.01.02.13.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 13:30:04 -0800 (PST)
Message-ID: <1fcfc835-64aa-48d0-87db-8de14913f3a4@gmail.com>
Date: Thu, 2 Jan 2025 23:30:01 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] arm64: dts: exynos: exynos8895-dreamlte: enable
 support for microSD storage
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
 <20250102205846.223955-6-ivo.ivanov.ivanov1@gmail.com>
Content-Language: en-US
From: Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20250102205846.223955-6-ivo.ivanov.ivanov1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivaylo,

On 1/2/25 10:58 PM, Ivaylo Ivanov wrote:
> Enable MMC for the Samsung Galaxy S8, used as external microSD card
> storage. Since the main PMIC is currently not supported, assume the
> required regulators are enabled by the previous bootloader.
>
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>   .../boot/dts/exynos/exynos8895-dreamlte.dts   | 39 +++++++++++++++++++
>   1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
> index 3a376ab2b..11aed89a3 100644
> --- a/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dts
> @@ -16,6 +16,10 @@ / {
>   	compatible = "samsung,dreamlte", "samsung,exynos8895";
>   	chassis-type = "handset";
>   
> +	aliases {
> +		mmc0 = &mmc;
> +	};
> +
>   	chosen {
>   		#address-cells = <2>;
>   		#size-cells = <1>;
> @@ -89,12 +93,47 @@ wink-key {
>   			wakeup-source;
>   		};
>   	};
> +
> +	reg_sd_vmmc: regulator-1 {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpb1 1 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "sdcard-vmmc";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +	};

This regulator was described in downstream, but it doesn't look like it 
exists on schematics. It could be different revisions having different 
hardware, of course, but for me it looks like it's redundant. (on 
schematics VMMC (Vdd for the card) is powered by S2MPS17 LDO29, and 
VQMMC (logic level) is powered by S2MPS17 LDO2).

I believe we should check if this hw exists by perhaps checking if 
manually changing GPIO output value changes the card behavior, and if it 
doesn't, it should be safe to drop it.

>   };
>   
>   &oscclk {
>   	clock-frequency = <26000000>;
>   };
>   
> +&mmc {
> +	assigned-clocks = <&cmu_top CLK_MOUT_CMU_FSYS1_MMC_CARD>;
> +	assigned-clock-parents = <&cmu_top CLK_FOUT_SHARED4_PLL>;
To clarify, as proven by testing, this exists because with default (on 
reset) mux MOUT_CMU_FSYS1_MMC_CARD configuration, the card doesn't show 
up, so the parent is manually set to SHARED4 PLL. With this in mind, 
maybe it makes more sense to put this into SoC dtsi, since it can't 
possibly be board-specific?
> +
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus1 &sd2_bus4>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <4>;
> +	card-detect-delay = <200>;
> +	cd-gpios = <&gpa1 5 GPIO_ACTIVE_LOW>;
Missing pinctrl for card detect pin?
> +	clock-frequency = <50000000>;
> +	disable-wp;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +
> +	/* TODO: Update once PMIC is implemented */
> +	vmmc-supply = <&reg_sd_vmmc>;
> +
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-ddr-timing = <1 2>;
> +	samsung,dw-mshc-sdr-timing = <0 3>;
> +
> +	status = "okay";
> +};
> +
>   &pinctrl_alive {
>   	key_power: key-power-pins {
>   		samsung,pins = "gpa2-4";


- Markuss

