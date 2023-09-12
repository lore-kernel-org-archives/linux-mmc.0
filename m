Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07740CA0ECA
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 10:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjILKCj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjILKCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 06:02:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35FBE64
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694512954; x=1726048954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jbNi6s2f3+aSt9AnkJiw8qvkOJ1tp9VRDcCHn9MIup0=;
  b=El0zX5GiJ9Tf/R1Zxi2MLGEp72qbzE/Xbpv80bI/e/VMgKTTNZTzt0Qf
   GSdcZy7tR/n1KnviDMowBlvkXw12ACkk0VpC/ODbCoQMD3R3IRSsdIBXc
   JOgqXlMdS3K4emPFhUrhd6yHpfEaB4gqgfw9WUGS07KjVelBDAITMsPuB
   3xijmGqg4aLKXSmht+uPtPrIvrNAsD8hoxLiCfSM7qySzbcXMF5y0UXgj
   ERu/OOCTqrccHM/qDXg+4VRPz/N/8KihxXwQboxuNcpEOpgxAfAgW+sZD
   X3s7/Z1oxtnBfOuwjF3asMig0LrkWnHisZilRPhmZ9CdCH7cgmqot8ktP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358605308"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358605308"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867313216"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867313216"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:02:30 -0700
Message-ID: <1cfe3e6d-159f-f2d2-d3d7-54847734023b@intel.com>
Date:   Tue, 12 Sep 2023 13:02:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: optimize the manual tuing logic to
 get the best timing
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
References: <20230831032647.3128702-1-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230831032647.3128702-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/08/23 06:26, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Current manual tuning logic only get the first pass window, but
> this pass window maybe not the best pass window.
> 
> Now find all the pass window, and chose the largest pass window,
> and use the average value of this largest pass window to get the
> best timing.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 52 +++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6170b7121f36..4cbbc0a786a0 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1154,32 +1154,52 @@ static void esdhc_post_tuning(struct sdhci_host *host)
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  }
>  
> +/*
> + * find the largest pass window, and use the average delay of this
> + * largest window to get the best timing.
> + */
>  static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	int min, max, avg, ret;
> +	int win_length, target_min, target_max, target_win_length;
>  
> -	/* find the mininum delay first which can pass tuning */
>  	min = ESDHC_TUNE_CTRL_MIN;
> -	while (min < ESDHC_TUNE_CTRL_MAX) {
> -		esdhc_prepare_tuning(host, min);
> -		if (!mmc_send_tuning(host->mmc, opcode, NULL))
> -			break;
> -		min += ESDHC_TUNE_CTRL_STEP;
> -	}
> -
> -	/* find the maxinum delay which can not pass tuning */
> -	max = min + ESDHC_TUNE_CTRL_STEP;
> +	max = ESDHC_TUNE_CTRL_MIN;
> +	target_win_length = 0;
>  	while (max < ESDHC_TUNE_CTRL_MAX) {
> -		esdhc_prepare_tuning(host, max);
> -		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> -			max -= ESDHC_TUNE_CTRL_STEP;
> -			break;
> +		/* find the mininum delay first which can pass tuning */
> +		while (min < ESDHC_TUNE_CTRL_MAX) {
> +			esdhc_prepare_tuning(host, min);
> +			if (!mmc_send_tuning(host->mmc, opcode, NULL))
> +				break;
> +			min += ESDHC_TUNE_CTRL_STEP;
>  		}
> -		max += ESDHC_TUNE_CTRL_STEP;
> +
> +		/* find the maxinum delay which can not pass tuning */
> +		max = min + ESDHC_TUNE_CTRL_STEP;
> +		while (max < ESDHC_TUNE_CTRL_MAX) {
> +			esdhc_prepare_tuning(host, max);
> +			if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +				max -= ESDHC_TUNE_CTRL_STEP;
> +				break;
> +			}
> +			max += ESDHC_TUNE_CTRL_STEP;
> +		}
> +
> +		win_length = max - min + 1;
> +		/* get the largest pass window */
> +		if (win_length > target_win_length) {
> +			target_win_length = win_length;
> +			target_min = min;
> +			target_max = max;
> +		}
> +
> +		/* continue to find the next pass window */
> +		min = max + ESDHC_TUNE_CTRL_STEP;
>  	}
>  
>  	/* use average delay to get the best timing */
> -	avg = (min + max) / 2;
> +	avg = (target_min + target_max) / 2;
>  	esdhc_prepare_tuning(host, avg);
>  	ret = mmc_send_tuning(host->mmc, opcode, NULL);
>  	esdhc_post_tuning(host);

