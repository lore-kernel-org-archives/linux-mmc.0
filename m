Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105823BFB9;
	Thu,  6 Feb 2025 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886042; cv=none; b=p31FvfzBqdA9K/5CEPHeO3T7TqB6oV6spwYzE3tnAmr+JLL63YVYdve8a91HPS0LI2+DljRmP/RHPU/oVZwCmGlShx4uXlhm5Ix+KVHrldYrfxYh9ShZv8cDrB8hOdRN+JPBonywo7/r3PwjY0H3CjyOZP7t0eXady1oEwpe8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886042; c=relaxed/simple;
	bh=sKG74MO9Ervs86b/Vu+wnBliMPOJbJqlCG4ip85mvx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QwDAlDV96n+lKydeXJ/pGil9cnbaJVuDGvqF7JD51f7y+kNtpfP4vDwRFoBTLYvQvZ0nV0b/eBy51euNgDe7xHzpkLG/yURfDQ8yCrmM510bsTkQ/3cJqHZoiMt0QNQ7WWjpDpMEcm6oAvrtDZnjUQcx33wt521jCBArWBiPxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y5qSaZM/; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y5qSaZM/"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516Nrgjl3717759
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 6 Feb 2025 17:53:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738886022;
	bh=LtFm2TQkrq/3ELtvJyhJA/YKyIt5JyaTds3OSrbiL58=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Y5qSaZM/xLbydMpDodPMN2poddD9QNeVIvzAd5120XewL1F7iZ/yKnh4OLQ7iliu+
	 M5QMc7AJTvEcQZMGikQzXpKr8Mh13rk7Ye61v56NUOjJX1Mi20rE3QN39hX1IoldMS
	 H/kGOK5HA4B2V+GisyIZB3zIICzWIf8JwPNxDBqI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516NrgQi099666;
	Thu, 6 Feb 2025 17:53:42 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 17:53:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 17:53:42 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516Nrfgh010084;
	Thu, 6 Feb 2025 17:53:41 -0600
Message-ID: <26432c7c-1cc7-4870-9eda-ee8564d2d4a2@ti.com>
Date: Thu, 6 Feb 2025 17:53:41 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] mmc: Update sdhci tune function to return errors
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <york.yang@csr.com>, <ulf.hansson@linaro.org>
References: <20250127223654.290904-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250127223654.290904-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Erick,

On 1/27/25 4:36 PM, Erick Shepherd wrote:
> Updates the sdhci_execute_tuning function to return the error code
> that was returned by the __sdhci_execute_tuning function.
> Previously this code was only stored in host->tuning_err and not
> actually returned.
> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
>   drivers/mmc/host/sdhci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..b35b8917fa1e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2967,7 +2967,8 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   
>   	sdhci_start_tuning(host);
>   
> -	host->tuning_err = __sdhci_execute_tuning(host, opcode);
> +	err = __sdhci_execute_tuning(host, opcode);
> +	host->tuning_err = err;
>   
>   	sdhci_end_tuning(host);
>   out:

