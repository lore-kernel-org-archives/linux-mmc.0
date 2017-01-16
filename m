From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v3 8/13] arm64: allwinner: a64: Add MMC nodes
Date: Mon, 16 Jan 2017 20:16:41 +0100
Message-ID: <20170116191641.GA11718@Red>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <ac77b9e25e7633886822cd1f1ebafd5985751ae4.1484585798.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ac77b9e25e7633886822cd1f1ebafd5985751ae4.1484585798.git-series.maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 16, 2017 at 05:56:58PM +0100, Maxime Ripard wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> The A64 has 3 MMC controllers, one of them being especially targeted to
> eMMC. Among other things, it has a data strobe signal and a 8 bits data
> width.
> 
> The two other are more usual controllers that will have a 4 bits width at
> most and no data strobe signal, which limits it to more usual SD or MMC
> peripherals.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 ++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 99b6bb1e141c..143e9706438f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -299,6 +299,45 @@
>  			#size-cells = <0>;
>  		};
>  
> +		mmc0: mmc@1c0f000 {
> +			compatible = "allwinner,sun50i-a64-mmc";
> +			reg = <0x01c0f000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc1: mmc@1c10000 {
> +			compatible = "allwinner,sun50i-a64-mmc";
> +			reg = <0x01c10000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC1>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		mmc2: mmc@1c11000 {
> +			compatible = "allwinner,sun50i-a64-emmc";
> +			reg = <0x01c11000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC2>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		gic: interrupt-controller@1c81000 {
>  			compatible = "arm,gic-400";
>  			reg = <0x01c81000 0x1000>,

Hello

It seems that mmc node is after i2c@1c2b400 so not in address order.

Regards
Corentin Labbe
