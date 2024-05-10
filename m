Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535B172790
	for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357699; cv=none; b=EHTLyhd+Aaem7PB0Zl4jFRXYifrexPGquSReYVy6yR2voIDprHb/Bwvq/DNB6DxKERE1rffWVYV6HYhbIj8wDrK8EFjWlkg6HHPvqpLCVqALmEiT+TKSfR/w6cguAVkts2W1KbLXJIOrBR5WjE5GtXvEEnilvkArsOI8UREUvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357699; c=relaxed/simple;
	bh=4eHFZq5myd0dvYKfE+TEgywl++q74XWh8GdzGYOqvY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G2XZxZ3KWSbeGR5d8USrNU9eLT7tINlu1ISywQI9kcT4eOmdz1Cf/dhXsx8ujy1BrhCQUfrurYXWSR5YXY179+A3Cc8zntGrc+wjg4Bkh1Jn+ro+iW6J7OT3KPPLFjq7ZT4GbRNNBtBRZy2GfhN+T9rvVLIfOJammXzdp3ZEcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJy3i8fP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJy3i8fP"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso2013890b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715357695; x=1715962495; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2LbLZ+9woydrEMjbXx5uZ/XQY+Yi6wnqufcdw76sKM=;
        b=SJy3i8fPMtmVJm6VkX8y+MN9w+N/Dcyp4FEnB8/cJNQHGQ/0f6ulrNTvmSfexwAZaI
         DA+rNawGmMvyRQiaGc2P563/UfqtAIdrumDGQFeWrfGax/WGCzKCV/1+1jkI7ff3N4gb
         q9NISGhh/lxLlLURWu5odP0EJCol50rpUmS5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715357695; x=1715962495;
        h=in-reply-to:autocrypt:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N2LbLZ+9woydrEMjbXx5uZ/XQY+Yi6wnqufcdw76sKM=;
        b=sfKfAW17WMD9ETsGq82iAmFQHD+YQ9jesakVjSFpf+a4KZIZn9LNCpionIbkT/acrg
         E0vu507EpM/9jJ858ba9I6rUzhdnYWj4hXhsVUCo3h6GJB/k5H1UiyQ5r068llFagWUJ
         ZxzpFfcPC0dbCHmWBdQ6bCzA9LSo0p9zvJJXDURGw4oytDy3ZYjfioWvP2dH6OaD8T01
         E+NX/hsST3GtXGzy6bcAS5kCkMVp7N/MtFW2ZR1jXpcn1Nrts6QUxWC2WiMvri3GVxFf
         KJeAY1ikZDkrHvO2pdyc1GSQS4dtWWFxJxik+b/x4EYbnSDnieTskUjc6v5IqMdkOScn
         r33w==
X-Forwarded-Encrypted: i=1; AJvYcCWkToULr7SlvMM99v2+FOaQdHU5RdLtAy+PCle26tDAHcG4lUYUKKtbBOOL3c/QRGhVg1y6FxdxRzYyoXiZ891QVVoabF7zJqTC
X-Gm-Message-State: AOJu0YyWpmk0C3ErV8be8qWQV61Cx6rtFyKuGJ5+bLrmi2iDaHBUOCJO
	CxkJ8z1VDX65ykPo/XukkekvVvsFYeB7rHVZCYW1zQJfKRakITIc7sqXZE/ZcA==
X-Google-Smtp-Source: AGHT+IGTdKoI+j+lblcPOvWAL27FWwnTw2OvmKoQ1gWpdSH54ayzH6S8faKf/UmBWjJkkQjoFeESeg==
X-Received: by 2002:a05:6a21:614:b0:1af:63f0:b416 with SMTP id adf61e73a8af0-1afde0e6381mr3142724637.15.1715357695365;
        Fri, 10 May 2024 09:14:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b862567sm2836782a12.29.2024.05.10.09.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 09:14:53 -0700 (PDT)
Message-ID: <786bbf35-e9fe-445c-b6f9-21119e60fb34@broadcom.com>
Date: Fri, 10 May 2024 09:14:50 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: broadcom: Add support for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <59a3015c3a6f2f0b70a38c030274a163773e7757.1715332922.git.andrea.porta@suse.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020b14106181bd693"

--00000000000020b14106181bd693
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/24 07:35, Andrea della Porta wrote:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   arch/arm64/boot/dts/broadcom/Makefile         |   1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
>   3 files changed, 365 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> 
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index 8b4591ddd27c..92565e9781ad 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -6,6 +6,7 @@ DTC_FLAGS := -@
>   dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
>   			      bcm2711-rpi-4-b.dtb \
>   			      bcm2711-rpi-cm4-io.dtb \
> +			      bcm2712-rpi-5-b.dtb \
>   			      bcm2837-rpi-3-a-plus.dtb \
>   			      bcm2837-rpi-3-b.dtb \
>   			      bcm2837-rpi-3-b-plus.dtb \
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> new file mode 100644
> index 000000000000..b5921437e09f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0

New DTS files should be under GPL-2.0-or-MIT AFAICT.

> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "bcm2712.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,5-model-b", "brcm,bcm2712";
> +	model = "Raspberry Pi 5";
> +
> +	aliases {
> +		serial10 = &uart0;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial10:115200n8";
> +	};
> +
> +	/* Will be filled by the bootloader */
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0 0 0x28000000>;

That should be a 4 cell member, see my comment on bcm2712.dtsi.

> +	};
> +
> +	sd_io_1v8_reg: sd-io-1v8-reg {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd-sd-io";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-settling-time-us = <5000>;
> +		gpios = <&gio_aon 3 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x1>,
> +			 <3300000 0x0>;

Can we use decimal for the second cell as well?

> +	};
> +
> +	sd_vcc_reg: sd-vcc-reg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpios = <&gio_aon 4 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +/* The system UART */
> +&uart0 {
> +	status = "okay";
> +};
> +
> +/* SDIO1 is used to drive the SD card */
> +&sdio1 {
> +	vqmmc-supply = <&sd_io_1v8_reg>;
> +	vmmc-supply = <&sd_vcc_reg>;
> +	bus-width = <4>;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;
> +	sd-uhs-sdr104;
> +};
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> new file mode 100644
> index 000000000000..398df13148bd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "brcm,bcm2712";
> +
> +	#address-cells = <2>;
> +	#size-cells = <1>;

This should be #size-cells = <2> to be future proof and support over 4GB 
of DRAM, because the DDR controller and the memory map on that chip have 
been designed with that requirement.

> +
> +	interrupt-parent = <&gicv2>;
> +
> +	axi: axi {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;

The AXI peripheral window should be defined in the ranges property. The 
aperture is from 0x10_0000_0000 to 0x10_3FFF_FFFF.

 From that point on you can define all peripherals under the axi node to 
be relative to that axi aperture, just like what you did for the legacy 
Pi peripherals in the subsequent bus node.

> +
> +		sdio1: mmc@1000fff000 {
> +			compatible = "brcm,bcm2712-sdhci",
> +				     "brcm,sdhci-brcmstb";
> +			reg = <0x10 0x00fff000  0x260>,
> +			      <0x10 0x00fff400  0x200>;
> +			reg-names = "host", "cfg";
> +			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_emmc2>;
> +			clock-names = "sw_sdio";
> +			mmc-ddr-3_3v;
> +		};
> +
> +		gicv2: interrupt-controller@107fff9000 {
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			compatible = "arm,gic-400";
> +			reg = <0x10 0x7fff9000  0x1000>,
> +			      <0x10 0x7fffa000  0x2000>,
> +			      <0x10 0x7fffc000  0x2000>,
> +			      <0x10 0x7fffe000  0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> +				      IRQ_TYPE_LEVEL_HIGH)>;

I would omit this interrupt property, because it is not clear to me 
whether the VGIC maintenance interrupt has actually been wired up.

> +		};
> +	};
> +
> +	clocks {
> +		/* The oscillator is the root of the clock tree. */
> +		clk_osc: clk-osc {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-output-names = "osc";
> +			clock-frequency = <54000000>;
> +		};
> +
> +		clk_vpu: clk-vpu {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <750000000>;
> +			clock-output-names = "vpu-clock";
> +		};
> +
> +		clk_uart: clk-uart {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <9216000>;
> +			clock-output-names = "uart-clock";
> +		};
> +
> +		clk_emmc2: clk-emmc2 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +			clock-output-names = "emmc2-clock";
> +		};
> +	};
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* Source for d/i cache-line-size, cache-sets, cache-size
> +		 * https://developer.arm.com/documentation/100798/0401
> +		 * /L1-memory-system/About-the-L1-memory-system?lang=en
> +		 */
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			d-cache-size = <0x10000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			i-cache-size = <0x10000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			next-level-cache = <&l2_cache_l0>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			d-cache-size = <0x10000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			i-cache-size = <0x10000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			next-level-cache = <&l2_cache_l1>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			d-cache-size = <0x10000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			i-cache-size = <0x10000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			next-level-cache = <&l2_cache_l2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a76";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			d-cache-size = <0x10000>;
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			i-cache-size = <0x10000>;
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>; // 64KiB(size)/64(line-size)=1024ways/4-way set
> +			next-level-cache = <&l2_cache_l3>;
> +		};
> +
> +		/* Source for cache-line-size and cache-sets:
> +		 * https://developer.arm.com/documentation/100798/0401
> +		 * /L2-memory-system/About-the-L2-memory-system?lang=en
> +		 * and for cache-size:
> +		 * https://www.raspberrypi.com/documentation/computers
> +		 * /processors.html#bcm2712
> +		 */
> +		l2_cache_l0: l2-cache-l0 {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <128>;
> +			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};

Since each of these L2 caches are per-CPU core, they should be under 
their respective CPU node. This is what I did for the BCM2712 sister 
chip, and it looks like this:

                 cpu@0 {
                         operating-points = <0x0 0x0 0x0 0x0 0x0 0x0 0x0 
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
                         d-cache-sets = <0x100>;
                         d-cache-line-size = <0x40>;
                         d-cache-size = <0x10000>;
                         i-cache-sets = <0x100>;
                         i-cache-line-size = <0x40>;
                         i-cache-size = <0x10000>;
                         clock-frequency = <0x95aad1c0>;
                         device_type = "cpu";
                         enable-method = "psci";
                         compatible = "arm,cortex-a76";
                         reg = <0x0 0x0>;
                         next-level-cache = <0x2>;
                         cpu-idle-states = <0x3>;
                         clocks = <0x4 0x0>;
                         clock-names = "cpu";
                         phandle = <0x9>;

                         cache-controller-0 {
                                 cache-sets = <0x400>;
                                 cache-line-size = <0x40>;
                                 cache-size = <0x80000>;
                                 compatible = "cache";
                                 cache-unified;
                                 cache-level = <0x2>;
                                 next-level-cache = <0x5>;
                                 phandle = <0x2>;
                         };
                 };

Also, the values are actually populated by the boot loader from reading 
the CLIDR registers, and they yield the same results as yours, so this 
part looks good to me. We should consider decimal numbers however for a 
source level Device Tree (the output I provided is rendered via libfdt).




> +
> +		l2_cache_l1: l2-cache-l1 {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <128>;
> +			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l2: l2-cache-l2 {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <128>;
> +			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		l2_cache_l3: l2-cache-l3 {
> +			compatible = "cache";
> +			cache-size = <0x80000>;
> +			cache-line-size = <128>;
> +			cache-sets = <1024>; // 512KiB(size)/64(line-size)=8192ways/8-way set
> +			cache-level = <2>;
> +			cache-unified;
> +			next-level-cache = <&l3_cache>;
> +		};
> +
> +		/* Source for cache-line-size and cache-sets:
> +		 * https://developer.arm.com/documentation/100453/0401/L3-cache?lang=en
> +		 * Source for cache-size:
> +		 * https://www.raspberrypi.com/documentation/computers/processors.html#bcm2712
> +		 */
> +		l3_cache: l3-cache {
> +			compatible = "cache";
> +			cache-size = <0x200000>;
> +			cache-line-size = <64>;
> +			cache-sets = <2048>; // 2MiB(size)/64(line-size)=32768ways/16-way set
> +			cache-level = <3>;
> +			cache-unified;
> +		};
> +	};
> +
> +	psci {
> +		method = "smc";
> +		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
> +		cpu_on = <0xc4000003>;
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +	};
> +
> +	rmem: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		atf@0 {
> +			reg = <0x0 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		cma: linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x4000000>; /* 64MB */
> +			reusable;
> +			linux,cma-default;
> +			alloc-ranges = <0x0 0x00000000 0x40000000>;
> +		};
> +	};
> +
> +	soc: soc@107c000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		ranges     = <0x7c000000  0x10 0x7c000000  0x04000000>;
> +		/* Emulate a contiguous 30-bit address range for DMA */
> +		dma-ranges = <0xc0000000  0x00 0x00000000  0x40000000>,
> +			     <0x7c000000  0x10 0x7c000000  0x04000000>;
> +
> +		system_timer: timer@7c003000 {
> +			compatible = "brcm,bcm2835-system-timer";
> +			reg = <0x7c003000 0x1000>;
> +			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <1000000>;
> +		};
> +
> +		mailbox: mailbox@7c013880 {
> +			compatible = "brcm,bcm2835-mbox";
> +			reg = <0x7c013880 0x40>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <0>;
> +		};
> +
> +		local_intc: local-intc@7cd00000 {
> +			compatible = "brcm,bcm2836-l1-intc";
> +			reg = <0x7cd00000 0x100>;
> +		};
> +
> +		uart0: serial@7d001000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x7d001000 0x200>;
> +			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_uart>, <&clk_vpu>;
> +			clock-names = "uartclk", "apb_pclk";
> +			arm,primecell-periphid = <0x00241011>;
> +			status = "disabled";
> +		};
> +
> +		interrupt-controller@7d517000 {
> +			compatible = "brcm,bcm7271-l2-intc";
> +			reg = <0x7d517000 0x10>;
> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			status = "disabled";
> +		};

I see no reason for an interrupt controller to be disabled by default, 
if the interrupts are not used, we are not going to be consuming resources.

> +
> +		gio_aon: gpio@7d517c00 {
> +			compatible = "brcm,bcm7445-gpio", "brcm,brcmstb-gpio";
> +			reg = <0x7d517c00 0x40>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			// Don't use GIO_AON as an interrupt controller because it will
> +			// clash with the firmware monitoring the PMIC interrupt via the VPU.
> +			brcm,gpio-bank-widths = <17 6>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +		/* This only applies to the ARMv7 stub */
> +		arm,cpu-registers-not-fw-configured;

And the A76 cannot boot an AArch32 kernel at EL1, is that comment still 
relevant? It looks like there is an ARM trusted reserved region, can we 
assume that it will have done the configuration properly?
-- 
Florian


--00000000000020b14106181bd693
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDmeeAvz04Kuay14
hQbLHKRsPWwkzAforWdZpss2ro+KMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDUxMDE2MTQ1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5BokVWQMeVbLqSe9fLxLh7FZYqK5cwgfE
ywqjTmzfJR4m6Mf9SJMhI09sWeITSGs2UELOyc/hyJoG14sRMjZrwyUmAcvLbBj2Pq+bP1DjpP7S
ObWTxE1SiRVCWKuMi7Sy76xDrgM3o6KYSLnG1gp1VAa0wc0VlxUOgwoTC1Efp/PtOSdPdZ6QFv4s
jobVK4JlXy4wYgYMGrb1Cx7gY4b8Ul104sgTfQt1NziyTXXHTJboKfN8eh0AoBKGjRx629hoMqzP
V9WejfJrZ8xMMblpuZ1CsofLCbqyUkpHD9KRsjgMs/vqWttNfjxz797pjjo/EJAum0S96lEq1v8F
229c
--00000000000020b14106181bd693--
