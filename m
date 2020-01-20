Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC5C33CA1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551DB2073A
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgATInU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:43:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:58883 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgATInU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 03:43:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 00:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,341,1574150400"; 
   d="scan'208";a="258630796"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2020 00:43:18 -0800
Subject: Re: [PATCH -next] mmc: sdhci-milbeaut: Remove redundant
 platform_get_irq error message
To:     YueHaibing <yuehaibing@huawei.com>, ulf.hansson@linaro.org,
        orito.takao@socionext.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200116144322.57308-1-yuehaibing@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ba5fbdf9-a9c8-408e-ac28-8ff98566678f@intel.com>
Date:   Mon, 20 Jan 2020 10:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116144322.57308-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/01/20 4:43 pm, YueHaibing wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-milbeaut.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
> index e6245b7..92f30a1 100644
> --- a/drivers/mmc/host/sdhci-milbeaut.c
> +++ b/drivers/mmc/host/sdhci-milbeaut.c
> @@ -246,10 +246,8 @@ static int sdhci_milbeaut_probe(struct platform_device *pdev)
>  	struct f_sdhost_priv *priv;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "%s: no irq specified\n", __func__);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
>  	if (IS_ERR(host))
> 

