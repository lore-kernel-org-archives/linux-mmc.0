Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646A749C;
	Fri, 24 May 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533701; cv=none; b=m97yEqjxqTVmj3rRa5NUFCs+FeY7ZkFTtjyHLYSoRJM6dRsYHL2ohkl57/yP+jb+QJC5UO7ZoDSxyhIHZkJwbGGYHvWNQve2ZKcl7Rzenz9/JgLHRUlCtsjjazz9HSSnvie1yf7JUwP9Eyh/CCtDSjLnz8+u35FZAedtl42p5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533701; c=relaxed/simple;
	bh=A04reydJ1QqXaU1zeHcdF/QX1OZS7oGEypnM8LgcdY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXX0acMT8VRqFOFzjuwuj+BYFXeMJpOdiv8gZRCo4TRRt9fYXBVyvt3Q7X6htnYB3fAgxDoDwyb+5I10ni9f45vdbvbRXEJsFXjNCRkDitCKFqM9YJTl3+89z/8mybSIVC0UsyLRMOPlQGCDBT14pzSKx6Ng+GNhD4hKBQypBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnowmz/M; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnowmz/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716533699; x=1748069699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A04reydJ1QqXaU1zeHcdF/QX1OZS7oGEypnM8LgcdY0=;
  b=jnowmz/MdWNjL5WniRDkFU5UtZGairEjadLEiRgWPIGmrT48qlbAkx7u
   KVstOKwylNTZv9ZbCC5q8yQ8kOZ/KQq0WbPUiPCI0YYC0YGV4YMOEjnyw
   gG3X79ZFRHhEh7EVzglKAF74u9WZ0n23AslMBOcb74ygiI1aT9NkYO5Ze
   934uPpGk1EQ1T7Vekd3UsPC2QPMm3Z8mHEb6H4e/4YWL2kwEsrinwUeWo
   wMBUIhnP4RG3ta96TenU844DP/8qEKxodiwD9CUs9CLHXbKDGAQTL90XL
   arU8E4+jpQQQ8wlNJKJDkghVKX95OO3zId6xutyiBen6VU0ISbzpirLWy
   g==;
X-CSE-ConnectionGUID: FOyDXE+HQSW0fFku2yANWA==
X-CSE-MsgGUID: zo8YLWnQTJGdqWJwErM8AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12746320"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="12746320"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 23:54:59 -0700
X-CSE-ConnectionGUID: FvRgV3crR7yhu6p25nhFuQ==
X-CSE-MsgGUID: VE7mwNuSQM2/X6Z54El0aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33850395"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.38])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 23:54:55 -0700
Message-ID: <4354636c-24dd-4145-a551-75dc5c69910b@intel.com>
Date: Fri, 24 May 2024 09:54:50 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 08/23] mmc: core: Support UHS-II Auto Command Error
 Recovery
To: Victor Shih <victorshihgli@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
 dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-9-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240522110909.10060-9-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/24 14:08, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Add UHS-II Auto Command Error Recovery functionality
> into the MMC request processing flow.

Not sure what "auto" means here, but the commit message
should outline what the spec. requires for error recovery.

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V16:
>  - Separate the Error Recovery mechanism from patch#7 to patch#8.
> 
> ---
> 
>  drivers/mmc/core/core.c    |  4 ++
>  drivers/mmc/core/core.h    |  1 +
>  drivers/mmc/core/sd_uhs2.c | 80 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h   |  6 +++
>  4 files changed, 91 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68496c51a521..18642afc405f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -403,6 +403,10 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>  	while (1) {
>  		wait_for_completion(&mrq->completion);
>  
> +		if (host->ops->get_cd(host))
> +			if (mrq->cmd->error || (mrq->data && mrq->data->error))
> +				mmc_sd_uhs2_error_recovery(host, mrq);

There are several issues with this:

1. It is not OK to start a request from within the request path
because it is recursive:

   mmc_wait_for_req_done()			<--
      mmc_sd_uhs2_error_recovery()
         sd_uhs2_abort_trans()
            mmc_wait_for_cmd()
               mmc_wait_for_req()
                  mmc_wait_for_req_done()	<--

2. The mmc block driver does not use this path

3. No need to always call ->get_cd() if there is no error

It is worth considering whether the host controller could
send the abort command as part of the original request, as
is done with the stop command.

> +
>  		cmd = mrq->cmd;
>  
>  		if (!cmd->error || !cmd->retries ||
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 920323faa834..259d47c8bb19 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -82,6 +82,7 @@ int mmc_attach_mmc(struct mmc_host *host);
>  int mmc_attach_sd(struct mmc_host *host);
>  int mmc_attach_sdio(struct mmc_host *host);
>  int mmc_attach_sd_uhs2(struct mmc_host *host);
> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq);
>  
>  /* Module parameters */
>  extern bool use_spi_crc;
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 85939a2582dc..d5acb4e6ccac 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1324,3 +1324,83 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>  
>  	return err;
>  }
> +
> +static void sd_uhs2_abort_trans(struct mmc_host *mmc)
> +{
> +	struct mmc_request mrq = {};
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	int err;
> +
> +	mrq.cmd = &cmd;
> +	mmc->ongoing_mrq = &mrq;
> +
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
> +			  mmc->card->uhs2_config.node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_CMD_TRANS_ABORT & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_WRITE |
> +			(UHS2_DEV_CMD_TRANS_ABORT >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +	err = mmc_wait_for_cmd(mmc, &cmd, 0);
> +
> +	if (err)
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(mmc), __func__, err);
> +}
> +
> +static void sd_uhs2_abort_status_read(struct mmc_host *mmc)
> +{
> +	struct mmc_request mrq = {};
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	int err;
> +
> +	mrq.cmd = &cmd;
> +	mmc->ongoing_mrq = &mrq;
> +
> +	uhs2_cmd.header = UHS2_NATIVE_PACKET |
> +			  UHS2_PACKET_TYPE_CCMD |
> +			  mmc->card->uhs2_config.node_id;
> +	uhs2_cmd.arg = ((UHS2_DEV_STATUS_REG & 0xFF) << 8) |
> +			UHS2_NATIVE_CMD_READ |
> +			UHS2_NATIVE_CMD_PLEN_4B |
> +			(UHS2_DEV_STATUS_REG >> 8);
> +
> +	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, 0, 0);
> +	err = mmc_wait_for_cmd(mmc, &cmd, 0);
> +
> +	if (err)
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(mmc), __func__, err);
> +}
> +
> +void mmc_sd_uhs2_error_recovery(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	mmc->ops->uhs2_reset_cmd_data(mmc);

The host controller should already have done any resets needed.
sdhci already has support for doing that - see host->pending_reset

> +
> +	if (mrq->data) {
> +		if (mrq->data->error && mmc_card_uhs2(mmc)) {
> +			if (mrq->cmd) {
> +				switch (mrq->cmd->error) {
> +				case ETIMEDOUT:
> +				case EILSEQ:
> +				case EIO:
> +					sd_uhs2_abort_trans(mmc);
> +					sd_uhs2_abort_status_read(mmc);

What is the purpose of sd_uhs2_abort_status_read() here?
It is not obvious it does anything.

> +					break;
> +				default:
> +					break;
> +				}
> +			}
> +		}
> +	} else {
> +		if (mrq->cmd) {
> +			switch (mrq->cmd->error) {
> +			case ETIMEDOUT:
> +				sd_uhs2_abort_trans(mmc);
> +				break;
> +			}
> +		}
> +	}
> +}
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index fc9520b3bfa4..c914a58f7e1e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -271,6 +271,12 @@ struct mmc_host_ops {
>  	 * negative errno in case of a failure or zero for success.
>  	 */
>  	int	(*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
> +
> +	/*
> +	 * The uhs2_reset_cmd_data callback is used to excute reset
> +	 * when a auto command error occurs.
> +	 */
> +	void 	(*uhs2_reset_cmd_data)(struct mmc_host *host);
>  };
>  
>  struct mmc_cqe_ops {

