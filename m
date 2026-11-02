Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602372;
	b=Qn4eAQquuCJqChDzntSIL52lCZ95/MBR6DJTUW0PZ5rvmJ2M7IT0NQ4mCz0LPA4NRvcq
	 dItteJrbXuV9uTcMcpD66p6DOYsJQDxUzGJMfQ3K/1j2vHqlyd4wAD+qR6mCQt0XfsBBE
	 jSI5Ltpsy2Lv2vTN21f0HUl+NyybRfqkSW9bbkOS9JS9gO4mmSksXymrPM7SZY9lzIrGH
	 lVIs2CSPNLMPPiinFP08O+sIIGwkM1q0rQ356zKYqxd1Y7Z40ia6cUEJxtjnl7ZwRfGEU
	 7T7xjxfYGL4DcaNZbVq5d8oTitVEr2tC17lwjgkeFQzPTHvmEz90j0bhb+3AcaX4N/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602372;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bMXZ0dgVH4WoOSFJpLmJHiq7X2F+yW/TzcS8zHyoUHU=;
	b=S/V4yeqKo/Ll4eBIZYHiDp4WgcBOXhh3B8yRNT+Wz9wNuvdwp+5WlUnT9Wau8sgLvPz1
	 p1WD4N9fRQgdCWy1LAEwbvCgQDHOPg+py+Sqkg3DP6ZklTN3XL+0/MlDCTSfdiLf6VuIa
	 fBVkSWaq/HsPi7+g7flrOOoHDefzLtOI7Fzs+bU5Vgwcnx9fVgfffHpJe+8vOo8bpp2Qd
	 B1otYwwkN3R5tMxsa+VTxedawpnrxsK7OScDRC463Zf/jEUVaFXzG4nWlZxwXS4Fi8jV4
	 3F9YvtpODDHmPUpdduhKOiUXnglHXuK+zpVj77UqdTFgcPCPysMP0KTesNjiICkfV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DVcZvFMg;
	arc=none smtp.remote-ip=95.215.58.99
Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810B606A326
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 06:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2810B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DVcZvFMg
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5hCLGLGXWdd30qKe7976AVeC000uZPY7d4C8iQIIm24=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793602368; v=1; x=1794207168;
 b=DVcZvFMgTh3vVE6FmYOznLQU4BXxwXV5ZoPkXInacPSY2LC+3bHKV1e2efcGLcBZp+G9yu45
 VpYH3dsMZrGR8MJz+Gb/9Q3qrKjZElY9AEMdkHOPAGteOEeINKHmvOBSsPADug43zRH7YYwBAWL
 6m3IBZHpDtB3TsB+8j8NOH0o=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 11fb00a865b394d4;
	Mon, 02 Nov 2026 06:52:48 +0000
X-Mizu-Trace-ID: 11fb00a865b394d4
X-Migadu-Flow: FLOW_OUT
Message-ID: <98fae1e9-58e8-4564-b4f2-18e7a77b2abb@linux.dev>
Date: Mon, 2 Nov 2026 14:52:38 +0800
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
Cc: shawn.lin@linux.dev, Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v11 4/6] mmc: core: Split sdio_set_host_pm_flags()
To: Kamal Dasu <kamal.dasu@broadcom.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
 <20261030181034.3811225-5-kamal.dasu@broadcom.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20261030181034.3811225-5-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/10/31 星期六 2:10, Kamal Dasu 写道:
> From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> 
> To prepare for a subsequent change, let's split up sdio_set_host_pm_flags()
> allowing the second part of it to be used as an internal function for the
> core.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>   drivers/mmc/core/core.c    | 10 ++++++++++
>   drivers/mmc/core/core.h    |  1 +
>   drivers/mmc/core/sdio_io.c |  7 +------
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 677e445dc48c..6cbb5ee6200c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1422,6 +1422,16 @@ int mmc_handle_undervoltage(struct mmc_host *host)
>   	return host->bus_ops->handle_undervoltage(host);
>   }
>   
> +int mmc_set_host_pm_flags(struct mmc_host *host, mmc_pm_flag_t flags)
> +{
> +	if (flags & ~host->pm_caps)
> +		return -EINVAL;
> +
> +	/* function suspend methods are serialized, hence no lock needed */
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
> -	host->pm_flags |= flags;
> -	return 0;
> +	return mmc_set_host_pm_flags(host, flags);
>   }
>   EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
>   

