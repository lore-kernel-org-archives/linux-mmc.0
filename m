Return-Path: <SRS0=OWc9=4P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33241C4BA2D
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A395246A3
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgB0NTx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:19:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:50317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgB0NTx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 Feb 2020 08:19:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 05:19:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="231836526"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 05:19:50 -0800
Subject: Re: [PATCH] mmc: host: sdhci-sprd: Set the missing
 MMC_CAP_WAIT_WHILE_BUSY flag
To:     Baolin Wang <baolin.wang7@gmail.com>, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d16d3eec-7ddc-0adc-20ca-95329a29e6b0@intel.com>
Date:   Thu, 27 Feb 2020 15:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96f16647f6a6e8cb058c44e46c61b122df027059.1582535202.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/02/20 11:08 am, Baolin Wang wrote:
> The Spreadtrum host controller supports HW busy detection for I/O
> operations, which means when the host gets a transfer complete event,
> that always indicates the busy signal is released. Thus we can set
> the MMC_CAP_WAIT_WHILE_BUSY flag to remove some redundant software
> busy polling.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index d346223..2ab42c5 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -556,7 +556,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  		sdhci_sprd_voltage_switch;
>  
>  	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -		MMC_CAP_ERASE | MMC_CAP_CMD23;
> +		MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
>  	ret = mmc_of_parse(host->mmc);
>  	if (ret)
>  		goto pltfm_free;
> 

