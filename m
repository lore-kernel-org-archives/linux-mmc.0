From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 28 Oct 2013 01:29:03 -0500
Message-ID: <0D287D95-C302-4A59-98AC-C654F5AC97B4@codeaurora.org>
References: <1382339639-16764-3-git-send-email-zhangfei.gao@linaro.org> <1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:58199 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab3J1G3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 02:29:07 -0400
In-Reply-To: <1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


On Oct 23, 2013, at 8:03 AM, Zhangfei Gao wrote:

> update: fix typo
> 
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
> .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   77 +++++
> drivers/mmc/host/Kconfig                           |   10 +
> drivers/mmc/host/Makefile                          |    1 +
> drivers/mmc/host/dw_mmc-k3.c                       |  297 ++++++++++++++++++++
> 4 files changed, 385 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> create mode 100644 drivers/mmc/host/dw_mmc-k3.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> new file mode 100644
> index 0000000..0de8c27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -0,0 +1,77 @@
> +* Hisilicon specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +Read synopsis-dw-mshc.txt for more details
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsis-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "hisilicon,hi4511-dw-mshc": for controllers with hi4511
> +	  specific extentions.
> +* vmmc-supply: should be vmmc used in dwmmc
> +* fifo-depth: should be provided if register can not provide correct value
> +* clken-reg: should be clock enable register and offset
> +* drv-sel-reg: should be driver delay select register, offset and bits
> +* sam-sel-reg: should be sample delay select register, offset and bits
> +* div-reg: should be divider register, offset and bits
> +* tune-table: should be array of clock tune mmc controller
> +

1. These should have vendor prefixes
2. why do we need the *-reg properties
3. for the *-reg properties its not clear what bits means?
4. tune-table is not well described, what does 'clock tune' mean, why an array?


> +Example:
> +
> +  The MSHC controller node can be split into two portions, SoC specific and
> +  board specific portions as listed below.
> +

Does dtc merge this all into a single node?  Would probably be good to have comments
in the example stating both that the merge into one node, and which is board and which
is soc.

> +	dwmmc_0: dwmmc0@fcd03000 {
> +		compatible = "hisilicon,hi4511-dw-mshc";
> +		reg = <0xfcd03000 0x1000>;
> +		interrupts = <0 16 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clk_sd>, <&clk_ddrc_per>;
> +		clock-names = "ciu", "biu";
> +		clken-reg = <0x1f8 0>;
> +		drv-sel-reg = <0x1f8 4 4>;
> +		sam-sel-reg = <0x1f8 8 4>;
> +		div-reg = <0x1f8 1 3>;
> +		tune-table =
> +		<180000000 6 6 13 13 25000000>,
> +		<0 0 0 0 0 0>,
> +		<360000000 6 4 2 0 50000000>,
> +		<180000000 6 4 13 13 25000000>,
> +		<360000000 6 4 2 0 50000000>,
> +		<720000000 6 1 9 4 100000000>,
> +		<0 0 0 0 0 0>,
> +		<360000000 7 1 3 0 50000000>;
> +	};
> +	dwmmc0@fcd03000 {
> +		num-slots = <1>;
> +		vmmc-supply = <&ldo12>;
> +		fifo-depth = <0x100>;
> +		supports-highspeed;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +			disable-wp;
> +			cd-gpios = <&gpio10 3 0>;
> +		};
> +	};
> +
> +PCTRL:
> +

should have a description

> +Required Properties:
> +* compatible: should be
> +	- "hisilicon,pctrl": Peripheral control
> +

Reg is not described as a required property.

> +Example:
> +
> +	pctrl: pctrl@fca09000 {
> +		compatible = "hisilicon,pctrl";
> +		reg = <0xfca09000 0x1000>;
> +	};

This should be in its own binding document, and not part of the mmc binding

- k
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

