From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 00/25] sdhci patches
Date: Tue, 21 Mar 2017 13:54:36 +0200
Message-ID: <04376d75-accb-b21e-f2ae-f3077157b205@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <20170321110039.6vphjb7n4zpe65kg@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41385 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbdCUMAM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Mar 2017 08:00:12 -0400
In-Reply-To: <20170321110039.6vphjb7n4zpe65kg@dell>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

On 21/03/17 13:00, Lee Jones wrote:
> On Mon, 20 Mar 2017, Adrian Hunter wrote:
> 
>> Hi
>>
>> Here are some sdhci patches that include preparation for CQE and some
>> general improvements.  Patches such as:
>>
>>     mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
>>     mmc: sdhci: Do not use spin lock in set_ios paths
>>
>> affect several drivers specifically, like:
>>
>>     drivers/mmc/host/sdhci-brcmstb.c
>>     drivers/mmc/host/sdhci-esdhc-imx.c
>>     drivers/mmc/host/sdhci-of-arasan.c
>>     drivers/mmc/host/sdhci-of-at91.c
>>     drivers/mmc/host/sdhci-of-esdhc.c
>>     drivers/mmc/host/sdhci-pxav3.c
>>     drivers/mmc/host/sdhci-s3c.c
>>     drivers/mmc/host/sdhci-sirf.c
>>     drivers/mmc/host/sdhci-spear.c
>>     drivers/mmc/host/sdhci-st.c
>>
>>
>>
>> Adrian Hunter (25):
>>       mmc: sdhci: Do not disable interrupts while waiting for clock
>>       mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power
>>       mmc: sdhci: Optimize delay loops
>>       mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() with pm
>>       mmc: sdhci-pci: Let devices define their own private data
>>       mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
>>       mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices
>>       mmc: sdhci: Remove ->select_drive_strength() callback
>>       mmc: sdhci: Do not use spin lock in set_ios paths
>>       mmc: sdhci: Reduce spin lock usage in sdhci_execute_tuning
>>       mmc: sdhci: Improve debug print format
>>       mmc: sdhci: Add response register to register dump
>>       mmc: sdhci: Use sdhci_readl() not readl() in sdhci_dumpregs()
>>       mmc: sdhci: Improve register dump print format
>>       mmc: sdhci: Export sdhci_dumpregs
>>       mmc: sdhci: Get rid of 'extern' in header file
>>       mmc: sdhci: Add sdhci_cleanup_host
>>       mmc: sdhci: Factor out sdhci_set_default_irqs
>>       mmc: sdhci: Add CQE support
>>       mmc: sdhci-pci: Let devices define how to add the host
>>       mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
>>       mmc: sdhci-pci: Conditionally compile pm sleep functions
>>       mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
>>       mmc: sdhci-pci: Add runtime suspend/resume callbacks
>>       mmc: sdhci-pci: Move a function to avoid later forward declaration
> 
> Why have you sent this set to so many people?

Because they might have an interest in testing the drivers that they have
contributed to.

> 
> Mores the point, why have you sent it to me?

Because you contributed to:

	drivers/mmc/host/sdhci-st.c

and might have an interest in testing it.

> 
>>  drivers/mmc/host/sdhci-acpi.c        |  12 +-
>>  drivers/mmc/host/sdhci-brcmstb.c     |   3 +
>>  drivers/mmc/host/sdhci-esdhc-imx.c   |   6 +
>>  drivers/mmc/host/sdhci-msm.c         |   8 -
>>  drivers/mmc/host/sdhci-of-arasan.c   |   9 +-
>>  drivers/mmc/host/sdhci-of-at91.c     |   5 +-
>>  drivers/mmc/host/sdhci-of-esdhc.c    |   3 +
>>  drivers/mmc/host/sdhci-pci-core.c    | 551 ++++++++++++++++++++---------------
>>  drivers/mmc/host/sdhci-pci-data.c    |   3 -
>>  drivers/mmc/host/sdhci-pci-o2micro.c |   4 +-
>>  drivers/mmc/host/sdhci-pci.h         |  24 +-
>>  drivers/mmc/host/sdhci-pltfm.c       |   3 +
>>  drivers/mmc/host/sdhci-pxav3.c       |  10 +-
>>  drivers/mmc/host/sdhci-s3c.c         |  10 +-
>>  drivers/mmc/host/sdhci-sirf.c        |   3 +
>>  drivers/mmc/host/sdhci-spear.c       |   3 +
>>  drivers/mmc/host/sdhci-st.c          |   6 +-
>>  drivers/mmc/host/sdhci.c             | 404 ++++++++++++++++---------
>>  drivers/mmc/host/sdhci.h             |  58 ++--
>>  19 files changed, 691 insertions(+), 434 deletions(-)
>>
>>
>> Regards
>> Adrian
> 

