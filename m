Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0703347C7;
	Fri,  8 Aug 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660299; cv=none; b=b5ogZWdrn0CFuMYgrAz/DLpNYxpBnwllE+Y2FNbP6dn02adl+1PKpFSbBeNebr03ywYULKPr7cHyX9CAGthV9UjuFKoYlihae1QmzRZrAFtnjDtnnrSJKpZJmevSYu1IPEgmraCuIq71jnAJtm+jRxZSfQDjRyg4BjCUtxvnRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660299; c=relaxed/simple;
	bh=c5lrnUgwIG/rNRAu0GC1hkwAXsNvrmjR7WDCjDn8UKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpN+07sqQnjLQz7pYdwQ7HB/Ev+4yRWXIZQMbcmLRNiiqYEEk4DmxSgeY3vI/EIBA/4ydvRE2ZNUPTTcJNUi4BVVn0tyF6kDHX43NzU39JXmJjk5uxBVlanUVZe9kxtjuGiYG7/yESefohCX1evxC5f5cjVGqFaQL2e7HZpVHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D3utI2E5; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D3utI2E5"
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578Dc9A8991745;
	Fri, 8 Aug 2025 08:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754660289;
	bh=fY6ITv0IOCwAWvbopI78ay0Ho+0F53h/qZ6BsbQ7c3Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D3utI2E5WFPqamVWrVO4a81tSwdLi0z6mOuyh7BD0sJ/1z2h91QIRwCJetoQbOosH
	 0wNxxvKkaMDf1KPSgEy9X/7q+tIxDvs/w7brC8w/24O0bu6gQY4ANOJWLgEqJ1r28Q
	 rVJIMxchuHyliXWThmBJRm4QQK97skudF8D4IpeA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578Dc91U520915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 08:38:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 08:38:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 08:38:08 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578Dc8OD3118894;
	Fri, 8 Aug 2025 08:38:09 -0500
Message-ID: <16fac32a-a42a-4ec8-b0a2-3efe785af728@ti.com>
Date: Fri, 8 Aug 2025 08:38:08 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0
 and SR1.1
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
References: <20250807225138.1228333-1-jm@ti.com>
 <20250807225138.1228333-3-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250807225138.1228333-3-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

On 8/7/25 5:51 PM, Judith Mendez wrote:
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
> 
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e4fc345be7e5..dc4975514847 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -156,6 +156,7 @@ struct sdhci_am654_data {
>   
>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>   #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>   };
>   
>   struct window {
> @@ -765,6 +766,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	struct device *dev = mmc_dev(host->mmc);
>   	u32 ctl_cfg_2 = 0;
>   	u32 mask;
>   	u32 val;
> @@ -820,6 +822,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   	if (ret)
>   		goto err_cleanup_host;
>   
> +	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
> +	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
> +		dev_err(dev, "Disable descoped HS400 mode for this silicon revision\n");

Forgot to switch to dev_info, so will respin the series one more time.

Sorry for the noise.

~ Judith

