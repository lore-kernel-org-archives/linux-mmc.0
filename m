Return-Path: <SRS0=abg9=DX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C4C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF2620878
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 08:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394759AbgJPIqN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:46:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:43025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394758AbgJPIqM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 16 Oct 2020 04:46:12 -0400
IronPort-SDR: chggaPFl9FfnfbBU1ivL8D0DyIMdwRHMfi9AJPLUR+fJWPVmPGyfWHMf+a/T8/JYTgbywZOweY
 yXdRSdXsbfeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="163090125"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="163090125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 01:46:12 -0700
IronPort-SDR: 8LLpAYwz9KCocTN2dUijC/LibC0f7DgLVp2iZzFYUccnI54ez/AHz3q+79kD8Z79B0bnAma9YA
 Dn74ihBSFEaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="522165891"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2020 01:46:10 -0700
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <20201015231149.9333-1-michael@walle.cc>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d3546633-18d6-9ebf-0581-a3bf043178c3@intel.com>
Date:   Fri, 16 Oct 2020 11:45:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015231149.9333-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/10/20 2:11 am, Michael Walle wrote:
> On rare occations there is the following error:
> 
>   mmc0: Tuning timeout, falling back to fixed sampling clock
> 
> There are SD cards which takes a significant longer time to reply to the
> first CMD19 command. The eSDHC takes the data timeout value into account
> during the tuning period. The SDHCI core doesn't explicitly set this
> timeout for the tuning procedure. Thus on the slow cards, there might be
> a spurious "Buffer Read Ready" interrupt, which in turn triggers a wrong
> sequence of events. In the end this will lead to an unsuccessful tuning
> procedure and to the above error.
> 
> To workaround this, set the timeout to the maximum value (which is the
> best we can do) and the SDHCI core will take care of the proper timeout
> handling.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 0b45eff6fed4..baf7801a1804 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1052,6 +1052,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	esdhc_tuning_block_enable(host, true);
>  
> +	/*
> +	 * The eSDHC controller takes the data timeout value into account
> +	 * during tuning. If the SD card is too slow sending the response, the
> +	 * timer will expire and a "Buffer Read Ready" interrupt without data
> +	 * is triggered. This leads to tuning errors.
> +	 *
> +	 * Just set the timeout to the maximum value because the core will
> +	 * already take care of it in sdhci_send_tuning().
> +	 */
> +	sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
> +
>  	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
>  
>  	do {
> 

