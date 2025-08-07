Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A5E2737EF;
	Thu,  7 Aug 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587702; cv=none; b=tYEtZSVH/Ovlhyql/nSufPFm8DPziKLFGmbye304ygga+Fkg3voyObLMOO6QXgpEefRemBSh3ceFGDNQHrebXqT7MIXsIBOsoRVzMRVYwN5oNfYgaY7Wf6mMsvZce6YARqpDrKeJZHjASq1uZXXJzOm8BI6AZF7ueDRvgvPVRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587702; c=relaxed/simple;
	bh=RlfgqenZp/u2agKKqu+k8blhWUlCC8aMnC0gzMmvjD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hbIFCAY6AJ8URGyD1S5XWJmzC+D2DGdauiNjQ0dOZRAp+yjNgmDQ1q32Trjoa3jH2/vikgkObO9MKzgrTdn/he2YHmuEpdC4FIO7VEEHgnmZlGCUNtLS5Y2uX4LWAjLT+GaK2oCaZrkaZYuLSrFieekdGLr9u+FcCL3B7xoxZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AECQ4PUt; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AECQ4PUt"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577HSB66362525;
	Thu, 7 Aug 2025 12:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754587692;
	bh=89lt97KFuZW4IPtsnBj++K4Y2vg1Z9hid7I47qBXrLc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AECQ4PUtPmJiO6IeeDPUTS5sO6f4VxviGDeHQrSZ/dbw1QxsFC3u8z/j+sBsTbg9R
	 47fcL35z3TAg/irpCaBjcjCNQMNmEbJ96I1ANtZgIX2MsEonNVT0Gj88kB7Q34oTf2
	 RERLvLx2P/LHx8GbmBc9R9C+bVLnKyEYIK78wV0Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577HSBNG1037376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 12:28:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 12:28:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 12:28:11 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577HSA1R1420821;
	Thu, 7 Aug 2025 12:28:10 -0500
Message-ID: <1f424bbd-3830-41f9-af4b-9d17af42edaa@ti.com>
Date: Thu, 7 Aug 2025 12:28:10 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and
 SR1.1
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20250805234950.3781367-1-jm@ti.com>
 <20250805234950.3781367-4-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250805234950.3781367-4-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/5/25 6:49 PM, Judith Mendez wrote:
> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
> due to errata i2458 [0] so disable HS400 for these SoC revisions.
> 
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/mmc/host/sdhci_am654.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e4fc345be7e5..b7d2adff3277 100644
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
> @@ -820,6 +821,9 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   	if (ret)
>   		goto err_cleanup_host;
>   
> +	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400)
> +		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> +
>   	ret = __sdhci_add_host(host);
>   	if (ret)
>   		goto err_cleanup_host;
> @@ -883,6 +887,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
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
> @@ -970,6 +980,12 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "parsing dt failed\n");
>   
> +	soc = soc_device_match(sdhci_am654_descope_hs400);
> +	if (soc) {
> +		dev_err(dev, "Disable descoped HS400 mode for this silicon revision\n");

Not really an error, use dev_info() or dev_warn(). Also this message
should go up in the init function when the caps are actually removed,
and only printed if the caps were set in the first place.

Andrew

> +		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
> +	}
> +
>   	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>   	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>   

