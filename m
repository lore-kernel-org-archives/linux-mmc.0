Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338FC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D859610FD
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 12:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbhIXMbr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 08:31:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:7788 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244404AbhIXMbr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 08:31:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="224092822"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="224092822"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 05:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="559292369"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2021 05:30:10 -0700
Subject: Re: [PATCH] mmc: sdhci-sprd: Wait until DLL locked after being
 configured
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20210923085750.71968-1-zhang.lyra@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2ba7f698-f16f-0999-53aa-dccb4411de8f@intel.com>
Date:   Fri, 24 Sep 2021 15:30:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923085750.71968-1-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/09/21 11:57 am, Chunyan Zhang wrote:
> From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> 
> According to the specification, DLL status has to be locked before using it.
> 
> Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/mmc/host/sdhci-sprd.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 11e375579cfb..83749c7a6db4 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -39,6 +39,9 @@
>  #define  SDHCI_SPRD_BIT_POSRD_DLY_INV		BIT(21)
>  #define  SDHCI_SPRD_BIT_NEGRD_DLY_INV		BIT(29)
>  
> +#define SDHCI_SPRD_REG_32_DLL_STS0	0x210
> +#define SDHCI_SPRD_DLL_LOCKED		BIT(18)
> +
>  #define SDHCI_SPRD_REG_32_BUSY_POSI		0x250
>  #define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN	BIT(25)
>  #define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN	BIT(24)
> @@ -236,7 +239,7 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>  
>  static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
>  {
> -	u32 tmp;
> +	u32 tmp, timeout = 1000;
>  
>  	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
>  	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
> @@ -256,6 +259,21 @@ static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
>  	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
>  	/* wait 1ms */
>  	usleep_range(1000, 1250);
> +
> +	while (--timeout) {
> +		if ((sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_STS0) &
> +		     SDHCI_SPRD_DLL_LOCKED))
> +			break;
> +		usleep_range(1000, 1250);
> +	}
> +
> +	if (!timeout) {

This could use read_poll_timeout() instead e.g.

	if (read_poll_timeout(sdhci_readl, tmp, (tmp & SDHCI_SPRD_DLL_LOCKED),
	    2000, USEC_PER_SEC, false, host, SDHCI_SPRD_REG_32_DLL_STS0)) {




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

