From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc: dw_mmc: release hardware lock error
Date: Tue, 28 Feb 2012 15:42:13 +0900
Message-ID: <4F4C7745.9090202@samsung.com>
References: <loom.20120228T060529-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40374 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737Ab2B1GmP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2012 01:42:15 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0300FW3BXK3LL0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 15:42:14 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0300H9KBYE4J10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Feb 2012 15:42:14 +0900 (KST)
In-reply-to: <loom.20120228T060529-421@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dongjin Kim <dongjin.kim@agreeyamobility.net>
Cc: linux-mmc@vger.kernel.org

On 02/28/2012 02:32 PM, Dongjin Kim wrote:

> Hello,
> 
> I encountered the problem that my hardware is frozen while switching clock from 
> 400kHz to others. This is caused that hardware locked error was triggered when 
> CMD register was written and interrupt was pended. Tested IP version is 2.10a
> 

Hi Dongjin.

It seems like this problem. Can you check this patch?
http://www.spinics.net/lists/linux-mmc/msg09895.html

Best Regards,
Jaehoon Chung

> Cheers,
> Dongjin.
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2f7f5ee..05ccee8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -520,15 +520,33 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 
> cmd, u32 arg)
>  	struct dw_mci *host = slot->host;
>  	unsigned long timeout = jiffies + msecs_to_jiffies(500);
>  	unsigned int cmd_status = 0;
> +	u32 ctrl;
>  
> +resend:
>  	mci_writel(host, CMDARG, arg);
>  	wmb();
>  	mci_writel(host, CMD, SDMMC_CMD_START | cmd);
> +
>  	while (time_before(jiffies, timeout)) {
>  		cmd_status = mci_readl(host, CMD);
>  		if (!(cmd_status & SDMMC_CMD_START))
>  			return;
> +
> +		if (host->cmd_status & SDMMC_INT_HLE) {
> +			dev_err(&slot->mmc->class_dev,
> +				"Hardware locked error (cmd %#x arg %#x)\n",
> +				cmd, arg);
> +
> +			ctrl = mci_readl(host, CTRL);
> +			ctrl |= SDMMC_CTRL_RESET;
> +			mci_writel(host, CTRL, ctrl);
> +
> +			host->cmd_status &= ~SDMMC_INT_HLE;
> +
> +			goto resend;
> +		}
>  	}
> +
>  	dev_err(&slot->mmc->class_dev,
>  		"Timeout sending command (cmd %#x arg %#x status %#x)\n",
>  		cmd, arg, cmd_status);
> @@ -1429,6 +1447,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void 
> *dev_id)
>  		if (!pending)
>  			break;
>  
> +		if (pending & SDMMC_INT_HLE) {
> +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
> +			host->cmd_status = status;
> +			smp_wmb();
> +		}
> +
>  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>  			host->cmd_status = status;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


