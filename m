Return-Path: <SRS0=Fy1S=6Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FAC38A2A
	for <linux-mmc@archiver.kernel.org>; Sun, 10 May 2020 11:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA56D2082E
	for <linux-mmc@archiver.kernel.org>; Sun, 10 May 2020 11:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEJLdL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 10 May 2020 07:33:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:47408 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgEJLdL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 10 May 2020 07:33:11 -0400
IronPort-SDR: BM+WVCJ8YwxzliLot2NAsOYRTZdb0X2kGFOyR+DXOzo1vovkIH5fwJPwJxsP/kJHa7CjHy/7kb
 st9sB4tPoxVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 04:33:10 -0700
IronPort-SDR: bbzTw6Pa4c8cK1P5xccWYNySBQ9KLEC0kVLkJC8mCxXwoSWnkfn6UM41eO++O7FBSCaC1w06LD
 HcvAeU2Cjt1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,375,1583222400"; 
   d="scan'208";a="285961094"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2020 04:33:07 -0700
Subject: Re: [PATCH] mmc: sdhci-acpi: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA for
 AMDI0040
To:     Raul E Rangel <rrangel@chromium.org>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>,
        linux-mmc@vger.kernel.org
Cc:     evgreen@chromium.org, Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, dianders@chromium.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20200508165344.1.Id5bb8b1ae7ea576f26f9d91c761df7ccffbf58c5@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <698f2fca-c9f9-6019-3296-63c14b50a373@intel.com>
Date:   Sun, 10 May 2020 14:33:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508165344.1.Id5bb8b1ae7ea576f26f9d91c761df7ccffbf58c5@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/05/20 1:54 am, Raul E Rangel wrote:
> The AMD eMMC 5.0 controller does not support 64 bit DMA.
> 
> See the discussion here: https://marc.info/?l=linux-mmc&m=158879884514552&w=2
> 
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
> 

