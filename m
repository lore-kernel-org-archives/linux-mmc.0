Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17685C433ED
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF14C611EE
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 09:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhECJnf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 May 2021 05:43:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:30461 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhECJnf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 May 2021 05:43:35 -0400
IronPort-SDR: XLhJRw3IjCdep6j3R+GJTUQVT3GtQrKwfU974j2xpEJodqbCI9q/yEpeuUjRrnFpOfkntB6p4p
 txiZXY/A+DAw==
X-IronPort-AV: E=McAfee;i="6200,9189,9972"; a="197758839"
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="197758839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 02:42:42 -0700
IronPort-SDR: yaEPbF0DDDrPMtjtpt8QJLoTnmz91JXt5JD7t8lB3zcIN0PKEtkFF3BBG0XTxlKNUofkUNWxAE
 WrvUIAgJEUZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,268,1613462400"; 
   d="scan'208";a="467960911"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2021 02:42:40 -0700
Subject: Re: [PATCH] mmc: sdhci-acpi: Disable write protect detection on
 Toshiba Encore 2 WT8-B
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
References: <20210503092157.5689-1-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <93c4c4ea-e1f4-4a10-cb66-b57885296c89@intel.com>
Date:   Mon, 3 May 2021 12:43:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503092157.5689-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/05/21 12:21 pm, Hans de Goede wrote:
> On the Toshiba Encore 2 WT8-B the  microSD slot always reports the card
> being write-protected even though microSD cards do not have a write-protect
> switch at all.
> 
> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk entry to sdhci-acpi.c's
> DMI quirk table for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index b6574e7fd26b..9e4358d7a0a6 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -820,6 +820,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
>  	},
> +	{
> +		/*
> +		 * The Toshiba WT8-B's microSD slot always reports the card being
> +		 * write-protected.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA ENCORE 2 WT8-B"),
> +		},
> +		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
> +	},
>  	{} /* Terminating entry */
>  };
>  
> 

