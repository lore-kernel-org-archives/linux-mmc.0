From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Fri, 04 Nov 2016 19:24:05 +0900
Message-ID: <dc78377a-c63b-29d7-cd36-c01bffc4a410@samsung.com>
References: <1478179901-25645-1-git-send-email-jun.nie@linaro.org>
 <CGME20161103133219epcas3p41740ee469f97b36f49d31d31f6332d19@epcas3p4.samsung.com>
 <1478179901-25645-2-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52726 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbcKDKYH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:24:07 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OG401R444W4R390@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Nov 2016 19:24:05 +0900 (KST)
In-reply-to: <1478179901-25645-2-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jason.liu@linaro.org, linux-mmc@vger.kernel.org

On 11/03/2016 10:31 PM, Jun Nie wrote:
> Document the device-tree binding of ZTE MMC host on
> ZX296718 SoC.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> new file mode 100644
> index 0000000..5e1e16d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
> @@ -0,0 +1,34 @@
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
> +		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
> +		clock-names = "biu", "ciu";
> +		num-slots = <1>;
> +		max-frequency = <50000000>;
> +		cap-sdio-irq;
> +		cap-sd-highspeed;
> +		status = "disabled";

bracket is not pair?
Other things look good to me.

Best Regards,
Jaehoon Chung

> 

