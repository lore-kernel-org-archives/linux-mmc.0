From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 2/2] mmc: dw_mmc: force setup bus if active slots exist
Date: Fri, 20 Jan 2017 17:19:15 +0900
Message-ID: <ba8bcad2-aba4-efb1-986c-7dfd224e8a54@samsung.com>
References: <1484616176-1005-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20170117012513epcas2p1a06202afac3ee9ce89057643d221c50f@epcas2p1.samsung.com>
 <1484616176-1005-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58313 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdATITS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 03:19:18 -0500
In-reply-to: <1484616176-1005-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, stable@vger.kernel.org

Hi Shawn,

On 01/17/2017 10:22 AM, Shawn Lin wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
> 
> It's necessary to setup bus if any slots are present.
> - update clock after ctrl reset
> - if the host has genpd node, we can guarantee the clock is
>   available before starting request. Otherwies, the clock register
>   is reset once power off the pd, and host can't output the active
>   clock during communication.
> 
> Fixes: e9ed8835e990 ("mmc: dw_mmc: add runtime PM callback")
> Fixes: df9bcc2bc0a1 ("mmc: dw_mmc: add missing codes for runtime resume")
> cc: <stable@vger.kernel.org>
> Reported-by: Randy Li <randy.li@rock-chips.com>
> Reported-by: S. Gilles <sgilles@math.umd.edu>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied on my fixes branch. Thanks!

Best Regards,
Jaehoon Chung

> 
> ---
> 
> Changes in v6:
> - reuse force_clkinit
> 
> Changes in v5:
> - rebase in order to skip spamming log
> 
> Changes in v4:
> - update commit message
> - fix SD host rpm resume can't work
> 
> Changes in v3:
> - only reset host with active slot.
> 
> Changes in v2:
> - update the commit message
> - use dw_mci_reset instead of dw_mci_ctrl_reset
> 
>  drivers/mmc/host/dw_mmc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 972c779..a9ac0b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3366,10 +3366,11 @@ int dw_mci_runtime_resume(struct device *dev)
>  
>  		if (!slot)
>  			continue;
> -		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
> +		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>  			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> -			dw_mci_setup_bus(slot, true);
> -		}
> +
> +		/* Force setup bus to guarantee available clock output */
> +		dw_mci_setup_bus(slot, true);
>  	}
>  
>  	/* Now that slots are all setup, we can enable card detect */
> 

