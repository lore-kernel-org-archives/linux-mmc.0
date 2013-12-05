From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 1/4] clk: socfpga: Add a clock driver for SOCFPGA's system manager
Date: Thu, 5 Dec 2013 04:00:39 +0100
Message-ID: <201312050400.40427.arnd@arndb.de>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com> <1386197576-3825-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64833 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab3LEDBQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 22:01:16 -0500
In-Reply-To: <1386197576-3825-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wednesday 04 December 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The system manager is an IP block on the SOCFPGA platform. The system manager
> contains registers that control other IPs on the platform. One of the IPs that
> the system manager has control over is the SD/MMC, by way of controlling the
> clock phase on the SD/MMC Card Interface Unit.
> 
> This patch adds a clock driver that the SD/MMC driver can use by calling
> the common clock API in order to set the appropriate register in the
> system manager by way of a syscon driver.
> 
> This clock driver can also be re-used for other IPs that need to poke the system
> manager.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

I think this still gets things wrong on multiple levels.

> ---
> v3: Not use the syscon driver because as of 3.13-rc1, the syscon driver
> is loaded after the clock driver.
> 
> v2: Use the syscon driver

Can't you reference the syscon driver just from the set_rate function?
When you do that, you won't need to care if it's available until the clock
is actually used by the sd card driver.

> +
> +#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +/* SDMMC Group for System Manager defines */
> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
> +	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
> +
> +extern void __iomem *sys_manager_base_addr;

You definitely cannot put "extern" variable declarations into driver files.
This is always a bug.

> +static int sysmgr_set_dwmmc_drvsel_smpsel(struct clk_hw *hwclk)
> +{
> +	struct device_node *np;
> +	struct socfpga_sysmgr *socfpga_sysmgr = to_sysmgr_clk(hwclk);
> +	u32 timing[2];
> +	u32 hs_timing;
> +
> +	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
> +	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[1], timing[0]);
> +	writel(hs_timing, sys_manager_base_addr + socfpga_sysmgr->reg);
> +	return 0;
> +}

The clock driver has absolutely no business looking into the
"samsung,dw-mshc-sdr-timing" property, that is a layering violation.
The SD card driver should pass the frequency to the clock driver
instead.

> +static void __init socfpga_sysmgr_init(struct device_node *node, const struct clk_ops *ops)
> +{
> +	u32 reg;
> +	struct clk *clk;
> +	struct socfpga_sysmgr *socfpga_sysmgr;
> +	const char *clk_name = node->name;
> +	struct clk_init_data init;
> +	int rc;
> +
> +	socfpga_sysmgr = kzalloc(sizeof(*socfpga_sysmgr), GFP_KERNEL);
> +	if (WARN_ON(!socfpga_sysmgr))
> +		return;
> +
> +	rc = of_property_read_u32(node, "reg", &reg);
> +	if (WARN_ON(rc))
> +		return;

This feels wrong: drivers should not manually interpret the standard "reg"
property. I'll let Mike comment on this, but I think what you want instead
is to use an index into the sysmgr in the clock reference. This assumes
that sysmgr contains a set of identical clock register blocks that can
be indexed in a simple way.

> +	socfpga_sysmgr->reg = reg;
> +
> +	init.name = clk_name;
> +	init.ops = ops;
> +	init.flags = 0;
> +	init.num_parents = 0;
> +
> +	socfpga_sysmgr->hw.init = &init;
> +	clk = clk_register(NULL, &socfpga_sysmgr->hw);
> +	if (WARN_ON(IS_ERR(clk))) {
> +		kfree(socfpga_sysmgr);
> +		return;
> +	}
> +	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	if (WARN_ON(rc))
> +		return;
> +}
> +
> +static void __init sysmgr_init(struct device_node *node)
> +{
> +	socfpga_sysmgr_init(node, &clk_sysmgr_sdmmc_ops);
> +}
> +CLK_OF_DECLARE(sysmgr, "altr,sysmgr-sdmmc-sdr", sysmgr_init);

Along the same lines: the "altr,sysmgr-sdmmc-sdr" string doesn't make
sense here, it should be a name given to the clock register layout
of the sysmgr, which is presumably identical for a number of clocks,
and cannot contain "sdmmc-sdr" in the name.

	Arnd
