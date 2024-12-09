Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB489219E94;
	Mon,  9 Dec 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742341; cv=none; b=t/oV2vLPjqvaHR7NHldeM6SfC97KhSB1T+Qkg/S4y92/xt9cuVO6A8sI48LVAdl6plDDVGU/t49LAvdVTpydtHvsoGbmP+q4EcVeoHzptj5C6Ia3YVE57vBqogian1JH7l0Ya4gXWXiBdcrOiAr5DcGU6vbdllRFhbo6miSsyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742341; c=relaxed/simple;
	bh=n7YGGlmMdsTgzi55fNbEQRX1BoMv4rYjTbGRl7w9cX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rrOX34dyHsOVHNxjkhg4WC1dDCqORkUhsL0fym3NK3jDpJx6qXgKgRgPLGiLaE5geM6yrgbEPFCfiQqEbr5hGKHnZpF2ti5vANjGuWbp+Nknrm6e9AQLwR6WRGbom1MYzmAmqBg991tBQLqXc/Y7tagNpgYWP84VReZNtwoysSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2HqGqXi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2HqGqXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733742340; x=1765278340;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=n7YGGlmMdsTgzi55fNbEQRX1BoMv4rYjTbGRl7w9cX8=;
  b=U2HqGqXicK41w165POqwj2pl2cC3i3yHwC6ycrF7sMWJOKM4coY6Xy6+
   SB/JV+0i3tKcobO0OfOPRh0eCyori5GlUpi6C0DsdOjRYnewZR7JDJLn9
   zxWLIfh46q8tAriNdHRXY7ysILpsoLpki7u6Yzk5A2KpRn2p5QezzIb01
   a4njBhfJ1J48U8/J1Fdi1NOputdzf7vVf56OwKDIdtERiVqc0zwtqONlM
   Gs1tNqWOAL+5hSYFPlFYVaxSFhQuPyP3j2yb2HxNEU+PdtptQzXFdcQs4
   jCu8vs+WB4bd0y9E14591ANCJRDB1jXiE3PcYEUcFNNfyl44eITpse3wN
   Q==;
X-CSE-ConnectionGUID: R3wV/vRlQ16p4zucnmoTzA==
X-CSE-MsgGUID: cEwD572kSPe5cXD1FkboXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34154540"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34154540"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:05:39 -0800
X-CSE-ConnectionGUID: BC73Iad+TEuoNeGmDi21yA==
X-CSE-MsgGUID: VOgcDn8jTqSrF7HSUsK/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="100084452"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:05:37 -0800
Message-ID: <69ad297e-f5d9-4b78-95f6-f3701b6b12d0@intel.com>
Date: Mon, 9 Dec 2024 13:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mmc: sdhci-acpi: Remove not so useful error
 message
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> First of all, this error message is just informative and doesn't prevent
> driver from going on. Second, the ioremap() on many architectures just
> works on page size granularity, which is higher than 256 bytes. Last,
> but not lease, this is an impediment for furhter cleanups, hence remove

lease -> least
furhter -> further

> it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 5241c5c26891..f861e9a3a911 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -849,9 +849,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	len = resource_size(iomem);
> -	if (len < 0x100)
> -		dev_err(dev, "Invalid iomem size!\n");
> -
>  	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
>  		return -ENOMEM;
>  

