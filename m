Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1987BC3DA78
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Jan 2023 13:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjAONON (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Jan 2023 08:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjAONOM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2023 08:14:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FED1258D
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2023 05:14:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4412B80907
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2023 13:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BBC433F1;
        Sun, 15 Jan 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673788448;
        bh=uoeK9uv1jEWCFXp1ZO/nJzy0w69kSxkEXGk+zsfJlCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUsVjXDMEVc6X5Kgha0eZQ0ikSlmXRlLAF9Qk7U7Cb+fOGGzBRhiWEcG4cAufkuzf
         ZmMxSj7OdDGf+JRBr1/l6a7WTEYWoKhpjQoyLc4sre/+cWWC9en968web9w+46/ALR
         8m5hH7XYHK/smKMj7BeL3+aXdSzZ3gaOGuDjo7/t3Ro+iXdZ8UJLAi5HM8vIVDtSus
         P9iGOOHmhoT4QeVFuDPLVCU21BvFdGzckf+5yqmokSIMfEY5Hi8C49qlIGCXm5K3bS
         PVL7i+OMuhOAXAFiYoApxLP5UFGted72UcX7ohaqvMwxeakerfLdhgzYktUOt+tCzJ
         xBKdV/qiixukA==
Date:   Sun, 15 Jan 2023 21:03:49 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 4/6] mmc: sdhci-pxav3: Replace SDHCI_QUIRK_MISSING_CAPS
Message-ID: <Y8P5tT7bcL/N8K9G@xhacker>
References: <20230113110011.129835-1-adrian.hunter@intel.com>
 <20230113110011.129835-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230113110011.129835-5-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 13, 2023 at 01:00:09PM +0200, Adrian Hunter wrote:
> SDHCI_QUIRK_MISSING_CAPS is not needed because sdhci_read_caps() can be
> called instead.
> 
> In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
> SDHCI_QUIRK_MISSING_CAPS with sdhci_read_caps().
> 
> __sdhci_read_caps() is also called from sdhci_setup_host() via
> sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
> anything because after that host->read_caps has been set to true.
> 
> Note, __sdhci_read_caps() does more than just set host->caps, such as do a
> reset, so calling __sdhci_read_caps() earlier could have unforeseen
> side-effects. However the code flow has been reviewed with that in mind.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index a6d89a3f1946..e39dcc998772 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -124,10 +124,8 @@ static int armada_38x_quirks(struct platform_device *pdev,
>  	struct resource *res;
>  
>  	host->quirks &= ~SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
> -	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>  
> -	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> -	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +	sdhci_read_caps(host);
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					   "conf-sdio3");
> -- 
> 2.34.1
> 
