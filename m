Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A74C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 13:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924F92063A
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 13:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXNdZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:33:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:43488 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgHXNdO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Aug 2020 09:33:14 -0400
IronPort-SDR: 2D4dXapw2Ok0EFldyAM5TYdg1eNdqTggsVoaaCE2xGrwK/wBMUd9/EWvEKpR7fhMQ9l6Q+ah5Y
 m3cqgTCrQl8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="173938302"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="173938302"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 06:33:13 -0700
IronPort-SDR: 4Qfwc64MzVWdtwY0dPovl9VQ59BfNIp7eWEPhwngTQ9ZBWYH9N/ByT/fDjubetG787Rbtlf9g1
 sKsXdKwwpa9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="298717171"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2020 06:33:06 -0700
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: remove unused code
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <1598265914-23606-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1909bee2-3080-1eef-67d4-a1ca6fbaffe0@intel.com>
Date:   Mon, 24 Aug 2020 16:32:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598265914-23606-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/20 1:45 pm, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Value assigned to a variable(err) is never used, so remove it
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3d6eaf490d4a..3d2615eb7d56 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1673,10 +1673,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		goto disable_ipg_clk;
>  
>  	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
> -	if (IS_ERR(imx_data->pinctrl)) {
> -		err = PTR_ERR(imx_data->pinctrl);
> +	if (IS_ERR(imx_data->pinctrl))
>  		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
> -	}
>  
>  	if (esdhc_is_usdhc(imx_data)) {
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> 

