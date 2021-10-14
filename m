Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD8C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4466C6101E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 10:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNKDo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:03:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:48349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhJNKDo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 06:03:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="291134256"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="291134256"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 03:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="571192569"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2021 03:01:37 -0700
Subject: Re: [PATCH v2 4/6] mmc: sdhci-pci: Remove dead code (struct
 sdhci_pci_data et al)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
 <20211013201723.52212-5-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <de61480c-0530-626b-fb4d-fc55a9c0501d@intel.com>
Date:   Thu, 14 Oct 2021 13:01:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013201723.52212-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/2021 23:17, Andy Shevchenko wrote:
> The last user of this struct gone couple of releases ago. Besides that
> there were not so many users of this API for 10+ years: one is implied
> above Intel Merrifield (added 20160831 by 3976b0380b31, removed 20210211
> by 4590d98f5a4f), and another is Intel Sunrisepoint (added 20150206 by
> e1bfad6d936d, removed 20170320 by 51ced59cc02e).

Please use the standard way of showing commits
i.e. commit xxxxxxxxxxxx ("blah blah")

> 
> Effectively this is a revert of the commit 52c506f0bc72 ("mmc: sdhci-pci:
> add platform data").
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

With above change:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Makefile          |  1 -
>  drivers/mmc/host/sdhci-pci-core.c  | 31 ++++--------------------------
>  drivers/mmc/host/sdhci-pci-data.c  |  6 ------
>  drivers/mmc/host/sdhci-pci.h       |  1 -
>  include/linux/mmc/sdhci-pci-data.h | 18 -----------------
>  5 files changed, 4 insertions(+), 53 deletions(-)
>  delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
>  delete mode 100644 include/linux/mmc/sdhci-pci-data.h
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 14004cc09aaa..ea36d379bd3c 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -14,7 +14,6 @@ obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> -obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 19e13dfae593..8938c63b1e77 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -17,8 +17,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
> -#include <linux/mmc/host.h>
> -#include <linux/mmc/mmc.h>
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -26,11 +24,13 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/debugfs.h>
> -#include <linux/mmc/slot-gpio.h>
> -#include <linux/mmc/sdhci-pci-data.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/slot-gpio.h>
> +
>  #ifdef CONFIG_X86
>  #include <asm/iosf_mbi.h>
>  #endif
> @@ -2131,22 +2131,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	slot->cd_gpio = -EINVAL;
>  	slot->cd_idx = -1;
>  
> -	/* Retrieve platform data if there is any */
> -	if (*sdhci_pci_get_data)
> -		slot->data = sdhci_pci_get_data(pdev, slotno);
> -
> -	if (slot->data) {
> -		if (slot->data->setup) {
> -			ret = slot->data->setup(slot->data);
> -			if (ret) {
> -				dev_err(&pdev->dev, "platform setup failed\n");
> -				goto free;
> -			}
> -		}
> -		slot->rst_n_gpio = slot->data->rst_n_gpio;
> -		slot->cd_gpio = slot->data->cd_gpio;
> -	}
> -
>  	host->hw_name = "PCI";
>  	host->ops = chip->fixes && chip->fixes->ops ?
>  		    chip->fixes->ops :
> @@ -2233,10 +2217,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		chip->fixes->remove_slot(slot, 0);
>  
>  cleanup:
> -	if (slot->data && slot->data->cleanup)
> -		slot->data->cleanup(slot->data);
> -
> -free:
>  	sdhci_free_host(host);
>  
>  	return ERR_PTR(ret);
> @@ -2259,9 +2239,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
>  	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
>  		slot->chip->fixes->remove_slot(slot, dead);
>  
> -	if (slot->data && slot->data->cleanup)
> -		slot->data->cleanup(slot->data);
> -
>  	sdhci_free_host(slot->host);
>  }
>  
> diff --git a/drivers/mmc/host/sdhci-pci-data.c b/drivers/mmc/host/sdhci-pci-data.c
> deleted file mode 100644
> index 18638fb363d8..000000000000
> --- a/drivers/mmc/host/sdhci-pci-data.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -#include <linux/module.h>
> -#include <linux/mmc/sdhci-pci-data.h>
> -
> -struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev, int slotno);
> -EXPORT_SYMBOL_GPL(sdhci_pci_get_data);
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 8f90c4163bb5..15b36cd47860 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -156,7 +156,6 @@ struct sdhci_pci_fixes {
>  struct sdhci_pci_slot {
>  	struct sdhci_pci_chip	*chip;
>  	struct sdhci_host	*host;
> -	struct sdhci_pci_data	*data;
>  
>  	int			rst_n_gpio;
>  	int			cd_gpio;
> diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
> deleted file mode 100644
> index 1d42872d22f3..000000000000
> --- a/include/linux/mmc/sdhci-pci-data.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef LINUX_MMC_SDHCI_PCI_DATA_H
> -#define LINUX_MMC_SDHCI_PCI_DATA_H
> -
> -struct pci_dev;
> -
> -struct sdhci_pci_data {
> -	struct pci_dev	*pdev;
> -	int		slotno;
> -	int		rst_n_gpio; /* Set to -EINVAL if unused */
> -	int		cd_gpio;    /* Set to -EINVAL if unused */
> -	int		(*setup)(struct sdhci_pci_data *data);
> -	void		(*cleanup)(struct sdhci_pci_data *data);
> -};
> -
> -extern struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev,
> -				int slotno);
> -#endif
> 

