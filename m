Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113988;
	b=W8li8zcuTZN9fBPelOVvA79hM40etssYuICX/FhkAB+kMiUSlVk8BjGJkRzHDnkDsMH8
	 9kY7x18qQbQNK7om10E2Igt2+VbJ93q+SV+27FpTIjK4i/GSxAc1KZ7RJXrvoz529BHG2
	 62u2dFMq23kf/2OZMAadIgJkEu2TpID9tkkFBuDyWmCGtzQPiLnlZGNtHkkwgjJQhzbB7
	 NKj/zIr/RfwgfLDjnt78gbUf27jW/k7ATPxivSCjZG3HS/CFaU/jf9JI0bIEVVDiimARQ
	 llUnrBweiE/ecE+yAbReQgGpHOep2WunLftZAmrqVgfe/VNnUJyPsmoGT9hCIps+7qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=A11UcNxxpBKAvqXF0gV8apwz9UitmN7B7nDEh6KsEgg=;
	b=VmsKextXkd6IYIkrktdqV8ZzYSj16mha+0mnu3gjHlEDvtMU6ivmF4V868Oh51TkdOnn
	 M/2iBrxe4dr3W9KnbkI6XLHcT3n/CkBZWcVREAHAG2c3o9pZx1cOISypi102bslV91vNJ
	 fSTZSXenm4Ho6ZR+LpWDtTgRjrwkteA/NhXWd23VtcOvWTEA7xOJwh6MxtW4ewakbXPZw
	 snmPD30BeErV9XWF2oYoqitAZpjrpnPOiX4RuolwPI7iOUWt+9xcTLdvRqwx+FoMP+Ked
	 s8tuXRNW9WkY/u7Dbe6mYoPBI1LypYVzw/Zt74vj80lDdVgL3Ngk6mzO3mGR+6Ko5LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2zPKxj9;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7796606A31B
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 15:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7796606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h2zPKxj9
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ot09Lr391s+gD9VJ0ej9HLZWHTp2K0z3o3CPA/71abg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793113984; v=1; x=1793718784;
 b=h2zPKxj9hJ7iHcYoEOlylHGhe9wqrk7G6TbhNi592kKmxl11nUOM/uxiE7VVwGfy6A+YfTdm
 jR0UwC9PyVOu/vzkL5WW6OpKREhTcRCSENpZxlzsCfnaY2J3nCcmZWHkRVna9k/DYKcNXFq/Zl3
 QDoW2xSetQ2fILNwH3f+QYTY=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 86b784ba5ef37df9;
	Tue, 27 Oct 2026 15:13:04 +0000
X-Mizu-Trace-ID: 86b784ba5ef37df9
X-Migadu-Flow: FLOW_OUT
Message-ID: <a005dddd-a495-45f4-ac43-7d708eea009c@linux.dev>
Date: Tue, 27 Oct 2026 23:12:56 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/6] mmc: core: Split sdio_set_host_pm_flags()
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-5-ulf.hansson@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20261027144051.249211-5-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ulf,

在 2026/10/27 星期二 22:40, Ulf Hansson 写道:
> To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
> allowing the second part of it to be used as an internal function for the
> core.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---
>   drivers/mmc/core/core.c    | 9 +++++++++
>   drivers/mmc/core/core.h    | 1 +
>   drivers/mmc/core/sdio_io.c | 7 +------
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 677e445dc48c..49c0494932cc 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1422,6 +1422,15 @@ int mmc_handle_undervoltage(struct mmc_host *host)
>   	return host->bus_ops->handle_undervoltage(host);
>   }
>   
> +int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
> +{
> +	if (flags & ~host->pm_caps)
> +		return -EINVAL;
> +
> +	host->pm_flags |= flags;
> +	return 0;
> +}
> +
>   /*
>    * Assign a mmc bus handler to a host. Only one bus handler may control a
>    * host at any given time.
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 9be2875608ce..d3a2ff00b18f 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -64,6 +64,7 @@ int mmc_handle_undervoltage(struct mmc_host *host);
>   void mmc_regulator_register_undervoltage_notifier(struct mmc_host *host);
>   void mmc_regulator_unregister_undervoltage_notifier(struct mmc_host *host);
>   void mmc_undervoltage_workfn(struct work_struct *work);
> +int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags);
>   
>   static inline void mmc_delay(unsigned int ms)
>   {
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 12716ec0e35d..99f857514b63 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -726,12 +726,7 @@ int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
>   
>   	host = func->card->host;
>   
> -	if (flags & ~host->pm_caps)
> -		return -EINVAL;
> -
> -	/* function suspend methods are serialized, hence no lock needed */

This is an API for sdio function driver, should we preserve this commet 
here?

> -	host->pm_flags |= flags;
> -	return 0;
> +	return mmc_set_host_pm_flags(host, flags);
>   }
>   EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
>   

