From: Georgi Djakov <gdjakov@mm-sol.com>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-msm: Convert to mmc_send_tuning()
Date: Fri, 05 Dec 2014 18:29:46 +0200
Message-ID: <5481DD7A.8050200@mm-sol.com>
References: <1417780783-12939-1-git-send-email-ulf.hansson@linaro.org> <1417780783-12939-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:55995 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbaLEQ30 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 11:29:26 -0500
In-Reply-To: <1417780783-12939-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Aisheng Dong <b29396@freescale.com>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 12/05/2014 01:59 PM, Ulf Hansson wrote:
> Instead of having a local hack taking care of sending the tuning
> command and as well to verify the response pattern, let's convert to
> the common mmc_send_tuning() API instead.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Ulf,
Tuning works for eMMC on apq8074-dragonboard and ifc6540 boards, so:
Tested-by: Georgi Djakov <gdjakov@mm-sol.com>
Acked-by: Georgi Djakov <gdjakov@mm-sol.com>

Thanks,
Georgi

> Changes in v2:
> 	Rebased, to get latest version of the mmc_send_tuning() API.
> 
> ---
>  drivers/mmc/host/sdhci-msm.c | 50 +++++++-------------------------------------
>  1 file changed, 7 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3080438..3d32ce8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -339,9 +339,7 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>  static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	int tuning_seq_cnt = 3;
> -	u8 phase, *data_buf, tuned_phases[16], tuned_phase_cnt = 0;
> -	const u8 *tuning_block_pattern = tuning_blk_pattern_4bit;
> -	int size = sizeof(tuning_blk_pattern_4bit);
> +	u8 phase, tuned_phases[16], tuned_phase_cnt = 0;
>  	int rc;
>  	struct mmc_host *mmc = host->mmc;
>  	struct mmc_ios ios = host->mmc->ios;
> @@ -355,53 +353,21 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	      (ios.timing == MMC_TIMING_UHS_SDR104)))
>  		return 0;
>  
> -	if ((opcode == MMC_SEND_TUNING_BLOCK_HS200) &&
> -	    (mmc->ios.bus_width == MMC_BUS_WIDTH_8)) {
> -		tuning_block_pattern = tuning_blk_pattern_8bit;
> -		size = sizeof(tuning_blk_pattern_8bit);
> -	}
> -
> -	data_buf = kmalloc(size, GFP_KERNEL);
> -	if (!data_buf)
> -		return -ENOMEM;
> -
>  retry:
>  	/* First of all reset the tuning block */
>  	rc = msm_init_cm_dll(host);
>  	if (rc)
> -		goto out;
> +		return rc;
>  
>  	phase = 0;
>  	do {
> -		struct mmc_command cmd = { 0 };
> -		struct mmc_data data = { 0 };
> -		struct mmc_request mrq = {
> -			.cmd = &cmd,
> -			.data = &data
> -		};
> -		struct scatterlist sg;
> -
>  		/* Set the phase in delay line hw block */
>  		rc = msm_config_cm_dll_phase(host, phase);
>  		if (rc)
> -			goto out;
> +			return rc;
>  
> -		cmd.opcode = opcode;
> -		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> -
> -		data.blksz = size;
> -		data.blocks = 1;
> -		data.flags = MMC_DATA_READ;
> -		data.timeout_ns = NSEC_PER_SEC;	/* 1 second */
> -
> -		data.sg = &sg;
> -		data.sg_len = 1;
> -		sg_init_one(&sg, data_buf, size);
> -		memset(data_buf, 0, size);
> -		mmc_wait_for_req(mmc, &mrq);
> -
> -		if (!cmd.error && !data.error &&
> -		    !memcmp(data_buf, tuning_block_pattern, size)) {
> +		rc = mmc_send_tuning(mmc);
> +		if (!rc) {
>  			/* Tuning is successful at this tuning point */
>  			tuned_phases[tuned_phase_cnt++] = phase;
>  			dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
> @@ -413,7 +379,7 @@ retry:
>  		rc = msm_find_most_appropriate_phase(host, tuned_phases,
>  						     tuned_phase_cnt);
>  		if (rc < 0)
> -			goto out;
> +			return rc;
>  		else
>  			phase = rc;
>  
> @@ -423,7 +389,7 @@ retry:
>  		 */
>  		rc = msm_config_cm_dll_phase(host, phase);
>  		if (rc)
> -			goto out;
> +			return rc;
>  		dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
>  			 mmc_hostname(mmc), phase);
>  	} else {
> @@ -435,8 +401,6 @@ retry:
>  		rc = -EIO;
>  	}
>  
> -out:
> -	kfree(data_buf);
>  	return rc;
>  }
>  
> 

