From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 2/4] clk: socfpga: Add a hook for SD/MMC driver to control CIU clock settings
Date: Thu, 5 Dec 2013 21:57:37 +0100
Message-ID: <201312052157.37538.arnd@arndb.de>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com> <1386263677-7733-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab3LEU55 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 15:57:57 -0500
In-Reply-To: <1386263677-7733-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 05 December 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
> the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
> the correct clock-phase for the CIU clock of the SD/MMC IP.
> 
> Re-use the "rockchip,rk2928-dw-mshc" binding as it is already defined and
> appropriate for the SOCFPGA platform as well.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

I think with this series we're getting closer to where things should be, but
there are still a number of the same problems. Maybe I have misunderstood
a few things here in how the clocks fit together, but here is what still
looks wrong about this patch:

> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
> index 60cb2f5..01baf20 100644
> --- a/drivers/clk/socfpga/clk.c
> +++ b/drivers/clk/socfpga/clk.c
> @@ -55,7 +55,13 @@
>  #define div_mask(width)	((1 << (width)) - 1)
>  #define streq(a, b) (strcmp((a), (b)) == 0)
>  
> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET	0x108
> +/* SDMMC Group for System Manager defines */
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
> +	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
> +
>  extern void __iomem *clk_mgr_base_addr;
> +extern void __iomem *sys_manager_base_addr;

As mentioned in yesterday's comments, you should not have the 'extern'
declaration for sys_manager_base_addr here. In fact, the existing
clk_mgr_base_addr declaration is just as wrong.

> +static int sdmmc_ciuclk_prepare(struct clk_hw *hwclk)
> +{
> +	struct device_node *np;
> +	u32 timing[2];
> +	u32 hs_timing;
> +
> +	np = of_find_compatible_node(NULL, NULL, "rockchip,rk2928-dw-mshc");
> +	if (of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2)) {
> +		pr_err("SDMMC: cannot find samsung,dw-mshc-sdr-timing!\n");
> +		return -ENODATA;
> +	}
> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[1], timing[0]);
> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
> +	return 0;
> +}
> +

And in now way should the clock provider code look into the DT properties of the
clock consumer. From what I can tell, the dw-mshc code already interprets the
"samsung,dw-mshc-sdr-timing" property and uses the data to pass the correct
clock rate using 'clk_set_rate()'. The clock code should only use the data passed
in the argument to that function to set up the registers and not need to know
at all who is setting it.

I am a little confused though what the SYSMGR_SDMMCGRP_CTRL_OFFSET register actually
does. It looks like this is just a clock divider, which should be represented as
a separate clock node (as you had in v3) and compute the correct factor from the
requested clock rate and the parent clock rate.

	Arnd
