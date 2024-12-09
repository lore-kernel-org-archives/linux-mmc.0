Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8921B8F2;
	Mon,  9 Dec 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743771; cv=none; b=pm9m2W3fV2OdtMyPa5DWvDB2YvOxrPiKqdCvooLTdoSAoLv7JyQIheJV0mS4dN1fPNLWtHbZ72cfNiBrQOqXof4CzH8fgfRL4AW+lNaS+airjRuNeKyRpqLFJlJ7twjgwc47tnz5JnipuGmbeuNx8gA211u0MX0DfwOxAd1Qh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743771; c=relaxed/simple;
	bh=fBIyqdVrQ2c6cQq+3bT2Bl4NdWWSRV4eYvYtONYZxYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WamhjMKJjx4eE1KCzTsLJG/SKVZczHUziNVkw+sONwdD/AddoI3LfV7Kjw+0o7bjFZSesupB2dJRzarsj5U+pf+KuIpm4OfgPqNqKiU8ZU2AoDch0P4mw2/2zCK0L3Dpyx9LaW2ZuPQ5ZfGPVeABQzrEgO7x7YfifNCNwwHna78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSRfBX3N; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSRfBX3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733743769; x=1765279769;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fBIyqdVrQ2c6cQq+3bT2Bl4NdWWSRV4eYvYtONYZxYA=;
  b=nSRfBX3NBb4AhDIItkNkT/161YrvfvBz5U/5lq/5HzO7RZ9jXleh9fz2
   /EEMBjAsJkuIm+toRXYvEaOlF9oQKWWH5iDIFsx7oRJXDKeoTpknVc/6F
   U7uREkNCh3qN5DjpwxiDoDoHjcXCQZkdGe5yDdERWH8E4N1eMsF9mypo0
   lTogP/BEe/hjqvFlJXIgYEXDKL3Q9wmZuM+b5u2z3SwJ3yxHZlmEiCrsv
   GObQufHHQwgREEXciFhEKMNZQOS9kZ2r47yL2e3tC5s+4fC2oEBORcX01
   OjCDnXdjB85xQOeLS7syQ9XFzinKm5pEoP/ecUeQvWN+PvahKdh8bVL7H
   A==;
X-CSE-ConnectionGUID: Jz1fnea4Qsui5WhcvW0ueg==
X-CSE-MsgGUID: dQigyBgESgeI7sVSWIXo2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44714047"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="44714047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:29:26 -0800
X-CSE-ConnectionGUID: DcExK5wjQzCr+hch9JHNYw==
X-CSE-MsgGUID: dVVi+NIYTHS1/9e0HpM5LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95121250"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:29:25 -0800
Message-ID: <8faca5b6-bd8f-4e9f-ba0f-45e78d203667@intel.com>
Date: Mon, 9 Dec 2024 13:29:19 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] mmc: sdhci-acpi: Tidy up ACPI ID table
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-6-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> Tidy up ACPI ID table:
> - sort entries alphabetically for better maintenance

Not a fan of alphabetical order just for the sake of it.
In this case, it seems to me more useful to keep different
vendors IDs together.

> - drop comma in the terminator entry
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 8e265b53d7ce..c931f506c1b0 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -682,33 +682,35 @@ struct sdhci_acpi_uid_slot {
>  };
>  
>  static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
> -	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
> -	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
> -	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
>  	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
>  	{ "80860F14" , "2" , &sdhci_acpi_slot_int_sdio },
>  	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
>  	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
> +	{ "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
> +	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
> +	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
> +	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
> +	{ "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
>  	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
>  	{ "INT33BB"  , "3" , &sdhci_acpi_slot_int_sd },
>  	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
>  	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
>  	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
> -	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
>  	{ "PNP0D40"  },
> +	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
>  	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
>  	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
> -	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
> -	{ "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
> -	{ },
> +	{ }
>  };
>  
>  static const struct acpi_device_id sdhci_acpi_ids[] = {
> +	{ "80860F14" },
> +	{ "80860F16" },
>  	{ "80865ACA" },
>  	{ "80865ACC" },
>  	{ "80865AD0" },
> -	{ "80860F14" },
> -	{ "80860F16" },
> +	{ "AMDI0040" },
> +	{ "AMDI0041" },
>  	{ "INT33BB"  },
>  	{ "INT33C6"  },
>  	{ "INT3436"  },
> @@ -716,9 +718,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  	{ "PNP0D40"  },
>  	{ "QCOM8051" },
>  	{ "QCOM8052" },
> -	{ "AMDI0040" },
> -	{ "AMDI0041" },
> -	{ },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  

