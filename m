From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 09/15] mmc: core: Move erase/trim/discard defines from
 public core.h to mmc.h
Date: Tue, 17 Jan 2017 16:06:51 +0100
Message-ID: <CAPDyKFojcp03V_+xwGVh5OEox-VohDkq+PEJMx9yTkXdtffURg@mail.gmail.com>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-10-git-send-email-ulf.hansson@linaro.org> <7c4e3f95-0273-f8a0-bcf3-7a1a0ae88b70@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:32879 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdAQPHT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 10:07:19 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so116557371ioi.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2017 07:06:52 -0800 (PST)
In-Reply-To: <7c4e3f95-0273-f8a0-bcf3-7a1a0ae88b70@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On 16 January 2017 at 04:05, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> =E5=9C=A8 2017/1/13 21:14, Ulf Hansson =E5=86=99=E9=81=93:
>>
>> As the public mmc.h header already contains similar defines for other mm=
c
>> commands and arguments, let's move those for erase/trim/discard into her=
e
>> as well.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  include/linux/mmc/core.h | 10 ----------
>>  include/linux/mmc/mmc.h  | 13 ++++++++++++-
>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index faacc90..6440e10 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -164,16 +164,6 @@ extern struct mmc_async_req *mmc_start_req(struct
>> mmc_host *,
>>  extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request *);
>>  extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command *,
>> int);
>>
>> -#define MMC_ERASE_ARG          0x00000000
>> -#define MMC_SECURE_ERASE_ARG   0x80000000
>> -#define MMC_TRIM_ARG           0x00000001
>> -#define MMC_DISCARD_ARG                0x00000003
>> -#define MMC_SECURE_TRIM1_ARG   0x80000001
>> -#define MMC_SECURE_TRIM2_ARG   0x80008000
>> -
>> -#define MMC_SECURE_ARGS                0x80000000
>> -#define MMC_TRIM_ARGS          0x00008001
>> -
>>  extern int mmc_hw_reset(struct mmc_host *host);
>>  extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_ca=
rd
>> *);
>>
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 261772e..8f78543 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -462,12 +462,23 @@ struct _mmc_csd {
>>  /*
>>   * MMC_SWITCH access modes
>>   */
>> -
>
>
> It's not relevant to remove this blank line?

Well, as I am anyway doing "clean-ups" I thought it make sense to fold
it in here. Seems a bit too much for a separate patch for that.

>
> Otherwise,
>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>>  #define MMC_SWITCH_MODE_CMD_SET                0x00    /* Change the
>> command set */
>>  #define MMC_SWITCH_MODE_SET_BITS       0x01    /* Set bits which are 1 =
in
>> value */
>>  #define MMC_SWITCH_MODE_CLEAR_BITS     0x02    /* Clear bits which are =
1
>> in value */
>>  #define MMC_SWITCH_MODE_WRITE_BYTE     0x03    /* Set target to value *=
/
>>
>> +/*
>> + * Erase/trim/discard
>> + */
>> +#define MMC_ERASE_ARG                  0x00000000
>> +#define MMC_SECURE_ERASE_ARG           0x80000000
>> +#define MMC_TRIM_ARG                   0x00000001
>> +#define MMC_DISCARD_ARG                        0x00000003
>> +#define MMC_SECURE_TRIM1_ARG           0x80000001
>> +#define MMC_SECURE_TRIM2_ARG           0x80008000
>> +#define MMC_SECURE_ARGS                        0x80000000
>> +#define MMC_TRIM_ARGS                  0x00008001
>> +
>>  #define mmc_driver_type_mask(n)                (1 << (n))
>>
>>  #endif /* LINUX_MMC_MMC_H */
>>
>
>
> --
> Best Regards
> Shawn Lin
>


Kind regards
Uffe
