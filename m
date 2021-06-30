Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F42C11F68
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FBA61435
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhF3Myy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:54:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:61720 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234761AbhF3Myy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269474314"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="269474314"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="419979517"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 05:52:22 -0700
Subject: Re: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in
 HS400 mode
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
References: <20210624163045.33651-1-alcooperx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a025f2b0-8353-3180-2724-9548e9c38349@intel.com>
Date:   Wed, 30 Jun 2021 15:52:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624163045.33651-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/06/21 7:30 pm, Al Cooper wrote:
> When an eMMC device is being run in HS400 mode, any access to the
> RPMB device will cause the error message "mmc1: Invalid UHS-I mode
> selected". This happens as a result of tuning being disabled before
> RPMB access and then re-enabled after the RPMB access is complete.
> When tuning is re-enabled, the system has to switch from HS400
> to HS200 to do the tuning and then back to HS400. As part of
> sequence to switch from HS400 to HS200 the system is temporarily
> put into HS mode. When switching to HS mode, sdhci_get_preset_value()
> is called and does not have support for HS mode and prints the warning
> message and returns the preset for SDR12. The fix is to add support
> for MMC and SD HS modes to sdhci_get_preset_value().
> 
> This can be reproduced on any system running eMMC in HS400 mode
> (not HS400ES) by using the "mmc" utility to run the following
> command: "mmc rpmb read-counter /dev/mmcblk0rpmb".
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bf238ade1602..6b39126fbf06 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	u16 preset = 0;
>  
>  	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_SD_HS:
> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
> +		break;
>  	case MMC_TIMING_UHS_SDR12:
>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
>  		break;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..960fed78529e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -253,6 +253,7 @@
>  
>  /* 60-FB reserved */
>  
> +#define SDHCI_PRESET_FOR_HIGH_SPEED	0x64
>  #define SDHCI_PRESET_FOR_SDR12 0x66
>  #define SDHCI_PRESET_FOR_SDR25 0x68
>  #define SDHCI_PRESET_FOR_SDR50 0x6A
> 
> base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
> 

