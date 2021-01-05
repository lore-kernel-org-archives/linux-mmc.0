Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86319C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C96B22C9D
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Jan 2021 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAEQBA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:01:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:35258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbhAEQBA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Jan 2021 11:01:00 -0500
IronPort-SDR: MxEUT6RReoE97PcVL9NtYozZRnpY3EkcrWt3f9kieVPLypCrJeknEyE+OWQsqOUgz0zdWDgdbM
 slTfMmDI42Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176345447"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="176345447"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 08:00:18 -0800
IronPort-SDR: yWMIoScZAUAopoUwJJJgG3cKq68FO6y2rDLLIBjmk7KqrwMTpQVT8hKn2b51O6U/W5Zs6y/Sx0
 dufWnPbszwtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421819081"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 08:00:16 -0800
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: fix rpmb access
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201229161625.38255233@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <33a544d0-d911-17dd-6ea6-a847fce42b3c@intel.com>
Date:   Tue, 5 Jan 2021 18:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201229161625.38255233@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/12/20 10:16 am, Jisheng Zhang wrote:
> Commit a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for
> RPMB") began to use ACMD23 for RPMB if the host supports ACMD23. In
> RPMB ACM23 case, we need to set bit 31 to CMD23 argument, otherwise
> RPMB write operation will return general fail.
> 
> However, no matter V4 is enabled or not, the dwcmshc's ARGUMENT2
> register is 32-bit block count register which doesn't support stuff
> bits of CMD23 argument. So let's handle this specific ACMD23 case.
> 
>>From another side, this patch also prepare for future v4 enabling
> for dwcmshc, because from the 4.10 spec, the ARGUMENT2 register is
> redefined as 32bit block count which doesn't support stuff bits of
> CMD23 argument.
> 
> Fixes: a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for RPMB")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4b673792b5a4..d90020ed3622 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -16,6 +16,8 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
> +
>  /* DWCMSHC specific Mode Select value */
>  #define DWCMSHC_CTRL_HS400		0x7
>  
> @@ -49,6 +51,29 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>  	sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>  
> +static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
> +				     struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	/*
> +	 * No matter V4 is enabled or not, ARGUMENT2 register is 32-bit
> +	 * block count register which doesn't support stuff bits of
> +	 * CMD23 argument on dwcmsch host controller.
> +	 */
> +	if (mrq->sbc && (mrq->sbc->arg & SDHCI_DWCMSHC_ARG2_STUFF))
> +		host->flags &= ~SDHCI_AUTO_CMD23;
> +	else
> +		host->flags |= SDHCI_AUTO_CMD23;
> +}
> +
> +static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	dwcmshc_check_auto_cmd23(mmc, mrq);
> +
> +	sdhci_request(mmc, mrq);
> +}
> +
>  static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>  				      unsigned int timing)
>  {
> @@ -133,6 +158,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	sdhci_get_of_property(pdev);
>  
> +	host->mmc_host_ops.request = dwcmshc_request;
> +
>  	err = sdhci_add_host(host);
>  	if (err)
>  		goto err_clk;
> 

