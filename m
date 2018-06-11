From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
Date: Mon, 11 Jun 2018 22:17:58 +0800
Message-ID: <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
 <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>, Doug Anderson <dianders@chromium.org>, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Qing Xia <xiaqing17@hisilicon.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2018/6/11 20:20, Ulf Hansson wrote:
> + Shawn Lin, Evgeniy Didin, Doug Andersson
> 
> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>> From: x00270170 <xiaqing17@hisilicon.com>
>>
>> Card write threshold control is supposed to be set since controller
>> version 2.80a for data write in HS400 mode and data read in
>> HS200/HS400/SDR104 mode. However the current code returns without
>> configuring it in the case of data writing in HS400 mode.
>> Meanwhile the patch fixes that the current code goes to
>> 'disable' when doing data reading in HS400 mode.
>>

I'm more or less unable to review this, as I don't have 2.80a databook,
nor a such platform to verify it. :(

>> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
> 
> This looks good to me. However, it seems like Jaehoon has been busy,
> no response yet.
> 
> I have looped in a few more people to see if they thinks this makes sense.
> 
> Kind regards
> Uffe
> 
>> ---
>>   drivers/mmc/host/dw_mmc.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 29a1afa..3ee8f57 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>>           * It's used when HS400 mode is enabled.
>>           */
>>          if (data->flags & MMC_DATA_WRITE &&
>> -               !(host->timing != MMC_TIMING_MMC_HS400))
>> -               return;
>> +               host->timing != MMC_TIMING_MMC_HS400)
>> +               goto disable;
>>
>>          if (data->flags & MMC_DATA_WRITE)
>>                  enable = SDMMC_CARD_WR_THR_EN;
>> @@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
>>                  enable = SDMMC_CARD_RD_THR_EN;
>>
>>          if (host->timing != MMC_TIMING_MMC_HS200 &&
>> -           host->timing != MMC_TIMING_UHS_SDR104)
>> +           host->timing != MMC_TIMING_UHS_SDR104 &&
>> +           host->timing != MMC_TIMING_MMC_HS400)
>>                  goto disable;
>>
>>          blksz_depth = blksz / (1 << host->data_shift);
>> --
>> 2.8.1
>>
> 
> 
> 


-- 
Best Regards
Shawn Lin
