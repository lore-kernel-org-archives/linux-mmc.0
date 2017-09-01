From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [EXT] [RFT v2 PATCH] mmc: sd: try to enable UHS mode w/o power
 cycle from S3
Date: Fri, 1 Sep 2017 15:57:17 -0700
Message-ID: <59A9E5CD.3000703@marvell.com>
References: <1503978827-202915-1-git-send-email-shawn.lin@rock-chips.com>
 <CAAXpJNvfSWHrJiLHoxmm+ENUDsGayQROnRTL=SoHr-7dX7R9+Q@mail.gmail.com>
 <59A5E6F2.5000407@marvell.com>
 <745b195b-bdd1-e675-a36a-ca22eb41feaa@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34344 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752563AbdIAW5X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Sep 2017 18:57:23 -0400
In-Reply-To: <745b195b-bdd1-e675-a36a-ca22eb41feaa@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Shawn,

On 08/29/2017 05:14 PM, Shawn Lin wrote:
> On 2017/8/30 6:13, Zhoujie Wu wrote:
>> Hi Shawn,
>> thanks for your patch.
>>
>> On 08/29/2017 02:56 PM, zhoujie wu wrote:
>>>
>>>
>>> CMD0 couldn't put the card back to 3.3v if can't do power
>>> cycle for cards. The card is already in SDR12 then, so still
>>> try to enable UHS mode.
>>>
>>> Pleas note that, if the platform use a hardware fixed
>>> sd power, you should still include a regulator-fixed
>>> regulator with always-on property there. So mmc core
>>> could handle this as well. Otherwise you shouldn't
>>> expect UHS to work for that case.
>>>
>>> Just compile only, please have a look and test.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> ---
>>>
>>>   drivers/mmc/core/card.h            | 17 +++++++++++++++++
>>>   drivers/mmc/core/core.c            |  8 ++++++++
>>>   drivers/mmc/core/sd.c              | 28 ++++++++++++++++++++++++++--
>>>   drivers/mmc/core/sd.h              |  3 ++-
>>>   drivers/mmc/core/sdio.c            |  2 +-
>>>   drivers/regulator/core.c           | 14 ++++++++++++++
>>>   include/linux/mmc/host.h           |  1 +
>>>   include/linux/regulator/consumer.h |  6 ++++++
>>>   8 files changed, 75 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>>> index f06cd91..a562110 100644
>>> --- a/drivers/mmc/core/card.h
>>> +++ b/drivers/mmc/core/card.h
>>> @@ -218,4 +218,21 @@ static inline int mmc_card_broken_hpi(const struct
>>> mmc_card *c)
>>>          return c->quirks & MMC_QUIRK_BROKEN_HPI;
>>>   }
>>>
>>> +static inline bool mmc_card_support_uhs(struct mmc_card *card)
>>> +{
>>> +       if (WARN_ON(!card))
>>> +               return false;
>>> +
>>> +       switch (card->sd_bus_speed) {
>>> +       case UHS_SDR104_BUS_SPEED:
>>> +       case UHS_DDR50_BUS_SPEED:
>>> +       case UHS_SDR50_BUS_SPEED:
>>> +       case UHS_SDR25_BUS_SPEED:
>>> +       case UHS_SDR12_BUS_SPEED:
>>> +               return true;
>>> +       default:
>>> +               return false;
>>> +       }
>>> +}
>>> +
>>>   #endif
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 2643126..6b5c6c5 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1424,6 +1424,14 @@ int mmc_regulator_get_supply(struct mmc_host 
>>> *mmc)
>>>   }
>>>   EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
>>>
>>> +bool mmc_regulator_can_power_off(struct regulator *supply)
>>> +{
>>> +       if (!IS_ERR(supply))
>>> +               return regulator_is_always_on(supply);
>>> +       return false;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mmc_regulator_can_power_off);
>>> +
>>>   /*
>>>    * Mask off any voltages we don't support and select
>>>    * the lowest voltage
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index a1b0aa1..7bec61b 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -721,7 +721,8 @@ struct device_type sd_type = {
>>>   /*
>>>    * Fetch CID from card.
>>>    */
>>> -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 
>>> *rocr)
>>> +int mmc_sd_get_cid(struct mmc_host *host, struct mmc_card *card,
>>> +                                  u32 ocr, u32 *cid, u32 *rocr)
>>>   {
>>>          int err;
>>>          u32 max_current;
>>> @@ -773,6 +774,27 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 
>>> ocr, u32
>>> *cid, u32 *rocr)
>>>                  return err;
>>>
>>>          /*
>>> +        * Per SD physical specification version 4.10, section
>>> +        * 3.9.4 UHS-I Bus Speed Mode Selection Sequence, once
>>> +        * the signal voltage is switched to 1V8, the card continues
>>> +        * 1.8V signaling regardless of CMD0. Power cycle resets the
>>> +        * signal voltage to 3.3V. As a fact that some vmmc is always
>>> +        * on so the card would still work with SDR12 after CMD0. So
>>> +        * let's attempt to enable enable UHS mode if vmmc can't be
>>> +        * powered off.
>>> +        */
>>> +       if (card && mmc_card_support_uhs(card) && mmc_host_uhs(host) &&
>>> +           !mmc_regulator_can_power_off(host->supply.vmmc) &&
>>> +           (ocr & SD_OCR_S18R)) {
>>> +                       *rocr |= SD_ROCR_S18A;
>>> +                       if (mmc_set_signal_voltage(host,
>>> MMC_SIGNAL_VOLTAGE_180)) {
>>> +                               retries = 0;
>>> +                               goto try_again;
>>> +                       }
>>> +
>>> +                       goto done;
>>> +       }
>> Good to have a higher level solution if the issue is common.
>> I did basic test with your patch(added your regulator modification 
>> you sent to me) and add vmmc-supply in board dts, I saw warning when 
>> boot up.
>> I think in below case, the card is not added yet, the card is null 
>> and print out the warning. I don't quite understand 
>> mmc_card_support_uhs, it return true for all card speed.
>>
>> [    4.310003] WARNING: CPU: 1 PID: 48 at drivers/mmc/core/card.h:224 
>> mmc_sd_get_cid+0x270/0x298
>
> it's just for debug, and won't be a big deal.
>
> And I find mmc_host_uhs here is redundant as oldcard's
> card->sd_bus_speed is already the result of checking uhs cap for both of
> controller and card. So mmc_card_support_uhs return true means both
> of your controller and the cards support UHS mode, didn't they?
>
>>
>> .....
>>
>> [    4.549657] [<ffffff8008757e24>] mmc_sd_get_cid+0x270/0x298
>>
>> [    4.555510] [<ffffff800875847c>] mmc_sd_init_card+0x44/0x614
>>
>> [    4.561456] [<ffffff8008758bd4>] mmc_attach_sd+0x7c/0x134
>>
>> [    4.566951] [<ffffff8008751fb8>] mmc_rescan+0x2e4/0x35c
>>
>> [    4.572451] [<ffffff80080d58d8>] process_one_work+0x12c/0x28c
>>
>> [    4.578304] [<ffffff80080d5a90>] worker_thread+0x58/0x3b8
>>
>> [    4.583801] [<ffffff80080db394>] kthread+0x100/0x12c
>>
>> [    4.589029] [<ffffff8008082ec0>] ret_from_fork+0x10/0x50
>>
>> [    4.594793] ---[ end trace 58af756d1037eb51 ]---
>>
>> I did some modifications and let code enter the if condition any way, 
>> I added some log and you can see, rocr is updated, but when it tried 
>> to switch to 1.8V signal, it failed. I don't know why yet.
>
> Ok, sounds the key point is to see why it fails to switch to 1.8v signal
>
>> So the code will try again, and use high speed to init card again.
>
> Thanks for testing this, but I haven' had enough time to put my hand
> on it. But I will be back and check it out by myself.. Anyway you may
> still be able to do more debugging if this approach looks good to you:)

I have checked why 1.8V signal switch failed here, as SD spec mentioned 
it needs to gate the clock for a while when switching the voltage, I 
added some logic to gate the clock before switch signal,
then re-enable the clock after that, just like what set_uhs_voltage does 
and it could work now.
and I adjust the if condition logic as below, hacked 
mmc_card_support_uhs now always return true.
This can be a fix, but to be a generic solution,  I am wondering from sd 
card perspective, except for no power cycle, if there is any other 
reason that may cause SD_OCR_S18A not set for uhs card?

+       if (mmc_card_support_uhs(card)
+           !mmc_regulator_can_power_off(host->supply.vmmc) &&
+           !(*rocr & SD_OCR_S18A))
>
>>
>> [    4.259194] before rocr = c0ff8000, ocr = 41200000
>>
>> [    4.359909] after rocr = c1ff8000  -- if condition meets, updated 
>> rocr
>>
>> [    4.364230] mmc0: 1.8V regulator output did not became stable  -- 
>> mmc_set_signal_voltage 1.8V failed.
>> [    4.372603] mmc0: Skipping voltage switch
>>
>> [    4.403225] before rocr = c0ff8000, ocr = 40200000   -- tried 
>> again with no SD_OCR_S18R .
>>> +       /*
>>>           * In case CCS and S18A in the response is set, start 
>>> Signal Voltage
>>>           * Switch procedure. SPI mode doesn't support CMD11.
>>>           */
>>> @@ -788,6 +810,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 
>>> ocr, u32
>>> *cid, u32 *rocr)
>>>                  }
>>>          }
>>>
>>> +done:
>>>          err = mmc_send_cid(host, cid);
>>>          return err;
>>>   }
>>> @@ -924,7 +947,7 @@ static int mmc_sd_init_card(struct mmc_host 
>>> *host, u32
>>> ocr,
>>>
>>>          WARN_ON(!host->claimed);
>>>
>>> -       err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>>> +       err = mmc_sd_get_cid(host, oldcard, ocr, cid, &rocr);
>>>          if (err)
>>>                  return err;
>>>
>>> @@ -995,6 +1018,7 @@ static int mmc_sd_init_card(struct mmc_host 
>>> *host, u32
>>> ocr,
>>>                  if (err)
>>>                          goto free_card;
>>>          } else {
>>> +
>>>                  /*
>>>                   * Attempt to change to high-speed (if supported)
>>>                   */
>>> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
>>> index 1ada980..9cd2482 100644
>>> --- a/drivers/mmc/core/sd.h
>>> +++ b/drivers/mmc/core/sd.h
>>> @@ -8,7 +8,8 @@
>>>   struct mmc_host;
>>>   struct mmc_card;
>>>
>>> -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 
>>> *rocr);
>>> +int mmc_sd_get_cid(struct mmc_host *host, struct mmc_card *card,
>>> +                  u32 ocr, u32 *cid, u32 *rocr);
>>>   int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
>>>   void mmc_decode_cid(struct mmc_card *card);
>>>   int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>>> index cc43687..08e82fe 100644
>>> --- a/drivers/mmc/core/sdio.c
>>> +++ b/drivers/mmc/core/sdio.c
>>> @@ -608,7 +608,7 @@ static int mmc_sdio_init_card(struct mmc_host 
>>> *host,
>>> u32 ocr,
>>>          }
>>>
>>>          if ((rocr & R4_MEMORY_PRESENT) &&
>>> -           mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 
>>> 0) {
>>> +           mmc_sd_get_cid(host, NULL, ocr & rocr, card->raw_cid, 
>>> NULL) ==
>>> 0) {
>>>                  card->type = MMC_TYPE_SD_COMBO;
>>>
>>>                  if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
>>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>>> index e567fa5..edea93b0 100644
>>> --- a/drivers/regulator/core.c
>>> +++ b/drivers/regulator/core.c
>>> @@ -2522,6 +2522,20 @@ int regulator_is_enabled(struct regulator 
>>> *regulator)
>>>   EXPORT_SYMBOL_GPL(regulator_is_enabled);
>>>
>>>   /**
>>> + * regulator_is_always_on - is the regulator output always enabled
>>> + * @regulator: regulator source
>>> + *
>>> + * Returns positive if the regulator driver backing the source/client
>>> + * has requested that the device be always on, zero if it isn't.
>>> + *
>>> + */
>>> +inline int regulator_is_always_on(struct regulator *regulator)
>>> +{
>>> +       return (regulator->always_on) ? 1 : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(regulator_is_always_on);
>>> +
>>> +/**
>>>    * regulator_count_voltages - count regulator_list_voltage() 
>>> selectors
>>>    * @regulator: regulator source
>>>    *
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index ebd1ceb..2f1206b 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -462,6 +462,7 @@ static inline int mmc_regulator_set_vqmmc(struct
>>> mmc_host *mmc,
>>>
>>>   u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>>>   int mmc_regulator_get_supply(struct mmc_host *mmc);
>>> +bool mmc_regulator_can_power_off(struct regulator *supply);
>>>
>>>   static inline int mmc_card_is_removable(struct mmc_host *host)
>>>   {
>>> diff --git a/include/linux/regulator/consumer.h 
>>> b/include/linux/regulator/
>>> consumer.h
>>> index df176d7..46126e3 100644
>>> --- a/include/linux/regulator/consumer.h
>>> +++ b/include/linux/regulator/consumer.h
>>> @@ -226,6 +226,7 @@ void 
>>> devm_regulator_bulk_unregister_supply_alias(struct
>>> device *dev,
>>>   int regulator_disable(struct regulator *regulator);
>>>   int regulator_force_disable(struct regulator *regulator);
>>>   int regulator_is_enabled(struct regulator *regulator);
>>> +int regulator_is_always_on(struct regulator *regulator);
>>>   int regulator_disable_deferred(struct regulator *regulator, int ms);
>>>
>>>   int __must_check regulator_bulk_get(struct device *dev, int 
>>> num_consumers,
>>> @@ -418,6 +419,11 @@ static inline int regulator_is_enabled(struct
>>> regulator *regulator)
>>>          return 1;
>>>   }
>>>
>>> +static inline int regulator_is_always_on(struct regulator *regulator)
>>> +{
>>> +       return 0;
>>> +}
>>> +
>>>   static inline int regulator_bulk_get(struct device *dev,
>>>                                       int num_consumers,
>>>                                       struct regulator_bulk_data 
>>> *consumers)
>>> -- 
>>> 1.9.1
>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>>
>>
>>
>

