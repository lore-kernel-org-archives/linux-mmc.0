From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 1/2] mmc: dw_mmc: silent verbose log when calling from
 PM context
Date: Fri, 20 Jan 2017 17:20:00 +0900
Message-ID: <5fdeb192-a1a6-dde1-648f-1852b596b281@samsung.com>
References: <CGME20170117012441epcas4p40d9a54cd0fe293740e44e55fdae5b7d7@epcas4p4.samsung.com>
 <1484616176-1005-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55284 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdATIUL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 03:20:11 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK202NO8KHDI590@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 17:20:01 +0900 (KST)
In-reply-to: <1484616176-1005-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>

Hi Shawn,

On 01/17/2017 10:22 AM, Shawn Lin wrote:
> When deploying runtime PM, it's quite verbose to print the
> log of ios setting. Also it's useless to print it from system
> PM as it should be the same with booting time. We also have
> sysfs to get all these information from ios attribute, so let's
> skip this print from PM context.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied on my dwmmc repository. Thanks!

Best Regards,
Jaehoon Chung

> 
> ---
> 
> Changes in v6:
> - reuse force_clkinit to skip the log
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3d213e7..972c779 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1182,11 +1182,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  		if ((clock != slot->__clk_old &&
>  			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
>  			force_clkinit) {
> -			dev_info(&slot->mmc->class_dev,
> -				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> -				 slot->id, host->bus_hz, clock,
> -				 div ? ((host->bus_hz / div) >> 1) :
> -				 host->bus_hz, div);
> +			/* Silent the verbose log if calling from PM context */
> +			if (!force_clkinit)
> +				dev_info(&slot->mmc->class_dev,
> +					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
> +					 slot->id, host->bus_hz, clock,
> +					 div ? ((host->bus_hz / div) >> 1) :
> +					 host->bus_hz, div);
>  
>  			/*
>  			 * If card is polling, display the message only
> 

