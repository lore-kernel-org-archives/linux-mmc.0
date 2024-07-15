Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0A183097
	for <linux-mmc@vger.kernel.org>; Mon, 15 Jul 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024675; cv=none; b=pERb6bi3OOBCgMDT6Cm9INCEiQhJWGbYfj6Qf4ZYZIDwBMPUHZcOEJwG4iCokEmLMnSXGWn3jMPf15wEluptjTNrhM/aC7qZxjf4nvHsQ/KISh2LAcnjX8f7RZ4V/GL+K817PccQNLeBsZBrWIFCyUQlPJjYriScOuN7DvYrXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024675; c=relaxed/simple;
	bh=7q6fCxVr2WMLiJPOEwNyVGCKYYDH1ZYVvzQnyqbhyGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBpeTy+GG0vn8B8P5mL6iLOb0bZc9x1br8xwE3P59EKzVJGM+vkS0PexhKi1S1U8a0Uwj2pMCKqW1ply7pH0PkZN4OXWHEb0DwyOD9Uj2SbvqM/PfgF3tG7YgwDzLhfHXtCyEg6AX3syRuQdXisAaLeIvmY1jBBeBDCF5l/grKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRbuslBK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRbuslBK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721024674; x=1752560674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7q6fCxVr2WMLiJPOEwNyVGCKYYDH1ZYVvzQnyqbhyGo=;
  b=jRbuslBK7TG00frm5JkL2ycHo8KEYRVue+oC483JS5OyBEmhdPet06gD
   9OX8e+6Q1sgefxkBH5Hw+K9xYmp0i/tnG8OItKdorChG1AJX+Nt62RS6u
   vCwzJ1tJ5mBrRj4mc8j3siNWingzc6oYrsuLP8PrYURqdk2yq+kz0vebn
   K7PoxWLEmw6VFhMd71qAeCcupPJT44JM3NLuUrQGzeu8P5No0D2xsq5e/
   Z78K8+M4fGFq+2EjDT1Ow78ivaG0YApCJ/S4bRui17h1WFpQYJFOJXnI/
   MrTO4wnTwI2Ajl6xM1/RP/KR39ng62Bd74dhbNnKvqR2kJxHlqAeD4R65
   A==;
X-CSE-ConnectionGUID: b5HaMLzQRZeyXHnlggPfMA==
X-CSE-MsgGUID: 02dGSj/dQTOUReVMAxxrtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18584054"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="18584054"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 23:24:32 -0700
X-CSE-ConnectionGUID: vw/xWFxrTtCzZuyG0ySD3w==
X-CSE-MsgGUID: emOGtjEVREmIXH7c9RfGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="54342801"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 23:24:31 -0700
Message-ID: <382b2d12-7509-4cf9-9771-4a07626f3564@intel.com>
Date: Mon, 15 Jul 2024 09:24:29 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pxav2: Remove unnecessary null pointer check
To: Doug Brown <doug@schmorgal.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20240714155510.48880-1-doug@schmorgal.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240714155510.48880-1-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/24 18:55, Doug Brown wrote:
> There is no need to check for a null mrq->cmd in pxav1_request_done.
> mmc_request_done already assumes it's not null, and it's always called
> in this path by every SDHCI driver. This was caught by Smatch.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain/
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pxav2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index b75cbea88b40..7b957f6d5588 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -126,7 +126,7 @@ static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
>  	struct sdhci_pxav2_host *pxav2_host;
>  
>  	/* If this is an SDIO command, perform errata workaround for silicon bug */
> -	if (mrq->cmd && !mrq->cmd->error &&
> +	if (!mrq->cmd->error &&
>  	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
>  	     mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
>  		/* Reset data port */

