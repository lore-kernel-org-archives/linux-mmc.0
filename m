From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add bindings for
 hi3798cv200-dw-mshc
Date: Tue, 24 Oct 2017 13:45:44 -0500
Message-ID: <20171024184543.metbxxzqwoxti3ju@rob-hp-laptop>
References: <1508325388-7260-1-git-send-email-xuejiancheng@hisilicon.com>
 <1508325388-7260-2-git-send-email-xuejiancheng@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508325388-7260-2-git-send-email-xuejiancheng@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiancheng Xue <xuejiancheng@hisilicon.com>
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, project-aspen-dev@linaro.org, hermit.wangheming@hisilicon.com, tianshuliang <tianshuliang@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Oct 18, 2017 at 07:16:27AM -0400, Jiancheng Xue wrote:
> From: tianshuliang <tianshuliang@hisilicon.com>
> 
> Hisilicon hi3798cv200 SoC extends the dw-mshc controller
> for additional clock control. Add device tree bindings for
> hi3798cv200-dw-mshc.
> 
> Signed-off-by: tianshuliang <tianshuliang@hisilicon.com>
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
> new file mode 100644
> index 0000000..845c32c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
> @@ -0,0 +1,51 @@
> +* Hisilicon specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +Read synopsys-dw-mshc.txt for more details
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following.
> +  - "hisilicon,hi3798cv200-dw-mshc": for controllers with hi3798cv200 specific extensions.
> +
> +Optional Properties:
> +* clocks: from common clock binding: if ciu-drive and ciu-sample are
> +  specified in clock-names, should contain handles to these clocks.
> +
> +* clock-names:Apart from the clock-names described in synopsys-dw-mshc.txt

space            ^

> +  two more clocks "ciu-drive" and "ciu-sample" are supported. They are used
> +  to control the clock phases, "ciu-sample" is required for tuning high-speed modes.

wrap your lines.

> +
> +Example:
> +
> +	/* for Hi3798cv200 */
> +
> +	/* SoC portion */
> +	emmc: mmc@9830000 {
> +		compatible = "hisilicon,hi3798cv200-dw-mshc";
> +		reg = <0x9830000 0x10000>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&crg HISTB_MMC_CIU_CLK>,
> +			 <&crg HISTB_MMC_BIU_CLK>,
> +			 <&crg HISTB_MMC_SAMPLE_CLK>;
> +		clock-names = "ciu", "biu", "ciu-sample";
> +	};
> +
> +	/* Board portion */

Don't show the board/soc split in examples.

> +	&emmc {
> +		status = "okay";
> +		num-slots = <1>;
> +		fifo-depth = <256>;
> +		clock-frequency = <200000000>;
> +		cap-mmc-highspeed;
> +		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		non-removable;
> +		bus-width = <8>;
> +	};
> -- 
> 2.7.4
> 
