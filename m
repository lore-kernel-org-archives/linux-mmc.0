From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH V4 2/7] mmc: sdhci: Change SDMA address register for v4
 mode
Date: Tue, 24 Jul 2018 06:26:59 +0800
Message-ID: <201807240502.gLFKN7nS%fengguang.wu@intel.com>
References: <1532340508-8749-3-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532340508-8749-3-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
List-Id: linux-mmc@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chunyan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ulf.hansson-mmc/next]
[also build test WARNING on v4.18-rc6 next-20180723]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/mmc-add-support-for-sdhci-4-0/20180724-045328
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
config: arm-exynos_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14:0,
                    from include/linux/delay.h:22,
                    from drivers/mmc/host/sdhci.c:16:
   drivers/mmc/host/sdhci.c: In function 'sdhci_data_irq':
>> drivers/mmc/host/sdhci.c:43:11: warning: format '%p' expects argument of type 'void *', but argument 4 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
     pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
              ^
   include/linux/printk.h:288:21: note: in definition of macro 'pr_fmt'
    #define pr_fmt(fmt) fmt
                        ^~~
   include/linux/printk.h:336:2: note: in expansion of macro 'dynamic_pr_debug'
     dynamic_pr_debug(fmt, ##__VA_ARGS__)
     ^~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci.c:43:2: note: in expansion of macro 'pr_debug'
     pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
     ^~~~~~~~
   drivers/mmc/host/sdhci.c:2849:4: note: in expansion of macro 'DBG'
       DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
       ^~~
   drivers/mmc/host/sdhci.c:2849:19: note: format string is defined here
       DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
                     ~^
                     %d
   In file included from include/linux/kernel.h:14:0,
                    from include/linux/delay.h:22,
                    from drivers/mmc/host/sdhci.c:16:
   drivers/mmc/host/sdhci.c:43:11: warning: format '%p' expects argument of type 'void *', but argument 6 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]
     pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
              ^
   include/linux/printk.h:288:21: note: in definition of macro 'pr_fmt'
    #define pr_fmt(fmt) fmt
                        ^~~
   include/linux/printk.h:336:2: note: in expansion of macro 'dynamic_pr_debug'
     dynamic_pr_debug(fmt, ##__VA_ARGS__)
     ^~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci.c:43:2: note: in expansion of macro 'pr_debug'
     pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
     ^~~~~~~~
   drivers/mmc/host/sdhci.c:2849:4: note: in expansion of macro 'DBG'
       DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
       ^~~
   drivers/mmc/host/sdhci.c:2849:56: note: format string is defined here
       DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
                                                          ~^
                                                          %d

vim +43 drivers/mmc/host/sdhci.c

d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24 @16  #include <linux/delay.h>
5a436cc0a drivers/mmc/host/sdhci.c Adrian Hunter         2017-03-20  17  #include <linux/ktime.h>
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  18  #include <linux/highmem.h>
b8c86fc5d drivers/mmc/host/sdhci.c Pierre Ossman         2008-03-18  19  #include <linux/io.h>
88b476797 drivers/mmc/host/sdhci.c Paul Gortmaker        2011-07-03  20  #include <linux/module.h>
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  21  #include <linux/dma-mapping.h>
5a0e3ad6a drivers/mmc/host/sdhci.c Tejun Heo             2010-03-24  22  #include <linux/slab.h>
117636092 drivers/mmc/host/sdhci.c Ralf Baechle          2007-10-23  23  #include <linux/scatterlist.h>
bd9b90279 drivers/mmc/host/sdhci.c Linus Walleij         2018-01-29  24  #include <linux/sizes.h>
250dcd114 drivers/mmc/host/sdhci.c Ulf Hansson           2017-11-27  25  #include <linux/swiotlb.h>
9bea3c850 drivers/mmc/host/sdhci.c Marek Szyprowski      2010-08-10  26  #include <linux/regulator/consumer.h>
66fd8ad51 drivers/mmc/host/sdhci.c Adrian Hunter         2011-10-03  27  #include <linux/pm_runtime.h>
92e0c44b9 drivers/mmc/host/sdhci.c Zach Brown            2016-11-02  28  #include <linux/of.h>
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  29  
2f730fec8 drivers/mmc/host/sdhci.c Pierre Ossman         2008-03-17  30  #include <linux/leds.h>
2f730fec8 drivers/mmc/host/sdhci.c Pierre Ossman         2008-03-17  31  
22113efd0 drivers/mmc/host/sdhci.c Aries Lee             2010-12-15  32  #include <linux/mmc/mmc.h>
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  33  #include <linux/mmc/host.h>
473b095a7 drivers/mmc/host/sdhci.c Aaron Lu              2012-07-03  34  #include <linux/mmc/card.h>
85cc1c331 drivers/mmc/host/sdhci.c Corneliu Doban        2015-02-09  35  #include <linux/mmc/sdio.h>
bec9d4e59 drivers/mmc/host/sdhci.c Guennadi Liakhovetski 2012-09-17  36  #include <linux/mmc/slot-gpio.h>
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  37  
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  38  #include "sdhci.h"
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  39  
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  40  #define DRIVER_NAME "sdhci"
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  41  
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  42  #define DBG(f, x...) \
f421865d5 drivers/mmc/host/sdhci.c Adrian Hunter         2017-03-20 @43  	pr_debug("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
d129bceb1 drivers/mmc/sdhci.c      Pierre Ossman         2006-03-24  44  

:::::: The code at line 43 was first introduced by commit
:::::: f421865d5b4ce57013040fb1700edceb43a14b42 mmc: sdhci: Improve debug print format

:::::: TO: Adrian Hunter <adrian.hunter@intel.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J2SCkAp4GZ/dPZZf--
