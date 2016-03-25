From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] DRAFT: shdci: allows custom wakeup irqs for runtime PM
Date: Sat, 26 Mar 2016 01:12:00 +0800
Message-ID: <201603260111.0O0yuecb%fengguang.wu@intel.com>
References: <1458921903-11133-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59345 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbcCYRM5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Mar 2016 13:12:57 -0400
Content-Disposition: inline
In-Reply-To: <1458921903-11133-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: kbuild-all@01.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi Ludovic,

[auto build test WARNING on ulf.hansson-mmc/next]
[also build test WARNING on v4.5 next-20160324]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Ludovic-Desroches/DRAFT-shdci-allows-custom-wakeup-irqs-for-runtime-PM/20160326-000948
base:   https://git.linaro.org/people/ulf.hansson/mmc next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/mmc/host/sdhci-pci-core.c:1497:49: sparse: not enough arguments for function sdhci_runtime_suspend_host
   drivers/mmc/host/sdhci-pci-core.c: In function 'sdhci_pci_runtime_suspend':
   drivers/mmc/host/sdhci-pci-core.c:1497:9: error: too few arguments to function 'sdhci_runtime_suspend_host'
      ret = sdhci_runtime_suspend_host(slot->host);
            ^
   In file included from drivers/mmc/host/sdhci-pci-core.c:31:0:
   drivers/mmc/host/sdhci.h:671:12: note: declared here
    extern int sdhci_runtime_suspend_host(struct sdhci_host *host, u32 wakeup_irqs);
               ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/mmc/host/sdhci-acpi.c:466:42: sparse: not enough arguments for function sdhci_runtime_suspend_host
   drivers/mmc/host/sdhci-acpi.c: In function 'sdhci_acpi_runtime_suspend':
   drivers/mmc/host/sdhci-acpi.c:466:9: error: too few arguments to function 'sdhci_runtime_suspend_host'
     return sdhci_runtime_suspend_host(c->host);
            ^
   In file included from drivers/mmc/host/sdhci-acpi.c:44:0:
   drivers/mmc/host/sdhci.h:671:12: note: declared here
    extern int sdhci_runtime_suspend_host(struct sdhci_host *host, u32 wakeup_irqs);
               ^
   drivers/mmc/host/sdhci-acpi.c:467:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/mmc/host/sdhci-pxav3.c:539:41: sparse: not enough arguments for function sdhci_runtime_suspend_host
   drivers/mmc/host/sdhci-pxav3.c: In function 'sdhci_pxav3_runtime_suspend':
   drivers/mmc/host/sdhci-pxav3.c:539:8: error: too few arguments to function 'sdhci_runtime_suspend_host'
     ret = sdhci_runtime_suspend_host(host);
           ^
   In file included from drivers/mmc/host/sdhci-pxav3.c:39:0:
   drivers/mmc/host/sdhci.h:671:12: note: declared here
    extern int sdhci_runtime_suspend_host(struct sdhci_host *host, u32 wakeup_irqs);
               ^

vim +1497 drivers/mmc/host/sdhci-pci-core.c

66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1481  static int sdhci_pci_runtime_suspend(struct device *dev)
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1482  {
923a231c drivers/mmc/host/sdhci-pci-core.c Geliang Tang  2015-12-27  1483  	struct pci_dev *pdev = to_pci_dev(dev);
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1484  	struct sdhci_pci_chip *chip;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1485  	struct sdhci_pci_slot *slot;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1486  	int i, ret;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1487  
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1488  	chip = pci_get_drvdata(pdev);
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1489  	if (!chip)
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1490  		return 0;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1491  
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1492  	for (i = 0; i < chip->num_slots; i++) {
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1493  		slot = chip->slots[i];
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1494  		if (!slot)
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1495  			continue;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1496  
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03 @1497  		ret = sdhci_runtime_suspend_host(slot->host);
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1498  
b678b91f drivers/mmc/host/sdhci-pci.c      Axel Lin      2011-12-03  1499  		if (ret)
b678b91f drivers/mmc/host/sdhci-pci.c      Axel Lin      2011-12-03  1500  			goto err_pci_runtime_suspend;
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1501  	}
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1502  
66fd8ad5 drivers/mmc/host/sdhci-pci.c      Adrian Hunter 2011-10-03  1503  	if (chip->fixes && chip->fixes->suspend) {
29495aa0 drivers/mmc/host/sdhci-pci.c      Manuel Lauss  2011-11-03  1504  		ret = chip->fixes->suspend(chip);
b678b91f drivers/mmc/host/sdhci-pci.c      Axel Lin      2011-12-03  1505  		if (ret)

:::::: The code at line 1497 was first introduced by commit
:::::: 66fd8ad5100b5003046aa744a4f12fa31bb831f9 mmc: sdhci-pci: add runtime pm support

:::::: TO: Adrian Hunter <adrian.hunter@intel.com>
:::::: CC: Chris Ball <cjb@laptop.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
