Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55CCA0ECA
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 09:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjILJmD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjILJmD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 05:42:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428941BB;
        Tue, 12 Sep 2023 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694511719; x=1726047719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W3JSnIFR79s8aFrtiFoBuORM65A7c95xGH7KGYqk5nE=;
  b=TT9VYAc9S6f6J1d1SqvYg1xSqlinfMMKgclx7Qw5bMt0u9eTE94Oe4u4
   TQtd1d8Tl+wCFKMPTocshPKzsvnobfoPUJASYVpxt7hDQVH3+GQUXcocY
   2TpcysLEUD0VWXEdM4qlOTQhDRE1n21eeNwTLOND0NAW6hG8kClYNhalb
   Wd+iJjvEUoxWoAZq2Vb7wbhpezdN+FPmnUMb78H/rxVXvXtMI2J8HZMxb
   oORHwq2G8ZXUJKD/i1sizXsbPBbx0zWFSOl/JP2UF/G/SWhteVy18BjiF
   YDc2yYy9jaji6O07+86oAObelyJcmT+57/iB5F4EQ0a4fwjtOJ/EmIoSz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382138832"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382138832"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772931265"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="772931265"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.45.152])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:41:56 -0700
Message-ID: <8c9e392f-2e41-3d2b-1418-50b04a3416be@intel.com>
Date:   Tue, 12 Sep 2023 12:41:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/09/23 12:54, Dan Carpenter wrote:
> Return an error code if sdhci_sprd_get_best_clk_sample() fails.
> Currently, it returns success.
> 
> Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is from static analysis and has not been tested.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 649ae075e229..6b84ba27e6ab 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
>  	best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
>  	if (best_clk_sample < 0) {
>  		dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> +		err = best_clk_sample;
>  		goto out;
>  	}
>  

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

