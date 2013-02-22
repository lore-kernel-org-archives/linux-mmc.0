From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Feb 2013 10:46:53 +0900
Message-ID: <5126CE0D.9010400@samsung.com>
References: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54091 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab3BVBqq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 20:46:46 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIL008CTM9MQ6G0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:46:45 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MIL00DMJM9VDK20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:46:44 +0900 (KST)
In-reply-to: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hyeonsu Kim <hyeonsu.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, kyungmin.park@samsung.com, tgih.jun@samsung.com

On 02/22/2013 10:27 AM, Hyeonsu Kim wrote:
> In the legacy code, driver clear not only UHS_REG 16 bit also 0-15bit.
> If we use UHS-1 mode spec card like SDR50, SDR104. UHS_REG 0-15 should be set by
> 1 according to slot id. In this case, legacy code can make problem.
UHS_REG register is consist of DDR_REG[31:16] and VOLT_REG[15:0].
Before adjusting this patch, bit[15:0] is always cleared.
So this patch looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 323c502..390c15c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -789,9 +789,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	/* DDR mode set */
>  	if (ios->timing == MMC_TIMING_UHS_DDR50)
> -		regs |= (0x1 << slot->id) << 16;
> +		regs |= ((0x1 << slot->id) << 16);
>  	else
> -		regs &= ~(0x1 << slot->id) << 16;
> +		regs &= ~((0x1 << slot->id) << 16);
>  
>  	mci_writel(slot->host, UHS_REG, regs);
>  
> 

