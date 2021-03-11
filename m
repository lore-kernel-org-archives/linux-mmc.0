Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E4C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025E864FC3
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhCKLOM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:14:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:45595 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232518AbhCKLOJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 06:14:09 -0500
IronPort-SDR: Db+nVXJnMkOBHBxt5LMYeKpDPdtv/bFe3NQgFIE1PSWnAsMh5JlZnUvHKXrCsHofB/YbOzEAen
 xvA3HwStzkEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="273690619"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="273690619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 03:14:09 -0800
IronPort-SDR: 2HNrg5ovQkxny6M2CJ9Ma3q8EbsazfCqN6gzIP4quy0V1zjzvzafPOGoOja9uKz9Nqgw4KzSuQ
 6VzI5EXulv9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="409454286"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 03:14:07 -0800
Subject: Re: [PATCH] mmc: sdhci-pci: Avoid comma separated statements
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311181432.6385cd2b@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f52742e2-fede-a420-d911-46704e285d62@intel.com>
Date:   Thu, 11 Mar 2021 13:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311181432.6385cd2b@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/21 12:14 pm, Jisheng Zhang wrote:
> Use semicolons.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9552708846ca..62799c1d9c0c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -958,7 +958,7 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>  
>  	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
> +		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>  		slot->host->mmc_host_ops.hs400_enhanced_strobe =
>  						intel_hs400_enhanced_strobe;
>  		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> 

