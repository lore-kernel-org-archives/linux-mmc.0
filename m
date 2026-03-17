Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE4386C23
	for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 20:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779074; cv=none; b=H76hfTzTsLPbCXLL54xmaJMoDhFgUmZTQo04XCdF8sl73cVIbAmybLIJ4UBgICO58zFCsedMpVtBxS2KTcACFjroXdPyZeworzcrKhQJAOKeYaPOVMm118Kr4ehvqgLWKfsiZaJv2E1vflbQMXDF9uKdsfVCnflNSz89t997Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779074; c=relaxed/simple;
	bh=/pSmMN7yBxcw33FZy6ItYc1Bekt1gKAsnKnNQIrvxNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKdkfHJNDbgf6p9LY0boew1aVtt2BNIecCioawRXSd6DGWQGWVRnT6aohrupYdGpF+uS+spec7zcrRtiqcmZwoCQ1Etjp/bstg1uaRXyTPUq5JTqvAbbXUYABqVmPK7n6sQ3nmgeqiG8DJNJQLxp39L1HKUv8N05eFwX77YDAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CX7O+no4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CX7O+no4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-505a1789a27so32341361cf.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773779072; x=1774383872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH049RaW0O4+GDFr4LRnFBkAFDmCy+4RM4isbdlqWYE=;
        b=CX7O+no4hHfZxqJhLPBuffMKgjOGtBQB0MhDK5Kf7S/RNP4wnVE+fwsxoZHLfLE8GP
         s1BGjwqIX4z7bp9NCvjaURdf1eWBuvgXpLAVBnHAhnV/Vp15K+EPEO9NaPPFUxRtghfH
         hznb/ig0Dp69oNUl5r3N0A2Ze+yxaS1JTgKE9cvXczkXGodcVgGpHwx4a1QwiWZcCfys
         FaDqWO6C1q/rW3YZT4bBO7pB5h2G0fbO9nF/M+HANhrkaGodprkIzW7tMyPhLrNo7clI
         Zc29CCobr4yFHWK2wwDcYV9SFR+FEDNXXwk0dPxgE8FiY/x/OrhyffPGo/Ms4xloPoNu
         4irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773779072; x=1774383872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH049RaW0O4+GDFr4LRnFBkAFDmCy+4RM4isbdlqWYE=;
        b=gr5+56by+k98z1RblI8ErON4Btg83/dcc1t1K2zvUr4Bym32GgJaS9Sy/RwTsjoRdo
         DxARQejydBoC/hswXvmyhz0FxXkNahize+2+TQU6rNDB0ntgbEbzmZpD6Hp/KOERL8d3
         FK2xfLwa6X2DLNqDjtiDKLuL5rvvya6NjuUxXB+7iZEvS2AoSxx0EP5JXZH29j1xlNwX
         Vi1w767FopE8S+b9W4g3+yTMUmfje+0se0Ti/VZgouQy3GlWFHiD4ISmSeCuQK5OM4Ih
         2PBvdhNgcHkGvyXhIkpwFFFbQDqhP4eXaCJ0u58+7jm1v9FI+PyTi6mWu1GyhzFV5jgk
         71EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcJA018tWBMwP/Z8VtCQWKydHlPxJK1zxudk+07gO8Gz67jp5uHv56X2RYJ5V6TkPv4f4FFkJu0AM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HU3dKlvZyC19PUTDDB9RvqeVGbCryfL0qLK+54DEbmUwcCn1
	T6TcnJdqrdVBHCFvA9vr4oHkqxlUU92UiZdKZvhn1YMeQpKkuZy6GZ5HW0g+M6MdAzpcpFFJ/B1
	aM5KTKc0=
X-Gm-Gg: ATEYQzzXoahV249regHKuQO3mKLcPPNTWnB/BKJZ2DRINItRaUMBb21VyTCtSu+9zfE
	TPEt3mv22PzQFwPuaHNq7xhbVAJvcKeD61lULwK/dAnCZE+/YAfGk3vpez6WINnEjLY7TXWI2+f
	Ddd9+nJ6CbMgmhDI1HO/xLhyICwi+bkAlEDQHx38kP0ajw8YhSiNQohgiuIe412EWnlVoZylRxw
	V1hk3QOyVjTv3WZMssSgqlUDOesbf/VzDfUWz1mIFQ1MsPrQV2rJq/XfZzLNUXL1NH8u0C20kpB
	UhxzViwGDE2ikSSGiIDm/EdUDApPXgoPV2OKZxQALJcTWea0j7EuOgZ5xua3pg5KRgNn/LfqDIA
	lLtXB+yDzzzsZAQKkEUXPCpj8rGJ+41453dcmw0fdVMfTW6zppfCPkH9RCefPY4neWFu4gs/aCu
	ImlFk/kNdnAyBvaFNweswkhHHIHOFm8JoagQET3j8Z1jT6CptK4BOj/vECSr33KwHZ6zN/yvjJf
	6LQ
X-Received: by 2002:a05:622a:41:b0:509:372e:35f5 with SMTP id d75a77b69052e-50b14887949mr8987231cf.55.1773779071676;
        Tue, 17 Mar 2026 13:24:31 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:4c82:63a9:39e9:5c17? ([2001:1970:3847:e000:4c82:63a9:39e9:5c17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135b7e50sm6479901cf.22.2026.03.17.13.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 13:24:31 -0700 (PDT)
Message-ID: <6635a48f-e7b6-4f5d-8285-cb1149754cd1@baylibre.com>
Date: Tue, 17 Mar 2026 16:24:29 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC
 and power infrastructure
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-5-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-5-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-03-16 10:03, Iker Pedrosa wrote:
> Add Spacemit P1 PMIC configuration and board power infrastructure for
> voltage regulation support.
>
> - Add board power regulators (12V input, 4V rail)
> - Enable I2C8 for PMIC communication
> - Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
> - Set up regulator constraints for SD card operation
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 ++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..f1533c99881dbf38e16cff5e91e33253cfa7a56d 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -19,6 +19,25 @@ aliases {
>   		ethernet1 = &eth1;
>   	};
>   
> +	reg_dc_in: dc-in-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_in_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};

Hi,

This still shows 12V instead of the 5V connector listed in the board's spec.

I was able to test it without issue, but this should be fixed up.

> +
> +	reg_vcc_4v: vcc-4v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_4v";
> +		regulator-min-microvolt = <4000000>;
> +		regulator-max-microvolt = <4000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		vin-supply = <&reg_dc_in>;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial0";
>   	};
> @@ -92,3 +111,32 @@ &uart0 {
>   	pinctrl-0 = <&uart0_2_cfg>;
>   	status = "okay";
>   };
> +
> +&i2c8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c8_cfg>;
> +	status = "okay";
> +
> +	pmic@41 {
> +		compatible = "spacemit,p1";
> +		reg = <0x41>;
> +		interrupts = <64>;
> +		vin-supply = <&reg_vcc_4v>;
> +
> +		regulators {
> +			buck4: buck4 {
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-ramp-delay = <5000>;
> +				regulator-always-on;
> +			};
> +
> +			aldo1: aldo1 {
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
>
