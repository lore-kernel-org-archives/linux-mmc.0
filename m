Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A621EE49A0
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 07:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjHXHnF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbjHXHmo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 03:42:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43F1716
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692862948; x=1724398948;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=IsVbTGOkf9eRuzb3PL4SYKdtwoqk9g/tw9O9wAA75o8=;
  b=KTocZTPCYunsEJMqlmXrotOo5MmFM4iDwAflNwuVmdQcZGLF4SUSTV5I
   eOjt9qSOr5BuUgOHrr2YnX3NPvqo4ZLEsr1UuEso0BBtHEsO5YzRyT6AJ
   mltxYIS1dOz2UJPt7bL+2InnPnPAjQ5DeXMi2N2r2gXbvcdQUiG9Q253Z
   ihn5vX4RQkuZSUf9ZEeFz8D5EmVawiBnZY88SahszjsQ/7K2viRCbYzBa
   u5VbOTFyUa3oGkdtzp66oaQxuYmL2jErwqQXMYH5VA6ZjzM5AATRPqMQp
   QW/x7WqyX1FBNsnsssh1pw0wKhIJ0R3TY9k9tR7BiO2H54nMUMSIE9IRK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="440719459"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="440719459"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="983600513"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="983600513"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:42:13 -0700
Message-ID: <79151ed0-46da-489c-1335-4f0286a6fdf1@intel.com>
Date:   Thu, 24 Aug 2023 10:42:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Use helper function
 devm_clk_get_enabled()
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Yi Yang <yiyang13@huawei.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Liming Sun <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20230821062303.185174-1-yiyang13@huawei.com>
 <842a0ac5-7eb2-390e-41af-f86e894b3c79@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <842a0ac5-7eb2-390e-41af-f86e894b3c79@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/23 10:37, Adrian Hunter wrote:
> On 21/08/23 09:23, Yi Yang wrote:
>> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
>> prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
>> can now be replaced by devm_clk_get_enabled() when the driver enables
>> (and possibly prepares) the clocks for the whole lifetime of the device.
>> Moreover, it is no longer necessary to unprepare and disable the clocks
>> explicitly.
>>
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>> v2: Remove clk_disable_unprepare in dwcmshc_remove()
>> ---
>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 31c1892f4ecd..08b566984733 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -495,19 +495,19 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>  	priv = sdhci_pltfm_priv(pltfm_host);
>>  
>>  	if (dev->of_node) {
>> -		pltfm_host->clk = devm_clk_get(dev, "core");
>> +		pltfm_host->clk = devm_clk_get_enabled(dev, "core");
>>  		if (IS_ERR(pltfm_host->clk)) {
>>  			err = PTR_ERR(pltfm_host->clk);
>> -			dev_err(dev, "failed to get core clk: %d\n", err);
>> +			dev_err(dev, "failed to get or enable core clk: %d\n", err);
>>  			goto free_pltfm;
>>  		}
>> -		err = clk_prepare_enable(pltfm_host->clk);
>> -		if (err)
>> -			goto free_pltfm;
>>  
>> -		priv->bus_clk = devm_clk_get(dev, "bus");
>> -		if (!IS_ERR(priv->bus_clk))
>> -			clk_prepare_enable(priv->bus_clk);
>> +		priv->bus_clk = devm_clk_get_enabled(dev, "bus");
>> +		if (!IS_ERR(priv->bus_clk)) {
> 
> "!" does not belong, should be "if (IS_ERR(priv->bus_clk))" instead

Although previously it seemed like the clock was optional.
At least the error was not considered fatal.

> 
>> +			err = PTR_ERR(priv->bus_clk);
>> +			dev_err(dev, "failed to get or enable bus clk: %d\n", err);
>> +			goto free_pltfm;
>> +		}
>>  	}
>>  
>>  	err = mmc_of_parse(host->mmc);
>> @@ -564,8 +564,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>  err_setup_host:
>>  	sdhci_cleanup_host(host);
>>  err_clk:
>> -	clk_disable_unprepare(pltfm_host->clk);
>> -	clk_disable_unprepare(priv->bus_clk);
>>  	if (rk_priv)
>>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>>  					   rk_priv->rockchip_clks);
>> @@ -583,8 +581,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
>>  
>>  	sdhci_remove_host(host, 0);
>>  
>> -	clk_disable_unprepare(pltfm_host->clk);
>> -	clk_disable_unprepare(priv->bus_clk);
>>  	if (rk_priv)
>>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>>  					   rk_priv->rockchip_clks);
> 

