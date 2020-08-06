Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06028C433E1
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614EF2311A
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgHFRUr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:20:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:51384 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbgHFRUX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 13:20:23 -0400
IronPort-SDR: EAsyGwuC2NO1Jx/bw1A2R6TlAqvNKhAe5IawoL+MsH2VmfVDWPG1sD2ozf1P6N9Ytzgxoh7hJJ
 uqOm2DYihFug==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152745828"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="152745828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 05:32:45 -0700
IronPort-SDR: 2aAO8Ggv2nwJsZzTNR+3URxFbkMv5n5zcTn051khE/n9Pk+zyVE+favngvjTASWIVJGr1gBe8P
 Pysl+v0aYB1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="325366356"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2020 05:32:43 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-o2micro: fix spelling mistake "unsupport"
 -> "unsupported"
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Colin King <colin.king@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        shirley her <shirley.her@bayhubtech.com>
References: <20200806115059.59241-1-colin.king@canonical.com>
 <016404fc-fce8-20f5-da6c-1b7ea936cf5a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e472589a-99ed-36d4-1f69-583376a5ceaf@intel.com>
Date:   Thu, 6 Aug 2020 15:32:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <016404fc-fce8-20f5-da6c-1b7ea936cf5a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/08/20 3:21 pm, Adrian Hunter wrote:
> + code author ernest.zhang <ernest.zhang@bayhubtech.com>

That email address bounced, so instead adding

	shirley her <shirley.her@bayhubtech.com>

> 
> On 6/08/20 2:50 pm, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a spelling mistake in a pr_info message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index fa76748d8929..4eca8d2d0599 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -469,7 +469,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>>  
>>  	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
>>  	if (!ret) {
>> -		pr_info("%s: unsupport msi, use INTx irq\n",
>> +		pr_info("%s: unsupported msi, use INTx irq\n",
> 
> I think the meaning is more like:
> 
> 	MSI is not supported, using INTx IRQ
> 
>>  			mmc_hostname(host->mmc));
>>  		return;
>>  	}
>>
> 

