From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Thu, 22 Dec 2016 11:21:59 +0000
Message-ID: <20161222112159.GY14217@n2100.armlinux.org.uk>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36152 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755467AbcLVLYQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 06:24:16 -0500
Content-Disposition: inline
In-Reply-To: <2564fe18eb9cc8a0a1a3311cdf7e7141f35211bd.1481651244.git-series.gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>

On Tue, Dec 13, 2016 at 06:48:40PM +0100, Gregory CLEMENT wrote:
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 7b6136182ad0..181e8c5de3bf 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -229,6 +229,15 @@
>  
>  			};
>  
> +			ap_sdhci0: sdhci@6e0000 {
> +				compatible = "marvell,armada-7000-sdhci";
> +				reg = <0x6e0000 0x300>;
> +				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cpm_syscon0 1 4>;
> +				status = "disabled";
> +			};
> +
>  			ap_syscon: system-controller@6f4000 {
>  				compatible = "marvell,ap806-system-controller",
>  					     "syscon";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index e5e3ed678b6f..035b2b2fc9ca 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -164,6 +164,16 @@
>  				clocks = <&cpm_syscon0 1 21>;
>  				status = "disabled";
>  			};
> +
> +			cpm_sdhci0: sdhci@780000 {
> +				compatible = "marvell,armada-7000-sdhci";
> +				reg = <0x780000 0x300>;
> +				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "core";
> +				clocks = <&cpm_syscon0 1 4>;
> +				status = "disabled";
> +			};
> +

One other point - aren't the SDHCI interfaces dma-coherent on the AP806
and CP110?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
