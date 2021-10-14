Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D35C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E50D610CF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJNJ4N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 05:56:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:16402 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhJNJ4M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 05:56:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="225100923"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="225100923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 02:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="571190575"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2021 02:54:04 -0700
Subject: Re: [PATCH v2 1/6] mmc: sdhci-pci: Read card detect from ACPI for
 Intel Merrifield
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
 <20211013201723.52212-2-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ca00991c-f2ab-645a-a297-018d7b6b0b41@intel.com>
Date:   Thu, 14 Oct 2021 12:54:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013201723.52212-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/2021 23:17, Andy Shevchenko wrote:
> Intel Merrifield platform had been converted to use ACPI enumeration.
> However, the driver missed an update to retrieve card detect GPIO.
> Fix it here.
> 
> Unfortunately we can't rely on CD GPIO state because there are two
> different PCB designs in the wild that are using the opposite card
> detection sense and there is no way to distinguish those platforms,
> that's why ignore CD GPIO completely and use it only as an event.
> 
> Fixes: 4590d98f5a4f ("sfi: Remove framework for deprecated firmware")
> BugLink: https://github.com/edison-fw/meta-intel-edison/issues/135
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index be19785227fe..d0f2edfe296c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -616,16 +616,12 @@ static int intel_select_drive_strength(struct mmc_card *card,
>  	return intel_host->drv_strength;
>  }
>  
> -static int bxt_get_cd(struct mmc_host *mmc)
> +static int sdhci_get_cd_nogpio(struct mmc_host *mmc)
>  {
> -	int gpio_cd = mmc_gpio_get_cd(mmc);
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	if (!gpio_cd)
> -		return 0;
> -
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->flags & SDHCI_DEVICE_DEAD)
> @@ -638,6 +634,21 @@ static int bxt_get_cd(struct mmc_host *mmc)
>  	return ret;
>  }
>  
> +static int bxt_get_cd(struct mmc_host *mmc)
> +{
> +	int gpio_cd = mmc_gpio_get_cd(mmc);
> +
> +	if (!gpio_cd)
> +		return 0;
> +
> +	return sdhci_get_cd_nogpio(mmc);
> +}
> +
> +static int mrfld_get_cd(struct mmc_host *mmc)
> +{
> +	return sdhci_get_cd_nogpio(mmc);
> +}
> +
>  #define SDHCI_INTEL_PWR_TIMEOUT_CNT	20
>  #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
>  
> @@ -1341,6 +1352,14 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  					 MMC_CAP_1_8V_DDR;
>  		break;
>  	case INTEL_MRFLD_SD:
> +		slot->cd_idx = 0;
> +		slot->cd_override_level = true;
> +		/*
> +		 * There are two PCB designs of SD card slot with the opposite
> +		 * card detection sense. Quirk this out by ignoring GPIO state
> +		 * completely in the custom ->get_cd() callback.
> +		 */
> +		slot->host->mmc_host_ops.get_cd = mrfld_get_cd;
>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  		break;
>  	case INTEL_MRFLD_SDIO:
> 

