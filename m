From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Do not poll for busy with status cmd for all
 switch cmds
Date: Thu, 12 Sep 2013 11:41:57 +0900
Message-ID: <523129F5.8030800@samsung.com>
References: <1378893256-27460-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47778 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab3ILClc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Sep 2013 22:41:32 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSZ00FPZRGYMSJ0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 Sep 2013 11:41:31 +0900 (KST)
In-reply-to: <1378893256-27460-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Ulf,

I will test with this patch, and share the result.
Thanks for posting this patch.

Best Regards,
Jaehoon Chung

On 09/11/2013 06:54 PM, Ulf Hansson wrote:
> Some switch operations like poweroff notify, shall according to the
> spec not be followed by any other new commands. For these cases and
> when the host does'nt support MMC_CAP_WAIT_WHILE_BUSY, we must not
> send status commands to poll for busy detection. Instead wait for
> the stated timeout from the EXT_CSD before completing the request.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/core/core.c    |    2 +-
>  drivers/mmc/core/mmc.c     |    6 +++---
>  drivers/mmc/core/mmc_ops.c |   23 ++++++++++++++++++-----
>  include/linux/mmc/core.h   |    3 ++-
>  4 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b9b9fb6..15eba0c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -301,7 +301,7 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>  	}
>  
>  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal);
> +			EXT_CSD_BKOPS_START, 1, timeout, use_busy_signal, true);
>  	if (err) {
>  		pr_warn("%s: Error %d starting bkops\n",
>  			mmc_hostname(card->host), err);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6d02012..8f0c516 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1404,9 +1404,9 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>  	if (notify_type == EXT_CSD_POWER_OFF_LONG)
>  		timeout = card->ext_csd.power_off_longtime;
>  
> -	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -			 EXT_CSD_POWER_OFF_NOTIFICATION,
> -			 notify_type, timeout);
> +	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_POWER_OFF_NOTIFICATION,
> +			notify_type, timeout, true, false);
>  	if (err)
>  		pr_err("%s: Power Off Notification timed out, %u\n",
>  		       mmc_hostname(card->host), timeout);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index ef18348..5ea83b6 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -370,11 +370,12 @@ int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
>   *	@timeout_ms: timeout (ms) for operation performed by register write,
>   *                   timeout of zero implies maximum possible timeout
>   *	@use_busy_signal: use the busy signal as response type
> + *	@send_status: send status cmd to poll for busy
>   *
>   *	Modifies the EXT_CSD register for selected card.
>   */
>  int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> -	       unsigned int timeout_ms, bool use_busy_signal)
> +		unsigned int timeout_ms, bool use_busy_signal, bool send_status)
>  {
>  	int err;
>  	struct mmc_command cmd = {0};
> @@ -411,14 +412,26 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  	/* Must check status to be sure of no errors */
>  	timeout = jiffies + msecs_to_jiffies(MMC_OPS_TIMEOUT_MS);
>  	do {
> -		err = mmc_send_status(card, &status);
> -		if (err)
> -			return err;
> +		if (send_status) {
> +			err = mmc_send_status(card, &status);
> +			if (err)
> +				return err;
> +		}
>  		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
>  			break;
>  		if (mmc_host_is_spi(card->host))
>  			break;
>  
> +		/*
> +		 * We are not allowed to issue a status command and the host
> +		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
> +		 * rely on waiting for the stated timeout to be sufficient.
> +		 */
> +		if (!send_status) {
> +			mmc_delay(timeout_ms);
> +			return 0;
> +		}
> +
>  		/* Timeout if the device never leaves the program state. */
>  		if (time_after(jiffies, timeout)) {
>  			pr_err("%s: Card stuck in programming state! %s\n",
> @@ -445,7 +458,7 @@ EXPORT_SYMBOL_GPL(__mmc_switch);
>  int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  		unsigned int timeout_ms)
>  {
> -	return __mmc_switch(card, set, index, value, timeout_ms, true);
> +	return __mmc_switch(card, set, index, value, timeout_ms, true, true);
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>  
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index da51bec..64274ec 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -151,7 +151,8 @@ extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
>  extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *,
>  	struct mmc_command *, int);
>  extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
> -extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool);
> +extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
> +			bool);
>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>  extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
>  
> 

