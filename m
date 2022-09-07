Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC285ECAAD3
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 07:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIGHGF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 03:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGHGE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 03:06:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADAA80EAF
        for <linux-mmc@vger.kernel.org>; Wed,  7 Sep 2022 00:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662534363; x=1694070363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0+rrOCaeBzhvoZ6I0JvYviJLtoxdOtxTZ0eG/inSq6M=;
  b=STjnKF+FYohRHTvoSDT6tebfy5zQREKhxDBPJW2xoSc+L2VZXGD2CBAx
   KcrBBPYCUpQgqvY6pRlxlw5KB3nSKauAgrVRisgYb8npSucTq19tzHbME
   JTrIp0W2cKVkdjaazlJsFelGWmMRkqxpM3cT1VAryjbj/QRp9HultyTdQ
   WnF4fspHo80JnI0OEgssoMPRJqIYAeltkpouJ+WXRKfzp4LxFbNFMVdxi
   jE3tPn2FYdx0lnRmvdG2BUnH7iuGWOm/zjjxyS08+JtfVaFtQsTBRHKFa
   wEma7kpVJ8KFHn2FgV0Dk/kzxzryd/yaI7nkjCq/NZaVzZ3wk4cIVJimr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322982330"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="322982330"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:06:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676051919"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:06:01 -0700
Message-ID: <3648678c-3c42-2555-aa84-a21b1e7c661f@intel.com>
Date:   Wed, 7 Sep 2022 10:05:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] mmc: sdhci: check host->cmd is null or not in
 sdhci_cqe_irq()
Content-Language: en-US
To:     "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
        linux-mmc@vger.kernel.org
Cc:     Ram Muthiah <rammuthiah@google.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20220831124359.2005165-1-paulliu@debian.org>
 <20220831124359.2005165-2-paulliu@debian.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220831124359.2005165-2-paulliu@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31/08/22 15:43, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> If we don't check host->cmd. We will get the following oops
> when booting from eMMC on RockPi4.
> 
>  Unable to handle kernel read from unreadable memory at
>    virtual address 0000000000000000
>  Call trace:
>    sdhci_cqe_irq+0x40/0x254

Thank you!  However, I prefer this patch:

https://lore.kernel.org/linux-mmc/20220907035847.13783-1-wenchao.chen666@gmail.com/

> 
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Signed-off-by: Ram Muthiah <rammuthiah@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffec5ad1..e0e7768bd6c0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
>  		*cmd_error = -EILSEQ;
> -		if (!mmc_op_tuning(host->cmd->opcode))
> +		if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
>  			sdhci_err_stats_inc(host, CMD_CRC);
>  	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error = -ETIMEDOUT;
> @@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  
>  	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error = -EILSEQ;
> -		if (!mmc_op_tuning(host->cmd->opcode))
> +		if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
>  			sdhci_err_stats_inc(host, DAT_CRC);
>  	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error = -ETIMEDOUT;

