From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property to the
 "altr, socfpga-gate-clk"
Date: Wed, 18 Dec 2013 12:56:36 -0800
Message-ID: <20131218205636.23538.50735@quantum>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
 <1387213476-22122-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:52952 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3LRU4n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 15:56:43 -0500
Received: by mail-yh0-f52.google.com with SMTP id i7so92990yha.39
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 12:56:42 -0800 (PST)
In-Reply-To: <1387213476-22122-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

Quoting dinguyen@altera.com (2013-12-16 09:04:33)
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The clk-phase property is used to represent the 2 clock phase values that is
> needed for the SD/MMC driver. Add a prepare function to the clk_ops, that will
> use the syscon driver to set sdmmc_clk's phase shift that is located in the
> system manager.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
> v7: Add dts property to represent the clk phase of the sdmmc_clk. Add a
>     prepare function to the gate clk that will toggle clock phase setting.
>     Remove the "altr,socfpga-sdmmc-sdr-clk" clock type.
> v6: Add a new clock type "altr,socfpga-sdmmc-sdr-clk" that will be used to
> set the phase shift settings.
> v5: Use the "snps,dw-mshc" binding
> v4: Use the sdmmc_clk prepare function to set the phase shift settings
> v3: Not use the syscon driver because as of 3.13-rc1, the syscon driver is
>     loaded after the clock driver.
> v2: Use the syscon driver
> ---
>  .../devicetree/bindings/clock/altr_socfpga.txt     |   14 ++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |    1 +
>  drivers/clk/socfpga/clk.c                          |   36 ++++++++++++++++++++
>  3 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> index 0045433..4b66754 100644
> --- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> +++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> @@ -23,3 +23,17 @@ Optional properties:
>          and the bit index.
>  - div-reg : For "socfpga-gate-clk", div-reg contains the divider register, bit shift,
>          and width.
> +- clk-phase : For the sdmmc_clk, contains the value of the clock phase that controls
> +  the SDMMC CIU clock. The first value is the clk_sample(smpsel), and the second
> +  value is the cclk_in_drv(drvsel). The clk-phase is used to enable the correct
> +  hold/delay times that is needed for the SD/MMC CIU clock. The values of both
> +  value can be one of the following:
> +
> +       <0x0>   :       0 degrees
> +       <0x1>   :       45 degrees
> +       <0x2>   :       90 degrees
> +       <0x3>   :       135 degrees
> +       <0x4>   :       180 degrees
> +       <0x5>   :       225 degrees
> +       <0x6>   :       270 degrees
> +       <0x7>   :       315 degrees
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index f936476..616d9ee 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -413,6 +413,7 @@
>                                                 compatible = "altr,socfpga-gate-clk";
>                                                 clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
>                                                 clk-gate = <0xa0 8>;
> +                                               clk-phase = <0 3>;

Looking at this again, I have a hard time understanding the values in
the clk-phase property. You reference some functions in the property
definition above, but they are not obvious to me.

Additionally I wonder if the binding would better if the clock-phase
property was simply the value in degrees. E.g:

	clk-phase = <315>;    // 315 degrees

Regards,
Mike

>                                         };
>  
>                                         nand_x_clk: nand_x_clk {
> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 280c983..7cfebd6 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -21,8 +21,10 @@
>  #include <linux/clkdev.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regmap.h>
>  
>  /* Clock Manager offsets */
>  #define CLKMGR_CTRL    0x0
> @@ -56,6 +58,11 @@
>  #define div_mask(width)        ((1 << (width)) - 1)
>  #define streq(a, b) (strcmp((a), (b)) == 0)
>  
> +/* SDMMC Group for System Manager defines */
> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET    0x108
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
> +       ((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
> +
>  static void __iomem *clk_mgr_base_addr;
>  
>  struct socfpga_clk {
> @@ -66,6 +73,7 @@ struct socfpga_clk {
>         void __iomem *div_reg;
>         u32 width;      /* only valid if div_reg != 0 */
>         u32 shift;      /* only valid if div_reg != 0 */
> +       u32 clk_phase[2];
>  };
>  #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
>  
> @@ -243,7 +251,28 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>         return parent_rate / div;
>  }
>  
> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
> +{
> +       struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
> +       struct regmap *sys_mgr_base_addr;
> +       u32 hs_timing;
> +
> +       if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
> +               sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> +               if (IS_ERR(sys_mgr_base_addr)) {
> +                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> +                       return -EINVAL;
> +               }
> +               hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
> +                                               socfpgaclk->clk_phase[1]);
> +               regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> +                                               hs_timing);
> +       }
> +       return 0;
> +}
> +
>  static struct clk_ops gateclk_ops = {
> +       .prepare = socfpga_clk_prepare,
>         .recalc_rate = socfpga_clk_recalc_rate,
>         .get_parent = socfpga_clk_get_parent,
>         .set_parent = socfpga_clk_set_parent,
> @@ -254,6 +283,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
>  {
>         u32 clk_gate[2];
>         u32 div_reg[3];
> +       u32 clk_phase[2];
>         u32 fixed_div;
>         struct clk *clk;
>         struct socfpga_clk *socfpga_clk;
> @@ -294,6 +324,12 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
>                 socfpga_clk->div_reg = 0;
>         }
>  
> +       rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
> +       if (!rc) {
> +               socfpga_clk->clk_phase[0] = clk_phase[0];
> +               socfpga_clk->clk_phase[1] = clk_phase[1];
> +       }
> +
>         of_property_read_string(node, "clock-output-names", &clk_name);
>  
>         init.name = clk_name;
> -- 
> 1.7.9.5
> 
> 
