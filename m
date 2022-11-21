Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7576C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 08:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKUI4G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiKUIzv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 03:55:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C54820F4A
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 00:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669020851; x=1700556851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DAyesIn+BEWljm/vLHTeTe2qNh+LYCQIDVz8y6IjLg0=;
  b=Z+gqrSGsH7oFgng0pclDbrOoujIrMaT+6fos/ADSWtnWEICL4kkMI6W+
   EOw9JD3xScgvGU4+4b3mVGUOhTGbAtD0MiqxMm2jiYOseablPVIerrSd3
   QhwUmmfEAmlEUNu8OnWRnEfq0UD+fUoAOb2/oNjnfZVMMkWpsWgzAfypk
   QycfzSsXbQiRRdTdjT7XLSJUIZ0f1CJAW5M4hX0Yxx0I532NgQ3j6+vM+
   Hqc6WXbuCv5r/1LidOL/Zof3nq7EsWqM1hmvnpesraLY/C1QjwOdxDQnh
   6653HOVCwg28VLMHD9OIEOdilHLuTI4F8iptjtPKC1HUn2m3G5dkSK18R
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="312210753"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="312210753"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:53:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="746821730"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="746821730"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.94])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 00:53:57 -0800
Message-ID: <dd766653-0526-afdc-03cb-c03d96661c94@intel.com>
Date:   Mon, 21 Nov 2022 10:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check
Content-Language: en-US
To:     Sebastian Falbesoner <sebastian.falbesoner@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
References: <20221119030400.1789919-1-sebastian.falbesoner@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221119030400.1789919-1-sebastian.falbesoner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/11/22 05:04, Sebastian Falbesoner wrote:
> With the current logic the "failed to exit halt state" error would be
> shown even if any other bit than CQHCI_HALT was set in the CQHCI_CTL
> register, since the right hand side is always true. Fix this by using
> the correct operator (bit-wise instead of logical AND) to only check for
> the halt bit flag, which was obviously intended here.
> 
> Signed-off-by: Sebastian Falbesoner <sebastian.falbesoner@gmail.com>

Fixes: 85236d2be844 ("mmc: sdhci-esdhc-imx: clear the HALT bit when enable CQE")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 31ea0a2fce35..ffeb5759830f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1512,7 +1512,7 @@ static void esdhc_cqe_enable(struct mmc_host *mmc)
>  	 * system resume back.
>  	 */
>  	cqhci_writel(cq_host, 0, CQHCI_CTL);
> -	if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT)
> +	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
>  		dev_err(mmc_dev(host->mmc),
>  			"failed to exit halt state when enable CQE\n");
>  

