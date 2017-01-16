From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 05/15] mmc: core: First step in cleaning up public mmc
 header files
Date: Mon, 16 Jan 2017 10:54:49 +0800
Message-ID: <4b267a82-ace4-ba77-a69d-f4a8ea454c67@rock-chips.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-6-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:39060 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdAPCzp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 21:55:45 -0500
In-Reply-To: <1484313256-25993-6-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 2017/1/13 21:14, Ulf Hansson wrote:
> This is the first step in cleaning up the public mmc header files. In this
> change we makes sure each header file builds standalone, as that helps to
> resolve dependencies.
>
> While changing this, it also seems reasonable to stop including other
> headers from inside a header itself which it don't depend upon.
> Additionally, in some cases such dependencies are better resolved by
> forward declaring the needed struct.
>

Look nice,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/mmc/card.h      | 2 --
>  include/linux/mmc/core.h      | 3 +--
>  include/linux/mmc/host.h      | 9 ++-------
>  include/linux/mmc/mmc.h       | 2 ++
>  include/linux/mmc/slot-gpio.h | 3 +++
>  5 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 00449e5..ca64f5b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -11,7 +11,6 @@
>  #define LINUX_MMC_CARD_H
>
>  #include <linux/device.h>
> -#include <linux/mmc/core.h>
>  #include <linux/mod_devicetable.h>
>
>  struct mmc_cid {
> @@ -206,7 +205,6 @@ struct sdio_cis {
>  };
>
>  struct mmc_host;
> -struct mmc_ios;
>  struct sdio_func;
>  struct sdio_func_tuple;
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index e33cc74..64e2ddf 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -8,10 +8,9 @@
>  #ifndef LINUX_MMC_CORE_H
>  #define LINUX_MMC_CORE_H
>
> -#include <linux/interrupt.h>
>  #include <linux/completion.h>
> +#include <linux/types.h>
>
> -struct request;
>  struct mmc_data;
>  struct mmc_request;
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8bc8841..8d38c76 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -10,16 +10,12 @@
>  #ifndef LINUX_MMC_HOST_H
>  #define LINUX_MMC_HOST_H
>
> -#include <linux/leds.h>
> -#include <linux/mutex.h>
> -#include <linux/timer.h>
>  #include <linux/sched.h>
>  #include <linux/device.h>
>  #include <linux/fault-inject.h>
>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/card.h>
> -#include <linux/mmc/mmc.h>
>  #include <linux/mmc/pm.h>
>
>  struct mmc_ios {
> @@ -82,6 +78,8 @@ struct mmc_ios {
>  	bool enhanced_strobe;			/* hs400es selection */
>  };
>
> +struct mmc_host;
> +
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in
> @@ -162,9 +160,6 @@ struct mmc_host_ops {
>  				  unsigned int direction, int blk_size);
>  };
>
> -struct mmc_card;
> -struct device;
> -
>  struct mmc_async_req {
>  	/* active mmc request */
>  	struct mmc_request	*mrq;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index a074082..261772e 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -24,6 +24,8 @@
>  #ifndef LINUX_MMC_MMC_H
>  #define LINUX_MMC_MMC_H
>
> +#include <linux/types.h>
> +
>  /* Standard MMC commands (4.1)           type  argument     response */
>     /* class 1 */
>  #define MMC_GO_IDLE_STATE         0   /* bc                          */
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index a7972cd..82f0d28 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -11,6 +11,9 @@
>  #ifndef MMC_SLOT_GPIO_H
>  #define MMC_SLOT_GPIO_H
>
> +#include <linux/types.h>
> +#include <linux/irqreturn.h>
> +
>  struct mmc_host;
>
>  int mmc_gpio_get_ro(struct mmc_host *host);
>


-- 
Best Regards
Shawn Lin

