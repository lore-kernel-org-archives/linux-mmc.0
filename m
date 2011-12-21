From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: use usleep_range() in mmc_delay()
Date: Wed, 21 Dec 2011 16:55:36 +0530
Message-ID: <4EF1C230.6060005@codeaurora.org>
References: <4EF18310.6080801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24634 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1LULZk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 06:25:40 -0500
In-Reply-To: <4EF18310.6080801@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Antipov <dmitry.antipov@linaro.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/21/2011 12:26 PM, Dmitry Antipov wrote:
>  From f447d78db65c6675e69466e8ed08364ff065ac08 Mon Sep 17 00:00:00 2001
> From: Dmitry Antipov <dmitry.antipov@linaro.org>
> Date: Wed, 21 Dec 2011 10:51:03 +0400
> Subject: [PATCH] mmc: use usleep_range() in mmc_delay()
>
> ---
> drivers/mmc/core/core.h | 8 ++------
> 1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 14664f1..a77851e 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -47,12 +47,8 @@ void mmc_power_off(struct mmc_host *host);
>
> static inline void mmc_delay(unsigned int ms)
> {
> - if (ms < 1000 / HZ) {
> - cond_resched();
> - mdelay(ms);
> - } else {
> - msleep(ms);
> - }
> + unsigned long us = ms * USEC_PER_MSEC;
> + usleep_range(us, us + 1000);

I have posted similar patch some time back. 
http://comments.gmane.org/gmane.linux.ports.arm.msm/2119.

Would you like to comment on that?

Thanks,
Sujit

> }
>
> void mmc_rescan(struct work_struct *work);

