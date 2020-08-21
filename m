Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A4C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A234E2224D
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgHUOJh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:09:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:13635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgHUOJg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:09:36 -0400
IronPort-SDR: FKCO65XV3GNOEJkOMQbzA9Gch6yfwA8EDgSNTb1nzVGucWcjMZsVUHtqycz7WUH/Sa3gFZ/VAd
 MHB0Xevx+ffg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="217075426"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="217075426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:09:35 -0700
IronPort-SDR: 0gaXXBQ4OOJw6UgRoqkKvIzfdJQglRwfV92/z8XVTVpfJ6iyj2KJfR8phG7v3QYbKRS9yLpiJX
 Xi5Er3JNLtHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="442357202"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2020 07:09:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 13/21] mmc: sdhci: UHS-II support, skip
 signal_voltage_switch()
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111104.29616-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9ab64a9d-cd78-785c-b48f-561048cfe2ed@intel.com>
Date:   Fri, 21 Aug 2020 17:09:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111104.29616-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/20 2:11 pm, Ben Chuang wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> sdhci_start_signal_voltage_switch() should be called only in UHS-I mode,
> and not for UHS-II mode.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5511649946b9..7f2537648a08 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2623,8 +2623,13 @@ int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  	/*
>  	 * Signal Voltage Switching is only applicable for Host Controllers
>  	 * v3.00 and above.
> +	 * But for UHS2, the signal voltage is supplied by vdd2 which is
> +	 * already 1.8v so no voltage switch required.
>  	 */
> -	if (host->version < SDHCI_SPEC_300)
> +	if (host->version < SDHCI_SPEC_300 ||
> +	    (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	     host->version >= SDHCI_SPEC_400 &&
> +	     host->mmc->flags & MMC_UHS2_SUPPORT))

Please look at hooking ->start_signal_voltage_switch() instead


>  		return 0;
>  
>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 

