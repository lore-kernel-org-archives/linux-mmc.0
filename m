Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01335C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A732176D
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgBRH71 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:59:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:56313 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgBRH71 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 02:59:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 23:59:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="314981100"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2020 23:59:23 -0800
Subject: Re: [PATCH v3 12/14] mmc: sdhci-esdhc-imx: restore pin state when
 resume back
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, linus.walleij@linaro.org
References: <1581324597-31031-1-git-send-email-haibo.chen@nxp.com>
 <1581324597-31031-7-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <df1c1a87-24d4-008f-a9ee-3998bf75d5b6@intel.com>
Date:   Tue, 18 Feb 2020 09:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581324597-31031-7-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/02/20 10:49 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> In some low power mode, SoC will lose the pin state, so need to restore
> the pin state when resume back.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 106097cbd0d4..dedc067cd0dd 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1717,7 +1717,13 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	return sdhci_suspend_host(host);
> +	ret = sdhci_suspend_host(host);
> +	if (!ret)
> +		if (pinctrl_pm_select_sleep_state(dev))
> +			dev_warn(mmc_dev(host->mmc),
> +			 "%s, failed to select sleep pin state!\n", __func__);

It looks to me like pinctrl_pm_select_sleep_state() prints an error anyway
if it fails, so the warning here is redundant.

Also a comment about why it is OK to ignore an error could be added.

> +
> +	return ret;
>  }
>  
>  static int sdhci_esdhc_resume(struct device *dev)
> @@ -1725,6 +1731,10 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (pinctrl_pm_select_default_state(dev))
> +		dev_warn(mmc_dev(host->mmc),
> +		 "%s, failed to select default pin state!\n", __func__);

Same as above

> +
>  	/* re-initialize hw state in case it's lost in low power mode */
>  	sdhci_esdhc_imx_hwinit(host);
>  
> 

