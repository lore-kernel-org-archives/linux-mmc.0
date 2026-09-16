Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E71FD4
	for <linux-mmc@vger.kernel.org>; Wed, 16 Sep 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518840; cv=none; b=MxwpIO9yiPPfIZ0NI880ic9Cw6IqDW43WNmOgePTiZ4SRReb7xR9Nlcb3tQ/5OMugz3mSshrrtLhzR6u6OqKCPAa9F7yvFjXv0s8hXHIdidY2CiVqwiHxURZJGVjSdc3/nAKbNig037T1LFVUxFqfCrDLJS0Mzy9bpPet0FWszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518840; c=relaxed/simple;
	bh=71YSysbM73J8M4gTfdyWpUgg7TRPpNjqYLUW3z1uREc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EEqvAwRKP3AYEnfr1OYR/cgFotghty37B5b4JP8jFJswgwa0xSpPrEsuyV+UJYwKnhhp4te6uctVbPwSUsX+9ElT9FgzqU9xfrcqQPSoe3qaPdLFPEpW7VauTItUgXJWzDro0rb+zIvVUdDO1kIYDL8mnxHTNvMTCnVlMfRVWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UWMZ57Dr; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UWMZ57Dr"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=71YSysbM73J8M4gTfdyWpUgg7TRPpNjqYLUW3z1uREc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789518835; v=1; x=1790123635;
 b=UWMZ57Dr6WCQK55AQDUe4CZdJTlukCH4PijfgOfNkX/1Dke+ZbOfmJKRubGDQ83HSenTVVVy
 Wdr+GizsMh3t6v3E2l/HwzKrnCjPe2i195+eIokN9D2n/tWprtJWH8EjgxXH3CViGL7PKlNBamZ
 P9/jfG9GYqicVEz/JRH2qcq4=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 361132ff8be2991e;
	Wed, 16 Sep 2026 00:33:55 +0000
X-Mizu-Trace-ID: 361132ff8be2991e
X-Migadu-Flow: FLOW_OUT
Message-ID: <95955dcd-98ae-4130-91d7-a334818662cc@linux.dev>
Date: Wed, 16 Sep 2026 08:33:46 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Rui Miguel Silva <rmfrfs@gmail.com>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static
 functions
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/09/15 星期二 21:20, Ulf Hansson 写道:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> As there are no longer any users of these functions, let's make them
> internal to the mmc core. While at it, let's also flip the order of the
> in-parameters to mmc_alloc_host() to be consistent with devm_alloc_host().
> 

Nice move when vub300 was gone,

Reviewed-by: Shawn Lin <shawn.lin@linux.dev>

> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> ---
>   drivers/mmc/core/host.c  | 35 +++++++++--------------------------
>   include/linux/mmc/host.h |  2 --
>   2 files changed, 9 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 1bcf0e917b59..8e9e61839198 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -505,14 +505,7 @@ static int mmc_first_nonreserved_index(void)
>   	return max + 1;
>   }
>   
> -/**
> - *	mmc_alloc_host - initialise the per-host structure.
> - *	@extra: sizeof private data structure
> - *	@dev: pointer to host device model structure
> - *
> - *	Initialise the per-host structure.
> - */
> -struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> +static struct mmc_host *mmc_alloc_host(struct device *dev, int extra)
>   {
>   	int index;
>   	struct mmc_host *host;
> @@ -583,7 +576,13 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>   	return host;
>   }
>   
> -EXPORT_SYMBOL(mmc_alloc_host);
> +static void mmc_free_host(struct mmc_host *host)
> +{
> +	cancel_delayed_work_sync(&host->detect);
> +	cancel_work_sync(&host->sdio_irq_work);
> +	mmc_pwrseq_free(host);
> +	put_device(&host->class_dev);
> +}
>   
>   static void devm_mmc_host_release(struct device *dev, void *res)
>   {
> @@ -598,7 +597,7 @@ struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
>   	if (!dr)
>   		return NULL;
>   
> -	host = mmc_alloc_host(extra, dev);
> +	host = mmc_alloc_host(dev, extra);
>   	if (!host) {
>   		devres_free(dr);
>   		return NULL;
> @@ -692,19 +691,3 @@ void mmc_remove_host(struct mmc_host *host)
>   }
>   
>   EXPORT_SYMBOL(mmc_remove_host);
> -
> -/**
> - *	mmc_free_host - free the host structure
> - *	@host: mmc host
> - *
> - *	Free the host once all references to it have been dropped.
> - */
> -void mmc_free_host(struct mmc_host *host)
> -{
> -	cancel_delayed_work_sync(&host->detect);
> -	cancel_work_sync(&host->sdio_irq_work);
> -	mmc_pwrseq_free(host);
> -	put_device(&host->class_dev);
> -}
> -
> -EXPORT_SYMBOL(mmc_free_host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ddb32bc2946f..198554e48346 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -585,11 +585,9 @@ struct mmc_host {
>   
>   struct device_node;
>   
> -struct mmc_host *mmc_alloc_host(int extra, struct device *);
>   struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
>   int mmc_add_host(struct mmc_host *);
>   void mmc_remove_host(struct mmc_host *);
> -void mmc_free_host(struct mmc_host *);
>   void mmc_of_parse_clk_phase(struct device *dev,
>   			    struct mmc_clk_phase_map *map);
>   int mmc_of_parse(struct mmc_host *host);

