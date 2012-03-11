From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Sun, 11 Mar 2012 18:06:52 +0200 (IST)
Message-ID: <c498ff8b542c601db641988c35ae120c.squirrel@www.codeaurora.org>
References: <4F190E26.4040909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24730 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab2CKQGx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Mar 2012 12:06:53 -0400
In-Reply-To: <4F190E26.4040909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hello Jaehoon,

On Fri, January 20, 2012 8:48 am, Jaehoon Chung wrote:
...
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 4d41fa9..109d0f0 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -392,13 +392,22 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>  		  (index << 16) |
>  		  (value << 8) |
>  		  set;
> -	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +	cmd.flags = MMC_CMD_AC;
> +	if (index == EXT_CSD_BKOPS_START &&
> +	    card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
> +		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> +	else
> +		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;

It is not good to use conditional on 'index', because this function
(mmc_switch)
is generic and in case you want functionality like here "in some cases cmd
 should not wait for PROG_DONE" it is better to use different approach:

1. Use internal function with additional parameter wait_for_prog_done:

int __mmc_switch(struct mmc_card *card, u8 set, u8 index,
                 unsigned int timeout_ms, u8 wait_for_prog_done)
{
...
    if(wait_for_prog_done)
      cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
    else
      cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
...
}

2. implement mmc_switch through __mmc_switch()
   int mmc_switch(struct mmc_card *card, u8 set, u8 index,
                                   unsigned int timeout_ms)
   {
     return __mmc_switch(card, set, index, timeout_ms, 0);
   }
3. when you need to start bkops, use: __mmc_switch(card, set, index,
timeout_ms, 1);

Does it make sense?

-- 
Konstantin Dorfman
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


