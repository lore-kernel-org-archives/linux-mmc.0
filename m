Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC022D8766;
	Tue, 12 Aug 2025 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015375; cv=none; b=vCKnv/YBDs0EncEKrfFKUWIWazX7BSN9zhqsOZtT9TFgay1HPcpQj1vUCdkpPsmmPB2WcFfI3tY8/S0LUb6G91z5JAIJ+PMpRANOFgZNyKZvhB5ecSyISkT14erHdUaAsioqth8TBqxiLulfWOYCV9ceiqIMPDijVX3HyA6EUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015375; c=relaxed/simple;
	bh=5CKZtbCtMZFmUKuvkywo2ShWr2yG0izXiueBW8zdot8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxgNYYdSIGAtU9Uc3VvEB6lCJS7VL+yK52ZlMb/daSwE5wb3JT5+Ia9n9fTyvR2qjhFRUrp6itxkSoniei8adPIqRfO/lyiGYWz3hnABchdACAgoj14ct6yKfTaR4KQCWIZHHhJ1ETG4io5tQgcHi0S/ZWHyplbl3zyCtfRKfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJXUCF1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJXUCF1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB286C4CEF1;
	Tue, 12 Aug 2025 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015374;
	bh=5CKZtbCtMZFmUKuvkywo2ShWr2yG0izXiueBW8zdot8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uJXUCF1Pd183MassaFQFNS6xvCuyis3KhrpZL7VYLUs/Jl6vz3RUcY+2JA7K/Vb3a
	 6kOOsQJOxLOQGGM1fVGwQgOWviWba/uXzIH59Rdq7ZK3pfZPo0hL/B/C0KOA8+CFAN
	 89KkofycVAs5V5fVArLUTlYqPNMxesnp15bFoef55eOtT4kt9xOIpctqAGZ108r+qK
	 KsTT4wdAnGE+8018sP9Fje4PRHcyAZ1hGRx11GCcSqXoyOEUimAHMOKZ/dAWw48Paq
	 QD9F3MLjoSiSErEGwXoWKPF43jpPde4CTD5e7YxnlhQDr3b3RzO0nANmBbPJu5FTBk
	 nqmDhPXosfqBA==
Message-ID: <ce1285be-5a3f-4d4b-bca1-e31f56573597@kernel.org>
Date: Tue, 12 Aug 2025 18:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] arm64: dts: bst: add support for Black Sesame
 Technologies C1200 CDCU1.0 board
To: Albert Yang <yangzh0906@thundersoft.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulf.hansson@linaro.org,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 adrian.hunter@intel.com, robin.murphy@arm.com, ding.wang@bst.ai,
 gordon.ge@bst.ai
Cc: bst-upstream@bstai.top, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, soc@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
 <20250812123110.2090460-7-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250812123110.2090460-7-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2025 14:31, Albert Yang wrote:
> Add device tree support for the Black Sesame Technologies (BST) C1200
> CDCU1.0 ADAS 4C2G platform. This platform is based on the BST C1200 SoC
> family.
> 
> The changes include:
> - Adding a new BST device tree directory
> - Adding Makefile entries to build the BST platform device trees
> - Adding the device tree for the BST C1200 CDCU1.0 ADAS 4C2G board
> 
> This board features a quad-core Cortex-A78 CPU, and various peripherals
> including UART, MMC, watchdog timer, and interrupt controller.
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> ---
> Changes for v3:
> - Split defconfig enablement out into a dedicated defconfig patch
> - Refine memory description: consolidate ranges in memory node and
>   delele unused memory ranges
> - Adjust the order of nodes
> - remove mask of gic
> 
> Changes for v2:
> 1. Reorganized memory map into discrete regions
> 2. Updated MMC controller definition:
>    - Split into core/CRM register regions
>    - Removed deprecated properties
>    - Updated compatible string
> 3. Standardized interrupt definitions and numeric formats
> 4. Removed reserved-memory node (superseded by bounce buffers)
> 5. Added root compatible string for platform identification
> 6. Add soc defconfig
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/bst/Makefile              |   2 +
>  .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  42 +++++++
>  arch/arm64/boot/dts/bst/bstc1200.dtsi         | 117 ++++++++++++++++++
>  4 files changed, 162 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/bst/Makefile
>  create mode 100644 arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
>  create mode 100644 arch/arm64/boot/dts/bst/bstc1200.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 79b73a21ddc2..a39b6cafb644 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -12,6 +12,7 @@ subdir-y += arm
>  subdir-y += bitmain
>  subdir-y += blaize
>  subdir-y += broadcom
> +subdir-y += bst
>  subdir-y += cavium
>  subdir-y += exynos
>  subdir-y += freescale
> diff --git a/arch/arm64/boot/dts/bst/Makefile b/arch/arm64/boot/dts/bst/Makefile
> new file mode 100644
> index 000000000000..4c1b8b4cdad8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/bst/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_BST) += bstc1200-cdcu1.0-adas_4c2g.dtb
> diff --git a/arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts b/arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
> new file mode 100644
> index 000000000000..d8fb07b0bc80
> --- /dev/null
> +++ b/arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "bstc1200.dtsi"
> +
> +/ {
> +	model = "BST C1200-96 CDCU1.0 4C2G";
> +	compatible = "bst,c1200-cdcu1.0-adas-4c2g", "bst,c1200";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@810000000 {
> +		device_type = "memory";
> +		reg = <0x8 0x10000000 0x0 0x30000000>,
> +		      <0x8 0xc0000000 0x1 0x0>,
> +		      <0xc 0x00000000 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		mmc0_reserved: mmc0-reserved@5160000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x5160000 0x0 0x10000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&mmc0 {

This is none of the two approved ordering styles from DTS coding style.
What sort of coding style are you using?

> +	status = "okay";
> +	memory-region = <&mmc0_reserved>;
> +};
> +
> diff --git a/arch/arm64/boot/dts/bst/bstc1200.dtsi b/arch/arm64/boot/dts/bst/bstc1200.dtsi
> new file mode 100644
> index 000000000000..5e9ca0ee17cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/bst/bstc1200.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "bst,c1200";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clk_mmc: clock-4000000 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <4000000>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a78";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_cache>;
> +			reg = <0>;

0x0

And why reg is the last? Please follow DTS coding style.

I already asked for this at v1. How did you resolve that comment?

Then I asked about this at v2:

"Nothing improved. I asked to follow DTS coding style in ordering."

So can you please respond to comments? You keep sending the same - third
time - and this is waste of our time.

> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a78";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_cache>;
> +			reg = <0x100>;
> +		};
> +
> +		cpu@2 {
> +			compatible = "arm,cortex-a78";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_cache>;
> +			reg = <0x200>;
> +		};
> +
> +		cpu@3 {
> +			compatible = "arm,cortex-a78";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_cache>;
> +			reg = <0x300>;
> +		};
> +
> +		l2_cache: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		interrupt-parent = <&gic>;
> +
> +		uart0: serial@20008000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x20008000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <25000000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@22200000 {
> +			compatible = "bst,c1200-dwcmshc-sdhci";
> +			reg = <0x0 0x22200000 0x0 0x1000>,
> +			      <0x0 0x23006000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk_mmc>;
> +			clock-names = "core";
> +			max-frequency = <200000000>;
> +			bus-width = <8>;
> +			non-removable;

Hm, this is odd to see in SoC. Are you saying that your SoC (!) has MMC
memory embedded?

> +			dma-coherent;
> +			status = "disabled";

If so, why is it disabled?

> +		};
> +
> +		gic: interrupt-controller@32800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-controller;
> +			ranges;
> +			reg = <0x0 0x32800000 0x0 0x10000>,
> +			      <0x0 0x32880000 0x0 0x100000>;

Random order...
Best regards,
Krzysztof

