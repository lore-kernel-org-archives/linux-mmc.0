Return-Path: <SRS0=5kc2=33=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767A2C2D0B1
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493E9222C2
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 07:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGHXE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:23:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:46845 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGHXE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 7 Feb 2020 02:23:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 23:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,412,1574150400"; 
   d="scan'208";a="232298579"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2020 23:23:01 -0800
Subject: Re: [PATCH] mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static
To:     Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20200206162124.201195-1-swboyd@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1cb6f040-e888-0fc9-0bf1-b582fe8eea11@intel.com>
Date:   Fri, 7 Feb 2020 09:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206162124.201195-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/02/20 6:21 pm, Stephen Boyd wrote:
> This function is not exported and only used in this file. Mark it
> static.
> 
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c18047..3955fa5db43c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1590,7 +1590,7 @@ static u32 sdhci_msm_cqe_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> -void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
> +static void sdhci_msm_cqe_disable(struct mmc_host *mmc, bool recovery)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	unsigned long flags;
> 

