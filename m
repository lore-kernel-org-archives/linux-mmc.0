Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D6EC71153
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Sep 2023 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjIDIMB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Sep 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351400AbjIDIL7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Sep 2023 04:11:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FDF9
        for <linux-mmc@vger.kernel.org>; Mon,  4 Sep 2023 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693815115; x=1725351115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ut1hgUg7qR8MGYKvW4DwY+SFcmWK+vtGvn0SuJjBLW0=;
  b=Nhlu1L/y7AypMcqQj2earxKmidX209FsoFry2rqFSokYxcsKeS4aTsSt
   yoa0ku+Rwv1K2QaRdcUphwttQHCyLwRY8v5L6XPmuEcc8ZS0QDB7PMxYi
   kVWmpTmj96XCYONccoG1gIgQhV8LJGbFlshchzHCcZLhTWIlMuNgeAgzq
   3AtZbNAb/uPpYG263SV0K2l4YIXhqyc2WSqioEofpeaBMbgpE8skT021k
   dvNOYS2FJpE5uEwdruufBJivbhJRVDmWZ6E05zT2qKjTnMc80rjlV4gN4
   pgGMFZMlxYjpx4MPMxdwOxyFRT2dU8s1bLu7hefY1cmvWXuNcBP+mq/ER
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="440510762"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="440510762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="987416627"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="987416627"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:11:51 -0700
Message-ID: <24299751-8b13-fe39-07a0-a9e9111241c8@intel.com>
Date:   Mon, 4 Sep 2023 11:11:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Content-Language: en-US
To:     haibo.chen@nxp.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, hkallweit1@gmail.com
References: <20230830093922.3095850-1-haibo.chen@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230830093922.3095850-1-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/08/23 12:39, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> tuning only support in 4-bit mode or 8 bit mode, so in 1-bit mode,
> need to hold retuning.
> 
> Find this issue when use manual tuning method on imx93. When system
> resume back, SDIO WIFI try to switch back to 4 bit mode, first will
> trigger retuning, and all tuning command failed.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

UHS-I is also not meant for 1-bit mode, but I guess switching modes
in this case is also risky.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Fixes tag?

> ---
>  drivers/mmc/core/sdio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index f64b9ac76a5c..5914516df2f7 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -1089,8 +1089,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
>  		}
>  		err = mmc_sdio_reinit_card(host);
>  	} else if (mmc_card_wake_sdio_irq(host)) {
> -		/* We may have switched to 1-bit mode during suspend */
> +		/*
> +		 * We may have switched to 1-bit mode during suspend,
> +		 * need to hold retuning, because tuning only supprt
> +		 * 4-bit mode or 8 bit mode.
> +		 */
> +		mmc_retune_hold_now(host);
>  		err = sdio_enable_4bit_bus(host->card);
> +		mmc_retune_release(host);
>  	}
>  
>  	if (err)

