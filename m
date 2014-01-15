From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv9 1/4] clk: socfpga: Add a clk-phase property to the "altr,
 socfpga-gate-clk"
Date: Wed, 15 Jan 2014 06:36:52 -0600
Message-ID: <52D680E4.6090608@gmail.com>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com> <1389303079-19808-2-git-send-email-dinguyen@altera.com> <52CF6D67.1000803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54503 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaAOMgW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 07:36:22 -0500
In-Reply-To: <52CF6D67.1000803@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, dinguyen@altera.com, arnd@arndb.de, cjb@laptop.org, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Mike,

On 1/9/14 9:47 PM, Jaehoon Chung wrote:
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> On 01/10/2014 06:31 AM, dinguyen@altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> The clk-phase property is used to represent the 2 clock phase values that is
>> needed for the SD/MMC driver. Add a prepare function to the clk_ops, that will
>> use the syscon driver to set sdmmc_clk's phase shift that is located in the
>> system manager.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>> v9: none
>> v8: Use degrees in the clk-phase binding property
>> v7: Add dts property to represent the clk phase of the sdmmc_clk. Add a
>>     prepare function to the gate clk that will toggle clock phase setting.
>>     Remove the "altr,socfpga-sdmmc-sdr-clk" clock type.
>> v6: Add a new clock type "altr,socfpga-sdmmc-sdr-clk" that will be used to
>>     set the phase shift settings.
>> v5: Use the "snps,dw-mshc" binding
>> v4: Use the sdmmc_clk prepare function to set the phase shift settings
>> v3: Not use the syscon driver because as of 3.13-rc1, the syscon driver is
>>     loaded after the clock driver.
>> v2: Use the syscon driver
>> ---
>>  .../devicetree/bindings/clock/altr_socfpga.txt     |    5 ++
>>  arch/arm/boot/dts/socfpga.dtsi                     |    1 +
>>  drivers/clk/socfpga/clk-gate.c                     |   68 ++++++++++++++++++++
>>  3 files changed, 74 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
>> index 0045433..5dfd145 100644
>> --- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
>> +++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
>> @@ -23,3 +23,8 @@ Optional properties:
>>          and the bit index.
>>  - div-reg : For "socfpga-gate-clk", div-reg contains the divider register, bit shift,
>>          and width.
>> +- clk-phase : For the sdmmc_clk, contains the value of the clock phase that controls
>> +	the SDMMC CIU clock. The first value is the clk_sample(smpsel), and the second
>> +	value is the cclk_in_drv(drvsel). The clk-phase is used to enable the correct
>> +	hold/delay times that is needed for the SD/MMC CIU clock. The values of both
>> +	can be 0-315 degrees, in 45 degree increments.
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index f936476..e776512 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -413,6 +413,7 @@
>>  						compatible = "altr,socfpga-gate-clk";
>>  						clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
>>  						clk-gate = <0xa0 8>;
>> +						clk-phase = <0 135>;
>>  					};
>>  
>>  					nand_x_clk: nand_x_clk {
>> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
>> index 4efcf4e..501d513 100644
>> --- a/drivers/clk/socfpga/clk-gate.c
>> +++ b/drivers/clk/socfpga/clk-gate.c
>> @@ -19,7 +19,9 @@
>>  #include <linux/clkdev.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>>  #include <linux/of.h>
>> +#include <linux/regmap.h>
>>  
>>  #include "clk.h"
>>  
>> @@ -35,6 +37,11 @@
>>  
>>  #define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
>>  
>> +/* SDMMC Group for System Manager defines */
>> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET    0x108
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel) \
>> +	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
>> +
>>  static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
>>  {
>>  	u32 l4_src;
>> @@ -115,7 +122,61 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>>  	return parent_rate / div;
>>  }
>>  
>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>> +{
>> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
>> +	struct regmap *sys_mgr_base_addr;
>> +	int i;
>> +	u32 hs_timing;
>> +	u32 clk_phase[2];
>> +
>> +	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>> +		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>> +		if (IS_ERR(sys_mgr_base_addr)) {
>> +			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
>> +			return -EINVAL;
>> +		}
>> +
>> +		for (i = 0; i < 2; i++) {
>> +			switch (socfpgaclk->clk_phase[i]) {
>> +			case 0:
>> +				clk_phase[i] = 0;
>> +				break;
>> +			case 45:
>> +				clk_phase[i] = 1;
>> +				break;
>> +			case 90:
>> +				clk_phase[i] = 2;
>> +				break;
>> +			case 135:
>> +				clk_phase[i] = 3;
>> +				break;
>> +			case 180:
>> +				clk_phase[i] = 4;
>> +				break;
>> +			case 225:
>> +				clk_phase[i] = 5;
>> +				break;
>> +			case 270:
>> +				clk_phase[i] = 6;
>> +				break;
>> +			case 315:
>> +				clk_phase[i] = 7;
>> +				break;
>> +			default:
>> +				clk_phase[i] = 0;
>> +				break;
>> +			}
>> +		}
>> +		hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
>> +		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
>> +			hs_timing);
>> +	}
>> +	return 0;
>> +}
>> +
>>  static struct clk_ops gateclk_ops = {
>> +	.prepare = socfpga_clk_prepare,
>>  	.recalc_rate = socfpga_clk_recalc_rate,
>>  	.get_parent = socfpga_clk_get_parent,
>>  	.set_parent = socfpga_clk_set_parent,
>> @@ -126,6 +187,7 @@ static void __init __socfpga_gate_init(struct device_node *node,
>>  {
>>  	u32 clk_gate[2];
>>  	u32 div_reg[3];
>> +	u32 clk_phase[2];
>>  	u32 fixed_div;
>>  	struct clk *clk;
>>  	struct socfpga_gate_clk *socfpga_clk;
>> @@ -166,6 +228,12 @@ static void __init __socfpga_gate_init(struct device_node *node,
>>  		socfpga_clk->div_reg = 0;
>>  	}
>>  
>> +	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
>> +	if (!rc) {
>> +		socfpga_clk->clk_phase[0] = clk_phase[0];
>> +		socfpga_clk->clk_phase[1] = clk_phase[1];
>> +	}
>> +
>>  	of_property_read_string(node, "clock-output-names", &clk_name);
>>  
>>  	init.name = clk_name;
>>
Can you apply this to your clk tree?

Thanks,
Dinh

