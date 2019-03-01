From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Date: Fri, 1 Mar 2019 13:44:41 +0530
Message-ID: <caa90cb6-a862-a6da-04ed-386f96b1f4b9@ti.com>
References: <20190226161606.18569-3-faiz_abbas@ti.com>
 <201903011552.lYOpBJe2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201903011552.lYOpBJe2%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01/03/19 12:52 PM, kbuild test robot wrote:
> Hi Faiz,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v5.0-rc8 next-20190228]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Faiz-Abbas/Fixes-for-command-errors-during-tuning/20190228-083200
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 8.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.2.0 make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "ia64_delay_loop" [drivers/spi/spi-thunderx.ko] undefined!
>    ERROR: "__sw_hweight8" [drivers/net/wireless/mediatek/mt76/mt76.ko] undefined!
>    ERROR: "ia64_delay_loop" [drivers/net/phy/mdio-cavium.ko] undefined!
>>> ERROR: "sdhci_cmd_err" [drivers/mmc/host/sdhci-omap.ko] undefined!
>>> ERROR: "sdhci_finish_command" [drivers/mmc/host/sdhci-omap.ko] undefined!

Looks like EXPORT_SYMBOL_GPL is required here. Will add in v2.

Thanks,
Faiz
