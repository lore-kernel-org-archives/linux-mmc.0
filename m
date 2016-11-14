From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Mon, 14 Nov 2016 15:58:51 +0800
Message-ID: <b72dcd9c-aa90-a487-dbfb-6682fcdf015b@rock-chips.com>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
 <1478568298-18380-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:41273 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754158AbcKNH7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 02:59:08 -0500
In-Reply-To: <1478568298-18380-2-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org

On 2016/11/8 9:24, Jun Nie wrote:
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
> +		reg = <0x01110000 0x1000>;
> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +		fifo-depth = <32>;
> +		data-addr = <0x200>;
> +		fifo-watermark-aligned;
> +		bus-width = <4>;
> +		clock-frequency = <50000000>;

do you need both clock-frequency and max-frequency here?

> +		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
> +		clock-names = "biu", "ciu";
> +		num-slots = <1>;
> +		max-frequency = <50000000>;
> +		cap-sdio-irq;
> +		cap-sd-highspeed;
> +		status = "disabled";
> +	};
>


-- 
Best Regards
Shawn Lin

