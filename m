Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4DC18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9198520719
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 07:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQHnO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:43:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:11926 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgCQHnN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 03:43:13 -0400
IronPort-SDR: pGBkd9xoqMrKjy33jglB3N7Jk5vmrDs15irPHIaO1E2zyydjZE6ieh91x1RzSxvfMu5U5PetHg
 aiYoG1wK3udQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:43:13 -0700
IronPort-SDR: p2xFCBpH3Tx+4ev8zS7+0QaGUobjUl6bFGFtDMCcuuSux7+Ou69GtsD/+3GNfmx574MaVEyxs0
 PuyPuRCFDaQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="443663361"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 00:43:11 -0700
Subject: Re: [PATCH v3 2/2] mmc: sdhci-acpi: Disable write protect detection
 on Acer Aspire Switch 10 (SW5-012)
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
References: <20200316184753.393458-1-hdegoede@redhat.com>
 <20200316184753.393458-2-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <72c3e884-1046-ca58-d090-ec011539755e@intel.com>
Date:   Tue, 17 Mar 2020 09:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316184753.393458-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/03/20 8:47 pm, Hans de Goede wrote:
> On the Acer Aspire Switch 10 (SW5-012) microSD slot always reports the card
> being write-protected even though microSD cards do not have a write-protect
> switch at all.
> 
> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk which when set sets
> the MMC_CAP2_NO_WRITE_PROTECT flag on the controller for the external SD
> slot; and add a DMI quirk table entry which selects this quirk for the
> Acer SW5-012.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - Drop the module option to allow overridig the quirks
> ---
>  drivers/mmc/host/sdhci-acpi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b4c1b2367066..2a2173d953f5 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -80,6 +80,7 @@ struct sdhci_acpi_host {
>  
>  enum {
>  	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
> +	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
>  };
>  
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
> @@ -671,6 +672,18 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
>  	},
> +	{
> +		/*
> +		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
> +		 * reports the card being write-protected even though microSD
> +		 * cards do not have a write-protect switch at all.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
> +		},
> +		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> +	},
>  	{} /* Terminating entry */
>  };
>  
> @@ -795,6 +808,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  
>  		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
>  			c->reset_signal_volt_on_suspend = true;
> +
> +		if (quirks & DMI_QUIRK_SD_NO_WRITE_PROTECT)
> +			host->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
>  	}
>  
>  	err = sdhci_setup_host(host);
> 

