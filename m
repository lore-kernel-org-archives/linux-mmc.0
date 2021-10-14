Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1128AC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F041A610E8
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 10:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhJNKGd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 06:06:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:5452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhJNKG1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 06:06:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227542851"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227542851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 03:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="571193171"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2021 03:04:04 -0700
Subject: Re: [PATCH v2 6/6] mmc: sdhci-pci: Remove dead code (rst_n_gpio et
 al)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
 <20211013201723.52212-7-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d76c1c8b-5d6e-f4b4-d43f-24155b76e75b@intel.com>
Date:   Thu, 14 Oct 2021 13:04:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013201723.52212-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/10/2021 23:17, Andy Shevchenko wrote:
> There is no user of this member. Remove the dead code for good.
> 
> The removal is dependent on previous removal of cd_gpio, cd_irq.

I got that wrong, I think it is actually dependent on the sdhci_pci_data
removal?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

With above resolved:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 27 ---------------------------
>  drivers/mmc/host/sdhci-pci.h      |  2 --
>  2 files changed, 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index e2b6f60e9f01..6f9877546830 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1915,21 +1915,6 @@ int sdhci_pci_enable_dma(struct sdhci_host *host)
>  	return 0;
>  }
>  
> -static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
> -{
> -	struct sdhci_pci_slot *slot = sdhci_priv(host);
> -	int rst_n_gpio = slot->rst_n_gpio;
> -
> -	if (!gpio_is_valid(rst_n_gpio))
> -		return;
> -	gpio_set_value_cansleep(rst_n_gpio, 0);
> -	/* For eMMC, minimum is 1us but give it 10us for good measure */
> -	udelay(10);
> -	gpio_set_value_cansleep(rst_n_gpio, 1);
> -	/* For eMMC, minimum is 200us but give it 300us for good measure */
> -	usleep_range(300, 1000);
> -}
> -
>  static void sdhci_pci_hw_reset(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -2060,7 +2045,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  
>  	slot->chip = chip;
>  	slot->host = host;
> -	slot->rst_n_gpio = -EINVAL;
>  	slot->cd_idx = -1;
>  
>  	host->hw_name = "PCI";
> @@ -2086,17 +2070,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  			goto cleanup;
>  	}
>  
> -	if (gpio_is_valid(slot->rst_n_gpio)) {
> -		if (!devm_gpio_request(&pdev->dev, slot->rst_n_gpio, "eMMC_reset")) {
> -			gpio_direction_output(slot->rst_n_gpio, 1);
> -			slot->host->mmc->caps |= MMC_CAP_HW_RESET;
> -			slot->hw_reset = sdhci_pci_gpio_hw_reset;
> -		} else {
> -			dev_warn(&pdev->dev, "failed to request rst_n_gpio\n");
> -			slot->rst_n_gpio = -EINVAL;
> -		}
> -	}
> -
>  	host->mmc->pm_caps = MMC_PM_KEEP_POWER;
>  	host->mmc->slotno = slotno;
>  	host->mmc->caps2 |= MMC_CAP2_NO_PRESCAN_POWERUP;
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 8bb3b9c78589..5e3193278ff9 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -157,8 +157,6 @@ struct sdhci_pci_slot {
>  	struct sdhci_pci_chip	*chip;
>  	struct sdhci_host	*host;
>  
> -	int			rst_n_gpio;
> -
>  	int			cd_idx;
>  	bool			cd_override_level;
>  
> 

