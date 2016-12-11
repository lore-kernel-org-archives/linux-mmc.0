From: Shyam Sundar S K <ssundark@amd.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Add support for HS200 tuning mode on
 AMD, eMMC-4.5.1
Date: Sun, 11 Dec 2016 08:13:30 +0530
Message-ID: <8067c293-f7d1-c556-d01f-5fd5da5e22c8@amd.com>
References: <201612110800.qBFQe9To%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:27761
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752526AbcLKCn6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 10 Dec 2016 21:43:58 -0500
In-Reply-To: <201612110800.qBFQe9To%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>



On 12/11/2016 5:50 AM, kbuild test robot wrote:
> Hi Shyam,
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.9-rc8 next-20161209]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shyam-Sundar-S-K/mmc-sdhci-pci-Add-support-for-HS200-tuning-mode-on-AMD-eMMC-4-5-1/20161211-045148
> config: x86_64-randconfig-b0-12110515 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/mmc/host/sdhci-pci-core.c: In function 'amd_execute_tuning':
>>> drivers/mmc/host/sdhci-pci-core.c:885: warning: unused variable 'flags'
>>> drivers/mmc/host/sdhci-pci-core.c:884: warning: unused variable 'val'
>>> drivers/mmc/host/sdhci-pci-core.c:883: warning: unused variable 'pdev'
>    At top level:
>    cc1: warning: unrecognized command line option "-Wno-maybe-uninitialized"
>    drivers/mmc/host/sdhci-pci-core.o: warning: objtool: sdhci_pci_probe()+0x8af: function has unreachable instruction
> 
> vim +/flags +885 drivers/mmc/host/sdhci-pci-core.c
> 
>    877		return 0;
>    878	}
>    879	
>    880	static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
>    881	{
>    882		struct sdhci_pci_slot *slot = sdhci_priv(host);
>  > 883		struct pci_dev *pdev = slot->chip->pdev;
>  > 884		unsigned int val;
>  > 885		unsigned long flags;

Apologies. Not sure why this was not caught on our build systems. Made a new submission by removing these unused variables.

>    886		u8 ctrl, tune_around, valid_f = 0, valid_win_max = 0;
>    887		u8 tune_low_max = 0, tune_low = 0, valid_win = 0, tune_res = 0;
>    888		bool this_tune_ok = 0, last_tune_ok = 0;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
