From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: start removing enable / disable API
Date: Wed, 29 Feb 2012 11:58:45 +0530
Message-ID: <4F4DC59D.70903@codeaurora.org>
References: <1330080561-7256-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:25633 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2B2G2v (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Feb 2012 01:28:51 -0500
In-Reply-To: <1330080561-7256-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Adrian,

On 2/24/2012 4:19 PM, Adrian Hunter wrote:
> Most parts of the enable / disable API are no longer used and
> can be removed.
>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Venkatraman S<svenkatr@ti.com>
> Cc: Kukjin Kim<kgene.kim@samsung.com>
> Cc: Thomas Abraham<thomas.abraham@linaro.org>
> Cc: Kyungmin Park<kyungmin.park@samsung.com>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
> ---
>   arch/arm/mach-exynos/mach-nuri.c           |    5 +-
>   arch/arm/mach-exynos/mach-universal_c210.c |    9 +-
>   drivers/mmc/core/core.c                    |  185 ++--------------------------
>   drivers/mmc/core/host.c                    |    1 -
>   drivers/mmc/core/host.h                    |    1 -
>   drivers/mmc/host/davinci_mmc.c             |    4 -
>   drivers/mmc/host/omap_hsmmc.c              |   15 +--
>   include/linux/mmc/core.h                   |    1 -
>   include/linux/mmc/host.h                   |   46 +-------
>   9 files changed, 25 insertions(+), 242 deletions(-)
>

> -	if (host->caps&  MMC_CAP_DISABLE)
> -		cancel_delayed_work(&host->disable);
>   	cancel_delayed_work_sync(&host->detect);
>   	mmc_flush_scheduled_work();
>
> @@ -2402,13 +2245,11 @@ int mmc_suspend_host(struct mmc_host *host)
>   {
>   	int err = 0;
>
> -	if (host->caps&  MMC_CAP_DISABLE)
> -		cancel_delayed_work(&host->disable);
>   	cancel_delayed_work(&host->detect);
>   	mmc_flush_scheduled_work();
>   	if (mmc_try_claim_host(host)) {
>   		err = mmc_cache_ctrl(host, 0);
> -		mmc_do_release_host(host);
> +		mmc_release_host(host);

mmc_try_claim_host does not call host->ops->enable(), but 
mmc_release_host call host->ops->disable(), is there any reason for 
this? For example: If host controller disable method internally calls 
clk_disable() then that would cause reference count warnings.

>   	} else {
>   		err = -EBUSY;
>   	}
> @@ -2429,7 +2270,7 @@ int mmc_suspend_host(struct mmc_host *host)

Thanks,
Sujit
