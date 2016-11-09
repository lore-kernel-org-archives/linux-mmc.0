From: Shyam Sundar S K <ssundark@amd.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for HS200 tuning mode, on AMD
 eMMC-4.5.1
Date: Wed, 9 Nov 2016 12:44:02 +0530
Message-ID: <67dbdf7c-d910-20bc-6a42-aa2ac8a13b30@amd.com>
References: <201611091506.s29MX9Hj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:48360
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751282AbcKIHOk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Nov 2016 02:14:40 -0500
In-Reply-To: <201611091506.s29MX9Hj%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Pankaj.Sen@amd.com, Nehal-bakulchandra.Shah@amd.com, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

Hi Ulf, Adrian

>    drivers/mmc/host/sdhci-pci-core.c: In function 'amd_find_good_phase':
>>> drivers/mmc/host/sdhci-pci-core.c:877:37: error: implicit declaration of function 'sdhci_pci_priv' [-Werror=implicit-function-declaration]
>      struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);

This build error is because, it has dependency on Adrian patch "mmc: sdhci-pci: Let devices define their own private data".

Kindly add our patch on top of Adrian's patch and that will resolve the build error.

Thanks,
Shyam

On 11/9/2016 12:36 PM, kbuild test robot wrote:
> Hi Shyam,
> 
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v4.9-rc4 next-20161109]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shyam-Sundar-S-K/mmc-sdhci-pci-Add-support-for-HS200-tuning-mode-on-AMD-eMMC-4-5-1/20161109-145027
> base:   https://git.linaro.org/people/ulf.hansson/mmc next
> config: i386-randconfig-x006-201645 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/mmc/host/sdhci-pci-core.c: In function 'amd_find_good_phase':
>>> drivers/mmc/host/sdhci-pci-core.c:877:37: error: implicit declaration of function 'sdhci_pci_priv' [-Werror=implicit-function-declaration]
>      struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>                                         ^~~~~~~~~~~~~~
>>> drivers/mmc/host/sdhci-pci-core.c:877:37: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>    drivers/mmc/host/sdhci-pci-core.c: In function 'amd_execute_tuning':
>    drivers/mmc/host/sdhci-pci-core.c:946:37: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
>      struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>                                         ^~~~~~~~~~~~~~
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_save_flags
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_restore
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_disable
>    Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_save
>    Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
>    Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
>    Cyclomatic Complexity 2 include/linux/err.h:IS_ERR
>    Cyclomatic Complexity 1 include/linux/err.h:ERR_CAST
>    Cyclomatic Complexity 1 arch/x86/include/asm/irqflags.h:arch_irqs_disabled_flags
>    Cyclomatic Complexity 1 arch/x86/include/asm/preempt.h:should_resched
>    Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
>    Cyclomatic Complexity 3 include/linux/spinlock.h:spin_unlock_irqrestore
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readb
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readw
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readl
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writeb
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writew
>    Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writel
>    Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
>    Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
>    Cyclomatic Complexity 3 include/linux/device.h:dev_name
>    Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
>    Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_read_config_byte
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_read_config_dword
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_write_config_byte
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_write_config_dword
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_get_drvdata
>    Cyclomatic Complexity 1 include/linux/pci.h:pci_set_drvdata
>    Cyclomatic Complexity 1 include/linux/mmc/host.h:mmc_priv
>    Cyclomatic Complexity 1 include/asm-generic/gpio.h:gpio_is_valid
>    Cyclomatic Complexity 1 include/asm-generic/gpio.h:gpio_direction_output
>    Cyclomatic Complexity 1 include/asm-generic/gpio.h:gpio_set_value_cansleep
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_allow
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_forbid
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_suspend_ignore_children
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_get_noresume
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_put_noidle
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:__pm_runtime_use_autosuspend
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_set_autosuspend_delay
>    Cyclomatic Complexity 1 include/linux/pm_runtime.h:pm_runtime_use_autosuspend
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_writel
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_writew
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_writeb
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_readl
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_readw
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_readb
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci.h:sdhci_priv
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:ricoh_mmc_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:mrst_hc_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:mrst_hc_probe
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:pch_hc_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_add_own_cd
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_remove_own_cd
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:mfd_emmc_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:mfd_sdio_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:byt_sdio_probe_slot
>    Cyclomatic Complexity 4 drivers/mmc/host/sdhci-pci-core.c:intel_mrfld_mmc_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:rtsx_probe_slot
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:amd_enable_manual_tuning
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_set_bus_width
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_runtime_pm_allow
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_runtime_pm_forbid
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_driver_init
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_select_drive_strength
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_hw_reset
>    Cyclomatic Complexity 12 drivers/mmc/host/sdhci-pci-core.c:byt_sd_probe_slot
>    Cyclomatic Complexity 5 drivers/mmc/host/sdhci-pci-core.c:spt_select_drive_strength
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:via_probe
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:syskt_probe
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:jmicron_enable_mmc
>    Cyclomatic Complexity 5 drivers/mmc/host/sdhci-pci-core.c:jmicron_pmos
>    Cyclomatic Complexity 10 drivers/mmc/host/sdhci-pci-core.c:jmicron_suspend
>    Cyclomatic Complexity 11 drivers/mmc/host/sdhci-pci-core.c:jmicron_remove_slot
>    Cyclomatic Complexity 15 drivers/mmc/host/sdhci-pci-core.c:jmicron_probe_slot
>    Cyclomatic Complexity 9 drivers/mmc/host/sdhci-pci-core.c:ricoh_probe
>    Cyclomatic Complexity 19 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_remove_slot
>    Cyclomatic Complexity 4 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_remove
>    Cyclomatic Complexity 12 drivers/mmc/host/sdhci-pci-core.c:jmicron_resume
>    Cyclomatic Complexity 69 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_probe_slot
>    Cyclomatic Complexity 33 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_probe
>    Cyclomatic Complexity 29 drivers/mmc/host/sdhci-pci-core.c:spt_read_drive_strength
>    Cyclomatic Complexity 5 drivers/mmc/host/sdhci-pci-core.c:byt_emmc_probe_slot
>    Cyclomatic Complexity 8 drivers/mmc/host/sdhci-pci-core.c:syskt_probe_slot
>    Cyclomatic Complexity 2 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_gpio_hw_reset
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_int_hw_reset
>    Cyclomatic Complexity 12 drivers/mmc/host/sdhci-pci-core.c:sdhci_pci_enable_dma
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:amd_tuning_reset
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:amd_config_tuning_phase
>    Cyclomatic Complexity 42 drivers/mmc/host/sdhci-pci-core.c:amd_find_good_phase
>    Cyclomatic Complexity 3 drivers/mmc/host/sdhci-pci-core.c:amd_execute_tuning
>    Cyclomatic Complexity 9 drivers/mmc/host/sdhci-pci-core.c:amd_probe
>    Cyclomatic Complexity 6 drivers/mmc/host/sdhci-pci-core.c:sdhci_intel_set_power
>    Cyclomatic Complexity 5 drivers/mmc/host/sdhci-pci-core.c:bxt_get_cd
>    Cyclomatic Complexity 24 drivers/mmc/host/sdhci-pci-core.c:jmicron_probe
>    Cyclomatic Complexity 1 drivers/mmc/host/sdhci-pci-core.c:ricoh_mmc_resume
> 
> vim +/sdhci_pci_priv +877 drivers/mmc/host/sdhci-pci-core.c
> 
>    871	}
>    872	
>    873	static int amd_find_good_phase(struct sdhci_host *host)
>    874	{
>    875		struct sdhci_pci_slot *slot = sdhci_priv(host);
>    876		struct pci_dev *pdev = slot->chip->pdev;
>  > 877		struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>    878	
>    879		unsigned int val;
>    880		unsigned long flags;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
