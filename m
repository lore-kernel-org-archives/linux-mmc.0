From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2 1/4] clk: gcc: Updates for SDHCI enablement
Date: Tue, 17 Jan 2017 15:25:42 -0800
Message-ID: <20170117232542.GV17126@codeaurora.org>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
 <1484614729-26751-2-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484614729-26751-2-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

On 01/16, Jeremy McNicoll wrote:
> Global clock updates to enable onboard SDHCI / MMC.
> Re-tabify dt-bindings to align correctly in vim.

We need much more words here on what's going on in this patch.

> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  drivers/clk/qcom/gcc-msm8994.c               | 108 +++++++++++++++++++++------
>  include/dt-bindings/clock/qcom,gcc-msm8994.h |  32 ++++----
>  2 files changed, 106 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
> index 8afd830..2bf8d1b 100644
> --- a/drivers/clk/qcom/gcc-msm8994.c
> +++ b/drivers/clk/qcom/gcc-msm8994.c
> @@ -24,6 +24,7 @@
>  
>  #include "common.h"
>  #include "clk-regmap.h"
> +#include "clk-pll.h"

Why?

>  #include "clk-alpha-pll.h"
>  #include "clk-rcg.h"
>  #include "clk-branch.h"
> @@ -54,7 +55,7 @@ static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
>  static const char * const gcc_xo_gpll0_gpll4[] = {
>  	"xo",
>  	"gpll0",
> -	"gpll4",
> +	"gpll4_vote",
>  };
>  
>  #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> @@ -97,29 +98,65 @@ static struct clk_alpha_pll_postdiv gpll0 = {
>  	},
>  };
>  
> -static struct clk_alpha_pll gpll4_early = {
> -	.offset = 0x1dc0,
> -	.clkr = {
> -		.enable_reg = 0x1480,
> -		.enable_mask = BIT(4),

This is doing PLL voting.

> -		.hw.init = &(struct clk_init_data)
> -		{
> -			.name = "gpll4_early",
> -			.parent_names = (const char *[]) { "xo" },
> -			.num_parents = 1,
> -			.ops = &clk_alpha_pll_ops,
> -		},
> +
> +static struct clk_rcg2 config_noc_clk_src = {
> +	.cmd_rcgr = 0x0150,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "config_noc_clk_src",
> +		.parent_names = gcc_xo_gpll0,
> +		.num_parents = 2,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 periph_noc_clk_src = {
> +	.cmd_rcgr = 0x0190,
> +	.hid_width = 5,
> +	.mnd_width = 8,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "periph_noc_clk_src",
> +		.parent_names = gcc_xo_gpll0,
> +		.num_parents = 2,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 system_noc_clk_src = {
> +	.cmd_rcgr = 0x0120, //TODO

This is right.

> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.clkr.hw.init = &(struct clk_init_data) {
> +		.name = "system_noc_clk_src",
> +		.parent_names = gcc_xo_gpll0,
> +		.num_parents = 2,
> +		.ops = &clk_rcg2_ops,
>  	},
>  };
>  
> -static struct clk_alpha_pll_postdiv gpll4 = {
> -	.offset = 0x1dc0,
> +static struct clk_pll gpll4 = {

gpll4 is an alpha PLL though.

> +	.status_reg = 0x1dc0,
> +	.status_bit = 30,
>  	.clkr.hw.init = &(struct clk_init_data)
>  	{
>  		.name = "gpll4",
> -		.parent_names = (const char *[]) { "gpll4_early" },
> +		.parent_names = (const char *[]) { "xo" },
>  		.num_parents = 1,
> -		.ops = &clk_alpha_pll_postdiv_ops,
> +		.ops = &clk_pll_ops,
> +	},
> +};
> +
> +static struct clk_regmap gpll4_vote = {
> +	.enable_reg = 0x1480,
> +	.enable_mask = BIT(4),
> +	.hw.init = &(struct clk_init_data)

This part is rather confusing.

> +	{
> +		.name = "gpll4_vote",
> +		.parent_names = (const char *[]) { "gpll4" },
> +		.num_parents = 1,
> +		.ops = &clk_pll_vote_ops,
>  	},
>  };
>  
> @@ -896,8 +933,8 @@ static struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
>  	F(25000000, P_GPLL0, 12, 1, 2),
>  	F(50000000, P_GPLL0, 12, 0, 0),
>  	F(100000000, P_GPLL0, 6, 0, 0),
> -	F(192000000, P_GPLL4, 2, 0, 0),
> -	F(384000000, P_GPLL4, 1, 0, 0),
> +	F(172000000, P_GPLL4, 2, 0, 0),
> +	F(344000000, P_GPLL4, 1, 0, 0),

It seems that gpll4 runs at slightly different speeds on 8994 and
8992. You'll need to differentiate which SoC it is and update the
frequency table appropriately. That can be done with the gcc
node's compatible string. That also means gcc-msm8992 needs to be
added and used as a compatible string.

>  	{ }
>  };
>  
> @@ -1057,6 +1094,10 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
>  		.hw.init = &(struct clk_init_data)
>  		{
>  			.name = "gcc_blsp1_ahb_clk",
> +			.parent_names = (const char *[]){
> +				"periph_noc_clk_src",
> +			},
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -1872,6 +1913,7 @@ static struct clk_branch gcc_pdm2_clk = {
>  
>  static struct clk_branch gcc_sdcc1_apps_clk = {
>  	.halt_reg = 0x04c4,
> +	.halt_check = BRANCH_HALT_VOTED,
>  	.clkr = {
>  		.enable_reg = 0x04c4,
>  		.enable_mask = BIT(0),
> @@ -1888,6 +1930,26 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
>  	},
>  };
>  
> +
> +static struct clk_branch gcc_sdcc1_ahb_clk = {
> +	.halt_reg = 0x04c8,
> +	.halt_check = BRANCH_HALT_VOTED,

Why voted?

> diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
> index 8fa535b..e4063d5 100644
> --- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
> +++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
> @@ -15,10 +15,10 @@
>  #ifndef _DT_BINDINGS_CLK_MSM_GCC_8994_H
>  #define _DT_BINDINGS_CLK_MSM_GCC_8994_H
>  
> -#define GPLL0_EARLY				0
>  #define GPLL0					1
> -#define GPLL4_EARLY				2
> -#define GPLL4					3
> +#define GPLL0_VOTE				0

Please keep the numbers ordered.

> +#define GPLL4					2
> +#define GPLL4_VOTE				3
>  #define UFS_AXI_CLK_SRC				4
>  #define USB30_MASTER_CLK_SRC			5
>  #define BLSP1_QUP1_I2C_APPS_CLK_SRC		6
> @@ -123,15 +123,21 @@
>  #define GCC_SDCC2_APPS_CLK			105
>  #define GCC_SDCC3_APPS_CLK			106
>  #define GCC_SDCC4_APPS_CLK			107
> -#define GCC_SYS_NOC_UFS_AXI_CLK			108
> -#define GCC_SYS_NOC_USB3_AXI_CLK		109
> -#define GCC_TSIF_REF_CLK			110
> -#define GCC_UFS_AXI_CLK				111
> -#define GCC_UFS_RX_CFG_CLK			112
> -#define GCC_UFS_TX_CFG_CLK			113
> -#define GCC_USB30_MASTER_CLK			114
> -#define GCC_USB30_MOCK_UTMI_CLK			115
> -#define GCC_USB3_PHY_AUX_CLK			116
> -#define GCC_USB_HS_SYSTEM_CLK			117
> +#define GCC_SDCC1_AHB_CLK			108
> +#define GCC_SDCC2_AHB_CLK			109

There should be an ahb clk for sdcc3 and sdcc4 too. Please just
add the defines even if they're not used.

> +
> +#define GCC_SYS_NOC_UFS_AXI_CLK			110

And don't change the numbering randomly. This should still be
108.

> +#define GCC_SYS_NOC_USB3_AXI_CLK		111
> +#define GCC_TSIF_REF_CLK			112
> +#define GCC_UFS_AXI_CLK				113
> +#define GCC_UFS_RX_CFG_CLK			114
> +#define GCC_UFS_TX_CFG_CLK			115
> +#define GCC_USB30_MASTER_CLK			116
> +#define GCC_USB30_MOCK_UTMI_CLK			117
> +#define GCC_USB3_PHY_AUX_CLK			118
> +#define GCC_USB_HS_SYSTEM_CLK			119
> +#define SYSTEM_NOC_CLK_SRC			120
> +#define PERIPH_NOC_CLK_SRC			121
> +#define CONFIG_NOC_CLK_SRC			122

And then the diff will be understandable.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
