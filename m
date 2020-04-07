Return-Path: <SRS0=BwSF=5X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5663C2BA16
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3ED20B1F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 05:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgDGFrY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:47:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:35239 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgDGFrY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Apr 2020 01:47:24 -0400
IronPort-SDR: RvVmck6jAbHHh1mB3wyUv24xr4z38Ij4EBe0n1gSHHfj9Q4dgHzvupqwtph9JDGbs+ICXYbXRA
 hG2EbZYCFXOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 22:47:24 -0700
IronPort-SDR: 3S3Zdp0+ED8s7zH2OeAcf0JxgD6iQcUOWo1vQBvUi1zkMiB8kUSYTGkbbt7LgdTJjjAva4kNfm
 W3HSlQOIOWOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="296856523"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 22:47:22 -0700
Subject: Re: [PATCH] mmc: sdhci-sprd: Drop redundant cap flags
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <20200406113724.8504-1-ulf.hansson@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9fa56ced-4a6e-31ec-1d58-5a6206e41c4e@intel.com>
Date:   Tue, 7 Apr 2020 08:46:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406113724.8504-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/04/20 2:37 pm, Ulf Hansson wrote:
> The MMC_CAP_ERASE and MMC_CAP_CMD23 flags are already being set in the
> common sdhci_setup_host(). This makes it redundant to set them for
> sdhci-sprd, so let's drop them.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-sprd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 2ab42c59e4f8..60c3a4c620f9 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -556,7 +556,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  		sdhci_sprd_voltage_switch;
>  
>  	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -		MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
> +		MMC_CAP_WAIT_WHILE_BUSY;
> +
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto pltfm_free;
> 

