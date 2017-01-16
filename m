From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 1/2] mmc: dw_mmc: silent verbose log when calling from
 PM context
Date: Mon, 16 Jan 2017 19:00:32 +0900
Message-ID: <14b8e5c4-c2ea-d06f-a7ab-500315fc109c@samsung.com>
References: <CGME20170113030103epcas4p430615cda590ef944a8163e68ee77a192@epcas4p4.samsung.com>
 <1484276362-44984-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57425 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdAPKAf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 05:00:35 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OJV0309MAGXYZB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jan 2017 19:00:33 +0900 (KST)
In-reply-to: <1484276362-44984-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, sgilles@math.umd.edu, Randy Li <randy.li@rock-chips.com>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 01/13/2017 11:59 AM, Shawn Lin wrote:
> When deploying runtime PM, it's quite verbose to print the
> log of ios setting. Also it's useless to print it from system
> PM as it should be the same with booting time. We also have
> sysfs to get all these information from ios attribute, so let's
> skip this print from PM context.

It seems that force_clkinit and pm_context are same value..
Why do you put "pm_context"?

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3d213e7..dc58ec3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1153,7 +1153,8 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>  		cmd, arg, cmd_status);
>  }
>  
> -static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
> +static void dw_mci_setup_bus(struct dw_mci_slot *slot,
> +			     bool force_clkinit, bool pm_context)
>  {
>  	struct dw_mci *host = slot->host;
>  	unsigned int clock = slot->clock;
> @@ -1182,11 +1183,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		if ((clock != slot->__clk_old &&
>  			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
>  			force_clkinit) {
> -			dev_info(&slot->mmc->class_dev,
> -				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> -				 slot->id, host->bus_hz, clock,
> -				 div ? ((host->bus_hz / div) >> 1) :
> -				 host->bus_hz, div);
> +			/* Silent the verbose log if calling from PM context */
> +			if (!pm_context)
> +				dev_info(&slot->mmc->class_dev,
> +					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> +					 slot->id, host->bus_hz, clock,
> +					 div ? ((host->bus_hz / div) >> 1) :
> +					 host->bus_hz, div);
>  
>  			/*
>  			 * If card is polling, display the message only
> @@ -1434,12 +1437,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		}
>  
>  		/* Adjust clock / bus width after power is up */
> -		dw_mci_setup_bus(slot, false);
> +		dw_mci_setup_bus(slot, false, false);
>  
>  		break;
>  	case MMC_POWER_OFF:
>  		/* Turn clock off before power goes down */
> -		dw_mci_setup_bus(slot, false);
> +		dw_mci_setup_bus(slot, false, false);
>  
>  		if (!IS_ERR(mmc->supply.vmmc))
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> @@ -3366,7 +3369,7 @@ int dw_mci_runtime_resume(struct device *dev)
>  			continue;
>  		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>  			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> -			dw_mci_setup_bus(slot, true);
> +			dw_mci_setup_bus(slot, true, true);
>  		}
>  	}
>  
> 

