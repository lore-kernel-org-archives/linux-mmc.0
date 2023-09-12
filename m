Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98168CA0EC3
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 01:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjILBjE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjILBiq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Sep 2023 21:38:46 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3A1601AF;
        Mon, 11 Sep 2023 18:16:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vruc1gH_1694481384;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vruc1gH_1694481384)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 09:16:25 +0800
Message-ID: <7c4a8e50-499c-ec13-536b-42ee951f58c3@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 09:16:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 9/7/2023 5:54 PM, Dan Carpenter wrote:
> Return an error code if sdhci_sprd_get_best_clk_sample() fails.
> Currently, it returns success.
> 
> Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> This is from static analysis and has not been tested.
> ---
>   drivers/mmc/host/sdhci-sprd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 649ae075e229..6b84ba27e6ab 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
>   	best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
>   	if (best_clk_sample < 0) {
>   		dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> +		err = best_clk_sample;
>   		goto out;
>   	}
>   
