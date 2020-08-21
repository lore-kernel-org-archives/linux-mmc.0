Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF12C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D742177B
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUOKe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:10:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:43559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOKd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:10:33 -0400
IronPort-SDR: 7+ybf7RvHrGvlHmSGwLCggg9nJPuGU4Qf+XIO9Jw9ywRNA0PxBZzGQCYSW9jeB8BvwTTrx9gus
 5hqoGgyukG1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="155523767"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="155523767"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:10:33 -0700
IronPort-SDR: NEotgQyb9Crw2rd72xxsF4uRflRDdb1aOpg5Z3NQFTZooi/8A+9VZjgXRZ+ALOte3p4jrek1dO
 v4/UXAUQXgdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="442357481"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2020 07:10:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 14/21] mmc: sdhci: UHS-II support, handle vdd2 in
 case of power-off
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111121.29671-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ef621382-b8b9-e8d2-cc54-3e6377050d5b@intel.com>
Date:   Fri, 21 Aug 2020 17:09:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111121.29671-1-benchuanggli@gmail.com>
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
> Configure a regulator for VDD2 in case of power-off.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7f2537648a08..d38d734ec83f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2333,6 +2333,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		if (!IS_ERR(mmc->supply.vmmc) &&
>  		    ios->power_mode == MMC_POWER_OFF)
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		    host->mmc->caps & MMC_CAP_UHS2 &&
> +		    !IS_ERR(mmc->supply.vmmc2) &&
> +		    ios->power_mode == MMC_POWER_OFF)

Probably this can be just:

		if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
		    ios->power_mode == MMC_POWER_OFF)


> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>  		return;
>  	}
>  
> 

