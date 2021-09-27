Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB183C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 05:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19BC60EB6
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 05:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhI0FoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 01:44:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:24946 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232594AbhI0FoW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Sep 2021 01:44:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="203901322"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="203901322"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 22:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="437593922"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2021 22:42:42 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-o2micro: Fix spelling mistake "unsupport"
 -> "unsupported"
To:     Colin King <colin.king@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210924225111.143112-1-colin.king@canonical.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <465f02b9-3fcf-b606-6dd9-67d133290578@intel.com>
Date:   Mon, 27 Sep 2021 08:43:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924225111.143112-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/09/21 1:51 am, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_info message. Fix it. Also
> put msi in capital letters.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 51d55a87aebe..f045c1ee4667 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -489,7 +489,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>  
>  	ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
>  	if (!ret) {
> -		pr_info("%s: unsupport msi, use INTx irq\n",
> +		pr_info("%s: unsupported MSI, use INTx irq\n",
>  			mmc_hostname(host->mmc));
>  		return;
>  	}
> 

