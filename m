From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2] mmc: core: eMMC4.5 Add the timeout for switch
Date: Thu, 01 Sep 2011 16:53:28 +0900
Message-ID: <4E5F39F8.5040107@samsung.com>
References: <1314854861-2430-1-git-send-email-girish.shivananjappa@linaro.org>
 <001901cc686f$4be243c0$e3a6cb40$%jun@samsung.com>
 <CAGxe1ZE--PoWiLmJstoyxJ+SpLdH9KzY3zPtC=PDEjdsg6Ot6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGxe1ZE--PoWiLmJstoyxJ+SpLdH9KzY3zPtC=PDEjdsg6Ot6g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish.

I agreed for Mr.Jeon's opinion.
I think that need not to check for any exception case.
(Mr.Jeon mentioned the below comment, just using default cmd6_timeout)

Thanks,
Jaehoon Chung

Girish K S wrote:

> Hello Mr Jeon,
>                       In case if the timeout is specified by the
> calling function, the code in this patch will not be executed. But if
> some command other than the three are called with 0, then this code
> will make sure that atleast the default value is used to timeout.
> 
> regards
> Girish K S
> 
> On 1 September 2011 11:50, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> Hi Girish,
>>
>> Girish K S wrote:
>>> V2- The datatype of the cmd6_timeout is changed from u8 to unsigned int,
>>> as it can hold a value upto 255*10=2550.
>>>       This patch adds the code to handle the default timeout
>>> for switch command.
>>> For eMMC 4.5 devices if timeout is not specified for the switch
>>> command while accessing a specific field,then the default timeout
>>> shall be used to timeout. Specification says there is no timeout
>>> defined while accessing BKOPS_START, SANITIZE_START, FLUSH_CACHE
>>> field(so these fields are excluded).
>>>
>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>> ---
>>>  drivers/mmc/core/mmc.c     |    5 +++++
>>>  drivers/mmc/core/mmc_ops.c |    8 ++++++++
>>>  include/linux/mmc/card.h   |    1 +
>>>  include/linux/mmc/mmc.h    |    4 ++++
>>>  4 files changed, 18 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 5700b1c..5b9fb6a 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -405,6 +405,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
>>> *ext_csd)
>>>       if (card->ext_csd.rev >= 5)
>>>               card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
>>>
>>> +     if (card->ext_csd.rev > 5) {
>>> +             /* (eMMC 4.5)timeout is expressed in units of 10 ms*/
>>> +             card->ext_csd.cmd6_timeout = ext_csd[EXT_CSD_CMD6_TIME]*10;
>>> +     }
>>> +
>>>       if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
>>>               card->erased_byte = 0xFF;
>>>       else
>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>>> index 770c3d0..c4d82f4 100644
>>> --- a/drivers/mmc/core/mmc_ops.c
>>> +++ b/drivers/mmc/core/mmc_ops.c
>>> @@ -394,6 +394,14 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
>>> index, u8 value,
>>>       cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>       cmd.cmd_timeout_ms = timeout_ms;
>>>
>>> +     /* timeout is not defined for below command indexes (eMMC 4.5) */
>>> +     if ((timeout_ms == 0)                                   &&
>>> +             (card->ext_csd->rev > 5)                        &&
>>> +             (index != EXT_CSD_BKOPS_START)          &&
>>> +             (index != EXT_CSD_SANITIZE_START)       &&
>>> +             (index != EXT_CSD_FLUSH_CACHE))
>>> +                     cmd.cmd_timeout_ms = card->ext_csd->cmd6_timeout;
>>> +
>> mmc_switch doesn't need to take over '0' value for timeout_ms except for undefined timeout(Background operation, sanitize, etc)
>> It is possible and good to pass the argument of specific timeout_ms(including default cmd6 timeout) explicitly rather than '0',
>> if timeout value for cmd6 is defined.
>> Then, mmc_switch maybe doesn't need to handle timeout for some exception case.
>>
>>>       err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>>>       if (err)
>>>               return err;
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index b460fc2..ef88412 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -50,6 +50,7 @@ struct mmc_ext_csd {
>>>       u8                      rel_sectors;
>>>       u8                      rel_param;
>>>       u8                      part_config;
>>> +     unsigned int            cmd6_timeout;   /* timeout in ms */
>>>       unsigned int            part_time;              /* Units: ms */
>>>       unsigned int            sa_timeout;             /* Units: 100ns */
>>>       unsigned int            hs_max_dtr;
>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>> index 5a794cb..a23f836 100644
>>> --- a/include/linux/mmc/mmc.h
>>> +++ b/include/linux/mmc/mmc.h
>>> @@ -270,8 +270,11 @@ struct _mmc_csd {
>>>   * EXT_CSD fields
>>>   */
>>>
>>> +#define EXT_CSD_FLUSH_CACHE          32      /* R/W */
>>>  #define EXT_CSD_PARTITION_ATTRIBUTE  156     /* R/W */
>>>  #define EXT_CSD_PARTITION_SUPPORT    160     /* RO */
>>> +#define EXT_CSD_BKOPS_START          164     /* R/W */
>>> +#define EXT_CSD_SANITIZE_START               165     /* R/W */
>>>  #define EXT_CSD_WR_REL_PARAM         166     /* RO */
>>>  #define EXT_CSD_ERASE_GROUP_DEF              175     /* R/W */
>>>  #define EXT_CSD_PART_CONFIG          179     /* R/W */
>>> @@ -293,6 +296,7 @@ struct _mmc_csd {
>>>  #define EXT_CSD_SEC_ERASE_MULT               230     /* RO */
>>>  #define EXT_CSD_SEC_FEATURE_SUPPORT  231     /* RO */
>>>  #define EXT_CSD_TRIM_MULT            232     /* RO */
>>> +#define EXT_CSD_CMD6_TIME            248     /* RO */
>>>
>>>  /*
>>>   * EXT_CSD field definitions
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
