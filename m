From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v13 3/6] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Sat, 1 Apr 2017 14:47:48 +0200
Message-ID: <20170401124748.GA29406@hardcore>
References: <20170330153128.22842-4-jglauber@cavium.com>
 <201704011255.vs85jY0Q%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:18592
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbdDAMsF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 1 Apr 2017 08:48:05 -0400
Content-Disposition: inline
In-Reply-To: <201704011255.vs85jY0Q%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 01, 2017 at 12:46:16PM +0800, kbuild test robot wrote:
> Hi Jan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.11-rc4 next-20170331]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-MMC-driver/20170401-055302
> config: sparc64-allmodconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "of_platform_device_create" [drivers/mmc/host/thunderx-mmc.ko] undefined!
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

commit d431e1fd494546795ab6478dece96532106b5e62
Author: Jan Glauber <jglauber@cavium.com>
Date:   Sat Apr 1 14:43:51 2017 +0200

    mmc: thunderx: Make driver depend on OF_ADDRESS
    
    Prevent this compile error (COMPILE_TEST) on sparc64:
    >> ERROR: "of_platform_device_create" [drivers/mmc/host/thunderx-mmc.ko] undefined!
    
    Signed-off-by: Jan Glauber <jglauber@cavium.com>

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index c882795..c2d05ba 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -626,6 +626,7 @@ config MMC_CAVIUM_THUNDERX
 	tristate "Cavium ThunderX SD/MMC Card Interface support"
 	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
 	depends on GPIOLIB
+	depends on OF_ADDRESS
 	help
 	  This selects Cavium ThunderX SD/MMC Card Interface.
 	  If you have an Cavium ARM64 board with a Multimedia Card slot
