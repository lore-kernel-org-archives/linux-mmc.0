From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 1/2] mmc: dw_mmc: silent verbose log when calling from
 PM context
Date: Mon, 16 Jan 2017 10:43:21 +0800
Message-ID: <28587a11-fd3e-31da-bc50-d63252cf3a78@rock-chips.com>
References: <1484276362-44984-1-git-send-email-shawn.lin@rock-chips.com>
 <e300d9fe-d410-815d-8615-0d319fcabc5d@soulik.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:45257 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdAPCoN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 21:44:13 -0500
In-Reply-To: <e300d9fe-d410-815d-8615-0d319fcabc5d@soulik.info>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ayaka <ayaka@soulik.info>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, sgilles@math.umd.edu, linux-rockchip@lists.infradead.org

On 2017/1/15 11:50, ayaka wrote:
>
>
> On 01/13/2017 10:59 AM, Shawn Lin wrote:
>> When deploying runtime PM, it's quite verbose to print the
>> log of ios setting. Also it's useless to print it from system
>> PM as it should be the same with booting time. We also have
>> sysfs to get all these information from ios attribute, so let's
>> skip this print from PM context.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/mmc/host/dw_mmc.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3d213e7..dc58ec3 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1153,7 +1153,8 @@ static void mci_send_cmd(struct dw_mci_slot
>> *slot, u32 cmd, u32 arg)
>>           cmd, arg, cmd_status);
>>   }
>>   -static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool
>> force_clkinit)
>> +static void dw_mci_setup_bus(struct dw_mci_slot *slot,
>> +                 bool force_clkinit, bool pm_context)
>>   {
>>       struct dw_mci *host = slot->host;
>>       unsigned int clock = slot->clock;
>> @@ -1182,11 +1183,13 @@ static void dw_mci_setup_bus(struct
>> dw_mci_slot *slot, bool force_clkinit)
>>           if ((clock != slot->__clk_old &&
>>               !test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
>>               force_clkinit) {
>> -            dev_info(&slot->mmc->class_dev,
>> -                 "Bus speed (slot %d) = %dHz (slot req %dHz, actual
>> %dHZ div = %d)\n",
>> -                 slot->id, host->bus_hz, clock,
>> -                 div ? ((host->bus_hz / div) >> 1) :
>> -                 host->bus_hz, div);
>> +            /* Silent the verbose log if calling from PM context */
>> +            if (!pm_context)
>> +                dev_info(&slot->mmc->class_dev,
>> +                     "Bus speed (slot %d) = %dHz (slot req %dHz,
>> actual %dHZ div = %d)\n",
>> +                     slot->id, host->bus_hz, clock,
>> +                     div ? ((host->bus_hz / div) >> 1) :
>> +                     host->bus_hz, div);
>>                 /*
>>                * If card is polling, display the message only
>> @@ -1434,12 +1437,12 @@ static void dw_mci_set_ios(struct mmc_host
>> *mmc, struct mmc_ios *ios)
>>           }
>>             /* Adjust clock / bus width after power is up */
>> -        dw_mci_setup_bus(slot, false);
>> +        dw_mci_setup_bus(slot, false, false);
>>             break;
>>       case MMC_POWER_OFF:
>>           /* Turn clock off before power goes down */
>> -        dw_mci_setup_bus(slot, false);
>> +        dw_mci_setup_bus(slot, false, false);
>>             if (!IS_ERR(mmc->supply.vmmc))
>>               mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> @@ -3366,7 +3369,7 @@ int dw_mci_runtime_resume(struct device *dev)
>>               continue;
>>           if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
>>               dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
>> -            dw_mci_setup_bus(slot, true);
>> +            dw_mci_setup_bus(slot, true, true);
> Sadness, it seems not work for firefly reload, maybe there is some
> problems with the card detect in that board.

This patch is intended to prevent the spamming log from pm context but
your firefly-reload board should have a another problem. So IIRC you
still see the spamming log with polling mode, we need to dig that later
but we need this two patches(at least 2/2) merged into 4.10-rc cycle to
fix the boot problem.





>>           }
>>       }
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

