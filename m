Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B0FC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED4B20747
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgGAKoa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:44:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:39136 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgGAKoa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Jul 2020 06:44:30 -0400
IronPort-SDR: N7whw5bG3g52W9I+AUsJ67g7tMFtvfVjXGjzz9qV8mM2fU2QHfviptTu/iR2J7uGT/dw9e31Xu
 +M8KcJYHLeOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134807117"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="134807117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:44:19 -0700
IronPort-SDR: Jpa5Aep7E13qHjqBxVTHr2OHKFxzhVxQg1u48cFSsh6JHvXElDp5y1uTpbe1iAf+8vu9YyleRV
 WGtiCn5O2Dqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="303805612"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 03:44:17 -0700
Subject: Re: [PATCH] mmc: sdhci-acpi: For amd device set driver type as
 MMC_SET_DRIVER_TYPE_A
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     rrangel@google.com, nehal-bakulchandra.shah@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20200623133347.4598-1-akshu.agrawal@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b51faa2a-f465-581b-05bc-81677c8c1071@intel.com>
Date:   Wed, 1 Jul 2020 13:43:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200623133347.4598-1-akshu.agrawal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/06/20 4:33 pm, Akshu Agrawal wrote:
> HS400/HS200/eMMC HS doesn't have Preset Value register.
> Hence, sdhci_set_ios function overrides the value set by fmw to
> SDHCI_CTRL_DRV_TYPE_B.
> This patch sets drv_type to MMC_SET_DRIVER_TYPE_A
> so that host_control2 register gets updated with the required
> strength value.
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d8b76cb8698a..48ecbd0b180d 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -542,6 +542,7 @@ static int amd_select_drive_strength(struct mmc_card *card,
>  				     unsigned int max_dtr, int host_drv,
>  				     int card_drv, int *drv_type)
>  {
> +	*drv_type = MMC_SET_DRIVER_TYPE_A;
>  	return MMC_SET_DRIVER_TYPE_A;
>  }
>  
> 

