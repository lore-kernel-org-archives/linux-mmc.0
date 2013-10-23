From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] mmc: wmt-sdmmc: Fix setting BM_EIGHTBIT_MODE bit in wmt_mci_set_ios()
Date: Wed, 23 Oct 2013 14:48:01 +0800
Message-ID: <CAFRkauAeJ1BS-Sv5taXjwdBoypVt3D_nOx8LEkkeGCeURixgwg@mail.gmail.com>
References: <1382432062.4804.1.camel@phoenix>
	<526755C5.80704@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57442 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3JWGsC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 02:48:02 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so674605pad.28
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 23:48:01 -0700 (PDT)
In-Reply-To: <526755C5.80704@prisktech.co.nz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

2013/10/23 Tony Prisk <linux@prisktech.co.nz>:
> On 22/10/13 21:54, Axel Lin wrote:
>>
>> For MMC_BUS_WIDTH_8 case, current code missed setting BM_EIGHTBIT_MODE
>> bit.
>> Also has a small refactor to make the code looks better in readability.
>>
>> So the bit settings witch below logic:
>>
>> SDMMC_BUSMODE register:
>> Set EIGHTBIT_MODE bit for 8 bit mode, Set FOURBIT_MODE bit for 4 bit mode.
>> Clear both EIGHTBIT_MODE and FOURBIT_MODE bits for 1 bit mode.
>>
>> SDMMC_EXTCTRL register:
>> Set EXT_EIGHTBIT bit for 8 bit mode, Clear EXT_EIGHTBIT bit for 1/4 bit
>> mode.
>>
>> Add define for EXT_EIGHTBIT to avoid using magic number.
>> BM_ONEBIT_MASK is no longer used, thus remove it.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>> Hi Tony,
>> After checking wm8505+sdmmc+controller+suppliment.pdf, I'm wondering if
>> this
>> dirver works for MMC_BUS_WIDTH_8 case without setting BM_EIGHTBIT_MODE
>> bit.
>> I don't have this h/w to test.
>> I'd appreciate if you can review and test if this patch works.
>> Thanks,
>> Axel
>>   drivers/mmc/host/wmt-sdmmc.c | 31 +++++++++++++++----------------
>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> index 8a48a50..6ed18f8 100644
>> --- a/drivers/mmc/host/wmt-sdmmc.c
>> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> @@ -72,7 +72,6 @@
>>   #define BM_SPI_CS                     0x20
>>   #define BM_SD_POWER                   0x40
>>   #define BM_SOFT_RESET                 0x80
>> -#define BM_ONEBIT_MASK                 0xFD
>>     /* SDMMC_BLKLEN bit fields */
>>   #define BLKL_CRCERR_ABORT             0x0800
>> @@ -120,6 +119,8 @@
>>   #define STS2_DATARSP_BUSY             0x20
>>   #define STS2_DIS_FORCECLK             0x80
>>   +/* SDMMC_EXTCTRL bit fields */
>> +#define EXT_EIGHTBIT                   0x04
>>     /* MMC/SD DMA Controller Registers */
>>   #define SDDMA_GCR                     0x100
>> @@ -672,7 +673,7 @@ static void wmt_mci_request(struct mmc_host *mmc,
>> struct mmc_request *req)
>>   static void wmt_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>   {
>>         struct wmt_mci_priv *priv;
>> -       u32 reg_tmp;
>> +       u32 busmode, extctrl;
>>         priv = mmc_priv(mmc);
>>   @@ -687,28 +688,26 @@ static void wmt_mci_set_ios(struct mmc_host *mmc,
>> struct mmc_ios *ios)
>>         if (ios->clock != 0)
>>                 clk_set_rate(priv->clk_sdmmc, ios->clock);
>>   +     busmode = readb(priv->sdmmc_base + SDMMC_BUSMODE);
>> +       extctrl = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
>> +
>> +       busmode &= ~(BM_EIGHTBIT_MODE | BM_FOURBIT_MODE);
>> +       extctrl &= ~EXT_EIGHTBIT;
>> +
>>         switch (ios->bus_width) {
>>         case MMC_BUS_WIDTH_8:
>> -               reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
>> -               writeb(reg_tmp | 0x04, priv->sdmmc_base + SDMMC_EXTCTRL);
>> +               busmode |= BM_EIGHTBIT_MODE;
>> +               extctrl |= EXT_EIGHTBIT;
>>                 break;
>>         case MMC_BUS_WIDTH_4:
>> -               reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
>> -               writeb(reg_tmp | BM_FOURBIT_MODE, priv->sdmmc_base +
>> -                      SDMMC_BUSMODE);
>> -
>> -               reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
>> -               writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
>> +               busmode |= BM_FOURBIT_MODE;
>>                 break;
>>         case MMC_BUS_WIDTH_1:
>> -               reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
>> -               writeb(reg_tmp & BM_ONEBIT_MASK, priv->sdmmc_base +
>> -                      SDMMC_BUSMODE);
>> -
>> -               reg_tmp = readb(priv->sdmmc_base + SDMMC_EXTCTRL);
>> -               writeb(reg_tmp & 0xFB, priv->sdmmc_base + SDMMC_EXTCTRL);
>>                 break;
>>         }
>> +
>> +       writeb(busmode, priv->sdmmc_base + SDMMC_BUSMODE);
>> +       writeb(extctrl, priv->sdmmc_base + SDMMC_EXTCTRL);
>>   }
>>     static int wmt_mci_get_ro(struct mmc_host *mmc)
>
> I don't have any means of testing this - All the vendor hardware I have uses
> 4-bit mode.
Oh, well.
But how do you think about this patch?
Since the code is there, and it looks wrong because
wm8505+sdmmc+controller+suppliment.pdf says

SDMMC Ext Control (Offset 0x0034)
BIT2 RW
        0: One Bit / Four bit mode
        1: Eight bit mode

Probably still good to make the code matches the document.

Regards,
Axel
