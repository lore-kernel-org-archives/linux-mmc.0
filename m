Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F256158D69;
	Fri, 31 May 2024 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162171; cv=none; b=o4M6e6v1YXpLHwR760bht5Eqe0E0Wj9G6SWyVDBJSes1vU++ywdYI1Ye2MyzUaFedc+RNYE5G/DgzgO+ERPMWZ/ytx9k96dObDTNFXKJ1O2HFYEJ+t7UgCz9NlZ3ZCdrouWGzATD+cZhScgj0zlLUffzZa8oe339v6JsSzlNoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162171; c=relaxed/simple;
	bh=1B5Ail3gluKkIFy3ZhVZfOGqKlrQeSOnSE+DIaF3Mgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uI6Au0Gcxb2VAm+CiMiowb+Ae9Q2i7eLw7bBKOLIWGg0yBs+cRnXefJ5ch/0nqNwffobPfTftA+BUQqv7GxreHB1UpTPSjP/FtuIYQx6miP2HgG184KqWiDtJjcKwM83QsJf7PCX5gmsGUH361B+FkcNMeZlPCahg7hvhRNmF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKqoHK29; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKqoHK29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717162170; x=1748698170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1B5Ail3gluKkIFy3ZhVZfOGqKlrQeSOnSE+DIaF3Mgg=;
  b=fKqoHK29j2Ply4TRyhgVfaKWy+IKBj1y5XAHUsZGGuUsd4eVWRZ6/d6m
   w9A2Rslv060+vKKFSY8gButHI4uBHPkiVQ9NWM+CTsepr+iKCxIEkCN6U
   iw4S1x8CYmFPx/Vf4Bh7S8ctsiYbUi3Oy3XUWZiYU4tGqyrgStIl9Cd8g
   Yi4nQ8Fz41mpy5xRGUduPWYYlkxbEr6orOl0UpDrsCjLCUuBkTGNbVDc5
   23lpR33z3y+75/cjbifMUc7oFp8Hnv4DFnZEG/26QuE1QNVUkgIw1HUQA
   Dv7SiV2MD1B9OInJMRiWp/1SXAkI+BEw70VKaUcFKERb0zDAH3hpoqKor
   Q==;
X-CSE-ConnectionGUID: 53EQ6DuISeODcO9Bvi5SWQ==
X-CSE-MsgGUID: z0n0AeboSbeSkmitZi/AFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24264776"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="24264776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:29:29 -0700
X-CSE-ConnectionGUID: 65t5r04gR3CfyhuOBFPsQg==
X-CSE-MsgGUID: zXqrHzlNSZeV3UI/dHXMsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36188428"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:29:26 -0700
Message-ID: <b42123e6-eb46-442e-9caf-0184f86d723b@intel.com>
Date: Fri, 31 May 2024 16:29:20 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set CQE irq-handler for rockchip
 variants
To: Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org
Cc: serghox@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240530215547.2192457-1-heiko@sntech.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240530215547.2192457-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/24 00:55, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The dwcmshc used on Rockchip rk3568 and rk3588 can use cqe, so set
> the needed irq handler.
> 
> Tested on a rk3588-tiger SoM with dd, hdparm and fio. fio performance
> does increase slightly from
> 
> Run status group 0 (all jobs):
>    READ: bw=209MiB/s (219MB/s), 209MiB/s-209MiB/s (219MB/s-219MB/s), io=4096MiB (4295MB), run=19607-19607msec
> 
> without CQE to
> 
> Run status group 0 (all jobs):
>    READ: bw=215MiB/s (225MB/s), 215MiB/s-215MiB/s (225MB/s-225MB/s), io=4096MiB (4295MB), run=19062-19062msec
> 
> with CQE enabled.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4410d4523728d..3c203857189f9 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -908,6 +908,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>  	.get_max_clock		= rk35xx_get_max_clock,
>  	.reset			= rk35xx_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
>  };
>  
>  static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {

