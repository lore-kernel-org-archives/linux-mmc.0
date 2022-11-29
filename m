Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53CC4321E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 11:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiK2LWY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiK2LWM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 06:22:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F15B5B4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 03:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669720930; x=1701256930;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=v1ePCJGwC9ikNlyXtOmkqegLiW9kcqiWgUt2IfzSoRU=;
  b=RHDwA/tWj0am+DIAILdXk1NIpsLSd5UijPqc7M+SZCp8CzhgPjHk96pe
   C0XDI41L3Tx/2wtGCMQzeW5oHC6Zf50MMxVyAjhZtBXUw9jNL8GOakWiQ
   M8T97q/zpTKXCGEjtudCGh9bP933pprUaM26BatbSzkAgqVcXcaPbtogD
   iNEUpRYf2KED7VcdiRADfUEiQuRfFQ02axH9Dd0X2X2fASnhIGQxS+rUm
   6T2BdytYdY1SVDF/TPqz/wsBrURyGNIqLEnOqZk69VTHdwLH+1Y7AVleI
   xWos1hhA9wb7nCyzowj+b/DkgXpCQkZZ1uyiIdjMIrPUcDIzV7CuXkxpV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="295461755"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="295461755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:22:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712338068"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="712338068"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.177])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:22:04 -0800
Message-ID: <c2cc3898-8dec-c84d-9a98-edc8f6eb610f@intel.com>
Date:   Tue, 29 Nov 2022 13:22:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] mmc: Replace with the already declared define
 function(mmc_op_tuning)
Content-Language: en-US
To:     Chanwoo Lee <cw9316.lee@samsung.com>, ulf.hansson@linaro.org,
        jh80.chung@samsung.com, chaotian.jing@mediatek.com,
        matthias.bgg@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-mmc@vger.kernel.org
References: <CGME20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a@epcas1p2.samsung.com>
 <20221124080031.14690-1-cw9316.lee@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221124080031.14690-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/11/22 10:00, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> Replace with the already declared define function.
> There are no functional differences.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Dunno if I'd have changed dw_mmc.c, but no matter:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/core.c              | 3 +--
>  drivers/mmc/host/dw_mmc.c            | 3 +--
>  drivers/mmc/host/mtk-sd.c            | 8 ++------
>  drivers/mmc/host/sdhci-msm.c         | 3 +--
>  drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
>  drivers/mmc/host/sdhci-tegra.c       | 8 ++------
>  drivers/mmc/host/sdhci.c             | 9 ++-------
>  7 files changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1bb70d438d6c..efa7178955f8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -142,8 +142,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>  	int err = cmd->error;
>  
>  	/* Flag re-tuning needed on CRC errors */
> -	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> -	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
> +	if (!mmc_op_tuning(cmd->opcode) &&
>  	    !host->retune_crc_disable &&
>  	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
>  	    (mrq->data && mrq->data->error == -EILSEQ) ||
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e4d09c439051..829af2c98a44 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -334,8 +334,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
>  	    cmdr == MMC_READ_MULTIPLE_BLOCK ||
>  	    cmdr == MMC_WRITE_BLOCK ||
>  	    cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
> -	    cmdr == MMC_SEND_TUNING_BLOCK ||
> -	    cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
> +	    mmc_op_tuning(cmdr) ||
>  	    cmdr == MMC_GEN_CMD) {
>  		stop->opcode = MMC_STOP_TRANSMISSION;
>  		stop->arg = 0;
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 652a67f9b054..d3f24dbda49f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1224,9 +1224,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>  
>  	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
>  		if (events & MSDC_INT_CMDTMO ||
> -		    (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> -		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
> -		     !host->hs400_tuning))
> +		    (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
>  			/*
>  			 * should not clear fifo/interrupt as the tune data
>  			 * may have alreay come when cmd19/cmd21 gets response
> @@ -1320,9 +1318,7 @@ static void msdc_cmd_next(struct msdc_host *host,
>  {
>  	if ((cmd->error &&
>  	    !(cmd->error == -EILSEQ &&
> -	      (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> -	       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200 ||
> -	       host->hs400_tuning))) ||
> +	      (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
>  	    (mrq->sbc && mrq->sbc->error))
>  		msdc_request_done(host, mrq);
>  	else if (cmd == mrq->sbc)
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 03f76384ab3f..4ac8651d0b29 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2219,8 +2219,7 @@ static int __sdhci_msm_check_write(struct sdhci_host *host, u16 val, int reg)
>  		if (!msm_host->use_cdr)
>  			break;
>  		if ((msm_host->transfer_mode & SDHCI_TRNS_READ) &&
> -		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK_HS200 &&
> -		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK)
> +		    !mmc_op_tuning(SDHCI_GET_CMD(val)))
>  			sdhci_msm_set_cdr(host, true);
>  		else
>  			sdhci_msm_set_cdr(host, false);
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index bca1d095b759..98cadff47b2b 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -326,8 +326,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		(host->timing != MMC_TIMING_UHS_SDR50))
>  		return sdhci_execute_tuning(mmc, opcode);
>  
> -	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> -			(opcode != MMC_SEND_TUNING_BLOCK)))
> +	if (WARN_ON(!mmc_op_tuning(opcode)))
>  		return -EINVAL;
>  
>  	/* Force power mode enter L0 */
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index c71000a07656..9fc8a61eca54 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -268,13 +268,9 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  {
>  	bool is_tuning_cmd = 0;
>  	bool clk_enabled;
> -	u8 cmd;
>  
> -	if (reg == SDHCI_COMMAND) {
> -		cmd = SDHCI_GET_CMD(val);
> -		is_tuning_cmd = cmd == MMC_SEND_TUNING_BLOCK ||
> -				cmd == MMC_SEND_TUNING_BLOCK_HS200;
> -	}
> +	if (reg == SDHCI_COMMAND)
> +		is_tuning_cmd = mmc_op_tuning(SDHCI_GET_CMD(val));
>  
>  	if (is_tuning_cmd)
>  		clk_enabled = tegra_sdhci_configure_card_clk(host, 0);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fb6e9a81f198..75437b0073e8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1692,8 +1692,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		flags |= SDHCI_CMD_INDEX;
>  
>  	/* CMD19 is special in that the Data Present Select should be set */
> -	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
> -	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
> +	if (cmd->data || mmc_op_tuning(cmd->opcode))
>  		flags |= SDHCI_CMD_DATA;
>  
>  	timeout = jiffies;
> @@ -3329,8 +3328,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
>  
>  static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  {
> -	u32 command;
> -
>  	/*
>  	 * CMD19 generates _only_ Buffer Read Ready interrupt if
>  	 * use sdhci_send_tuning.
> @@ -3339,9 +3336,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
>  	 */
>  	if (intmask & SDHCI_INT_DATA_AVAIL && !host->data) {
> -		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> -		if (command == MMC_SEND_TUNING_BLOCK ||
> -		    command == MMC_SEND_TUNING_BLOCK_HS200) {
> +		if (mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)))) {
>  			host->tuning_done = 1;
>  			wake_up(&host->buf_ready_int);
>  			return;

