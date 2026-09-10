Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172431F9B4;
	Thu, 10 Sep 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078699; cv=none; b=jdeYQmR9EYR9mmfOxeHz9gE7kn+pfZac9ut9Sq0czIVIPuCW06KPKa8GUZ8Frb/YvjkjPUwbWR8ImxgR/bVBdDL3D7FRYRAXtzfc4/GnM9gV1j/5C3tbMNWnA25qbUYdDtTy9wLBji0zPjbaBv5WeUtZtSKQTTvyw/fvfZPAKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078699; c=relaxed/simple;
	bh=7wVWwurN/h0UfK56gPZolyDAb0z3FbgclCmbEZseAEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ5zC5uN93ljEEI8DiBVObqhxDLbUKFo4OuDvYIR2Q8MiJCXJGR0OE/b5d1FClmPtbNqFKxnAznrQfpaxIKu3CqBj7nPqoB6lJIwK6wjDt3G/kV8tqlXgX5sfw3BPN4303KsqqmxAVU7q0ldkWBighTU/JRFF3j0Q8XYGrnKGy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=onLdeVEJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="onLdeVEJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BDA237B;
	Thu, 10 Sep 2026 15:18:12 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74B8A3F7B4;
	Thu, 10 Sep 2026 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789078696; bh=7wVWwurN/h0UfK56gPZolyDAb0z3FbgclCmbEZseAEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=onLdeVEJh+X78kzwpPJjKiJ+UJ2DE86wjqBwMU4YEDhYM8t9Gpw6YGE/RhQgZuMT2
	 9guKA845RvwrbbFo8k4GhSOzYLWh2YB/pD16ioOzwKMaeugrwTmog3h+OhvwhRkcaa
	 QEp982vU6I4KU+kOO0DpmTqVRvAR6y6Ktc6xQ8nw=
Date: Fri, 11 Sep 2026 00:18:05 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Enzo Adriano via B4 Relay
 <devnull+enzo.adriano.code.gmail.com@kernel.org>
Cc: enzo.adriano.code@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: allwinner: add Allwinner A733 SoC
Message-ID: <20260911001805.0a2e033d@ryzen.lan>
In-Reply-To: <20260613-a733-dts-v1-public-ready-v1-3-7787c94681db@gmail.com>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
	<20260613-a733-dts-v1-public-ready-v1-3-7787c94681db@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 05:42:15 -0400
Enzo Adriano via B4 Relay
<devnull+enzo.adriano.code.gmail.com@kernel.org> wrote:

Hi Enzo,

it seems like it's probably a good time now to send a v2. Branch off at
v7.3-rc1, cherry-pick the DT binding patches for clocks and pinctrl
(plus anything else missing), then put your patches on top.
Verify that with (in the build directory, after "make dtbs"):
$ make W=2 CHECK_DTBS=y allwinner/sun60i-*.dtb

> From: Enzo Adriano <enzo.adriano.code@gmail.com>
> 
> Add the initial A733 SoC description with CPUs, timers, interrupt
> controller, clocks, pinctrl, UART0, and MMC0.

This misses the RTC, support for which has been merged recently.
 
> Keep peripherals disabled by default. Board DTS files can enable only the
> devices that are proven on their hardware.

Not sure we need that needs explicit mentioning, as this is how .dtsi
files work...
 
> Signed-off-by: Enzo Adriano <enzo.adriano.code@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi | 198 +++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
> new file mode 100644
> index 000000000000..3721aa9e8573
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun60i-a733-ccu.h>
> +#include <dt-bindings/reset/sun60i-a733-ccu.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			compatible = "arm,cortex-a55";
> +			device_type = "cpu";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <530>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			compatible = "arm,cortex-a76";
> +			device_type = "cpu";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			compatible = "arm,cortex-a76";
> +			device_type = "cpu";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
> +		};
> +	};
> +
> +	osc24M: osc24M-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc24M";
> +	};
> +
> +	osc32k: osc32k-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		clock-output-names = "osc32k";
> +	};
> +
> +	iosc: internal-osc-clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <16000000>;
> +		clock-output-names = "iosc";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";

No need for arm,psci-1.0. PSCI v0.2 requires a version call.

> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		arm,no-tick-in-suspend;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;

Please add the ARMv8.2 EL2 virtual timer IRQ, see commit
a186a9742dc5d.

> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x40000000>;
> +
> +		pio: pinctrl@2000000 {
> +			compatible = "allwinner,sun60i-a733-pinctrl";
> +			reg = <0x02000000 0x600>;
> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_APB1>, <&osc24M>, <&osc32k>;
> +			clock-names = "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells = <3>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +
> +			mmc0_pins: mmc0-pins {
> +				pins = "PF0", "PF1", "PF2",
> +				       "PF3", "PF4", "PF5";
> +				function = "mmc0";
> +				drive-strength = <30>;
> +				bias-pull-up;

You need an allwinner,pinmux property here.
Also please add the other MMC pins, at least for mmc1 and mmc2.

> +			};
> +		};
> +
> +		ccu: clock-controller@2002000 {
> +			compatible = "allwinner,sun60i-a733-ccu";
> +			reg = <0x02002000 0x2000>;
> +			clocks = <&osc24M>, <&osc32k>, <&iosc>;
> +			clock-names = "hosc", "losc", "iosc";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		uart0: serial@2500000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x02500000 0x400>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			clocks = <&ccu CLK_BUS_UART0>;
> +			resets = <&ccu RST_BUS_UART0>;
> +			status = "disabled";
> +		};

Please add the other UART instances here as well.

> +
> +		gic: interrupt-controller@3400000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x03400000 0x10000>,
> +			      <0x03460000 0x100000>;

Please add the maintenance interrupt here. And do we need
dma-noncoherent, like in the A523?
And isn't there an ITS here to describe?

> +		};
> +
> +		mmc0: mmc@4020000 {
> +			compatible = "allwinner,sun60i-a733-mmc",
> +				     "allwinner,sun20i-d1-mmc";
> +			reg = <0x04020000 0x1000>;
> +			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins>;
> +			max-frequency = <200000000>;
> +			cap-sd-highspeed;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};

Please describe the other MMC controllers here as well. The IP is the
same, so no reason to not add them here.

And what about I2C? We would need that for the AXP PMIC. Having that in
the initial DT is required to keep the DTBs compatible with older/stable
kernels later on.

And it seems like the whole r_ side is missing, even those we should
have bindings for those. At least r_pio and r_ccu would be needed, plus
r_i2c.

Cheers,
Andre

> +	};
> +};
> 

