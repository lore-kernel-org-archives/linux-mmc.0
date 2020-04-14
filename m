Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D51C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 13:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC38720578
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 13:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbgDNNuM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:50:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:16095 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbgDNNuK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Apr 2020 09:50:10 -0400
IronPort-SDR: eQ73OGoO2B7Ol5lnEg2ELVqO+oqWRS66a+iFpY792SA6DIwHHpYqAfo3spm48Z1G2Y0Rr7MXf6
 zU3G3ZdyusYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 06:50:08 -0700
IronPort-SDR: DzU44UtbBXnlgcTVLfD4U2AwqPWdn9MqtzL9D4GQjno3lz/kgO0DNfIu/vm7nZg3NR83qNM/k9
 UbLqMGnUvKdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="243817701"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2020 06:50:06 -0700
Subject: Re: [PATCH v5 3/3] mmc: host: sdhci-sprd: Implement the
 request_atomic() API
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     arnd@arndb.de, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1586744073.git.baolin.wang7@gmail.com>
 <60142fe6c6c1dbba2696e775564ae2166786f0bc.1586744073.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <dbf41269-0d0c-084c-e090-b040f92fee3e@intel.com>
Date:   Tue, 14 Apr 2020 16:49:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <60142fe6c6c1dbba2696e775564ae2166786f0bc.1586744073.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/04/20 5:46 am, Baolin Wang wrote:
> Implement the request_atomic() API for nonremovable cards, that means
> we can submit next request in the irq hard handler context to reduce
> latency.
> 
> Moreover factor out the AUTO CMD23 checking into a separate function
> to reduce duplicate code.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 2ab42c59e4f8..bc7a8cb84862 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -406,7 +406,8 @@ static struct sdhci_ops sdhci_sprd_ops = {
>  	.request_done = sdhci_sprd_request_done,
>  };
>  
> -static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +static void sdhci_sprd_check_auto_cmd23(struct mmc_host *mmc,
> +					struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> @@ -422,10 +423,23 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	    mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
>  	    (host->flags & SDHCI_AUTO_CMD23))
>  		host->flags &= ~SDHCI_AUTO_CMD23;
> +}
> +
> +static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	sdhci_sprd_check_auto_cmd23(mmc, mrq);
>  
>  	sdhci_request(mmc, mrq);
>  }
>  
> +static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
> +				      struct mmc_request *mrq)
> +{
> +	sdhci_sprd_check_auto_cmd23(mmc, mrq);
> +
> +	return sdhci_request_atomic(mmc, mrq);
> +}
> +
>  static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -561,6 +575,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto pltfm_free;
>  
> +	if (!mmc_card_is_removable(host->mmc))
> +		host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
> +	else
> +		host->always_defer_done = true;
> +
>  	sprd_host = TO_SPRD_HOST(host);
>  	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
>  
> @@ -654,8 +673,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_cleanup_host;
>  
> -	host->always_defer_done = true;
> -
>  	ret = __sdhci_add_host(host);
>  	if (ret)
>  		goto err_cleanup_host;
> 

