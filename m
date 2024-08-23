Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DE185B43;
	Fri, 23 Aug 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417042; cv=none; b=elyWFLXBHgIMltrtK9RRzdXryeFV73JqzDem2kpgXEGU3L+qB/bxAFTMo/3T+dsl8C4mY0o+JKzMMif8xDqcQlSHA6WLmr+e/XEiaicE0g8mIJV/9TfkVRTpGLGS41zBLU2XWVo/I7IJLow9dhiakyCBAsard4G57+rsXDwVfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417042; c=relaxed/simple;
	bh=lMs3WVJ0h51AwCcaO6LVDCS+SOEzExXqCQrseb9Nc6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umPHiXiuKRh5ry6OYDCVd3dugyM0bp0Vyr542rAb2Ua9qxATTAcr6XrbqpWOb12zsCvXnk1UokNh2FdOjlUop6Hy9pnP88/szQ5VMPAoH/H21zPqJhcv+U3ZT+Q8eCgKDbh3LK6ENkc5yvhZZ345CSAdwehtObmaEcbS8Lw5bzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrGIflyu; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrGIflyu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724417040; x=1755953040;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lMs3WVJ0h51AwCcaO6LVDCS+SOEzExXqCQrseb9Nc6Q=;
  b=mrGIflyuvjcwBdMnWR2FCz1D7LMU7cPRImHQ9szBYwx30YyKCCGsGyFY
   UkNun9iDkZ/+H9NTrRMVYP8pL7KJ0p4bC7+ZV8OqLM3KgP8c7NkcFETM2
   5ORT7ld2S+UT/3+3nE5SjFZOFREppgD9rbeWUzih38E6j0CXXpp75hGcJ
   NTYrnz4z5Od1zTJlKE4VN1fWb7s6EXJKVrcY/Lh4vIiJQQPQTMA3f2Xei
   QHVxa76oHWkWhlLc5Pv2ArLU0OrUjp+Miep2TQ7fZ9ZbpyXR+ym83TJsI
   NuZM1DYpxfpDUkO8YOGkgvPj4Z0mmEeDDoGOl5Waw8aswkUJUE4zeoFVs
   w==;
X-CSE-ConnectionGUID: w/6/OGk7REymy9TTB8lrwg==
X-CSE-MsgGUID: uyHjD7H4T/i9/mLvVuJObA==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="23036541"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="23036541"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:43:59 -0700
X-CSE-ConnectionGUID: eIvSks3nRiW8LF0Dt+BXpw==
X-CSE-MsgGUID: Bv/QxV9YT663iUhdrN22cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62088183"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:43:54 -0700
Message-ID: <a1ed46af-cd9d-4f5d-8780-80349318cb9b@intel.com>
Date: Fri, 23 Aug 2024 15:43:48 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V18 17/22] mmc: sdhci-uhs2: add irq() and others
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
 takahiro.akashi@linaro.org, dlunev@chromium.org,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
 <20240802102229.10204-18-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240802102229.10204-18-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/08/24 13:22, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's request() operation.
> It handles UHS-II related command interrupts and errors.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V18:
>  - Modify the judgment condition in the sdhci_uhs2_reset_cmd_data() and
>    replace it from mmc_card_uhs2() to host->mmc->uhs2_sd_tran flag.
> 
> Updates in V17:
>  - Add sdhci_uhs2_reset_cmd_data() and sdhci_uhs2_needs_reset() to
>    resolve the data error or cmd error.
> 
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_complete_work(), sdhci_uhs2_irq() and
>    sdhci_uhs2_thread_irq().
> 
> Updates in V13:
>  - Re-order function to avoid declaration.
>  - Remove unnecessary definitions.
> 
> Updates in V9:
>  - Cancel export state of sdhci_set_mrq_done() function.
> 
> Updates in V8:
>  - Forward declare struct mmc_request in sdhci_uhs2.h.
>  - Remove forward declaration of sdhci_send_command().
>  - Use mmc_dev() to simplify code in sdhci_request_done_dma().
> 
> Updates in V7:
>  - Remove unnecessary functions.
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_irq().
>  - Modify descriptions in sdhci_uhs2_irq().
>  - Cancel export state of some functions.
> 
> Updates in V6:
>  - Remove unnecessary functions.
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_complete_work().
>  - Add sdhci_uhs2_mode() in sdhci_uhs2_thread_irq().
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 237 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   2 +
>  drivers/mmc/host/sdhci.c      | 102 ++++++++-------
>  drivers/mmc/host/sdhci.h      |   5 +
>  4 files changed, 300 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 31486e28496d..c9bd438e9c26 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -106,6 +106,19 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +static void sdhci_uhs2_reset_cmd_data(struct sdhci_host *host)
> +{
> +	sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +	if (host->mmc->uhs2_sd_tran) {
> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +
> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +		sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> +	}
> +}
> +
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -904,6 +917,230 @@ static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Request done                                                              *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static bool sdhci_uhs2_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	return sdhci_needs_reset(host, mrq) ||
> +	       (!(host->flags & SDHCI_DEVICE_DEAD) && mrq->data && mrq->data->error);
> +}
> +
> +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> +{
> +	unsigned long flags;
> +	struct mmc_request *mrq;
> +	int i;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> +		mrq = host->mrqs_done[i];
> +		if (mrq)
> +			break;
> +	}
> +
> +	if (!mrq) {
> +		spin_unlock_irqrestore(&host->lock, flags);
> +		return true;
> +	}
> +
> +	/*
> +	 * Always unmap the data buffers if they were mapped by
> +	 * sdhci_prepare_data() whenever we finish with a request.
> +	 * This avoids leaking DMA mappings on error.
> +	 */
> +	if (host->flags & SDHCI_REQ_USE_DMA)
> +		sdhci_request_done_dma(host, mrq);
> +
> +	/*
> +	 * The controller needs a reset of internal state machines
> +	 * upon error conditions.
> +	 */
> +	if (sdhci_uhs2_needs_reset(host, mrq)) {
> +		/*
> +		 * Do not finish until command and data lines are available for
> +		 * reset. Note there can only be one other mrq, so it cannot
> +		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> +		 * would both be null.
> +		 */
> +		if (host->cmd || host->data_cmd) {
> +			spin_unlock_irqrestore(&host->lock, flags);
> +			return true;
> +		}
> +
> +		if (mrq->cmd->error || mrq->data->error)
> +			sdhci_uhs2_reset_cmd_data(host);
> +		else
> +			sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET);

sdhci_uhs2_reset() 2nd parameter is mask but SDHCI_UHS2_SW_RESET
is the register offset

> +		host->pending_reset = false;
> +	}
> +
> +	host->mrqs_done[i] = NULL;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (host->ops->request_done)
> +		host->ops->request_done(host, mrq);
> +	else
> +		mmc_request_done(host->mmc, mrq);
> +
> +	return false;
> +}
> +
> +static void sdhci_uhs2_complete_work(struct work_struct *work)
> +{
> +	struct sdhci_host *host = container_of(work, struct sdhci_host,
> +					       complete_work);
> +
> +	if (!mmc_card_uhs2(host->mmc)) {
> +		sdhci_complete_work(work);
> +		return;
> +	}
> +
> +	while (!sdhci_uhs2_request_done(host))
> +		;
> +}
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Interrupt handling                                                        *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> +	    mmc_hostname(host->mmc), uhs2mask);
> +
> +	if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> +		if (!host->cmd) {
> +			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		host->cmd->error = -EILSEQ;
> +		if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> +			host->cmd->error = -ETIMEDOUT;
> +	}
> +
> +	if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> +		if (!host->data) {
> +			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +
> +		if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> +			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
> +			       mmc_hostname(host->mmc),
> +			       (unsigned int)uhs2mask);
> +			host->data->error = -ETIMEDOUT;
> +		} else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> +			pr_err("%s: ADMA error = 0x %x\n",
> +			       mmc_hostname(host->mmc),
> +			       sdhci_readb(host, SDHCI_ADMA_ERROR));
> +			host->data->error = -EIO;
> +		} else {
> +			host->data->error = -EILSEQ;
> +		}
> +	}
> +
> +	if (host->data && host->data->error)
> +		sdhci_uhs2_finish_data(host);
> +	else
> +		sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	u32 mask = intmask, uhs2mask;
> +
> +	if (!mmc_card_uhs2(host->mmc))
> +		goto out;
> +
> +	if (intmask & SDHCI_INT_ERROR) {
> +		uhs2mask = sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> +		if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> +			goto cmd_irq;
> +
> +		/* Clear error interrupts */
> +		sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> +			     SDHCI_UHS2_INT_STATUS);
> +
> +		/* Handle error interrupts */
> +		__sdhci_uhs2_irq(host, uhs2mask);
> +
> +		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 errors */
> +		intmask &= ~SDHCI_INT_ERROR;
> +		mask &= SDHCI_INT_ERROR;
> +	}
> +
> +cmd_irq:
> +	if (intmask & SDHCI_INT_CMD_MASK) {
> +		/* Clear command interrupt */
> +		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
> +
> +		/* Handle command interrupt */
> +		if (intmask & SDHCI_INT_RESPONSE)
> +			sdhci_uhs2_finish_command(host);
> +
> +		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 commands */
> +		intmask &= ~SDHCI_INT_CMD_MASK;
> +		mask &= SDHCI_INT_CMD_MASK;
> +	}
> +
> +	/* Clear already-handled interrupts. */
> +	sdhci_writel(host, mask, SDHCI_INT_STATUS);
> +
> +out:
> +	return intmask;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> +
> +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> +{
> +	struct sdhci_host *host = dev_id;
> +	struct mmc_command *cmd;
> +	unsigned long flags;
> +	u32 isr;
> +
> +	if (!mmc_card_uhs2(host->mmc))
> +		return sdhci_thread_irq(irq, dev_id);
> +
> +	while (!sdhci_uhs2_request_done(host))
> +		;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	isr = host->thread_isr;
> +	host->thread_isr = 0;
> +
> +	cmd = host->deferred_cmd;
> +	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> +		sdhci_finish_mrq(host, cmd->mrq);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> +		struct mmc_host *mmc = host->mmc;
> +
> +		mmc->ops->card_event(mmc);
> +		mmc_detect_change(mmc, msecs_to_jiffies(200));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index f6649a518842..077a2c7a6cb0 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -176,11 +176,13 @@
>  
>  struct sdhci_host;
>  struct mmc_command;
> +struct mmc_request;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a43a3b8d7b8b..442a89234b54 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -235,7 +235,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset);
>  
> -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  {
>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>  		struct mmc_host *mmc = host->mmc;
> @@ -248,6 +248,7 @@ static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
>  
>  	return true;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_do_reset);
>  
>  static void sdhci_reset_for_all(struct sdhci_host *host)
>  {
> @@ -1497,7 +1498,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
>  }
>  
> -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>  	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
>  		((mrq->cmd && mrq->cmd->error) ||
> @@ -1505,6 +1506,7 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
>  		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
>  		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
>  }
> +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
>  
>  static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
>  {
> @@ -3097,6 +3099,53 @@ static const struct mmc_host_ops sdhci_ops = {
>   *                                                                           *
>  \*****************************************************************************/
>  
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	struct mmc_data *data = mrq->data;
> +
> +	if (data && data->host_cookie == COOKIE_MAPPED) {
> +		if (host->bounce_buffer) {
> +			/*
> +			 * On reads, copy the bounced data into the
> +			 * sglist
> +			 */
> +			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> +				unsigned int length = data->bytes_xfered;
> +
> +				if (length > host->bounce_buffer_size) {
> +					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> +					       mmc_hostname(host->mmc),
> +					       host->bounce_buffer_size,
> +					       data->bytes_xfered);
> +					/* Cap it down and continue */
> +					length = host->bounce_buffer_size;
> +				}
> +				dma_sync_single_for_cpu(mmc_dev(host->mmc),
> +							host->bounce_addr,
> +							host->bounce_buffer_size,
> +							DMA_FROM_DEVICE);
> +				sg_copy_from_buffer(data->sg,
> +						    data->sg_len,
> +						    host->bounce_buffer,
> +						    length);
> +			} else {
> +				/* No copying, just switch ownership */
> +				dma_sync_single_for_cpu(mmc_dev(host->mmc),
> +							host->bounce_addr,
> +							host->bounce_buffer_size,
> +							mmc_get_dma_dir(data));
> +			}
> +		} else {
> +			/* Unmap the raw data */
> +			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> +				     data->sg_len,
> +				     mmc_get_dma_dir(data));
> +		}
> +		data->host_cookie = COOKIE_UNMAPPED;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> +
>  static bool sdhci_request_done(struct sdhci_host *host)
>  {
>  	unsigned long flags;
> @@ -3161,48 +3210,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  			sdhci_set_mrq_done(host, mrq);
>  		}
>  
> -		if (data && data->host_cookie == COOKIE_MAPPED) {
> -			if (host->bounce_buffer) {
> -				/*
> -				 * On reads, copy the bounced data into the
> -				 * sglist
> -				 */
> -				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> -					unsigned int length = data->bytes_xfered;
> -
> -					if (length > host->bounce_buffer_size) {
> -						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> -						       mmc_hostname(host->mmc),
> -						       host->bounce_buffer_size,
> -						       data->bytes_xfered);
> -						/* Cap it down and continue */
> -						length = host->bounce_buffer_size;
> -					}
> -					dma_sync_single_for_cpu(
> -						mmc_dev(host->mmc),
> -						host->bounce_addr,
> -						host->bounce_buffer_size,
> -						DMA_FROM_DEVICE);
> -					sg_copy_from_buffer(data->sg,
> -						data->sg_len,
> -						host->bounce_buffer,
> -						length);
> -				} else {
> -					/* No copying, just switch ownership */
> -					dma_sync_single_for_cpu(
> -						mmc_dev(host->mmc),
> -						host->bounce_addr,
> -						host->bounce_buffer_size,
> -						mmc_get_dma_dir(data));
> -				}
> -			} else {
> -				/* Unmap the raw data */
> -				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> -					     data->sg_len,
> -					     mmc_get_dma_dir(data));
> -			}
> -			data->host_cookie = COOKIE_UNMAPPED;
> -		}
> +		sdhci_request_done_dma(host, mrq);
>  	}
>  
>  	host->mrqs_done[i] = NULL;
> @@ -3217,7 +3225,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  	return false;
>  }
>  
> -static void sdhci_complete_work(struct work_struct *work)
> +void sdhci_complete_work(struct work_struct *work)
>  {
>  	struct sdhci_host *host = container_of(work, struct sdhci_host,
>  					       complete_work);
> @@ -3225,6 +3233,7 @@ static void sdhci_complete_work(struct work_struct *work)
>  	while (!sdhci_request_done(host))
>  		;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_complete_work);
>  
>  static void sdhci_timeout_timer(struct timer_list *t)
>  {
> @@ -3686,7 +3695,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  	return result;
>  }
>  
> -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  {
>  	struct sdhci_host *host = dev_id;
>  	struct mmc_command *cmd;
> @@ -3716,6 +3725,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
>  
>  /*****************************************************************************\
>   *                                                                           *
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index ff53ad592d85..941723cea698 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -831,6 +831,7 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
>  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
>  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
>  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
>  void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset);
> @@ -853,6 +854,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
>  void sdhci_reset(struct sdhci_host *host, u8 mask);
> +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> @@ -862,6 +864,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);
>  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> +void sdhci_complete_work(struct work_struct *work);
> +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
>  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
>  			   dma_addr_t addr, int len, unsigned int cmd);
>  

