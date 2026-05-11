Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9D3750BD
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499812; cv=none; b=lM37OlzB1nrmoEP56AahDUJD8Ww64AFyYWbV99VTSvVlN6hpA7aWQDrt2cvCl/+vdtFk/uEAZh8d0NvN6dgpG9VdDZ5uK2fLp0+wP3CzvYy2VIUwReeGXiKAoGJ0E7fSlXc4rCfrC3zFTie0KwQnYFk+74J1SM1yRMSt/iHzSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499812; c=relaxed/simple;
	bh=z3Lm7HpwUT3CHnQ6JBExuWySXx5/0hgPmQoR7JuuetQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnTJ0ppFBeUhEswf4ucyL2bFYp1diOB9ku0Cubu5kGsmHdxXZXIPI19w3uqZMXdGlAwCqkF58zIgZQb0LGQo94AbxywGXoCvhdvVAevxYNhuZSdBQYFIXvYn2pz/kgCOEaLpEDA2jc+rb1MXalqFkZv/B6ZufHyEXIgQk7AgeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsWmOePq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsWmOePq"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44c350a5b87so2545081f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778499810; x=1779104610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vq0OHDPrSqmT5iEr31Nrcm4QgRLDSjmnaM+8FKnpEIY=;
        b=OsWmOePqnVEI0mCMiFo7j1sVbgbHgi8awNpMIzWfJpcqQt1HNnKv5NySE+h4edMBH+
         PHflk/r7l7aTclhXHGn92l44h8aDanG/XWlIKOnzx5IFT5CIDgwhGj52rkKT+ZD5PyXJ
         kXILNfFZ/X4t3jw9XS3MKywQePi1GBw9AZaQU82dihEHnCACccQjRgTaUFHH5wtp4C9I
         pn8da1U2O6dOTmRQxz0Wj4iiXdW5RRQmDjrUnSk2HsQ3YL6gxJBwFzPwAYrgenBmrHN8
         MUQqG3DscYRtD/IP+T2vIOyodpdFhAdXu/eCBYczegU7Oc/Ac378l7ZvF9uZuLYQELm/
         S8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499810; x=1779104610;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq0OHDPrSqmT5iEr31Nrcm4QgRLDSjmnaM+8FKnpEIY=;
        b=HnFDBC9Iv0TgO9IV8NDYtjlAOPZ2Zx/VAkUPOBJ1sSPcxIxQIxdKDaSUqnVOfelya3
         nkk2Ml+ClYlODCH+KCfOPjvgkWldPf9sDBqrupcPz+vzv6QkT5t2hBG32M/gVxSSZsfp
         5IMbpPGr4fSGvIW4h0jZXvbr6qAFLyP15iCysIxVop9+SGLkpvmvpUB6iSQbcP5zK3rj
         UrTcLc6HgcMaVELmha3VZI6d+0qNEaYS8InN772ai1rHpPIHNntkmrc+bSOQo1csqp6x
         RmyJyBL1CRkIT5IWMkCReX3TcmVRAG44q/xW0r3ZdT170pBYoaE+Q9H1fwocfNg7uEmI
         N5XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+YnPNrgFfRdeUoSyKoWca8BjvNQxYsnkbjncmF5aX7/4/Kyx075kbVvOYThKJk8BeADieUBkwAxYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkar9+V2DXEN2h5UdptYfiOjZC1UE90sVon91zmLCk9vk91XRe
	hIb3ErrvArq+usxPUYEurRHENqy3CcAY+GCVctYO+jysi19XXN9lFDyJ
X-Gm-Gg: Acq92OEZLUVe/51iDACJbP0AWG8p51gFxV63Bv2mN0GynvCZMA+IsZn4zwQhZ0hh8hp
	pjUU1djuWCAKZQaUiQXbOOo4XzHxMFa/qJuQzBjzhM3BEHv+bOF5dHfAOuXHS3InYtwFF2uvJbY
	RdEuBCz/X2ODn1tYEcHmrZvjTAy8OJc1zuKORB6IEedG2z6czY/gsmZfa1swyoKL6IuwknUZT3p
	MevMjXtK/RyDVC0Wgq+tQnbvIqjXlXGoGwjBfYi9J7LRcxPobyV3FVbePKH+ssPA+ZObLpiv0nV
	8ZcPirRCg9D5PsYGZhqBB10AQXr57BrmMEF38TbCwLuFZin9jOWiYDbPaKGq9MmlmuOEtgLf8XU
	xBGEePJTNEKoIAcPzDuN6BIm9ue6cMve/7poNUouVnq8YyYJdWhBHZYLXO/uuRqJyxyZTBbDtIl
	YCpZ1QMEHO2D/LOput+tbMwI6pXxdmsuS0aFfhBpFb7l8jMQ+pCiEa4CFzpvIbDUQ=
X-Received: by 2002:a5d:64c9:0:b0:43d:75ec:26f7 with SMTP id ffacd0b85a97d-4515cb3d91dmr38402992f8f.29.1778499809527;
        Mon, 11 May 2026 04:43:29 -0700 (PDT)
Received: from [192.168.0.40] (a89-182-129-90.net-htp.de. [89.182.129.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm9488989f8f.3.2026.05.11.04.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 04:43:29 -0700 (PDT)
Message-ID: <46f93cdb-e65d-4c83-9050-f8223690b0ce@gmail.com>
Date: Mon, 11 May 2026 13:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Trevor Gamblin <tgamblin@baylibre.com>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
 <20260511-orangepi-sd-card-uhs-v9-8-ae48c0b2b2cf@gmail.com>
From: Andre Heider <a.heider@gmail.com>
Content-Language: de-DE
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-8-ae48c0b2b2cf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Iker,

On 11.05.26 10:54 AM, Iker Pedrosa wrote:
> From: Trevor Gamblin <tgamblin@baylibre.com>
> 
> Update the Muse Pi Pro devicetree with SD card support to match what
> was done for the OrangePi RV2 in [1]. More precisely:
> 
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
> 
> [1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

with the cd issue mentioned below this is:

Tested-by: Andre Heider <a.heider@gmail.com>


> ---
>   arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 66 ++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> index 29e333b670cf..774a4640f065 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> @@ -18,6 +18,24 @@ aliases {
>   		ethernet0 = &eth0;
>   		serial0 = &uart0;
>   	};
> +	reg_dc_in: dc-in-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_in_5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_vcc_4v: vcc-4v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_4v";
> +		regulator-min-microvolt = <4000000>;
> +		regulator-max-microvolt = <4000000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>   
>   	chosen {
>   		stdout-path = "serial0";
> @@ -77,3 +95,51 @@ &uart0 {
>   	pinctrl-names = "default";
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
> +
> +&sdhci0 {
> +	pinctrl-names = "default", "uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +	cd-inverted;

cd doesn't work with that on my muse pi pro. This on top fixes it though:

diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
index c3920fc708f51..ad68ded8dfd7e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -396,8 +396,7 @@ &sdhci0 {
     pinctrl-0 = <&mmc1_cfg>;
     pinctrl-1 = <&mmc1_uhs_cfg>;
     bus-width = <4>;
-   cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
-   cd-inverted;
+   cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
     no-mmc;
     no-sdio;
     disable-wp;

> +	no-mmc;
> +	no-sdio;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&buck4>;
> +	vqmmc-supply = <&aldo1>;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> 

Thanks!
Andre
