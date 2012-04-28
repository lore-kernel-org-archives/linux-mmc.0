From: Dmitry Shmidt <dimitrysh@android.com>
Subject: dw_mmc: New sdio CMD53 starts with non-empty FIFO
Date: Fri, 27 Apr 2012 17:35:41 -0700
Message-ID: <CALzehA0GkpxLqfPLUr0+Y=JfWAzq4B-0oJ4Ap9gVo3-vSTp1NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56200 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757665Ab2D1Afn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Apr 2012 20:35:43 -0400
Received: by lbbgf7 with SMTP id gf7so895065lbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 Apr 2012 17:35:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Will Newton <will.newton@imgtec.com>

Hi,

I am working with dw_mmc controller. Kernel 3.4-rc3. Sdio wlan device
in UHS_SDR50 mode.
What I see that sometimes next sdio CMD53 starts before FIFO is empty
and then controller goes insane and
sdio request will be blocked forever.

And it looks like DW_MCI_QUIRK_IDMAC_DTO quirk is helping this problem
to disappear.

My question is that this quirk actually adds SDMMC_INT_DATA_OVER to
pending status and in this case
reading from device it taking care of. Is it the only case? Writing
can not be interrupted in same way?

For the test I adding the next code to dw_mmc.c
(DW_MCI_QUIRK_IDMAC_DTO was not set):

@@ -687,11 +721,19 @@ static void __dw_mci_start_request(struct dw_mci *host,
        struct mmc_request *mrq;
        struct mmc_data *data;
        u32 cmdflags;
+#define FIFO_SIZE(x)   (((x) & 0x3FFE0000) >> 17)
+       u32 temp;

        mrq = slot->mrq;
        if (host->pdata->select_slot)
                host->pdata->select_slot(slot->id);

+       do {
+               temp = mci_readl(host, STATUS);
+               if (!(temp & BIT(2))) {
+                       printk("%s: FIFO is not empty: 0x%x\n",
__func__, FIFO_SIZE(temp));
+               }
+       } while (!(temp & BIT(2)));
+

-----------------------------------------------------------------------------------------------
[  215.785000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 98040Hz, actual 98039HZ div = 255)
[  215.800000] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 50000000Hz, actual 50000000HZ div = 0)
...
[  215.865000] __dw_mci_start_request: FIFO is not empty: 0xf
<<<<<<<< !!!!!!!!!!!!!!!!
------------------------------------------------------------------------------------------------

My other question is why do we need to use pio transfer in this case
if DMA controller will finish the job if we will give it a chance?

Thanks,

Dmitry
