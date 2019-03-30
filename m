From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Date: Sat, 30 Mar 2019 13:53:17 +0800
Message-ID: <201903301321.kfK13ZG5%lkp@intel.com>
References: <20190329121042.24415-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329121042.24415-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi Faiz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ulf.hansson-mmc/next]
[also build test WARNING on v5.1-rc2 next-20190329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Faiz-Abbas/mmc-sdhci-omap-Don-t-finish_mrq-on-a-command-error-during-tuning/20190330-093057
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   drivers/mmc/host/sdhci-omap.c:386:31: sparse: expression using sizeof(void)
   drivers/mmc/host/sdhci-omap.c:386:31: sparse: expression using sizeof(void)
>> drivers/mmc/host/sdhci-omap.c:847:16: sparse: incorrect type in initializer (different signedness) @@    expected unsigned int ( *irq )( ... ) @@    got int enunsigned int ( *irq )( ... ) @@
   drivers/mmc/host/sdhci-omap.c:847:16:    expected unsigned int ( *irq )( ... )
   drivers/mmc/host/sdhci-omap.c:847:16:    got int enum irqreturn ( *<noident> )( ... )
   include/linux/device.h:688:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/device.h:688:13: sparse: call with no type!

vim +847 drivers/mmc/host/sdhci-omap.c

   836	
   837	static struct sdhci_ops sdhci_omap_ops = {
   838		.set_clock = sdhci_omap_set_clock,
   839		.set_power = sdhci_omap_set_power,
   840		.enable_dma = sdhci_omap_enable_dma,
   841		.get_max_clock = sdhci_pltfm_clk_get_max_clock,
   842		.get_min_clock = sdhci_omap_get_min_clock,
   843		.set_bus_width = sdhci_omap_set_bus_width,
   844		.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
   845		.reset = sdhci_omap_reset,
   846		.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 > 847		.irq = sdhci_omap_irq,
   848	};
   849	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
