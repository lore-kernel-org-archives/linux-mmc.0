From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 3/7] arm64: dts: actions: Add MMC controller support
 for S900
Date: Mon, 14 Oct 2019 20:14:32 +0530
Message-ID: <20191014144432.GA8583@mani>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-4-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190916154546.24982-4-manivannan.sadhasivam@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org, sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linus.walleij@linaro.org, linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 16, 2019 at 09:15:42PM +0530, Manivannan Sadhasivam wrote:
> Add MMC controller support for Actions Semi S900 SoC. There are 4 MMC
> controllers in this SoC which can be used for accessing SD/MMC/SDIO cards.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for v5.5.

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/actions/s900.dtsi | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
> index df3a68a3ac97..eb35cf78ab73 100644
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/actions,s900-cmu.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/actions,s900-reset.h>
>  
> @@ -284,5 +285,49 @@
>  			dma-requests = <46>;
>  			clocks = <&cmu CLK_DMAC>;
>  		};
> +
> +		mmc0: mmc@e0330000 {
> +			compatible = "actions,owl-mmc";
> +			reg = <0x0 0xe0330000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD0>;
> +			resets = <&cmu RESET_SD0>;
> +			dmas = <&dma 2>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@e0334000 {
> +			compatible = "actions,owl-mmc";
> +			reg = <0x0 0xe0334000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD1>;
> +			resets = <&cmu RESET_SD1>;
> +			dmas = <&dma 3>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@e0338000 {
> +			compatible = "actions,owl-mmc";
> +			reg = <0x0 0xe0338000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD2>;
> +			resets = <&cmu RESET_SD2>;
> +			dmas = <&dma 4>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc3: mmc@e033c000 {
> +			compatible = "actions,owl-mmc";
> +			reg = <0x0 0xe033c000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD3>;
> +			resets = <&cmu RESET_SD3>;
> +			dmas = <&dma 46>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.17.1
> 
