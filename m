Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54CFC19;
	Mon,  9 Sep 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869176; cv=none; b=nay4VkY6XxjehMmFjffLqo+IEZArI/bjBOT5YdGYYiwQ1GVWqLdagizUteCdxiMb1QedYjFI9TEZBMSEqKMoSgsB6bloTczgHFSYqjBzOOJ9G7KrA0g9OZq38TtLzhjWN5CTFMu+OSV87/kSAJS6yoI06XmfS2HNWI7aaGumFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869176; c=relaxed/simple;
	bh=nqAEbMu0Hl4E+fzQxzAhsUXW7dpGrcqreqBLb5Fu30w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aepy7ckK8JrrVbhaZloG2I/+es4wVMXoWxU5LnlDh7U1dmz5E1Bmu4DlGv2ZlW2KR1xEzd9NSpV66Elpg5XXiQVNLpOMZgZDOgrhEAbINnf/LPNOKa5RcmwpXl59dFr5L1TojMqvYdqyR0meD4pJwEfnGZUOEd0p4CUDuU0ULK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxiriWh+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxiriWh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725869175; x=1757405175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqAEbMu0Hl4E+fzQxzAhsUXW7dpGrcqreqBLb5Fu30w=;
  b=HxiriWh+vu7hlZA4Uaoe1alMOsGEfwTJ/ZeYtbzRNtIWIr806gH7PopW
   lhERfRVFl2GU5AyaJukRaAFkHZVHyWFkTzo7rXV1k5gkfXWK5ACpggvBr
   GqHYgW1f3wLaH16g7nEdf9v+79rgpo4HZ/DkpjaoOHg/a9iAdNxR3cRaQ
   iH7FqgrBDxXxnT6blGBhsJrN+JAAzfoZI5GXSeFvZuZKT+BCYEw2HERse
   hBB9fmTfkHQgEeLkwtKrYGS+nAEe19A3Zev32y+h2RcOusq9ZnTxwhYvq
   XEtlIHdc+NnQspzL0MNZ547MiIuMAb9PqMG8SqvqMo4+HbuNXUW5I5ig7
   g==;
X-CSE-ConnectionGUID: XHBAcfkjQAGkyLPDhEzFzQ==
X-CSE-MsgGUID: uOrwGLAiTMyeybVNnMzixA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24697352"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24697352"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:06:14 -0700
X-CSE-ConnectionGUID: vYlnByAHRSuDY1BYsVO0zg==
X-CSE-MsgGUID: 3FVEY5IUTIyuliY7Z/Ytpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="97302281"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:06:10 -0700
Message-ID: <5ab812d6-da62-4337-8495-3a906c60a2a0@intel.com>
Date: Mon, 9 Sep 2024 11:06:04 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V21 09/22] mmc: sdhci: add UHS-II module and add a kernel
 configuration
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
 <20240906102049.7059-10-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240906102049.7059-10-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/09/24 13:20, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This patch adds sdhci-uhs2.c as a module for UHS-II support.
> This is a skeleton for further development in this patch series.
> 
> This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
> in the following commits to indicate UHS-II specific code in sdhci
> controllers.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Doesn't compile:

drivers/mmc/host/sdhci-uhs2.c:28:12: error: ‘sdhci_uhs2_host_ops_init’ defined but not used [-Werror=unused-function]
   28 | static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/mmc/host/sdhci-uhs2.o] Error 1
make[4]: *** [scripts/Makefile.build:485: drivers/mmc/host] Error 2
make[3]: *** [scripts/Makefile.build:485: drivers/mmc] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/home/ahunter/git/review/Makefile:1925: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

> ---
> 
> Updates in V9:
>  - Modify the commit message.
> 
> Updates in V8:
>  - Modify MODULE_LICENSE from "GPL v2" to "GPL".
> 
> Updates in V6:
>  - Merage V5 of patch[7] and patch[9] in to V6 of patch[8].
> 
> ---
> 
>  drivers/mmc/host/Kconfig      |  9 +++++++
>  drivers/mmc/host/Makefile     |  1 +
>  drivers/mmc/host/sdhci-uhs2.c | 46 +++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7199cb0bd0b9..f636af8a98df 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -98,6 +98,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
>  
>  	  This is the case for the Nintendo Wii SDHCI.
>  
> +config MMC_SDHCI_UHS2
> +	tristate "UHS2 support on SDHCI controller"
> +	depends on MMC_SDHCI
> +	help
> +	  This option is selected by SDHCI controller drivers that want to
> +	  support UHS2-capable devices.
> +
> +	  If you have a controller with this feature, say Y or M here.
> +
>  config MMC_SDHCI_PCI
>  	tristate "SDHCI support on PCI bus"
>  	depends on MMC_SDHCI && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 3ccffebbe59b..5147467ec825 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
>  obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
> +obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> new file mode 100644
> index 000000000000..608f8ad5aaed
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  linux/drivers/mmc/host/sdhci_uhs2.c - Secure Digital Host Controller
> + *  Interface driver
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + *  Copyright (C) 2020 Genesys Logic, Inc.
> + *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *  Copyright (C) 2020 Linaro Limited
> + *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + */
> +
> +#include <linux/module.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-uhs2.h"
> +
> +#define DRIVER_NAME "sdhci_uhs2"
> +#define DBG(f, x...) \
> +	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Driver init/exit                                                          *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static int __init sdhci_uhs2_mod_init(void)
> +{
> +	return 0;
> +}
> +module_init(sdhci_uhs2_mod_init);
> +
> +static void __exit sdhci_uhs2_mod_exit(void)
> +{
> +}
> +module_exit(sdhci_uhs2_mod_exit);
> +
> +MODULE_AUTHOR("Intel, Genesys Logic, Linaro");
> +MODULE_DESCRIPTION("MMC UHS-II Support");
> +MODULE_LICENSE("GPL");

