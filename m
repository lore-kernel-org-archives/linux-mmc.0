Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604044;
	b=0xjaojoviBxc3TGLdOL9yjG+7eGfPVbsz+7Kx0eDEbYmZvLtJkuWkVLdmO+7vER9XmhH
	 U/d0BLtNa+orogxCKEdsKavvSE9vLEWWytb0Eniz0jVdfQZ+Rf+GxQ9paJFahllqxwzWf
	 LKLfnc9cHVnbNdGuXpXkul3/ScGwNJ1SuVU3WY/G+KGoFryNoMjU9J1x9UDaZjZmvyLIl
	 yp2RlV6/AJ1nH0YSY+Dfqf9fwtenYUWKt+JuPVdNydg+RZCRJQaIi3lj6hwA4VeytOgnN
	 Vinvu0FLPqRJT30jfqR0h00DzQ6H2RGo6sJNtBCm90rdl1EFCgflrL/OxpzEbfEljKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604044;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gd+hGEGM2Vnn8hTbClRMrTy8v2VKZQsmXOh+wQ/G2aw=;
	b=Ahp5qnEDSF6Y90IlgwgAdeAoM6qcrYX43pDJ0KGgeykI1XxWMotVMb5DbfMKVkJmILid
	 PMUb62Qo8g5bwQDFSOBwM1weWLzQPzWnA0H+tfKXdVGU9YPcSqu0eYlJ6tJ1hpW0EdVup
	 QZOiNhaCgOU9h0jhzHOAL3GYcRv5E/jqE7o7AEb9iOkAjh9VMRA8z82Pnmh7hus690y9y
	 fLQn1sRFWj2q0BJ+ThWOe7G4q5n8wqeiqCp3a/pUKmksW2acFdyalMUU6oDj00SqQ+x56
	 +rkxHUTs1CSOhyAcK8ym0XJoXD718dLTzWnG5qV/46rf8Wtfh8MWWSoNSLxPsbCQj9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K+7NKyyO;
	arc=none smtp.remote-ip=95.215.58.26
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6813606A324
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 07:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6813606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K+7NKyyO
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kLN6oli0AthDvizLE+0mZtojUTfv9uqFrmrnHc7+xQM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793604041; v=1; x=1794208841;
 b=K+7NKyyO0neyS3fZOQU/SbajgI9YtbqkzEq0I+Wlo5bzePURV8Yp5yPGr8AlkpN3Esfugidc
 tkGOJXhBAu9mEfjPXO2cYr7EezyW3JyZTW/VrvTW6jEqndaUH3YkKEBSfKB3jN1ZqimzRlODDUB
 Nu/GUMFL4xFtcLqKfulo9HFw=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 20128cc2e629c35a;
	Mon, 02 Nov 2026 07:20:39 +0000
X-Mizu-Trace-ID: 20128cc2e629c35a
X-Migadu-Flow: FLOW_OUT
Message-ID: <e27b69ed-7444-49ac-99d2-dd78f2ef8b9c@linux.dev>
Date: Mon, 2 Nov 2026 15:20:28 +0800
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
Subject: Re: [PATCH v11 6/6] mmc: core: Add support for resetting an eMMC at
 system resume
To: Kamal Dasu <kamal.dasu@broadcom.com>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>
References: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
 <20261030181034.3811225-7-kamal.dasu@broadcom.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20261030181034.3811225-7-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/10/31 星期六 2:10, Kamal Dasu 写道:
> From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> 
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
> The property only makes sense together with keep-power-in-suspend, as the
> card would otherwise be powered off and system suspend is refused. Warn
> about that while parsing the DT properties, to flag the misconfiguration
> upfront. While at it, claim the host around the reset in mmc_resume(), as
> it sends commands to the card.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Co-developed-by: Kamal Dasu <kamal.dasu@broadcom.com>
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>   drivers/mmc/core/host.c  | 13 +++++++++++++
>   drivers/mmc/core/mmc.c   |  8 ++++++++
>   include/linux/mmc/host.h |  1 +
>   3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8e9e61839198..8b38ff45d20f 100644
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
> @@ -375,6 +383,11 @@ int mmc_of_parse(struct mmc_host *host)
>   		host->pm_caps |= MMC_PM_KEEP_POWER;
>   	if (device_property_read_bool(dev, "wakeup-source"))
>   		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +	if (device_property_read_bool(dev, "reset-card-at-resume")) {
> +		host->caps2 |= MMC_CAP2_RESET_AT_RESUME;
> +		if (!(host->pm_caps & MMC_PM_KEEP_POWER))
> +			dev_warn(dev, "reset-card-at-resume without keep-power-in-suspend, system suspend will fail\n");

No strong opinion on this log, but we set MMC_PM_KEEP_POWER if
reset-card-at-resume is present anyway, could the suspend fail?

> +	}
>   	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
>   		host->caps |= MMC_CAP_3_3V_DDR;
>   	if (device_property_read_bool(dev, "mmc-ddr-1_8v"))
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 026003ba507d..a9e3cf7ae039 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2320,6 +2320,14 @@ static int mmc_resume(struct mmc_host *host)
>   	}
>   
>   	pm_runtime_enable(&host->card->dev);
> +
> +	if (mmc_card_keep_power(host) &&
> +	    host->caps2 & MMC_CAP2_RESET_AT_RESUME) {
> +		mmc_claim_host(host);
> +		_mmc_hw_reset(host);
> +		mmc_release_host(host);
> +	}
> +
>   	host->pm_flags &= ~MMC_PM_KEEP_POWER;
>   	return 0;
>   }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 032c018650e0..3c0ea74e3e35 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -430,6 +430,7 @@ struct mmc_host {
>   	u32			caps2;		/* More host capabilities */
>   
>   #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
> +#define MMC_CAP2_RESET_AT_RESUME BIT(1)	/* Reset the card at system resume */
>   #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
>   #define MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND (1 << 3) /* Can do full power cycle in suspend */
>   #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */

