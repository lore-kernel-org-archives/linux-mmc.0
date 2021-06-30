Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA7C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E02461624
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhF3MWI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:22:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:49865 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234459AbhF3MWI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 08:22:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="229973841"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="229973841"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="419972224"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 05:19:36 -0700
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Finetune GL9763E L1 Entry Delay
To:     Renius Chen <reniuschengl@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw
References: <20210624025647.101387-1-reniuschengl@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bfa4fbcc-df3e-21e7-b6d8-0f4ae35f0196@intel.com>
Date:   Wed, 30 Jun 2021 15:19:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624025647.101387-1-reniuschengl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/06/21 5:56 am, Renius Chen wrote:
> Finetune the L1 entry delay to 20us for better balance of performance and
> battery life.
> 
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 302a7579a9b3..4e3c0561354d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -90,7 +90,7 @@
>  
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x50
>  
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -810,7 +810,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  
>  	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>  	value &= ~GLI_9763E_CFG2_L1DLY;
> -	/* set ASPM L1 entry delay to 21us */
> +	/* set ASPM L1 entry delay to 20us */
>  	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>  
> 

