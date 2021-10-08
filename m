Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7062C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F6D61029
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbhJHJrt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:47:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:40097 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238853AbhJHJrs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="287355769"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="287355769"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="524978001"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2021 02:45:48 -0700
Subject: Re: [PATCH v1 6/6] mmc: sdhci-pci: Remove dead code (rst_n_gpio et
 al)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <20211005102430.63716-7-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <892a121b-dbfe-fdbc-f58d-08b9789ccaf8@intel.com>
Date:   Fri, 8 Oct 2021 12:45:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005102430.63716-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/10/2021 13:24, Andy Shevchenko wrote:
> There is no user of this member. Remove the dead code for good.

So this is dependent on patch 5 i.e. that patch removed the
references to the code being removed in this patch.  Please
make a note of that in the commit message.


> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 27 ---------------------------
>  drivers/mmc/host/sdhci-pci.h      |  2 --
>  2 files changed, 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index a4279437bb5f..6c284e07675e 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1900,21 +1900,6 @@ int sdhci_pci_enable_dma(struct sdhci_host *host)
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
> @@ -2045,7 +2030,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  
>  	slot->chip = chip;
>  	slot->host = host;
> -	slot->rst_n_gpio = -EINVAL;
>  	slot->cd_idx = -1;
>  
>  	host->hw_name = "PCI";
> @@ -2071,17 +2055,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
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

