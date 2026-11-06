Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964116;
	b=z+vZUWyQmY75VlmvDjOcXI51QtGXMr+1WudueZCQ9pjRe7odKhKLAixHz/eG1CpgZXnA
	 +FlrwMPi+deYxgPZeWyaR4YrZw3isXJ0GNAsYvSkBTUgl3+PdKGX8Pl5bWakMy9Jaiiq/
	 3HTNdXxVYMpwyTD/lg5F+hMcnb8JRBTMiVWx/TGuXC1cN8KwrfrvaXyDoyiPGezt40i8o
	 GcgPLIHVVzL8hDH3XVYMo+8UMU5G9RrlM6UaBlay9NmhaqwOH+/wEo4zABQiDnvWCbU5x
	 TCd04cLGKoxDSbd5kOnI6PdN22xPqY4ZSTo/sOyQMObT+srj992vNT63K5K1HWQ8Gug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964116;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=z7aW3+opSiH7y0XqRuy6at87FK5gKoz43cEXHGVwj4I=;
	b=VDhJ/nE2CX5gs1SwX7VQZ6dBfGCDt82wb4vaHJUjALLfa+WOAbaMN2jXnLtpqji59lZs
	 Dmvu9MPKJ8TWmQOc+xewn4bSwr97RP08JEsuVCYvRYo2QQ1OJIsybko5K8CEYhZAXreBw
	 QK5NjoA19hrzPWiF1YLx7C+6DZIzWXPXXXUe66f3jtDJZ+ZCg+U6M372iixZryZAhw2W9
	 YQsOgCnx9+QDDErHezerSyGQAhLnZ7RIqk8mw+2ozL4ab2zV+hrTcvHvdBO7+wdhrUMrS
	 jw1WKAe5AxOUTzzntHMPrf9YBHspGB6scYXad0tIQDsrSx7k5ZVY59S92k9jB+m7G9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWgRMBfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E42606A326;
	Fri,  6 Nov 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWgRMBfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8471F008A1;
	Fri,  6 Nov 2026 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964115;
	bh=z7aW3+opSiH7y0XqRuy6at87FK5gKoz43cEXHGVwj4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kWgRMBfICz/KGL0LPa6FKWNca5OHfggwd5woJwFqwHuhXPWPHcF44TydWhSYhQEI3
	 f0iXsXQO61f2Hu6MqnrwbLLzW3CAeA52xJ6yof4l7Qbt3cnqCTjSVqsOVGVgXtNvE5
	 VqbcGK3wHcW91ZhlCc7T6tl7J+DNfexArWOD2szT/vMSq4XKjg0HbZmcdfqg9B+rxc
	 8yoQs2z+7JO2d2FhX3SGvq5J+mePC3O7cKqwa/L8U6whDLFYHbsJmYI/+Ees4jzSX8
	 jeayfgA4FFVfLyuUqHHzBTSc4qEhfUgTKNK5iyK2RicG/pjeubmPhIOiM9gfeiKlM9
	 d2FDxwB8fOORw==
Message-ID: <0b4e0483-2aee-4201-af48-96042944ee85@kernel.org>
Date: Fri, 6 Nov 2026 12:21:41 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] riscv: add Metanoia MT2824 SoC and MT5824 EVB
 support
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ben Zong-You Xie <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>,
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?B?UmFuZG9scGggU2hlbmctS2FpIExpbijmnpfogZblh7Ep?=
 <randolph@andestech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2026 10:30, Benoît Monin wrote:
> Add the device tree for the Metanoia MT2824, a dual-core Andes
> AX45MP-based SoC, and for the MT5824 evaluation board.
> 
> The SoC device tree describes the CPUs and their L2 cache, the PLIC,
> PLICSW and PLMT, the reset controller, the reboot controller, the
> watchdog, two UARTs, the QSPI and eight SPI controllers, the DWC
> MSHC MMC controller, and the USB2 controller.
> 
> The MT5824 EVB enables the watchdog, the two UARTs, the MMC
> controller, the QSPI port with its SPI-NOR flash, the first three SPI
> controllers, and the USB controller.
> 
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
> ---
>  arch/riscv/boot/dts/Makefile                |   1 +
>  arch/riscv/boot/dts/metanoia/Makefile       |   2 +
>  arch/riscv/boot/dts/metanoia/mt2824.dtsi    | 330 ++++++++++++++++++++++++++++
>  arch/riscv/boot/dts/metanoia/mt5824-evb.dts |  81 +++++++
>  4 files changed, 414 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 69d8751fb17c..8e1e987ea089 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -4,6 +4,7 @@ subdir-y += andes
>  subdir-y += anlogic
>  subdir-y += canaan
>  subdir-y += eswin
> +subdir-y += metanoia
>  subdir-y += microchip
>  subdir-y += renesas
>  subdir-y += sifive
> diff --git a/arch/riscv/boot/dts/metanoia/Makefile b/arch/riscv/boot/dts/metanoia/Makefile
> new file mode 100644
> index 000000000000..7a685798d5a4
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_METANOIA) += mt5824-evb.dtb
> diff --git a/arch/riscv/boot/dts/metanoia/mt2824.dtsi b/arch/riscv/boot/dts/metanoia/mt2824.dtsi
> new file mode 100644
> index 000000000000..5f73c6d3760b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/mt2824.dtsi
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	#address-cells = <0x02>;
> +	#size-cells = <0x02>;
> +	compatible = "metanoia,mt2824";
> +
> +	cpus: cpus {
> +		#address-cells = <0x01>;
> +		#size-cells = <0x00>;
> +		timebase-frequency = <20000000>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			reg = <0x00>;
> +			compatible = "andestech,ax45mp", "riscv";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm", "xandespmu";
> +			mmu-type = "riscv,sv39";
> +			clock-frequency = <900000000>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <0x100>;
> +			i-cache-line-size = <0x40>;
> +			i-cache-block-size = <0x40>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <0x80>;
> +			d-cache-line-size = <0x40>;
> +			d-cache-block-size = <0x40>;
> +			next-level-cache = <&l2_cache>;
> +
> +			cpu0intc: interrupt-controller {
> +				#interrupt-cells = <0x01>;
> +				interrupt-controller;
> +				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
> +			};
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			reg = <0x01>;
> +			compatible = "andestech,ax45mp", "riscv";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm", "xandespmu";
> +			mmu-type = "riscv,sv39";
> +			clock-frequency = <900000000>;
> +			i-cache-size = <0x8000>;
> +			i-cache-sets = <0x100>;
> +			i-cache-line-size = <0x40>;
> +			i-cache-block-size = <0x40>;
> +			d-cache-size = <0x8000>;
> +			d-cache-sets = <0x80>;
> +			d-cache-line-size = <0x40>;
> +			d-cache-block-size = <0x40>;
> +			next-level-cache = <&l2_cache>;
> +
> +			cpu1intc: interrupt-controller {
> +				#interrupt-cells = <0x01>;
> +				interrupt-controller;
> +				compatible = "andestech,cpu-intc", "riscv,cpu-intc";
> +			};
> +		};
> +	};
> +
> +	clocks {
> +		ext_clk: ext-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <20000000>;
> +			clock-output-names = "ext-clk";
> +		};
> +
> +		pclk_div4: platform-clock-div4 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <225000000>;
> +			clock-output-names = "platform-clock-div4";
> +		};
> +
> +		pll_soc_out3: pll-soc-out3 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <180000000>;
> +			clock-output-names = "pll-soc-out3";
> +		};
> +
> +		usb_otg_ahb_clk: clock-usb-otg-ahb {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <60000000>;
> +			clock-output-names = "otg";
> +		};
> +	};
> +
> +	soc: soc {
> +		#address-cells = <0x02>;
> +		#size-cells = <0x02>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		ranges;
> +
> +		usb0: usb@4000000 {
> +			compatible = "metanoia,mt2824-usb", "snps,dwc2";
> +			reg = <0x0 0x04000000 0x0 0x100000>;
> +			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&usb_otg_ahb_clk>;
> +			clock-names = "otg";
> +			dr_mode = "host";
> +			resets = <&rst 19>, <&rst 20>;
> +			reset-names = "dwc2", "dwc2-ecc";
> +			phys = <&usb2phy>;
> +			phy-names = "usb2-phy";
> +			hnp-disable;
> +			srp-disable;
> +			disable-over-current;
> +			status = "disabled";
> +		};
> +
> +		mmcsd: mmc@4100000 {
> +			compatible = "metanoia,mt2824-dwcmshc";
> +			clocks = <&pll_soc_out3>;
> +			clock-names = "core";
> +			reg = <0x0 0x04100000 0x0 0x00100000>;

Please follow coding style and dt-checkstyle.

Also 0x00100000 is 0x100000

Anywya, look at size of address space. 0x100000, right?

...

> +		reboot: reboot@10000004 {
> +			compatible = "metanoia,mt2824-reboot";
> +			reg = <0x0 0x10000004 0x0 0x08>;

Now look here - 0x8

> +		};
> +
> +		rst: reset-controller@1000000c {
> +			#reset-cells = <1>;

Random coding style.

> +			compatible = "metanoia,mt2824-reset";
> +			reg = <0x0 0x1000000c 0x0 0x04>;

and 0x4.

Do you see the problem?

Why do you pad some numbers?

> +		};
> +
> +		watchdog: watchdog@10090000 {
> +			compatible = "metanoia,mt2824-wdt", "andestech,ae350-wdt";
> +			reg = <0x0 0x10090000 0x0 0x10000>;
> +			clocks = <&ext_clk>;
> +			andestech,clock-source = <0>;
> +			timeout-sec = <10>;
> +			status = "disabled";

Why? It's always there, no?


> +
> +	usb2phy: usb2-phy {

Follow DTS coding style.


Best regards,
Krzysztof
