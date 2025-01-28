Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26E18D622;
	Tue, 28 Jan 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080300; cv=none; b=Js/SYRi+Rgk6X8EdgaYhOt2iNxIz1ALyQ4B5h3Y/V1IOmtFp+inmQoPNehqKAzJ7twLWrc9mMUKVxGCl13m446T8CQZfvCVsDsTGOxhMtueyHi8UKsSNnHU27kzvMc3NjF2/sQyymkdfkxr4OM6kikjrmiwUzD0Adoev0RZGVwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080300; c=relaxed/simple;
	bh=lz72shMy0/gqNUH+BQJITOpmvFTJ3Jkr36OTQTCL5Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fUUsStRmAtQO7absAgllGaXjlSOYuYjZJ8LpgOOfz16wAF7ditappTAB26c64rHkcP5OhNq95ev940nXWrLZ4uQdHRzat4KnltjBMt/a6X9EJY1FvW5zqo5C5w/A/CPvYNuZyEC9JKnbNUusRLuCkkVS02RHnt2DOqFOXSyZGXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aOkFfHji; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aOkFfHji"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50SG4dCu1987963
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 10:04:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738080279;
	bh=bC+S7694HgfHVPRviYJwpXEH+HeRFTx8iZFNhIMP1Ug=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aOkFfHjisUGoiEPmSHPR2gqHAJKtLlivk2bG3CcU4AgzDgGIz9nIwAZuwVzGxVyL2
	 Qs5FVe9uBvTzo2LZSnXTVAGMkeoJ0EbdM+nZwSDNOKE8vc41hZIW/AU1QQNN2rE+Po
	 1GIOl30bMSjlhm1TLm0V1pAULDa0wuUQNjk7oJbo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50SG4dUw013164
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jan 2025 10:04:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Jan 2025 10:04:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Jan 2025 10:04:38 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50SG4cfe085475;
	Tue, 28 Jan 2025 10:04:38 -0600
Message-ID: <93f9d38e-60b3-4090-91e7-aebf1ddb72dc@ti.com>
Date: Tue, 28 Jan 2025 10:04:38 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] mmc: Allow tuning to be skipped during card init
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <york.yang@csr.com>, <ulf.hansson@linaro.org>
References: <20250127223654.290904-1-erick.shepherd@ni.com>
 <20250127223654.290904-2-erick.shepherd@ni.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250127223654.290904-2-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Erick,

On 1/27/25 4:36 PM, Erick Shepherd wrote:
> Add a new field to the mmc_host struct to track when the card should
> skip the initial tuning and use it to conditionally stop tuning in the
> mmc_sd_init_uhs_card function. Currently the new field only gets set
> when a DDR50 card fails to tune, which indicates the card does not
> support tuning.

Just out of curiosity, why do we want to stop the initial tuning?

~ Judith

> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>   drivers/mmc/core/sd.c    | 4 +++-
>   include/linux/mmc/host.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..353715fd8f53 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -663,7 +663,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>   	if (!mmc_host_is_spi(card->host) &&
>   		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
>   		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
> -		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
> +		 card->host->ios.timing == MMC_TIMING_UHS_SDR104) &&
> +		!card->host->skip_init_tune) {
>   		err = mmc_execute_tuning(card);
>   
>   		/*
> @@ -676,6 +677,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>   		if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
>   			pr_warn("%s: ddr50 tuning failed\n",
>   				mmc_hostname(card->host));
> +			card->host->skip_init_tune = 1;
>   			err = 0;
>   		}
>   	}
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..91c4db6837c9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,6 +486,7 @@ struct mmc_host {
>   	unsigned int		use_spi_crc:1;
>   	unsigned int		claimed:1;	/* host exclusively claimed */
>   	unsigned int		doing_init_tune:1; /* initial tuning in progress */
> +	unsigned int		skip_init_tune:1;	/* skip the initial tuning */
>   	unsigned int		can_retune:1;	/* re-tuning can be used */
>   	unsigned int		doing_retune:1;	/* re-tuning in progress */
>   	unsigned int		retune_now:1;	/* do re-tuning at next req */

