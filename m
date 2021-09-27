Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEFC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 05:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A446115B
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 05:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhI0Fte (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 01:49:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:52528 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232594AbhI0Fte (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Sep 2021 01:49:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="224467283"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="224467283"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 22:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="437594752"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2021 22:47:53 -0700
Subject: Re: [PATCH v2] mmc: sdhci-sprd: Wait until DLL locked after being
 configured
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20210926092835.146449-1-zhang.lyra@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <847b5295-ba23-107c-6fee-4e766a86ce7a@intel.com>
Date:   Mon, 27 Sep 2021 08:48:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210926092835.146449-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/09/21 12:28 pm, Chunyan Zhang wrote:
> From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> 
> According to the specification, DLL status has to be locked before using it.
> 
> Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes since v1:
> * Use read_poll_timeout() instead of while loop.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 11e375579cfb..f33e9349e4e6 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -39,6 +40,9 @@
>  #define  SDHCI_SPRD_BIT_POSRD_DLY_INV		BIT(21)
>  #define  SDHCI_SPRD_BIT_NEGRD_DLY_INV		BIT(29)
>  
> +#define SDHCI_SPRD_REG_32_DLL_STS0	0x210
> +#define SDHCI_SPRD_DLL_LOCKED		BIT(18)
> +
>  #define SDHCI_SPRD_REG_32_BUSY_POSI		0x250
>  #define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN	BIT(25)
>  #define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN	BIT(24)
> @@ -256,6 +260,15 @@ static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
>  	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
>  	/* wait 1ms */
>  	usleep_range(1000, 1250);
> +
> +	if (read_poll_timeout(sdhci_readl, tmp, (tmp & SDHCI_SPRD_DLL_LOCKED),
> +		2000, USEC_PER_SEC, false, host, SDHCI_SPRD_REG_32_DLL_STS0)) {
> +		pr_err("%s: DLL locked fail!\n", mmc_hostname(host->mmc));
> +		pr_info("%s: DLL_STS0 : 0x%x, DLL_CFG : 0x%x\n",
> +			 mmc_hostname(host->mmc),
> +			 sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_STS0),
> +			 sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG));
> +	}
>  }
>  
>  static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
> 

