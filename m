From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add the card write threshold for HS400
 mode
Date: Mon, 20 Jun 2016 17:25:26 +0900
Message-ID: <5767A876.8080606@samsung.com>
References: <1466396749-29456-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160620082120epcas1p19e756b030f4b7583bf20b2b5b8c60ad5@epcas1p1.samsung.com>
 <1bedbc35-dd60-b554-356c-9ef42edb64a3@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50283 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbcFTJkd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 05:40:33 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9200KERA2E3S80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 20 Jun 2016 17:25:26 +0900 (KST)
In-reply-to: <1bedbc35-dd60-b554-356c-9ef42edb64a3@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi Shawn,

On 06/20/2016 05:21 PM, Shawn Lin wrote:
> On 2016/6/20 12:25, Jaehoon Chung wrote:
>> Since v2.80a, dwmmc controller introduced the card write threshold for
>> HS400 mode. So CardThrCtl can be supported during write operation, not
>> only read operation.
>> (Note: Only use the write threshold when mode is HS400.)
>>
>> To use more compatible, removed "_rd_" from function name.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 31 +++++++++++++++++++++----------
>>  drivers/mmc/host/dw_mmc.h |  5 ++++-
>>  2 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 5cf143b..6efda0b 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -899,13 +899,12 @@ done:
>>      mci_writel(host, FIFOTH, fifoth_val);
>>  }
>>
>> -static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>> +static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>>  {
>>      unsigned int blksz = data->blksz;
>>      u32 blksz_depth, fifo_depth;
>>      u16 thld_size;
>> -
>> -    WARN_ON(!(data->flags & MMC_DATA_READ));
> 
> before v2.80a, we still only allow it for READ, so
> shouldn't we need to check both the host->verid and
> data->flags rather than drop it directly?

Yes, i will define the verid for 280A. 
When i have checked the version 2.80a, it added the some features and bits for some registers.
If you have the v2.80a, you can check these features with me.

Anyway, your opinion is good. I will update.
Thanks!

Best Regards,
Jaehoon Chung

> 
>> +    u8 enable;
>>
>>      /*
>>       * CDTHRCTL doesn't exist prior to 240A (in fact that register offset is
>> @@ -914,8 +913,20 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>>      if (host->verid < DW_MMC_240A)
>>          return;
>>
>> +    /*
>> +     * Card write Threshold is introduced since 2.80a
>> +     * It's used when HS400 mode is enabled.
>> +     */
>> +    if (data->flags & MMC_DATA_WRITE &&
>> +        !(host->timing != MMC_TIMING_MMC_HS400))
>> +        return;
>> +
>> +    if (data->flags & MMC_DATA_WRITE)
>> +        enable = SDMMC_CARD_WR_THR_EN;
>> +    else
>> +        enable = SDMMC_CARD_RD_THR_EN;
>> +
>>      if (host->timing != MMC_TIMING_MMC_HS200 &&
>> -        host->timing != MMC_TIMING_MMC_HS400 &&
>>          host->timing != MMC_TIMING_UHS_SDR104)
>>          goto disable;
>>
>> @@ -931,11 +942,11 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
>>       * Currently just choose blksz.
>>       */
>>      thld_size = blksz;
>> -    mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(thld_size, 1));
>> +    mci_writel(host, CDTHRCTL, SDMMC_SET_THLD(thld_size, enable));
>>      return;
>>
>>  disable:
>> -    mci_writel(host, CDTHRCTL, SDMMC_SET_RD_THLD(0, 0));
>> +    mci_writel(host, CDTHRCTL, 0);
>>  }
>>
>>  static int dw_mci_submit_data_dma(struct dw_mci *host, struct mmc_data *data)
>> @@ -1006,12 +1017,12 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
>>      host->sg = NULL;
>>      host->data = data;
>>
>> -    if (data->flags & MMC_DATA_READ) {
>> +    if (data->flags & MMC_DATA_READ)
>>          host->dir_status = DW_MCI_RECV_STATUS;
>> -        dw_mci_ctrl_rd_thld(host, data);
>> -    } else {
>> +    else
>>          host->dir_status = DW_MCI_SEND_STATUS;
>> -    }
>> +
>> +    dw_mci_ctrl_thld(host, data);
>>
>>      if (dw_mci_submit_data_dma(host, data)) {
>>          if (host->data->flags & MMC_DATA_READ)
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 1e8d838..2bf7464 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -175,7 +175,10 @@
>>  /* Version ID register define */
>>  #define SDMMC_GET_VERID(x)        ((x) & 0xFFFF)
>>  /* Card read threshold */
>> -#define SDMMC_SET_RD_THLD(v, x)        (((v) & 0xFFF) << 16 | (x))
>> +#define SDMMC_SET_THLD(v, x)        (((v) & 0xFFF) << 16 | (x))
>> +#define SDMMC_CARD_WR_THR_EN        BIT(2)
>> +#define SDMMC_CARD_RD_THR_EN        BIT(0)
>> +/* UHS-1 register defines */
>>  #define SDMMC_UHS_18V            BIT(0)
>>  /* All ctrl reset bits */
>>  #define SDMMC_CTRL_ALL_RESET_FLAGS \
>>
> 
> 

