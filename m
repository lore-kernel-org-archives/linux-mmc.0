Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C03C4338F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Aug 2021 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4BD60F35
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Aug 2021 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHCMS0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:18:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:2093 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235269AbhHCMSZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Aug 2021 08:18:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="235611501"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="235611501"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 05:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="466658517"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2021 05:18:11 -0700
Subject: Re: [PATCH V1 1/1]mmc:sdhci-bayhub:fix Qualcomm sd host 845 SD card
 compatibility issue
To:     chevron <chevron.li@bayhubtech.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux.kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com
References: <20210714010742.4707-1-chevron.li@bayhubtech.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5aaf7750-4ecc-505e-9a2c-5f96f2494ec5@intel.com>
Date:   Tue, 3 Aug 2021 15:18:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714010742.4707-1-chevron.li@bayhubtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/07/21 4:07 am, chevron wrote:
> Improve the signal integrity for long SD bus trace by using 845+BH201 SD host redriver chip
> 
> Signed-off-by: chevron.li <chevron.li@bayhubtech.com>
> ---
> change in V1:
> 1. copy Qualcomm driver base from sdhci-msm.c to sdhci-bayhub.c
> 2. implement the BH201 chip initialization function at sdhci-bayhub.c
> 3. implement the BH201 chip power control function at sdhci-bayhub.c
> 4. implement the BH201 chip tuning function at sdhci-bayhub.c
> 5. re-implement mmc_rescan to match BH201 mode switch flow at sdhci-bayhub.c
> ---
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt     |    1 +
>  drivers/mmc/host/Makefile                     |    1 +
>  drivers/mmc/host/sdhci-bayhub.c               | 6563 +++++++++++++++++
>  3 files changed, 6565 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-bayhub.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 4c7fa6a4ed15..a0401dc16929 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -20,6 +20,7 @@ Required properties:
>  		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>  		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
>  		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> +		"qcom,sdm845-bayhub-sdhci", "qcom,sdhci-msm-bayhub-v5"
>  		"qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
>  		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>  	NOTE that some old device tree files may be floating around that only
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 14004cc09aaa..d4d6f4cca732 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)	+= sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
>  obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
> +obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-bayhub.o
>  obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
> diff --git a/drivers/mmc/host/sdhci-bayhub.c b/drivers/mmc/host/sdhci-bayhub.c
> new file mode 100644
> index 000000000000..75029470bd22
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-bayhub.c
> @@ -0,0 +1,6563 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Bayhub Technologies, Inc. BH201 SDHCI bridge IC for
> + * VENDOR SDHCI platform driver source file
> + *
> + * Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The license information is not needed when an SPDX license identifier is used

> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/delay.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +#include <linux/iopoll.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/interconnect.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/io.h>
> +#include <linux/of_gpio.h>
> +
> +#include "sdhci-pltfm.h"
> +#include "cqhci.h"
> +#include "../core/core.h"
> +#include "../core/sd_ops.h"
> +#include "../core/sdio_ops.h"
> +#include "../core/mmc_ops.h"
> +#include "../core/sd.h"
> +#include "../core/bus.h"
> +#include "../core/host.h"
> +#include "../core/card.h"
> +#include "../core/pwrseq.h"
> +

The core headers are not meant to be accessed by host drivers.

You will need to discuss what you are trying to do with Ulf.

But possibly you could consider starting with a simpler driver that
doesn't have the features that need those headers.
