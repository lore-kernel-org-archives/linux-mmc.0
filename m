Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55080C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiCGMt6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiCGMt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2022 07:49:58 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B474C407
        for <linux-mmc@vger.kernel.org>; Mon,  7 Mar 2022 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646657344; x=1678193344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ztz8XJhtQhJtPhab7sg4P02Jp7mStT+9/9U8GkIByPo=;
  b=PjbN5W2sheMLzQqVIUgD21cpGB5TQNMll9axx+O9D606Qfvw+XahC8Z6
   1UnO0OR4gEatV3IF4CN8aMK4sURgqLazSFiOS0SodeB8QIG7EmIQKPglx
   aEA78nrR9pj3tKLnGQ4bzeVV0FSs+A1FZ0AvbGUrJX5KuWnDVzPDRvTLs
   Ok5rrcHxNZdIL1NO18YTIlWisM/3afOQV60IhFU48iMXye8G74L3HXpxB
   Z0VhJx/+pb7lIItJTCoQ05Uwd2MS2m8c1AM+Mca6xxUb/Gw/zl0pW7PoA
   VrGdW9d3ODhDYmPt1Z0o1FcX4Gn4AZdpMfIisbehUJPfsqTKcQnO9Dof4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="315095562"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="315095562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 04:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="553140621"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 07 Mar 2022 04:49:01 -0800
Message-ID: <f98b62b1-d29f-9589-800d-ee829cfea251@intel.com>
Date:   Mon, 7 Mar 2022 14:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc/host: Re-enable card en only after UHS mode changed
 for spreadtrum chipset.
Content-Language: en-US
To:     Zhenxiong Lai <lzx.stg@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, zhixin.huang@unisoc.com,
        yuelin.tang@unisoc.com, zhenxiong.lai@unisoc.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        gengcixi@gmail.com
References: <20220307023425.8687-1-lzx.stg@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220307023425.8687-1-lzx.stg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/03/2022 04:34, Zhenxiong Lai wrote:
> From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> 
> DLL locked status probably couldn't come out in a certain time on
> Sharkl3 platform sometimes.
> It can be workaround if re-anable card en bit only
> rather than calling ->set_clock() after UHS timing changed.
> 
> Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 ++++++-
>  drivers/mmc/host/sdhci.h | 2 ++

This is an SDHCI patch so it would be better if the subject
begins with "mmc: sdhci: "

>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 07c6da1f2f0f..c415d00304fe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2396,7 +2396,12 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  
>  		/* Re-enable SD Clock */
> -		host->ops->set_clock(host, host->clock);
> +		if (host->quirks2 & SDHCI_QUIRK2_RE_ENABLE_CARD_EN) {
> +			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +			clk |= SDHCI_CLOCK_CARD_EN;
> +			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

We like to try and avoid quirks whenever possible.
Why can't this be done in the driver's ->set_clock() callback?

> +		} else
> +			host->ops->set_clock(host, host->clock);
>  	} else
>  		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d7929d725730..3d4ab68f133f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -477,6 +477,8 @@ struct sdhci_host {
>   * block count.
>   */
>  #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
> +/* controller only need to enable card en again after UHS timing was changed */
> +#define SDHCI_QUIRK2_RE_ENABLE_CARD_EN			(1<<19)

A quirk without any users is not useful.  Please also send the driver
change that uses this quirk, although as I wrote above, the ->set_clock()
callback should be used instead.

>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */

