Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F139DC4332B
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA83D229C5
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbhAENsA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:48:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:1440 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbhAENr7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Jan 2021 08:47:59 -0500
IronPort-SDR: w15NMDQcIHo9vsKz/SQBW/X5rpas3j1hgie1RQsl6VXm2H+bVc+mYyGtYAdMsnLzZixj2UzsUt
 oXlTEQFdWLXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="238657273"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="238657273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 05:47:18 -0800
IronPort-SDR: K+oOaHaTMm745c8x0yJQONHkJSAVG3HVrQAmqA2jXJ7BV8Ngd08TMocGk74SwwVLU82I49e0nR
 gfJydaJf775A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421777717"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 05:47:15 -0800
Subject: Re: [PATCH v6 4/6] mmc: sdhci-of-aspeed: Add KUnit tests for phase
 calculations
To:     Andrew Jeffery <andrew@aj.id.au>, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
References: <20201218035338.1130849-1-andrew@aj.id.au>
 <20201218035338.1130849-5-andrew@aj.id.au>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ff588027-0fbb-100e-05a9-4a804662d838@intel.com>
Date:   Tue, 5 Jan 2021 15:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201218035338.1130849-5-andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18/12/20 5:53 am, Andrew Jeffery wrote:
> Converting degrees of phase to logic delays is irritating to test on
> hardware, so lets exercise the function using KUnit.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/Kconfig                |  14 ++++
>  drivers/mmc/host/Makefile               |   1 +
>  drivers/mmc/host/sdhci-of-aspeed-test.c | 100 ++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 596f32637315..d6f00d1d6251 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -168,6 +168,20 @@ config MMC_SDHCI_OF_ASPEED
>  
>  	  If unsure, say N.
>  
> +config MMC_SDHCI_OF_ASPEED_TEST
> +	bool "Tests for the ASPEED SDHCI driver"
> +	depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
> +	help
> +	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
> +	  option only if you will boot the kernel for the purpose of running
> +	  unit tests (e.g. under UML or qemu).
> +
> +	  The KUnit tests generally exercise parts of the driver that do not
> +	  directly touch the hardware, for example, the phase correction
> +	  calculations.
> +
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_OF_AT91
>  	tristate "SDHCI OF support for the Atmel SDMMC controller"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 451c25fc2c69..3ee59d5802cf 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)	+= sdhci-of-aspeed-test.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> new file mode 100644
> index 000000000000..fb79b278fb81
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (C) 2020 IBM Corp. */
> +
> +#include <kunit/test.h>
> +
> +#include "sdhci-of-aspeed.c"

I am not sure including like that is advisable.  Did you consider instead
doing it the other way around i.e. adding an include to the bottom of
sdhci-of-aspeed.c?
