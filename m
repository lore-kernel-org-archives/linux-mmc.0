Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF873451B8;
	Mon, 18 Aug 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549528; cv=none; b=u85vXVF5PRx8wtsPBb18LPkEBz7tIOCb8sv9sEuwNStBkVjRaJ3V8whRT1lmIZQszTbi2e75mlxIF1Mf1O6rR4E9lHr8cEbrh+NIPOE1oYGWna62c35YFkc91pFiPx424uO2zWipW17X5HEdKNT8ejABvfthZYBXwOw65w7i5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549528; c=relaxed/simple;
	bh=0IYYWO0B6ZvRp5vVTH+D51pMvA6PkpLd76CN79sMSrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFUxqT/StOcC1hA2wzfdUM5ZckEHRiG5xYBelpDdE2MTm9W7YtTK3tSOuJ0JG8wdD84PLNGYbv9KCVw2vyzsD/qUPjNLBEkSPTiK1KnqZob6aJQv+HH+xC089sr6/iVKyLdHt9Y7zZZZDA2wUhs6T2GF/qmsSwo7gqbE+hHEYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B3Y0+REL; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B3Y0+REL"
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IKcghd2737585;
	Mon, 18 Aug 2025 15:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755549522;
	bh=77vEtxKLEbZUsC10RpC+fq6efe6YOvp3tLDFxWRZ9wg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B3Y0+RELmAh6rsWrZ++7aGVaZf+NDEVKJLsoixbMiF4mixsOt+YBADu8H24z3+2KB
	 Rc+WBBzAWl2ZvvdK9lZwZT7B5VmUz5NSlg+Tdyc2rdUqTyvP40wjxA1/wkfayAjuOP
	 PmR3uIglKzWUytYytYS5hU9TKNNX4O7Cwwxiuiqc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IKcg7L767705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 15:38:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 15:38:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 15:38:41 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IKcf2W1603499;
	Mon, 18 Aug 2025 15:38:41 -0500
Message-ID: <f07d0353-4103-4776-a303-f6a3aad5bf15@ti.com>
Date: Mon, 18 Aug 2025 15:38:41 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and
 SR1.1
To: Judith Mendez <jm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250818203310.3066985-1-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250818203310.3066985-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/18/25 3:33 PM, Judith Mendez wrote:
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
> 
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> This patch was separated from [0] since it will be merged to
> different trees anyways.
> 
> Link to v2:
> [0] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
> ---
>   drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8a099508b939..cc8c4145bf2b 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>   
>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>   #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>   };
>   
>   struct window {
> @@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	struct device *dev = mmc_dev(host->mmc);
>   	u32 ctl_cfg_2 = 0;
>   	u32 mask;
>   	u32 val;
> @@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   	if (ret)
>   		goto err_cleanup_host;
>   
> +	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
> +	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
> +		dev_info(dev, "Disable descoped HS400 mode for this silicon revision\n");

Messages to the user do not need to be imperative, maybe:

"Disabling HS400 mode not supported on this silicon revision\n"

Not a blocker,

Reviewed-by: Andrew Davis <afd@ti.com>

> +		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +	}
> +
>   	ret = __sdhci_add_host(host);
>   	if (ret)
>   		goto err_cleanup_host;
> @@ -882,6 +890,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>   	return 0;
>   }
>   
> +static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
> +	{ .family = "AM62PX", .revision = "SR1.0" },
> +	{ .family = "AM62PX", .revision = "SR1.1" },
> +	{ /* sentinel */ }
> +};
> +
>   static const struct of_device_id sdhci_am654_of_match[] = {
>   	{
>   		.compatible = "ti,am654-sdhci-5.1",
> @@ -969,6 +983,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "parsing dt failed\n");
>   
> +	soc = soc_device_match(sdhci_am654_descope_hs400);
> +	if (soc)
> +		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
> +
>   	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>   	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>   

