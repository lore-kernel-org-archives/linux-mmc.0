From: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v5 15/20] arm64: dts: hisi: add kirin pcie node
Date: Fri, 16 Jun 2017 15:43:05 +0100
Message-ID: <5943EE79.1050505@hisilicon.com>
References: <20170615030417.14059-16-guodong.xu@linaro.org>
 <20170616141322.30466-1-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616141322.30466-1-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, arnd@arndb.de, xuejiancheng@hisilicon.com, puck.chen@hisilicon.com
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Xiaowei Song <songxiaowei@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guodong,

On 2017/6/16 15:13, Guodong Xu wrote:
> From: Xiaowei Song <songxiaowei@hisilicon.com>
> 
> Add PCIe node for hi3660
> 
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Changes in v5:
>  * fix interrupt-map, to conform to gic's #address-cells = <0>
>  * remove redundant status = "ok"
> ---

Thanks!
Applied v5 and dropped the v4 in the hisilicon arm64 dt tree.

BR,
Wei


>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 36 +++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index e138973..8183d71 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -754,5 +754,41 @@
>  			cs-gpios = <&gpio18 5 0>;
>  			status = "disabled";
>  		};
> +
> +		pcie@f4000000 {
> +			compatible = "hisilicon,kirin960-pcie";
> +			reg = <0x0 0xf4000000 0x0 0x1000>,
> +			      <0x0 0xff3fe000 0x0 0x1000>,
> +			      <0x0 0xf3f20000 0x0 0x40000>,
> +			      <0x0 0xf5000000 0x0 0x2000>;
> +			reg-names = "dbi", "apb", "phy", "config";
> +			bus-range = <0x0  0x1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges = <0x02000000 0x0 0x00000000
> +				  0x0 0xf6000000
> +				  0x0 0x02000000>;
> +			num-lanes = <1>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0xf800 0 0 7>;
> +			interrupt-map = <0x0 0 0 1
> +					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 2
> +					 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 3
> +					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x0 0 0 4
> +					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +				 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +				 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +				 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +			clock-names = "pcie_phy_ref", "pcie_aux",
> +				      "pcie_apb_phy", "pcie_apb_sys",
> +				      "pcie_aclk";
> +			reset-gpios = <&gpio11 1 0 >;
> +		};
>  	};
>  };
> 
