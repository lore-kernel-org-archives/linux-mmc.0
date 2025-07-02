Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728C26E173;
	Wed,  2 Jul 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458523; cv=none; b=cMHYUVrWTDUjqVBqwdHH4JvaNQIcZ/PqSSaCDdNjTIzOxcDnAmsx7P9X4zwzQOyduUC7xDY9ixXX4dFKw+Oc6s8VKUY3Of9J9DunK8kyMson8OQN44RO/862AW3cjjWz1F5q9RBoCO7SoJGMmtCyrqspujaOOD2nkqQUvVafMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458523; c=relaxed/simple;
	bh=i2lOKI0qOB5KxI2VHSRVdByaSAIoK6aaq3MNFlB5CtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHGJaVWXrIKALZd4iYe7LpUUkPN2aDJjqfnYK1RrSgJo+D12uRlpu19QKKnEcYfPFibRkTQknOLdqdfR6nJ5FhOFjlZqCjEAWPlZdztailHN3/iuOlZ2RusOmFW+yCtIbZ5Uo+wfrzQCXtOyUiikXZmnhrHCa5EYygM/GMKdkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA6722D9;
	Wed,  2 Jul 2025 05:15:04 -0700 (PDT)
Received: from [10.1.27.90] (010265703453.arm.com [10.1.27.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E7D3F58B;
	Wed,  2 Jul 2025 05:15:15 -0700 (PDT)
Message-ID: <b287de09-223c-4916-8ea1-ab474df407ef@arm.com>
Date: Wed, 2 Jul 2025 13:15:13 +0100
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
 krzk+dt@kernel.org, krzk@kernel.org, conor+dt@kernel.org, gordon.ge@bst.ai,
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250702094444.3523973-7-yangzh0906@thundersoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-02 10:44 am, Albert Yang wrote:
[...]
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
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		always-on;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;

Your PPIs target 8 of the 4 CPUS? Either way you don't have GICv2, 
please use the GICv3 binding.

> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x0 0xffffffff 0xffffffff>;
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

Given the funky DMA setup, I can't help be mildly suspicious of this - 
is the device genuinely I/O coherent and capable of snooping the CPU 
caches, or are you only getting away with it because 
dma_init_coherent_memory() happens to remap as non-cacheable regardless?

Thanks,
Robin.

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
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +};
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 897fc686e6a9..0a1cfaa19688 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -45,6 +45,7 @@ CONFIG_ARCH_BCMBCA=y
>   CONFIG_ARCH_BRCMSTB=y
>   CONFIG_ARCH_BERLIN=y
>   CONFIG_ARCH_BLAIZE=y
> +CONFIG_ARCH_BST=y
>   CONFIG_ARCH_EXYNOS=y
>   CONFIG_ARCH_SPARX5=y
>   CONFIG_ARCH_K3=y

