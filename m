From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: dw_mmc: New sdio CMD53 starts with non-empty FIFO
Date: Tue, 08 May 2012 20:27:06 +0900
Message-ID: <000e01cd2d0d$806463e0$812d2ba0$%jun@samsung.com>
References: <CALzehA0GkpxLqfPLUr0+Y=JfWAzq4B-0oJ4Ap9gVo3-vSTp1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47523 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2EHL1J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 07:27:09 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M3P00KC8BT7M7E0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 08 May 2012 20:27:08 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M3P006NRBT78J20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 08 May 2012 20:27:07 +0900 (KST)
In-reply-to: <CALzehA0GkpxLqfPLUr0+Y=JfWAzq4B-0oJ4Ap9gVo3-vSTp1NA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dmitry Shmidt' <dimitrysh@android.com>, linux-mmc@vger.kernel.org
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Will Newton' <will.newton@imgtec.com>

Hi,

Dmitry Shmidt <dimitrysh@android.com> wrote:
> Hi,
> 
> I am working with dw_mmc controller. Kernel 3.4-rc3. Sdio wlan device
> in UHS_SDR50 mode.
> What I see that sometimes next sdio CMD53 starts before FIFO is empty
> and then controller goes insane and
> sdio request will be blocked forever.
> 
> And it looks like DW_MCI_QUIRK_IDMAC_DTO quirk is helping this problem
> to disappear.
> 
> My question is that this quirk actually adds SDMMC_INT_DATA_OVER to
> pending status and in this case
> reading from device it taking care of. Is it the only case? Writing
> can not be interrupted in same way?
> 
> For the test I adding the next code to dw_mmc.c
> (DW_MCI_QUIRK_IDMAC_DTO was not set):

I found that idmac interrupt(Transmit Interrupt) is sometimes later than DTO interrupt
in case of write. Current handling of idmac interrupt sets EVENT_DATA_COMPLETE as well as
EVENT_XFER_COMPLETE regardless DTO rising. This makes the current request be finished in tasklet 
and permits the next request even though data transfer is still in progress.
Setting EVENT_DATA_COMPLETE is not proper after IDMAC interrupt.
It should be taken after DTO interrupt is generated.

@@ -1625,7 +1625,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
        if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
                mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI);
                mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
-               set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
                host->dma_ops->complete(host);
        }
 #endif

> 
> @@ -687,11 +721,19 @@ static void __dw_mci_start_request(struct dw_mci *host,
>         struct mmc_request *mrq;
>         struct mmc_data *data;
>         u32 cmdflags;
> +#define FIFO_SIZE(x)   (((x) & 0x3FFE0000) >> 17)
> +       u32 temp;
> 
>         mrq = slot->mrq;
>         if (host->pdata->select_slot)
>                 host->pdata->select_slot(slot->id);
> 
> +       do {
> +               temp = mci_readl(host, STATUS);
> +               if (!(temp & BIT(2))) {
> +                       printk("%s: FIFO is not empty: 0x%x\n",
> __func__, FIFO_SIZE(temp));
> +               }
> +       } while (!(temp & BIT(2)));
> +
> 
> -----------------------------------------------------------------------------------------------
> [  215.785000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> req 98040Hz, actual 98039HZ div = 255)
> [  215.800000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
> req 50000000Hz, actual 50000000HZ div = 0)
> ...
> [  215.865000] __dw_mci_start_request: FIFO is not empty: 0xf
> <<<<<<<< !!!!!!!!!!!!!!!!
> ------------------------------------------------------------------------------------------------
> 
> My other question is why do we need to use pio transfer in this case
> if DMA controller will finish the job if we will give it a chance?
> 
> Thanks,
> 
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

