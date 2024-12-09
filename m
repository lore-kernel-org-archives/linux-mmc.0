Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4A21CFFE;
	Mon,  9 Dec 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743966; cv=none; b=g47mJT8kiwJY1O1x+2/wVLa4L71Q8taPlgWlGB0P3LSUY4yBE2SanpEZUakP0IF8NsdaCNZhCIZYpSDxpqssXuBjSXYgV9FJQj5pShjvu1ftngg/1j5pATl7V0Glo4WdKBkfzZQuC6uj0XylJIIORg5c0RGjwzd0DT23G6Lp0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743966; c=relaxed/simple;
	bh=BoYF5OCIxsaFrEe2jmj9dpeqG06KkB2nY29ICS4Di8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XoH6B5XvluJ9QBXSge9MNx8GnXsD4qNox/16Dy7j90rpW6UgEEuRWrTPQTyIqAJzBtO0Sj016/TV0+W1Q+WzMPSt1XIfK3s4RNJxx9k65p7jFWTdl0YR/Ym5djJ2F1mlAw1sT05dLdmSnMII08cDbCTahvP8gHJvFrtIySJ+OPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM2AMkqy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM2AMkqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733743964; x=1765279964;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BoYF5OCIxsaFrEe2jmj9dpeqG06KkB2nY29ICS4Di8Q=;
  b=QM2AMkqyrjegy7mstjxoVyJYMwWuD+5D7cAA5JinHeAml+12+wmxoCBG
   rzuASBXUW36AJCkvx7pYD/agQdiVwDmZ9mdSHS2ZQy3ot6wi3QfdOEOCR
   4VsQ3nN5ae/2XwsgdXoCvbxBQXxJzpdft1EEalSF2+dW5X4SUsfqsr4EX
   aYEdLBiOvKS7PMpDOETWJC8+uijGNkStnnirRSW0hQuo4ZHolOAlSNxZi
   uGIthbknfhis+AEDCwvBq/eZHxr8YEDuTc1ANItYg68O4VYPiO7nW1WNP
   crFOIIAQLFLDBUiPfkO8r7fm3t47dOVGDt2/3J4A1mZcdI/Bxdn4qZO10
   Q==;
X-CSE-ConnectionGUID: 6/Sph6IwRQqOPsASF1nB/Q==
X-CSE-MsgGUID: ppEr92PNS62tziRInPqUmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45411251"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45411251"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:32:44 -0800
X-CSE-ConnectionGUID: ij/+rlQuTAulmoMitOjv6A==
X-CSE-MsgGUID: C4JFe081QdyvVXlnE30vtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="99860642"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 03:32:41 -0800
Message-ID: <52ac8bbc-49d1-4104-98e2-40bb69c23f09@intel.com>
Date: Mon, 9 Dec 2024 13:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mmc: sdhci-acpi: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241101101441.3518612-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 12:11, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use) principle.
> While at it, sort them alphabetically for better maintenance.

Not a fan of alphabetical order for include files.
In this case it makes it hard to see what actually
changed.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index c931f506c1b0..fcb69a509c1e 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -5,27 +5,30 @@
>   * Copyright (c) 2012, Intel Corporation.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
> -#include <linux/init.h>
> -#include <linux/export.h>
> -#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmi.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/platform_device.h>
> -#include <linux/ioport.h>
> -#include <linux/io.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/compiler.h>
> -#include <linux/stddef.h>
> -#include <linux/bitops.h>
> -#include <linux/types.h>
> -#include <linux/err.h>
> -#include <linux/interrupt.h>
> -#include <linux/acpi.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/delay.h>
> -#include <linux/dmi.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/pm.h>

