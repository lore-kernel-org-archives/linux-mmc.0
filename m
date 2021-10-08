Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6446FC433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B38961037
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 09:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhJHJry (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:47:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:42568 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238771AbhJHJrw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Oct 2021 05:47:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="223883223"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="223883223"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 02:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="524977886"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2021 02:45:09 -0700
Subject: Re: [PATCH v1 5/6] mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq
 et al)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <20211005102430.63716-6-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <05957c44-73f2-b53f-a23f-9f7d19cfe10b@intel.com>
Date:   Fri, 8 Oct 2021 12:45:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005102430.63716-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 05/10/2021 13:24, Andy Shevchenko wrote:
> The last user of this struct gone couple of releases ago.
> Remove the dead code for good and encourage people to use
> MMC core functionality for that.

So this is dependent on patch 4 i.e. that patch removed the
references to the code being removed in this patch.  Please
make a note of that in the commit message.


> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 76 +------------------------------
>  drivers/mmc/host/sdhci-pci.h      |  2 -
>  2 files changed, 1 insertion(+), 77 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 8d01285e1b32..a4279437bb5f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -345,73 +345,6 @@ static int pch_hc_probe_slot(struct sdhci_pci_slot *slot)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -
> -static irqreturn_t sdhci_pci_sd_cd(int irq, void *dev_id)
> -{
> -	struct sdhci_pci_slot *slot = dev_id;
> -	struct sdhci_host *host = slot->host;
> -
> -	mmc_detect_change(host->mmc, msecs_to_jiffies(200));
> -	return IRQ_HANDLED;
> -}
> -
> -static void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
> -{
> -	int err, irq, gpio = slot->cd_gpio;
> -
> -	slot->cd_gpio = -EINVAL;
> -	slot->cd_irq = -EINVAL;
> -
> -	if (!gpio_is_valid(gpio))
> -		return;
> -
> -	err = devm_gpio_request(&slot->chip->pdev->dev, gpio, "sd_cd");
> -	if (err < 0)
> -		goto out;
> -
> -	err = gpio_direction_input(gpio);
> -	if (err < 0)
> -		goto out_free;
> -
> -	irq = gpio_to_irq(gpio);
> -	if (irq < 0)
> -		goto out_free;
> -
> -	err = request_irq(irq, sdhci_pci_sd_cd, IRQF_TRIGGER_RISING |
> -			  IRQF_TRIGGER_FALLING, "sd_cd", slot);
> -	if (err)
> -		goto out_free;
> -
> -	slot->cd_gpio = gpio;
> -	slot->cd_irq = irq;
> -
> -	return;
> -
> -out_free:
> -	devm_gpio_free(&slot->chip->pdev->dev, gpio);
> -out:
> -	dev_warn(&slot->chip->pdev->dev, "failed to setup card detect wake up\n");
> -}
> -
> -static void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
> -{
> -	if (slot->cd_irq >= 0)
> -		free_irq(slot->cd_irq, slot);
> -}
> -
> -#else
> -
> -static inline void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
> -{
> -}
> -
> -static inline void sdhci_pci_remove_own_cd(struct sdhci_pci_slot *slot)
> -{
> -}
> -
> -#endif
> -
>  static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
> @@ -2113,7 +2046,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	slot->chip = chip;
>  	slot->host = host;
>  	slot->rst_n_gpio = -EINVAL;
> -	slot->cd_gpio = -EINVAL;
>  	slot->cd_idx = -1;
>  
>  	host->hw_name = "PCI";
> @@ -2184,15 +2116,11 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	if (ret)
>  		goto remove;
>  
> -	sdhci_pci_add_own_cd(slot);
> -
>  	/*
>  	 * Check if the chip needs a separate GPIO for card detect to wake up
>  	 * from runtime suspend.  If it is not there, don't allow runtime PM.
> -	 * Note sdhci_pci_add_own_cd() sets slot->cd_gpio to -EINVAL on failure.
>  	 */
> -	if (chip->fixes && chip->fixes->own_cd_for_runtime_pm &&
> -	    !gpio_is_valid(slot->cd_gpio) && slot->cd_idx < 0)
> +	if (chip->fixes && chip->fixes->own_cd_for_runtime_pm && slot->cd_idx < 0)
>  		chip->allow_runtime_pm = false;
>  
>  	return slot;
> @@ -2212,8 +2140,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
>  	int dead;
>  	u32 scratch;
>  
> -	sdhci_pci_remove_own_cd(slot);
> -
>  	dead = 0;
>  	scratch = readl(slot->host->ioaddr + SDHCI_INT_STATUS);
>  	if (scratch == (u32)-1)
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 15b36cd47860..8bb3b9c78589 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -158,8 +158,6 @@ struct sdhci_pci_slot {
>  	struct sdhci_host	*host;
>  
>  	int			rst_n_gpio;
> -	int			cd_gpio;
> -	int			cd_irq;
>  
>  	int			cd_idx;
>  	bool			cd_override_level;
> 

