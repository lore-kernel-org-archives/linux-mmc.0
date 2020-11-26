Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671AC63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7289920B80
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbgKZIRN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:17:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:6124 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgKZIRN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:17:13 -0500
IronPort-SDR: CbN/qOfI4H+UakpLGE1GJiqAyQsQF4J36zfa1yW7FcH86UrJzgzdj7aNG7D5G4AJXPD3tZoAJL
 OKhBOCuvElrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190406024"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="190406024"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:17:13 -0800
IronPort-SDR: 56XHBIs9T/Ssg+tTYnPatBL3+5DSKhf7z7AI/ilH01mF+BYHhbQ7V0z1MkRsgoD5bk4neH9lqd
 KPNSWDnpQVCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362721688"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:17:08 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 14/27] mmc: sdhci-uhs2: skip
 signal_voltage_switch()
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-15-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d2bb08b8-b3d0-3956-70ff-a21ab8a0fe30@intel.com>
Date:   Thu, 26 Nov 2020 10:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-15-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
> so no voltage switch required.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 2bf78cc4e9ed..1eca89359351 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -178,6 +178,29 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * MMC callbacks                                                             *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
> +						  struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	/*
> +	 * For UHS2, the signal voltage is supplied by vdd2 which is
> +	 * already 1.8v so no voltage switch required.
> +	 */
> +        if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +             host->version >= SDHCI_SPEC_400 &&
> +             host->mmc->flags & MMC_UHS2_SUPPORT)

Could this be the same helper function suggested elsewhere i.e.

	if (!sdhci_uhs2_mode(host))

> +                return 0;
> +
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -186,6 +209,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
>  
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
> +	host->mmc_host_ops.start_signal_voltage_switch =
> +		sdhci_uhs2_start_signal_voltage_switch;
> +
>  	return 0;
>  }
>  
> 

