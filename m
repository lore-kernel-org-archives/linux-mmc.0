Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7C21A938;
	Mon,  9 Dec 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743604; cv=none; b=P6CFXDMr9TXd0pvuTFwjpog6AIGsKCtpRbNWWnzzvHW62s2tendb+JPg2YqqyKipY++HPO/WFAk1jXwjQEj6W3yAGWUQmIYvY88Osx7IHNnx6emgQBa+0TPA9Xm51uGzApDyTcYtXrC2eA4HEy77bb46E0vFHCmv8EGXO2xKG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743604; c=relaxed/simple;
	bh=0QNsk/Qi2KMsCROyB0Mi0n1iw2pvxWs3STEg2DbBmfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g3vdP/PQch9Sak5k+32UqxTM9ULiawUyddAbDfvfaqIO94d/NIpZtC86ohgZ5Pa0Ia4sdL5k1+2GILFkkFHEP7PSc6SJFhjh9p19u7SZ5OOtQwYcq1R2zxRHt1qP3by0503mcI75YP5+kk9yGoXPCPCPHFsxZGb7IA6ZtPDDCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKxNMaHG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKxNMaHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733743602; x=1765279602;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0QNsk/Qi2KMsCROyB0Mi0n1iw2pvxWs3STEg2DbBmfw=;
  b=bKxNMaHGyZLTty+u0qkxQrutKD9WWX/B7b6BWRL9VO2m2G0WaliwluVO
   I3qsg69UY4te9q9GvVd+Rg07jqllQfX3Lt74PhBk8hT2/IeuF8NIUydnZ
   7PmT+XL7HVRiPZUhSbKaSqT1m4Sr5z+b1E1gIhkPHPOn3jP158q9EJNW1
   c3SjdYq26I6Jgig5vUT1ZC2+UZQLWR5XqKjXSk8UuSqgj9UdVYfmdQt8G
   e7slrQbtF+K4BMsrA0FUeeSJDXWytbaTZ/hcJK7RyMPRmXSpbKe3IIEar
   DVnzUDPBwF369y/fXMIG3B1teXqm/TlVsYnmfYiI5S0+5k8zu39eTujA3
   g==;
X-CSE-ConnectionGUID: XMHyCiR3SXuEZygX1ViltQ==
X-CSE-MsgGUID: RoTMbHHhR2WOavQxZxTvWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="36871605"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="36871605"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:26:41 -0800
X-CSE-ConnectionGUID: gs8kRMQkR5yht66jWfcIew==
X-CSE-MsgGUID: HY5MOvVUQuuHxmD5XKDsZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100075311"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:26:38 -0800
Message-ID: <4aa50389-ff14-4144-a07e-d1ef97449a89@intel.com>
Date: Mon, 9 Dec 2024 13:26:30 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mmc: sdhci-acpi: Use
 devm_platform_ioremap_resource()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-5-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> The struct resource is not used for anything else, so we can simplify
> the code a bit by using the helper function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index f861e9a3a911..8e265b53d7ce 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -822,8 +822,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *device;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
> -	struct resource *iomem;
> -	resource_size_t len;
>  	size_t priv_size;
>  	int quirks = 0;
>  	int err;
> @@ -844,14 +842,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	if (sdhci_acpi_byt_defer(dev))
>  		return -EPROBE_DEFER;
>  
> -	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!iomem)
> -		return -ENOMEM;
> -
> -	len = resource_size(iomem);
> -	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
> -		return -ENOMEM;
> -
>  	priv_size = slot ? slot->priv_size : 0;
>  	host = sdhci_alloc_host(dev, sizeof(struct sdhci_acpi_host) + priv_size);
>  	if (IS_ERR(host))
> @@ -873,10 +863,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  		goto err_free;
>  	}
>  
> -	host->ioaddr = devm_ioremap(dev, iomem->start,
> -					    resource_size(iomem));
> -	if (host->ioaddr == NULL) {
> -		err = -ENOMEM;
> +	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(host->ioaddr)) {
> +		err = PTR_ERR(host->ioaddr);
>  		goto err_free;
>  	}
>  

