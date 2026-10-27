Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114466;
	b=gzeSnJSiWQILi2GZCAklcAuV6UIlbJ1PaQEgbD07zAk+QNyVof2mJB9iCfGIfjJiciOo
	 a3hzjXQ0I2es7cs5U5EnlRrvac3WMx9g8T7dnzkvh/h81QQvw3EXkVOM+8+9nQvU3n5LY
	 yEUSPoeEeKyPYr9b9IcWRecy6PVm6mMt7v+Wn5Eu7MaI9xxJ8c1sR8mU2q6Oj2GX50QuW
	 uxcIg+MO6q9Ud1SL0HhZ31QavZIFkXilwtoFlP86NUiJXISYYTa7u/azzXB38DFFj51+r
	 3l8qh1M9WHCpu6JsRPZx2QgLXT3BK+EfzqscZy74t4J90T40IF47zMT5A+PlzpunXVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=W6YIh/Gc0yCi5BDeh+MtSftokqchrGdjjgj9FnTKEnw=;
	b=sXg9dhINzN2503a5IVABcKaB433WTstiS1JpH75j2knLizrykJGq3DVRuhiF/D7xtNI8
	 nk21tTRlzdSJxOl5OYiE9/JJDjeAxCwXLO9LBpu4xcd8ECc6zuKUm7wXqXx9PbFRvpVuG
	 x2PK4OuZMew+RVO03cXZkm4SyY9v/2b+uURCrIqn/p/ih61j6Jhoe2eKPfoxpKAUPrgZ3
	 0w+FNutSMR8vi1UQ6EU56M/hYh/2cgSaTWxBlUuKsfk4qS87Q6c/eMTrzDNX4bjKFPpdT
	 zvywE6sPPLXjUjWNpH7l+cSkOfjqOHikZcBbPtlF1qNKrwtcPmoINrqg88TpTxHlP3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C1XhmBdB;
	arc=none smtp.remote-ip=91.218.175.233
Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BE6606A31A
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 15:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C1XhmBdB
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0TlkYeKrfeawIngsI3ug0HiDUp/gJwAA57+wIvoITDU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793114463; v=1; x=1793719263;
 b=C1XhmBdBVkRsvrNktkfe41NLUvz4sosrYWcjrG1OFB3YUrTAm9IUB7vcgmHoKiD8a9ny3aKB
 k9ZHHRppA5v9oh5vDFF28qREz/W6q5J4vpm1Rlbi8gMWBvBr9xGuMxRnuo3KsUvX70HYDeoW8Kr
 QnfipvFt0ETou4S+j7Uv/IyA=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a2887dac71c64c3;
	Tue, 27 Oct 2026 15:21:03 +0000
X-Mizu-Trace-ID: 0a2887dac71c64c3
X-Migadu-Flow: FLOW_OUT
Message-ID: <d106e4f5-7702-4bc4-ba69-765e2050a28f@linux.dev>
Date: Tue, 27 Oct 2026 23:20:52 +0800
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
Subject: Re: [PATCH v10 6/6] mmc: core: Add support for resetting an eMMC at
 system resume
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-7-ulf.hansson@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20261027144051.249211-7-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/27 星期二 22:40, Ulf Hansson 写道:
> The DT property reset-card-at-resume specifies that we need to make a reset
> of an eMMC card at system resume, assuming it also has stayed powered on
> during system suspend.
> 
> To implement support for this, let's start by parsing for the new DT
> property and set the new bit MMC_CAP2_RESET_AT_RESUME if it's found. Based
> on the property, we must also set MMC_PM_KEEP_POWER in the pm_flags for the
> host, to keep the eMMC powered on during system suspend.
> 
> Finally, to manage the actual reset during system resume, let's extend
> mmc_resume() to support the needed behaviour.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---
>   drivers/mmc/core/host.c  | 10 ++++++++++
>   drivers/mmc/core/mmc.c   |  5 +++++
>   include/linux/mmc/host.h |  1 +
>   3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8e9e61839198..e3daf4026cba 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -48,6 +48,14 @@ static int mmc_host_class_prepare(struct device *dev)
>   	if (host->bus_ops->pre_suspend)
>   		return host->bus_ops->pre_suspend(host);
>   
> +	/*
> +	 * If it's required to make a reset of the card at system resume, this
> +	 * indirectly also means that we must keep the card powered on during
> +	 * system suspend.
> +	 */
> +	if (host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> +		return mmc_set_host_pm_flags(host, MMC_PM_KEEP_POWER);
> +
>   	return 0;
>   }
>   
> @@ -375,6 +383,8 @@ int mmc_of_parse(struct mmc_host *host)
>   		host->pm_caps |= MMC_PM_KEEP_POWER;
>   	if (device_property_read_bool(dev, "wakeup-source"))
>   		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +	if (device_property_read_bool(dev, "reset-card-at-resume"))
> +		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
>   	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
>   		host->caps |= MMC_CAP_3_3V_DDR;
>   	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index d4bf0f25bd74..908d5cad304b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2315,6 +2315,11 @@ static int mmc_resume(struct mmc_host *host)
>   	}
>   
>   	pm_runtime_enable(&host->card->dev);
> +
> +	if (mmc_card_keep_power(host) &&
> +	    host->caps2 & MMC_CAP2_RESET_AT_RESUME)
> +		_mmc_hw_reset(host);
> +
>   	host->pm_flags &= ~MMC_PM_KEEP_POWER;
>   	return 0;
>   }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 032c018650e0..552873da7987 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -430,6 +430,7 @@ struct mmc_host {
>   	u32			caps2;		/* More host capabilities */
>   
>   #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
> +#define MMC_CAP2_RESET_AT_RESUME (1 << 1)	/* Reset the card at system resume */
>   #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
>   #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
>   #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */

