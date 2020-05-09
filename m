Return-Path: <SRS0=X1IY=6X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EDAC28CBC
	for <linux-mmc@archiver.kernel.org>; Sat,  9 May 2020 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8B20A8B
	for <linux-mmc@archiver.kernel.org>; Sat,  9 May 2020 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEIL0T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 9 May 2020 07:26:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:17673 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgEIL0T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 9 May 2020 07:26:19 -0400
IronPort-SDR: 9QtHlhUUo9/daZyv5ee5D114c8JYB9FggUKx7xkrnWEVYYXbUmdbyVmo8cQnpNPiml56Skk18r
 E0BBvq3nKhUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 04:26:19 -0700
IronPort-SDR: HKfzTQaPvRqLKCqudCd2lgZ/PweXKX8hSfKloSuKI+hUhI+5jFEd/k4l/PUhAu9/8nxpilruT8
 w+KyqFvC/ATw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,371,1583222400"; 
   d="scan'208";a="264656512"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 09 May 2020 04:26:16 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jXNcZ-005aYr-Dx; Sat, 09 May 2020 14:26:19 +0300
Date:   Sat, 9 May 2020 14:26:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        linux-mmc@vger.kernel.org, evgreen@chromium.org,
        Joerg Roedel <jroedel@suse.de>,
        Daniel Kurtz <djkurtz@chromium.org>, dianders@chromium.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-acpi: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA for
 AMDI0040
Message-ID: <20200509112619.GC185537@smile.fi.intel.com>
References: <20200508165344.1.Id5bb8b1ae7ea576f26f9d91c761df7ccffbf58c5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508165344.1.Id5bb8b1ae7ea576f26f9d91c761df7ccffbf58c5@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 08, 2020 at 04:54:21PM -0600, Raul E Rangel wrote:
> The AMD eMMC 5.0 controller does not support 64 bit DMA.
> 
> See the discussion here: https://marc.info/?l=linux-mmc&m=158879884514552&w=2

Link: ...

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/host/sdhci-acpi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index faba53cf139b..d8b76cb8698a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -605,10 +605,12 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>  }
>  
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
> -	.chip   = &sdhci_acpi_chip_amd,
> -	.caps   = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> -	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR | SDHCI_QUIRK_32BIT_DMA_SIZE |
> -			SDHCI_QUIRK_32BIT_ADMA_SIZE,
> +	.chip		= &sdhci_acpi_chip_amd,
> +	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> +	.quirks		= SDHCI_QUIRK_32BIT_DMA_ADDR |
> +			  SDHCI_QUIRK_32BIT_DMA_SIZE |
> +			  SDHCI_QUIRK_32BIT_ADMA_SIZE,
> +	.quirks2	= SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
>  	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
>  };
>  
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 
With Best Regards,
Andy Shevchenko


