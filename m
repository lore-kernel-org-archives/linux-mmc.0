Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D8FC43217
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 07:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbiKRHdI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiKRHdH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 02:33:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8C7DEDD;
        Thu, 17 Nov 2022 23:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668756786; x=1700292786;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wqq6p7emkxt5LAd+YfGgGUaluBoYtkiltPBGxPE3TbY=;
  b=anwjS0+dVzt7K1CQ9HWE58hA8C68kSnku+wygnFzE2LWSvIjEXmqHCiB
   Srd9cjfsP5bnY0Idb2HKWMgE19vLJecOVKS17WyJ08dDglKY+T0ltN2zO
   f9OaN9tkBn6ANjI1xk1Dce1ja6LH9eOzSls0ovLqa6wtj2RsHOgGgbGL5
   mntiUVACLrtIK9xir/fjF86qqGF171lHWyoBoePzbdszIUr+eHswHWhlC
   dmIPAnY2VzciYMf6TL3WqgQorlymfdk3c7OtS04iHXVbYpxfO9fCi9tP6
   YINkaokOO4++8Z+FLA5oLuhTD7dJH7HCDbBRsULfTQ7JZbzvaEgP6Mn23
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296440958"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="296440958"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:33:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703646901"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="703646901"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.138])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:33:03 -0800
Message-ID: <11a4e08b-f176-a39a-365c-278b08fc1bdb@intel.com>
Date:   Fri, 18 Nov 2022 09:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v11 3/6] mmc: sdhci-tegra: Sort includes alphabetically
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
 <20221117182720.2290761-4-thierry.reding@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221117182720.2290761-4-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/11/22 20:27, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Sort includes alphabetically to make it easier to add new ones
> subsequently.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

12 insertions and 11 deletions because linux/bitfield.h
was added.

I am not super enthusiastic about reordering includes.
I would advise people to text search to find an include
instead.

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index c71000a07656..e2a8488d4fa9 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -3,28 +3,29 @@
>   * Copyright (C) 2010 Google, Inc.
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
> -#include <linux/iopoll.h>
> -#include <linux/platform_device.h>
> -#include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> +#include <linux/iopoll.h>
> +#include <linux/ktime.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
> -#include <linux/mmc/card.h>
> -#include <linux/mmc/host.h>
> -#include <linux/mmc/mmc.h>
> -#include <linux/mmc/slot-gpio.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/ktime.h>
>  
>  #include <soc/tegra/common.h>
>  

