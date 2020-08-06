Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BAC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E190723124
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 17:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgHFRVV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:21:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:15606 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbgHFRRF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 13:17:05 -0400
IronPort-SDR: /slNVu9mYoXyp+zWgpWBcOmMfwLN2bjumDruDhHfEioSXgbgcKwHtfqwHThQmKhIoAdhY72Xjx
 S3SpCwoDSr7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140662224"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="140662224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 05:21:38 -0700
IronPort-SDR: Qwvu0VK5iroQvkARLssUhiiV4FgMFwJQ6rsD01xVsy79+MlsNigcuySyBTMRj670mHi4IFu/z+
 uZm712bkEdSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="493647059"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2020 05:21:36 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-o2micro: fix spelling mistake "unsupport"
 -> "unsupported"
To:     Colin King <colin.king@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "ernest.zhang" <ernest.zhang@bayhubtech.com>
References: <20200806115059.59241-1-colin.king@canonical.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <016404fc-fce8-20f5-da6c-1b7ea936cf5a@intel.com>
Date:   Thu, 6 Aug 2020 15:21:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806115059.59241-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ code author ernest.zhang <ernest.zhang@bayhubtech.com>

On 6/08/20 2:50 pm, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_info message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index fa76748d8929..4eca8d2d0599 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -469,7 +469,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  
>  	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
>  	if (!ret) {
> -		pr_info("%s: unsupport msi, use INTx irq\n",
> +		pr_info("%s: unsupported msi, use INTx irq\n",

I think the meaning is more like:

	MSI is not supported, using INTx IRQ

>  			mmc_hostname(host->mmc));
>  		return;
>  	}
> 

