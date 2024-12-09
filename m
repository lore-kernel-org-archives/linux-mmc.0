Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3921A45E;
	Mon,  9 Dec 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742016; cv=none; b=KD6jKdguQqbKulcXCxIij23zSb9VJzNmJiBKQaPAdRloOLDKqVX99KVcXNL8jOUGiUDWrE4PxRc7BAdjZQnQt+JR2uMGS3xRXqCYO3LulNV2UZjeqVuhaTRpeVZuBzeO3RmpnE8Wana5wcVoUsp0/037mmxtYrM3lTslNGlsXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742016; c=relaxed/simple;
	bh=JLFlL6DYThBxJfQGV1znXl8DWXLEZbMjmydvqgn3i8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ECrUS+SBsFuV4bH4MXR8Iy7xVlg0SDE6WApNYAgHObVIWHH7LEaYEbYbh8MfklGhmoAehh1SY1B9UMpnxchURGFR+FfTf4KHb9tOJsApx4eUVZmSl936KgmPjmJnbXHnQ+edl+yR0uvzsHzfcwaYMS1mGF+kQUtf5mO/CZ14RtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8mNi7Fr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8mNi7Fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733742015; x=1765278015;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JLFlL6DYThBxJfQGV1znXl8DWXLEZbMjmydvqgn3i8E=;
  b=J8mNi7FrR1+fT0psYJ9qbMqCK6lOf4V2aqjvkj5OrRSS5b66VjekjKpV
   TRnMuMm7us6RBPmxlwK9Gqjjt1vZjDebnaLEdvKhvSURcpqhFz1V1a4fk
   ZF+AlEmqoI/sM/89/FU22JwLZduYHRah1t2sr8lU/J8osUaIQpqYTmYoT
   6q+ViAvM/CXzNGkz/PXl+5FHc0INe422ULKUO5sHFSgkAexodExeApaq6
   tiPeq/+Il7RLva48qI2PShemDnIJp9Qbbne4yErqwwh4hDjP0zT3mqZvy
   K6ELqy9yrSKmW3lca7hFeDDK0rxuM8lZcz65z2G7+NNEWVgGz1aAeNxC6
   g==;
X-CSE-ConnectionGUID: HQARYHpTSHCDAo764cpETA==
X-CSE-MsgGUID: f8Cz0unOSMysgIuvVJPoBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="59430499"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="59430499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:00:13 -0800
X-CSE-ConnectionGUID: BmHk0KLmSRiPCbg4cr+tiA==
X-CSE-MsgGUID: IIuJK9GwTVWOnDi04Vhu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94872059"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:00:11 -0800
Message-ID: <446b8fbd-c53e-42da-b8ba-e955cfe8075d@intel.com>
Date: Mon, 9 Dec 2024 13:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mmc: sdhci-acpi: Switch to
 SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
> and require an ifdeffery protection against unused function warnings.
> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
> the compiler to see the functions, thus suppressing the warning. Thus
> drop the ifdeffery protection.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Seems to depend on patch 1

> ---
>  drivers/mmc/host/sdhci-acpi.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d1ce9193ece9..5241c5c26891 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -1006,8 +1006,6 @@ static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
>  	}
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int sdhci_acpi_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> @@ -1034,10 +1032,6 @@ static int sdhci_acpi_resume(struct device *dev)
>  	return sdhci_resume_host(c->host);
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_PM
> -
>  static int sdhci_acpi_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> @@ -1064,12 +1058,9 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>  	return sdhci_runtime_resume_host(c->host, 0);
>  }
>  
> -#endif
> -
>  static const struct dev_pm_ops sdhci_acpi_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
> -	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
> -			sdhci_acpi_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
> +	RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend, sdhci_acpi_runtime_resume, NULL)
>  };
>  
>  static struct platform_driver sdhci_acpi_driver = {
> @@ -1077,7 +1068,7 @@ static struct platform_driver sdhci_acpi_driver = {
>  		.name			= "sdhci-acpi",
>  		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
>  		.acpi_match_table	= sdhci_acpi_ids,
> -		.pm			= &sdhci_acpi_pm_ops,
> +		.pm			= pm_ptr(&sdhci_acpi_pm_ops),
>  	},
>  	.probe	= sdhci_acpi_probe,
>  	.remove = sdhci_acpi_remove,

