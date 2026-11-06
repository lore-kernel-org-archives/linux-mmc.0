Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989840;
	b=RgTXTaH8HQS6//GTP52KhK87L0P+VQYo+qUmrI7MvDHvGDeuLh7M9yy4Q9soDPFAZQ8l
	 rDOIvk3HcO8q4P99ykz2B8FSzz/YDdWCOogqkRd78NwQEddxeUQVgpLYk9fUB+GT+N0yW
	 UgSDv/UwHhTybqnS2TqsXg1mfKvFCMhfmZQdAIB5/Mqbpl7KPqzbNEOrf9eU13UyvUHzE
	 wtHzn70kR8YE7BEHxNmdQ87Zs8AWUcInMANl/tbdt0YNO7ffkYF/aAuQg4O5lgdJodlD7
	 n+KybqxVH/0JRHQqf+bPeeDDD5rqv6Kea9OCRl12p5WGMt7ZUlNEvkZvHDQ1PrGYCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jN+SIR2+8EH7AFSQyftGGlUBzcqrVp7rY3xpDZWw1iA=;
	b=f3kj5zG7bsLB1AzQuWc32z+vMJRKdwxjRk5oc0G+NuqHHqDILL/7wf8cgZK/e8YA6t2h
	 jO/2CPmRQp76zZJrdL0nBmvtusbOV03nDuAm4w6SmXag2o9pm1LOhINA26S9l26zA1ct3
	 Y3uPdlzuUwGaGUDGiaFMtUHi3CB87q16uAVnN+qEzJrl2izZcnC5ptqCH3eYdzOXLQ4ov
	 ksFqftLu7fwBOqJGeoQx2pvRthkS9XEHdipE+5FiUq0NKMBi+3kpxqVSayr7HhMcRBqbf
	 woaFmvul02EhXuOqSFTxNbYTyA7vL+4vqHQLafSSof+6dUgNQOVGUN8HRor9JAbQKhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnBXyQOK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E02606A326;
	Fri,  6 Nov 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnBXyQOK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF601F0089F;
	Fri,  6 Nov 2026 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989839;
	bh=jN+SIR2+8EH7AFSQyftGGlUBzcqrVp7rY3xpDZWw1iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AnBXyQOKrP/zbbQW9KfIjdIXhrT+R6/JiAFOXixdvx+32awVrrUjr/01Gg1pIarfS
	 4xyhnd+UO9+7fuYB4kZH2/tnHfriCCnsIZxNhjdL/kzvVOY4UBXwIHwAem8wQV+8Ry
	 BOgb7K7zl8c7PCt3ZW7zWOBmGRScqNKOwVOXQ2+gAlnnfxms8fvs03s1/YcXOrIZNw
	 tijMqy1C32QHM4FJo6Q8s8v3I4awlRSlNbOiPqnauOD2C4fQ/eeX11AWMsOeSxlUG2
	 u4g3Z8h4HXQPkwBIK6hisbbrawdMMnz9wGVYApWqzwx9DEh0jLBq0wXurtP71VBj8C
	 bzxdFsFEttZrQ==
Date: Fri, 6 Nov 2026 18:30:30 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jun Chang <jun.chang@metanoia-comm.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 24/25] riscv: add Metanoia MT2824 SoC and MT5824 EVB
 support
Message-ID: <20261106-starter-chowtime-7799df8249fa@spud>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gVj6kT/nEeV7IrJz"
Content-Disposition: inline
In-Reply-To: <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>

--gVj6kT/nEeV7IrJz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 10:30:21AM +0100, Beno=EEt Monin wrote:
> Add the device tree for the Metanoia MT2824, a dual-core Andes
> AX45MP-based SoC, and for the MT5824 evaluation board.
>=20
> The SoC device tree describes the CPUs and their L2 cache, the PLIC,
> PLICSW and PLMT, the reset controller, the reboot controller, the
> watchdog, two UARTs, the QSPI and eight SPI controllers, the DWC
> MSHC MMC controller, and the USB2 controller.
>=20
> The MT5824 EVB enables the watchdog, the two UARTs, the MMC
> controller, the QSPI port with its SPI-NOR flash, the first three SPI
> controllers, and the USB controller.
>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> Signed-off-by: Beno=EEt Monin <benoit.monin@bootlin.com>
> ---
>  arch/riscv/boot/dts/Makefile                |   1 +
>  arch/riscv/boot/dts/metanoia/Makefile       |   2 +
>  arch/riscv/boot/dts/metanoia/mt2824.dtsi    | 330 ++++++++++++++++++++++=
++++++
>  arch/riscv/boot/dts/metanoia/mt5824-evb.dts |  81 +++++++
>  4 files changed, 414 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index 69d8751fb17c..8e1e987ea089 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -4,6 +4,7 @@ subdir-y +=3D andes
>  subdir-y +=3D anlogic
>  subdir-y +=3D canaan
>  subdir-y +=3D eswin
> +subdir-y +=3D metanoia
>  subdir-y +=3D microchip
>  subdir-y +=3D renesas
>  subdir-y +=3D sifive
> diff --git a/arch/riscv/boot/dts/metanoia/Makefile b/arch/riscv/boot/dts/=
metanoia/Makefile
> new file mode 100644
> index 000000000000..7a685798d5a4
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_METANOIA) +=3D mt5824-evb.dtb
> diff --git a/arch/riscv/boot/dts/metanoia/mt2824.dtsi b/arch/riscv/boot/d=
ts/metanoia/mt2824.dtsi
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
> +	#address-cells =3D <0x02>;
> +	#size-cells =3D <0x02>;
> +	compatible =3D "metanoia,mt2824";
> +
> +	cpus: cpus {
> +		#address-cells =3D <0x01>;
> +		#size-cells =3D <0x00>;

Non-hex here please.

> +		timebase-frequency =3D <20000000>;
> +
> +		cpu0: cpu@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0x00>;

0x0 etc

> +			compatible =3D "andestech,ax45mp", "riscv";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm", "xandespmu";
> +			mmu-type =3D "riscv,sv39";
> +			clock-frequency =3D <900000000>;
> +			i-cache-size =3D <0x8000>;
> +			i-cache-sets =3D <0x100>;
> +			i-cache-line-size =3D <0x40>;
> +			i-cache-block-size =3D <0x40>;
> +			d-cache-size =3D <0x8000>;
> +			d-cache-sets =3D <0x80>;
> +			d-cache-line-size =3D <0x40>;
> +			d-cache-block-size =3D <0x40>;
> +			next-level-cache =3D <&l2_cache>;
> +
> +			cpu0intc: interrupt-controller {
> +				#interrupt-cells =3D <0x01>;
> +				interrupt-controller;
> +				compatible =3D "andestech,cpu-intc", "riscv,cpu-intc";
> +			};
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type =3D "cpu";
> +			reg =3D <0x01>;
> +			compatible =3D "andestech,ax45mp", "riscv";
> +			riscv,isa-base =3D "rv64i";
> +			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm", "xandespmu";
> +			mmu-type =3D "riscv,sv39";
> +			clock-frequency =3D <900000000>;
> +			i-cache-size =3D <0x8000>;
> +			i-cache-sets =3D <0x100>;
> +			i-cache-line-size =3D <0x40>;
> +			i-cache-block-size =3D <0x40>;
> +			d-cache-size =3D <0x8000>;
> +			d-cache-sets =3D <0x80>;
> +			d-cache-line-size =3D <0x40>;
> +			d-cache-block-size =3D <0x40>;
> +			next-level-cache =3D <&l2_cache>;
> +
> +			cpu1intc: interrupt-controller {
> +				#interrupt-cells =3D <0x01>;
> +				interrupt-controller;
> +				compatible =3D "andestech,cpu-intc", "riscv,cpu-intc";
> +			};
> +		};
> +	};
> +
> +	clocks {
> +		ext_clk: ext-clk {
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <20000000>;
> +			clock-output-names =3D "ext-clk";
> +		};

Is the frequency here actually set by the soc, or actually by the board?
If it says "ext", I assume it's not part of the soc.

> +
> +		pclk_div4: platform-clock-div4 {
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <225000000>;
> +			clock-output-names =3D "platform-clock-div4";
> +		};
> +
> +		pll_soc_out3: pll-soc-out3 {
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <180000000>;
> +			clock-output-names =3D "pll-soc-out3";
> +		};
> +
> +		usb_otg_ahb_clk: clock-usb-otg-ahb {
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <60000000>;
> +			clock-output-names =3D "otg";
> +		};

I'd much rather this not be merged until things like this are replaced
by an actual clock controller, lest it appear in u-boot etc and then
have the support break because it got swapped out for a clock
controller.

> +	};
> +
> +	soc: soc {
> +		#address-cells =3D <0x02>;
> +		#size-cells =3D <0x02>;
> +		compatible =3D "simple-bus";
> +		interrupt-parent =3D <&plic>;
> +		ranges;
> +
> +		usb0: usb@4000000 {
> +			compatible =3D "metanoia,mt2824-usb", "snps,dwc2";
> +			reg =3D <0x0 0x04000000 0x0 0x100000>;
> +			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&usb_otg_ahb_clk>;
> +			clock-names =3D "otg";
> +			dr_mode =3D "host";
> +			resets =3D <&rst 19>, <&rst 20>;
> +			reset-names =3D "dwc2", "dwc2-ecc";
> +			phys =3D <&usb2phy>;
> +			phy-names =3D "usb2-phy";
> +			hnp-disable;
> +			srp-disable;
> +			disable-over-current;
> +			status =3D "disabled";
> +		};
> +
> +		mmcsd: mmc@4100000 {
> +			compatible =3D "metanoia,mt2824-dwcmshc";
> +			clocks =3D <&pll_soc_out3>;
> +			clock-names =3D "core";
> +			reg =3D <0x0 0x04100000 0x0 0x00100000>;

ordering should be compatible -> reg

> +			interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		l2_cache: cache-controller@a000000 {
> +			compatible =3D "metanoia,mt2824-ax45mp-cache",
> +				     "andestech,ax45mp-cache", "cache";
> +			reg =3D <0x0 0x0a000000 0x0 0x40000>;
> +			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
> +			cache-line-size =3D <64>;
> +			cache-level =3D <2>;
> +			cache-sets =3D <1024>;
> +			cache-size =3D <0x40000>;
> +			cache-unified;
> +		};
> +
> +		plic: interrupt-controller@c000000 {
> +			compatible =3D "metanoia,mt2824-plic", "andestech,nceplic100";
> +			reg =3D <0x0 0x0c000000 0x0 0x400000>;
> +			interrupts-extended =3D <&cpu0intc 0x0b>, <&cpu0intc 0x09>,
> +					      <&cpu1intc 0x0b>, <&cpu1intc 0x09>;
> +			interrupt-controller;
> +			#address-cells =3D <0x00>;
> +			#interrupt-cells =3D <0x02>;
> +			riscv,ndev =3D <0x47>;
> +		};
> +
> +		plmt: timer@c400000 {
> +			compatible =3D "metanoia,mt2824-plmt", "andestech,plmt0";
> +			reg =3D <0x0 0x0c400000 0x0 0x00400000>;
> +			interrupts-extended =3D <&cpu0intc 0x07>,
> +					      <&cpu1intc 0x07>;
> +		};
> +
> +		plicsw: interrupt-controller@c800000 {
> +			compatible =3D "metanoia,mt2824-plicsw", "andestech,plicsw";
> +			reg =3D <0x0 0x0c800000 0x0 0x400000>;
> +			interrupts-extended =3D <&cpu0intc 0x03>,
> +					      <&cpu1intc 0x03>;
> +		};
> +

> +		reboot: reboot@10000004 {
> +			compatible =3D "metanoia,mt2824-reboot";
> +			reg =3D <0x0 0x10000004 0x0 0x08>;
> +		};
> +
> +		rst: reset-controller@1000000c {
> +			#reset-cells =3D <1>;
> +			compatible =3D "metanoia,mt2824-reset";
> +			reg =3D <0x0 0x1000000c 0x0 0x04>;
> +		};

As pointed out, these are probably part of a syscon that I would imagine
also includes some clocks or other features.

By and large I think this is fine though..

Thanks,
Conor.

> +
> +		watchdog: watchdog@10090000 {
> +			compatible =3D "metanoia,mt2824-wdt", "andestech,ae350-wdt";
> +			reg =3D <0x0 0x10090000 0x0 0x10000>;
> +			clocks =3D <&ext_clk>;
> +			andestech,clock-source =3D <0>;
> +			timeout-sec =3D <10>;
> +			status =3D "disabled";
> +		};
> +
> +		serial0: serial@100e0000 {
> +			compatible =3D "ns16550a";
> +			reg =3D <0x0 0x100e0000 0x0 0x1000>;
> +			interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&pclk_div4>;
> +			current-speed =3D <115200>;
> +			reg-shift =3D <0x02>;
> +			reg-offset =3D <0x20>;
> +			reg-io-width =3D <0x04>;
> +			no-loopback-test;
> +			status =3D "disabled";
> +		};
> +
> +		serial1: serial@100f0000 {
> +			compatible =3D "ns16550a";
> +			reg =3D <0x0 0x100f0000 0x0 0x1000>;
> +			interrupts =3D <18 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&pclk_div4>;
> +			current-speed =3D <115200>;
> +			reg-shift =3D <0x02>;
> +			reg-offset =3D <0x20>;
> +			reg-io-width =3D <0x04>;
> +			no-loopback-test;
> +			status =3D "disabled";
> +		};
> +
> +		qspi: spi@10120000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10120000 0x0 0x10000>;
> +			interrupts =3D <13 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi0: spi@10130000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10130000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi1: spi@10140000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10140000 0x0 0x10000>;
> +			interrupts =3D <19 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi2: spi@10150000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10150000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi3: spi@10160000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10160000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi4: spi@10170000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10170000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi5: spi@10180000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10180000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi6: spi@10190000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x10190000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +
> +		spi7: spi@101a0000 {
> +			compatible =3D "metanoia,mt2824-spi", "andestech,ae350-spi";
> +			reg =3D <0x0 0x101a0000 0x0 0x10000>;
> +			#address-cells =3D <0x01>;
> +			#size-cells =3D <0x00>;
> +			num-cs =3D <0x01>;
> +			clocks =3D <&pll_soc_out3>;
> +			status =3D "disabled";
> +		};
> +	};
> +
> +	usb2phy: usb2-phy {
> +		compatible =3D "metanoia,mt2824-usb2-phy";
> +		#phy-cells =3D <0>;
> +		resets =3D <&rst 18>;
> +		reset-names =3D "usb2-phy";
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <0x2>;
> +		#size-cells =3D <0x2>;
> +		ranges;
> +
> +		/* for the DSPs, configured as non-cacheable in openSBI */
> +		rsc_table: rsc-table@81000000 {
> +			reg =3D <0x0 0x81000000 0x0 0x10000>;
> +			no-map;
> +		};
> +	};
> +};
> diff --git a/arch/riscv/boot/dts/metanoia/mt5824-evb.dts b/arch/riscv/boo=
t/dts/metanoia/mt5824-evb.dts
> new file mode 100644
> index 000000000000..d0e8eb0a49a4
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/mt5824-evb.dts
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "mt2824.dtsi"
> +
> +/ {
> +	model =3D "Metanoia MT5824 EVB";
> +	compatible =3D "metanoia,mt5824-evb", "metanoia,mt2824";
> +
> +	aliases {
> +		uart0 =3D &serial0;
> +		uart1 =3D &serial1;
> +		spi0 =3D &spi0;
> +		spi1 =3D &spi1;
> +		spi2 =3D &spi2;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "uart0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x80000000 0x0 0x80000000>,
> +		      <0x1 0x00000000 0x0 0x80000000>;
> +	};
> +};
> +
> +&usb0 {
> +	status =3D "okay";
> +};
> +
> +&mmcsd {
> +	bus-width =3D <8>;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	no-sdio;
> +	disable-wp;
> +	cap-mmc-hw-reset;
> +	status =3D "okay";
> +};
> +
> +&watchdog {
> +	status =3D "okay";
> +};
> +
> +&serial0 {
> +	status =3D "okay";
> +};
> +
> +&serial1 {
> +	status =3D "okay";
> +};
> +
> +&qspi {
> +	status =3D "okay";
> +	flash@0 {
> +		compatible =3D "jedec,spi-nor";
> +		spi-rx-bus-width =3D <0x4>;
> +		spi-tx-bus-width =3D <0x4>;
> +		spi-max-frequency =3D <100000000>;
> +		reg =3D <0x0>;
> +	};
> +};
> +
> +&spi0 {
> +	status =3D "okay";
> +};
> +
> +&spi1 {
> +	status =3D "okay";
> +};
> +
> +&spi2 {
> +	status =3D "okay";
> +};
>=20
> --=20
> 2.56.0
>=20

--gVj6kT/nEeV7IrJz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4cxgAKCRB4tDGHoIJi
0owRAP95exaOo/pmlWS1vJaLTUgL7WEsc8vCXRQ+o6aUNvXW3wEA5DDwcNTzyqSd
KtDAtgukopwz3ahW3I8SJ/bIZDQyMww=
=r1sH
-----END PGP SIGNATURE-----

--gVj6kT/nEeV7IrJz--
