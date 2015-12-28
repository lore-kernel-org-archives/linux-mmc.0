From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove the unused quirks
Date: Tue, 29 Dec 2015 07:40:34 +0900
Message-ID: <5681BA62.2030706@samsung.com>
References: <1450950063-5359-1-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFoPLtLfG0uOYMRXxNmAvW6310wvXpCHkr0_4rZ1J7zS2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37505 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbbL1Wkk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 17:40:40 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O0301CS9AZQAD80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 29 Dec 2015 07:40:38 +0900 (KST)
In-reply-to: <CAPDyKFoPLtLfG0uOYMRXxNmAvW6310wvXpCHkr0_4rZ1J7zS2w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 12/28/2015 10:30 PM, Ulf Hansson wrote:
> On 24 December 2015 at 10:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Removed the unused quirks. These quirks don't used anywhere.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> As I don't expect any additional PR for dw_mmc for 4.5, I decided to
> pick this one up myself.
> 
> Thanks, applied for next!

Thanks!

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/dw_mmc.c  | 19 -------------------
>>  include/linux/mmc/dw_mmc.h | 10 ++--------
>>  2 files changed, 2 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index fb204ee..7128351 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1634,12 +1634,6 @@ static int dw_mci_command_complete(struct dw_mci *host, struct mmc_command *cmd)
>>         else
>>                 cmd->error = 0;
>>
>> -       if (cmd->error) {
>> -               /* newer ip versions need a delay between retries */
>> -               if (host->quirks & DW_MCI_QUIRK_RETRY_DELAY)
>> -                       mdelay(20);
>> -       }
>> -
>>         return cmd->error;
>>  }
>>
>> @@ -2355,16 +2349,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>
>>         pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>>
>> -       /*
>> -        * DTO fix - version 2.10a and below, and only if internal DMA
>> -        * is configured.
>> -        */
>> -       if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO) {
>> -               if (!pending &&
>> -                   ((mci_readl(host, STATUS) >> 17) & 0x1fff))
>> -                       pending |= SDMMC_INT_DATA_OVER;
>> -       }
>> -
>>         if (pending) {
>>                 /* Check volt switch first, since it can look like an error */
>>                 if ((host->state == STATE_SENDING_CMD11) &&
>> @@ -3165,9 +3149,6 @@ int dw_mci_probe(struct dw_mci *host)
>>         /* Now that slots are all setup, we can enable card detect */
>>         dw_mci_enable_cd(host);
>>
>> -       if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>> -               dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>> -
>>         return 0;
>>
>>  err_dmaunmap:
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 7776afb..89df7ab 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -235,16 +235,10 @@ struct dw_mci_dma_ops {
>>  };
>>
>>  /* IP Quirks/flags. */
>> -/* DTO fix for command transmission with IDMAC configured */
>> -#define DW_MCI_QUIRK_IDMAC_DTO                 BIT(0)
>> -/* delay needed between retries on some 2.11a implementations */
>> -#define DW_MCI_QUIRK_RETRY_DELAY               BIT(1)
>> -/* High Speed Capable - Supports HS cards (up to 50MHz) */
>> -#define DW_MCI_QUIRK_HIGHSPEED                 BIT(2)
>>  /* Unreliable card detection */
>> -#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION     BIT(3)
>> +#define DW_MCI_QUIRK_BROKEN_CARD_DETECTION     BIT(0)
>>  /* Timer for broken data transfer over scheme */
>> -#define DW_MCI_QUIRK_BROKEN_DTO                        BIT(4)
>> +#define DW_MCI_QUIRK_BROKEN_DTO                        BIT(1)
>>
>>  struct dma_pdata;
>>
>> --
>> 1.9.1
>>
> 
> 

