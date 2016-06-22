From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/3] mmc: dw_mmc: add the card write threshold for HS400
 mode
Date: Wed, 22 Jun 2016 13:16:05 +0900
Message-ID: <576A1105.8070901@samsung.com>
References: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
 <1466487339-13211-2-git-send-email-jh80.chung@samsung.com>
 <CGME20160621080553epcas1p33e7295dfd0217bb3bdf7894ce6f23531@epcas1p3.samsung.com>
 <dabbd1ce-5783-c4ac-5782-553b2c5acc87@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41766 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcFVEQS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 00:16:18 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9500OO8NUT7WB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Jun 2016 13:16:05 +0900 (KST)
In-reply-to: <dabbd1ce-5783-c4ac-5782-553b2c5acc87@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 06/21/2016 05:05 PM, Shawn Lin wrote:
> On 2016/6/21 13:35, Jaehoon Chung wrote:
>> Since v2.80a, dwmmc controller introduced the card write threshold for
>> HS400 mode. So CardThrCtl can be supported during write operation, not
>> only read operation.
>> (Note: Only use the write threshold when mode is HS400.)
>>
>> To use more compatible, removed "_rd_" from function name.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>>     - Add the DW_MMC_280A for checking IP-version.
>>     - Applied the Shawn's suggestion.
>>
>>  drivers/mmc/host/dw_mmc.c | 34 +++++++++++++++++++++++-----------
>>  drivers/mmc/host/dw_mmc.h |  6 +++++-
>>  2 files changed, 28 insertions(+), 12 deletions(-)
>>
> 
> Looks good to me,
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied this patch on my repository.

Best Regards,
Jaehoon Chung

> 
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 5cf143b..ec3f0a8 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -899,23 +899,35 @@ done:
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
>> +    u8 enable;
>>
>>      /*
>>       * CDTHRCTL doesn't exist prior to 240A (in fact that register offset is
>>       * in the FIFO region, so we really shouldn't access it).
>>       */
>> -    if (host->verid < DW_MMC_240A)
>> +    if (host->verid < DW_MMC_240A ||
>> +        (host->verid < DW_MMC_280A && data->flags & MMC_DATA_WRITE))
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
>> @@ -931,11 +943,11 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
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
>> @@ -1006,12 +1018,12 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
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
>> index 1e8d838..a186d4b 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -15,6 +15,7 @@
>>  #define _DW_MMC_H_
>>
>>  #define DW_MMC_240A        0x240a
>> +#define DW_MMC_280A        0x280a
>>
>>  #define SDMMC_CTRL        0x000
>>  #define SDMMC_PWREN        0x004
>> @@ -175,7 +176,10 @@
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

