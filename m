From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Fri, 9 Dec 2016 15:47:20 -0600
Message-ID: <20161209214720.lymj7dfadksleryr@rob-hp-laptop>
References: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
 <1480904976-7081-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35529 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbcLIVrW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2016 16:47:22 -0500
Content-Disposition: inline
In-Reply-To: <1480904976-7081-2-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org

On Mon, Dec 05, 2016 at 10:29:32AM +0800, Jun Nie wrote:
> Document the device-tree binding of ZTE MMC host on
> ZX296718 SoC.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> new file mode 100644
> index 0000000..c175c4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> @@ -0,0 +1,35 @@
> +* ZTE specific extensions to the Synopsys Designware Mobile Storage
> +  Host Controller
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the ZTE specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "zte,zx296718-dw-mshc": for ZX SoCs
> +
> +Example:
> +
> +	mmc1: mmc@1110000 {
> +		compatible = "zte,zx296718-dw-mshc";

> +		#address-cells = <1>;
> +		#size-cells = <0>;

These aren't needed unless you have child nodes with reg property. The 
DW binding says you should have at least one child.

> +		reg = <0x01110000 0x1000>;
> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +		fifo-depth = <32>;
> +		data-addr = <0x200>;
> +		fifo-watermark-aligned;

Custom properties should have vendor prefix.

> +		bus-width = <4>;
> +		clock-frequency = <50000000>;
> +		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
> +		clock-names = "biu", "ciu";
> +		num-slots = <1>;
> +		max-frequency = <50000000>;
> +		cap-sdio-irq;
> +		cap-sd-highspeed;
> +		status = "disabled";
> +	};
> -- 
> 1.9.1
> 
