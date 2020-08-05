Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F86C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A152177B
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHEIPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:15:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:22115 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgHEIO7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Aug 2020 04:14:59 -0400
IronPort-SDR: wvgw0Q8gQ+1RDGiKDEem0YI1cC5kaCY4hKl0U8EJcXJPKPHYIMSdHm7tUj8c0dkzQ6VpCVe0uB
 8C0JFfIuWQcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="216858170"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="216858170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:14:58 -0700
IronPort-SDR: FKAEfpxQvRpAwcmWHM4G3+ACM4fCV8GZe1qflhqIUAodCGG1rOJAXWIHTBCMwE7GEg59IlQONp
 i7OyQUfH8AoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="493197775"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 01:14:56 -0700
Subject: Re: [PATCH] mmc: sdhci_am654: Add workaround for card detect debounce
 timer
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org
References: <20200729234130.25056-1-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2d692a90-0e58-ae69-9b5b-c9eb3ffe21ec@intel.com>
Date:   Wed, 5 Aug 2020 11:14:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729234130.25056-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/07/20 2:41 am, Faiz Abbas wrote:
> There is a one time delay because of a card detect debounce timer in the
> controller IP. This timer runs as soon as power is applied to the module
> regardless of whether a card is present or not and any writes to
> SDHCI_POWER_ON will return 0 before it expires. This timeout has been
> measured to be about 1 second in am654x and j721e.
> 
> Write-and-read-back in a loop on SDHCI_POWER_ON for a maximum of
> 1.5 seconds to make sure that the controller actually powers on.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci_am654.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 1718b9e8af63..55cff9de2f3e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -272,6 +272,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  	sdhci_set_clock(host, clock);
>  }
>  
> +#define MAX_POWER_ON_TIMEOUT	1500 /* ms */
>  static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  {
>  	unsigned char timing = host->mmc->ios.timing;
> @@ -291,6 +292,26 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  	}
>  
>  	writeb(val, host->ioaddr + reg);
> +	if (reg == SDHCI_POWER_CONTROL && (val & SDHCI_POWER_ON)) {
> +		/*
> +		 * Power on will not happen until the card detect debounce
> +		 * timer expires. Wait at least 1.5 seconds for the power on
> +		 * bit to be set
> +		 */

Can you use readb_poll_timeout() here?

> +		ktime_t timeout = ktime_add_ms(ktime_get(),
> +					       MAX_POWER_ON_TIMEOUT);
> +		do {
> +			if (ktime_compare(ktime_get(), timeout) > 0) {
> +				dev_warn(mmc_dev(host->mmc),
> +					 "Power on failed\n");
> +
> +				return;
> +			}
> +
> +			writeb(val, host->ioaddr + reg);
> +			usleep_range(1000, 10000);
> +		} while (!(readb(host->ioaddr + reg) & SDHCI_POWER_ON));
> +	}
>  }
>  
>  static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 

