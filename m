Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AE238C0C;
	Wed,  2 Jul 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452250; cv=none; b=uGCOPr/JY0NhIo6AUED8sj8GFMYf6D7GcKt1cqAZGYbJAF+E1byMltX1Ri3MeLlHemp4VYlj8G3BjDPAJyrg6fx8LlATsLOL0Osvb9607cwOMGdCj0HbIXvvOABB1URB+pQLmv0BruyJigKSy2XS4KY0HAaUyT13HA0/EFvQ2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452250; c=relaxed/simple;
	bh=mDp3jgvgSjrH7XdapPjK1I4S+fk4WAUCQ1t47z0AAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPPFxH4fDtqqnjpm4jSFVhzt+y3wOWbIlLrEl2s3BpFP08qBrFq1OdNXHktkGWw5ANLJghn3x5TguzVjg+wdtbQndnQiVQ7v89/vAbJqkFida9QTAb7LdeMumM0AvHUcmUFlh2TFgxCNVHWftOZBon9OtGct6fhmxZfqY463GsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNCQcsb0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNCQcsb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84933C4CEED;
	Wed,  2 Jul 2025 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751452249;
	bh=mDp3jgvgSjrH7XdapPjK1I4S+fk4WAUCQ1t47z0AAfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mNCQcsb00Z8hHxMlxpgaTfQHxNRN6CxQshE5VINtS7FdORNdXH2urmRJip27BoLjH
	 1XRO9WPRRhUlaBQB78By5E5y6WE/BJ3pK7TegOingtDLSXeK9bt5iN2zpf0SjTQFmF
	 XFU1f0pzTEm06VQD6XNRp+z0hf1SBwyNDYMGncizLVDSiiao4kAf4Y2Yzy4Ab+DQeH
	 Bqqyf627q9BK236mNLmDgFbQeN/zdy747C6F8SO0KUPkhwQLJhAN1Xp8QiOThJ88Pb
	 J46y6v9UHsSny920S5KziwXEvTZHvuTrDiBBBwEsauQW86Y7rqO7DgRNpRO0ppnu1q
	 a1vfRH3/LSnGA==
Message-ID: <a570b833-0619-4d1a-909f-971ba08f4202@kernel.org>
Date: Wed, 2 Jul 2025 12:30:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: bst: add support for Black Sesame
 Technologies C1200 CDCU1.0 board and defconfig
To: Albert Yang <yangzh0906@thundersoft.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, gordon.ge@bst.ai,
 catalin.marinas@arm.com, geert.uytterhoeven@gmail.com, will@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, soc@lists.linux.dev,
 bst-upstream@bstai.top, neil.armstrong@linaro.org,
 jonathan.cameron@huawei.com, bigfoot@classfun.cn, kever.yang@rock-chips.com,
 mani@kernel.org, geert+renesas@glider.be, andersson@kernel.org, nm@ti.com,
 nfraprado@collabora.com, quic_tdas@quicinc.com, ebiggers@google.com,
 victor.shih@genesyslogic.com.tw, shanchun1218@gmail.com,
 ben.chuang@genesyslogic.com.tw
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-7-yangzh0906@thundersoft.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250702094444.3523973-7-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2025 11:44, Albert Yang wrote:
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
> ---
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
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

This is messed. SoB does not go to changelog. Apply your patch and look
at result - do you see SoB? No, because changelog is stripped.
submitting patches explains how this is supposed to look like.

> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/bst/Makefile              |   2 +
>  .../dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts    |  60 +++++++++
>  arch/arm64/boot/dts/bst/bstc1200.dtsi         | 117 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  5 files changed, 181 insertions(+)
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
> index 000000000000..4036e0ac2e1d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/bst/bstc1200-cdcu1.0-adas_4c2g.dts
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include "bstc1200.dtsi"
> +
> +/ {
> +	model = "BST C1200-96 CDCU1.0 4C2G";
> +	compatible = "bst,c1200-cdcu1.0-adas-4c2g", "bst,c1200";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@810000000 {
> +		device_type = "memory";
> +		reg = <0x8 0x10000000 0x0 0x30000000>;
> +	};
> +
> +	memory@8c0000000 {
> +		device_type = "memory";
> +		reg = <0x8 0xc0000000 0x1 0x0>;
> +	};
> +
> +	memory@c00000000 {
> +		device_type = "memory";
> +		reg = <0xc 0x0 0x0 0x40000000>;
> +	};
> +
> +	memory@800254000 {
> +		device_type = "memory";
> +		reg = <0x8 0x254000 0x0 0x1000>;
> +	};
> +
> +	memory@800151000 {
> +		device_type = "memory";
> +		reg = <0x8 0x151000 0x0 0x1000>;
> +	};

Why do you have multiple memory nodes, not one?

Also, why aren't these sorted according to DTS coding style?

> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		mmc0_reserved: mmc0@5160000 {
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
> +	status = "okay";
> +	memory-region = <&mmc0_reserved>;
> +};
> +
> diff --git a/arch/arm64/boot/dts/bst/bstc1200.dtsi b/arch/arm64/boot/dts/bst/bstc1200.dtsi
> new file mode 100644
> index 000000000000..ddff2cb82cb0
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
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a78";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			next-level-cache = <&l2_cache>;
> +			reg = <0x100>;

Nothing improved. I asked to follow DTS coding style in ordering.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

You already got this comment. How did you resolve it? You never
responded to comments, so does it mean you just ignored it or something
was not clear? In any case, repeating the same mistake is not getting
this code merged, so respond to comment.

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
> +		l2_cache: l2-cache-1 {

l2-cache. Otherwise it is incomplete, so add the second one.

> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	clk_mmc: clock-4000000 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <4000000>;
> +	};
> +
> +	timer {

t > s

> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		always-on;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x0 0xffffffff 0xffffffff>;


Nothing improved. I asked to follow DTS coding style in ordering.


> +		interrupt-parent = <&gic>;
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
> +			dma-coherent;
> +			status = "disabled";
> +		};
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
> +		gic: interrupt-controller@32800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-controller;
> +			ranges;
> +			reg = <0x0 0x32800000 0x0 0x10000>,
> +			      <0x0 0x32880000 0x0 0x100000>;

Nothing improved. I asked to follow DTS coding style in ordering.

> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +	};
> +
> +	psci {

p < s, it is really randomly put :/


> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +};
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 897fc686e6a9..0a1cfaa19688 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig

This is not a DTS patch.

> @@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
>  CONFIG_ARCH_BRCMSTB=y
>  CONFIG_ARCH_BERLIN=y
>  CONFIG_ARCH_BLAIZE=y
> +CONFIG_ARCH_BST=y
>  CONFIG_ARCH_EXYNOS=y
>  CONFIG_ARCH_SPARX5=y
>  CONFIG_ARCH_K3=y

Best regards,
Krzysztof

