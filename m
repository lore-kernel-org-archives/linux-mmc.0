From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 3/4] mmc: dw-mmc: check whether card is busy or not,
 before disabling clock
Date: Wed, 28 Nov 2012 15:01:32 +0900
Message-ID: <001501cdcd2d$d124ba80$736e2f80$%jun@samsung.com>
References: <509B6ED4.703@samsung.com>
 <001601cdcc75$82685d10$87391730$%jun@samsung.com>
 <50B554FF.2050905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27696 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2K1GBe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 01:01:34 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME600F1SOOPS7K0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 15:01:33 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0ME600LJUOQKN140@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 28 Nov 2012 15:01:33 +0900 (KST)
In-reply-to: <50B554FF.2050905@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <James.Hogan@imgtec.com>

On Wednesday, November 28, 2012, Jaehoon Chung wrote:
> On 11/27/2012 05:02 PM, Seungwon Jeon wrote:
> > On Thursday, November 08, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> Before disabling clock, need to check whether card is busy on not.
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> ---
> >>  drivers/mmc/host/dw_mmc.c |   53 +++++++++++++++++++++++++++-----------------
> >>  drivers/mmc/host/dw_mmc.h |    1 +
> >>  2 files changed, 33 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index 0a80b5c..9704b09 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -228,6 +228,27 @@ static void dw_mci_set_timeout(struct dw_mci *host)
> >>  	mci_writel(host, TMOUT, 0xffffffff);
> >>  }
> >>
> >> +static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
> >> +{
> >> +	unsigned long timeout = jiffies + msecs_to_jiffies(500);
> >> +	unsigned int ctrl;
> >> +
> >> +	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
> >> +				SDMMC_CTRL_DMA_RESET));
> >> +
> >> +	/* wait till resets clear */
> >> +	do {
> >> +		ctrl = mci_readl(host, CTRL);
> >> +		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
> >> +			      SDMMC_CTRL_DMA_RESET)))
> >> +			return true;
> >> +	} while (time_before(jiffies, timeout));
> >> +
> >> +	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
> >> +
> >> +	return false;
> >> +}
> >> +
> >>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> >>  {
> >>  	struct mmc_data	*data;
> >> @@ -622,6 +643,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
> >>  	struct dw_mci *host = slot->host;
> >>  	u32 div;
> >>  	u32 clk_en_a;
> >> +	int timeout = 1000;
> >>
> >>  	if (slot->clock != host->current_speed) {
> >>  		div = host->bus_hz / slot->clock;
> >> @@ -638,6 +660,16 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
> >>  			 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ"
> >>  			 " div = %d)\n", slot->id, host->bus_hz, slot->clock,
> >>  			 div ? ((host->bus_hz / div) >> 1) : host->bus_hz, div);
> >> +		do {
> >> +			if (!(mci_readl(host, STATUS) & SDMMC_DATA_BUSY))
> >> +				break;
> >> +			if (timeout-- < 0) {
> >> +				dev_err(host->dev, "Can't disable clock"
> >> +					"because Card is busy!!\n");
> >> +				return;
> >> +			}
> >> +			mci_wait_reset(host->dev, host);
> > Should 'mci_wait_reset' be called every loop?
> > Only if card status is still busy at the end of while, one time is enough.
> >
> >> +		} while (1);
> > How about counting jiffies for while-loop with usleep_range?
> > do {
> > ...
> > 	usleep_range(10, 20)
> > } while (time_before())
> Is there reason that use "usleep_range()"?
If we should wait busy status with long time,
it would be better sleep-wait rather than just busy-wait.

Thanks,
Seungwon Jeon
> >
> > Thanks,
> > Seungwon Jeon
> >>
> >>  		/* disable clock */
> >>  		mci_writel(host, CLKENA, 0);
> >> @@ -1995,27 +2027,6 @@ no_dma:
> >>  	return;
> >>  }
> >>
> >> -static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
> >> -{
> >> -	unsigned long timeout = jiffies + msecs_to_jiffies(500);
> >> -	unsigned int ctrl;
> >> -
> >> -	mci_writel(host, CTRL, (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
> >> -				SDMMC_CTRL_DMA_RESET));
> >> -
> >> -	/* wait till resets clear */
> >> -	do {
> >> -		ctrl = mci_readl(host, CTRL);
> >> -		if (!(ctrl & (SDMMC_CTRL_RESET | SDMMC_CTRL_FIFO_RESET |
> >> -			      SDMMC_CTRL_DMA_RESET)))
> >> -			return true;
> >> -	} while (time_before(jiffies, timeout));
> >> -
> >> -	dev_err(dev, "Timeout resetting block (ctrl %#x)\n", ctrl);
> >> -
> >> -	return false;
> >> -}
> >> -
> >>  #ifdef CONFIG_OF
> >>  static struct dw_mci_of_quirks {
> >>  	char *quirk;
> >> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> >> index 53b8fd9..4f27357 100644
> >> --- a/drivers/mmc/host/dw_mmc.h
> >> +++ b/drivers/mmc/host/dw_mmc.h
> >> @@ -127,6 +127,7 @@
> >>  #define SDMMC_CMD_INDX(n)		((n) & 0x1F)
> >>  /* Status register defines */
> >>  #define SDMMC_GET_FCNT(x)		(((x)>>17) & 0x1FFF)
> >> +#define SDMMC_DATA_BUSY			BIT(9)
> >>  /* Internal DMAC interrupt defines */
> >>  #define SDMMC_IDMAC_INT_AI		BIT(9)
> >>  #define SDMMC_IDMAC_INT_NI		BIT(8)
> >> --
> >> 1.7.4.1
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

