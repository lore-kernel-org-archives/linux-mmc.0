Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955AAC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jun 2022 08:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbiFVIoD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jun 2022 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355558AbiFVInf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2022 04:43:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFD340C2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2022 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887414; x=1687423414;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QgS6gqXUCp98sYOy1tTKtfD3zE2RhCwd03cTX1A7GCE=;
  b=atqkuYWH0+9/HviWGA7TmwqoH6/4W/1sqGxB/R9J3bADtEytL4np6rAt
   nx7g3ScGi/zFIdsDLjtTfQVCc4IMiJKYG8yDwUtesVyosc3AHtg27FZpQ
   UMfaXRZ5jt5Q5rv0YfSbJ8IBtD3SG8tlkLaWNNB7SlJGxiFjL4RJV21ST
   VzLTh+AJC0YJ6/ELLrq+4NcXfDNjQ3bIo37hZVEL8V/lXka3um9agrzGu
   aKwRHgWmyCIh1lN0LqsPKJ1qXe468OeMvdqhiOIevN5v2hsGcfgqIh7X5
   0RPxnOuQ9wUEqzBZJzARu+6QR+Oz1H298gR6S1KXeEabUdcYLPhk9ZqaK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263391601"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="263391601"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:43:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644081172"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:43:32 -0700
Message-ID: <d1a15acd-dd87-839e-6dbb-7598b63b069d@intel.com>
Date:   Wed, 22 Jun 2022 11:43:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc/host/sdhci-of-esdhc: Hold a reference returned by
 of_find_compatible_node
Content-Language: en-US
To:     Liang He <windhl@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
References: <20220621065259.4079817-1-windhl@126.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220621065259.4079817-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/06/22 09:52, Liang He wrote:
> In sdhci_esdhc_probe(), we should hold the reference returned by
> of_find_compatible_node() which is used to of_node_put() for keep
> refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d9dc41143bb3..9c8cd8b63578 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1418,7 +1418,7 @@ static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host;
> -	struct device_node *np;
> +	struct device_node *np, *tp;
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_esdhc *esdhc;
>  	int ret;
> @@ -1463,7 +1463,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	if (esdhc->vendor_ver > VENDOR_V_22)
>  		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
>  
> -	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
> +	tp = of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc");
> +	if (tp) {
> +		of_node_put(tp);
>  		host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  	}

