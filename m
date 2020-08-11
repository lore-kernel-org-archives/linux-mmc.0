Return-Path: <SRS0=iZb8=BV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02399C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 12:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB14E2076B
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 12:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgHKMvu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:51:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:27028 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgHKMvu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Aug 2020 08:51:50 -0400
IronPort-SDR: AD87MptztKCULHvXjT4Zz3bJdZgt+fR4zn6ZyNBlp386iG50kvXdB/22+gVP8+PSNC6Kykm5Ar
 gWLVcLvXAh7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151392710"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="151392710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 05:51:49 -0700
IronPort-SDR: 6w4t7igL5w7Hc7VzAdA+1JW4ZwnCGW1t90B4Vz8C4HDmXfLlRoLIXIBYrUpTPesQnC8wUvolwh
 vNxXzm4ighPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="326839015"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2020 05:51:46 -0700
Subject: Re: [PATCH v2] mmc: host: sdhci-esdhc-imx: reset usdhc before sending
 tuning command for manual tuning method
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <1597135057-22272-1-git-send-email-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <41017141-7b84-fa33-6157-a0a17ff8b8ce@intel.com>
Date:   Tue, 11 Aug 2020 15:51:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597135057-22272-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/08/20 11:37 am, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> According to IC suggestion, everytime before sending the tuning command,
> need to reset the usdhc, so to reset the tuning circuit, to let every
> tuning command work well for the manual tuning method. For standard
> tuning method, IC already add the reset operation in the hardware logic.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a76b4513fbec..cf335c661cc7 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -987,10 +987,20 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  {
>  	u32 reg;
> +	u8 sw_rst;
> +	int ret;
>  
>  	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
>  	mdelay(1);
>  
> +	/* IC suggest to reset USDHC before every tuning command */
> +	esdhc_clrset_le(host, 0xff, SDHCI_RESET_ALL, SDHCI_SOFTWARE_RESET);
> +	ret = readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET, sw_rst,
> +				!(sw_rst & SDHCI_RESET_ALL), 10, 100);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(mmc_dev(host->mmc),
> +		"warning! RESET_ALL never complete before sending tuning command\n");
> +
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
>  	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
>  			ESDHC_MIX_CTRL_FBCLK_SEL;
> 

