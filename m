Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832BDC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB6CF2086A
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgHFQ4i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:56:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:51810 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbgHFQ40 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 12:56:26 -0400
IronPort-SDR: BHjRSx/QJzLP6+4XSosV0MiRp/Cg0u2QDTGUv74ds8AbitMg9GfWfKoqfk3Xkz+HqTZGfLDF/K
 dyqhnyzQV0Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152013500"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="152013500"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 05:11:43 -0700
IronPort-SDR: aIWq0USTfCsA0J51HaCgdt1mtxZ9bVN5RLLMW++jXM/vm3cxbyJsJUecAQha5zRwwJA0oG/aNd
 9bIVJM7rUiyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="493643812"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2020 05:11:33 -0700
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d3e56b01-144b-17cf-d414-9e0d558b9bcc@intel.com>
Date:   Thu, 6 Aug 2020 15:11:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596714504-16313-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/08/20 2:48 pm, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> According to IC suggestion, everytime before sending the tuning command,
> need to reset the usdhc, so to reset the tuning circuit, to let every
> tuning command work well for the manual tuning method. For standard
> tuning method, IC already add the reset operation in the logic.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a76b4513fbec..e4694eb1b914 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -990,6 +990,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  
>  	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
>  	mdelay(1);
> +	sdhci_reset(host, SDHCI_RESET_ALL);

Doesn't that reset all registers i.e. the entire ios state?

>  
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
> 

