From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Move the judgement of timeout into
 mmc_switch_status_error()
Date: Mon, 28 Dec 2015 11:30:16 +0900
Message-ID: <56809EB8.3030706@samsung.com>
References: <1921572.349701451268445456.JavaMail.weblogic@ep2mlwas03b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59790 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbL1CaZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Dec 2015 21:30:25 -0500
In-reply-to: <1921572.349701451268445456.JavaMail.weblogic@ep2mlwas03b>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yj84.jang@samsung.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: demon.lee@samsung.com, js07.lee@samsung.com

Hi,

Did you read my comment? Which kernel version did you use?

I think your patch doesn't need on mainline kernel.
If you want to apply the patch, work on the latest kernel.

https://patchwork.kernel.org/patch/7719811/

Author:     Chaotian Jing <chaotian.jing@mediatek.com>
AuthorDate: Mon Nov 30 09:27:30 2015 +0800
Commit:     Ulf Hansson <ulf.hansson@linaro.org>
CommitDate: Tue Dec 22 11:32:18 2015 +0100

    mmc: core: fix __mmc_switch timeout caused by preempt

    there is a time window between __mmc_send_status() and time_afer(),
    on some eMMC chip, the timeout_ms is only 10ms, if this thread was
    scheduled out during this period, then, even card has already changes
    to transfer state by the result of CMD13, this part of code also treat
    it to timeout error.
    So, need calculate timeout first, then call __mmc_send_status(), if
    already timeout and card still in programing state, then treat it to
    the real timeout error.

    Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>


Best Regards,
Jaehoon Chung

On 12/28/2015 11:07 AM, Youngjin Jang wrote:
> __mmc_switch() is possible to misjudge error.
> 
> Although jiffies was overed timeout,
> the chance about "R1_CURRENT_STATE(status) != R1_STATE_PRG" is exists.
> In other words, Successful completion of CMD6 with timeout error.
> 
> Kernel expects failure of __mmc_switch,
> but card is completed CMD6 in this case.
> It makes mismatch status between mmc subsystem and mmc card.
> 
> Especially, in case of partition switch,
> If timeout occurs with normal status of CMD13 response unfortunatley,
> "main_md->curr" will not be set, even card switched successfully.

main_md->curr is right? main_md->part_curr?

> 
> Checking state of mmc card is needed when judging an timeout error,
> if it is just timeout or timeout with error.
> 
> Reviewed-by: Jungseung Lee <js07.lee@samsung.com>
> Signed-off-by: Youngjin Jang <yj84.jang@samsung.com>
> ---
>  drivers/mmc/core/mmc_ops.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..033f475 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -456,6 +456,8 @@ int mmc_switch_status_error(struct mmc_host *host, u32 status)
>  		if (status & R1_SPI_ILLEGAL_COMMAND)
>  			return -EBADMSG;
>  	} else {
> +		if (R1_CURRENT_STATE(status) == R1_STATE_PRG)
> +			return -ETIMEDOUT;
>  		if (status & 0xFDFFA000)
>  			pr_warn("%s: unexpected status %#x after switch\n",
>  				mmc_hostname(host), status);
> @@ -568,8 +570,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  		if (time_after(jiffies, timeout)) {
>  			pr_err("%s: Card stuck in programming state! %s\n",
>  				mmc_hostname(host), __func__);
> -			err = -ETIMEDOUT;
> -			goto out;
> +			break;
>  		}
>  	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
>  
> 

