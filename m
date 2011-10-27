From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 1/3 v2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Thu, 27 Oct 2011 16:19:45 -0500
Message-ID: <EC466705-A720-4083-A41E-C57065381C47@freescale.com>
References: <1314345150-1803-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:49532
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077Ab1J0VTw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Oct 2011 17:19:52 -0400
In-Reply-To: <1314345150-1803-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linuxppc-dev@lists.ozlabs.org


On Aug 26, 2011, at 2:52 AM, Chunhe Lan wrote:

> Move mmc_delay() from drivers/mmc/core/core.h to
> include/linux/mmc/core.h. So when other functions
> call it with include syntax using <linux/mmc/core.h>
> of absolute path rather than "../core/core.h" of
> relative path.
> 
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> drivers/mmc/core/core.h  |   12 ------------
> include/linux/mmc/core.h |   11 +++++++++++
> 2 files changed, 11 insertions(+), 12 deletions(-)

Chris,

Any comments on these patches or acceptance?

- k

> 
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index d9411ed..58c3f10 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -11,8 +11,6 @@
> #ifndef _MMC_CORE_CORE_H
> #define _MMC_CORE_CORE_H
> 
> -#include <linux/delay.h>
> -
> #define MMC_CMD_RETRIES        3
> 
> struct mmc_bus_ops {
> @@ -44,16 +42,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
> 
> -static inline void mmc_delay(unsigned int ms)
> -{
> -	if (ms < 1000 / HZ) {
> -		cond_resched();
> -		mdelay(ms);
> -	} else {
> -		msleep(ms);
> -	}
> -}
> -
> void mmc_rescan(struct work_struct *work);
> void mmc_start_host(struct mmc_host *host);
> void mmc_stop_host(struct mmc_host *host);
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b8b1b7a..7bc2798 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -10,6 +10,7 @@
> 
> #include <linux/interrupt.h>
> #include <linux/device.h>
> +#include <linux/delay.h>
> 
> struct request;
> struct mmc_data;
> @@ -182,6 +183,16 @@ static inline void mmc_claim_host(struct mmc_host *host)
> 	__mmc_claim_host(host, NULL);
> }
> 
> +static inline void mmc_delay(unsigned int ms)
> +{
> +	if (ms < 1000 / HZ) {
> +		cond_resched();
> +		mdelay(ms);
> +	} else {
> +		msleep(ms);
> +	}
> +}
> +
> extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> 
> #endif /* LINUX_MMC_CORE_H */
> -- 
> 1.7.5.1
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


