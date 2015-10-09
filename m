From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD
Date: Fri, 9 Oct 2015 09:33:51 -0700
Message-ID: <CANEJEGtpCvDYd8=mUOn5NbyR=fofz3yb9FkTN0qC8vxiLkK9Tw@mail.gmail.com>
References: <1443058233-2370-1-git-send-email-grundler@chromium.org>
	<CAPDyKFqNx6ADXAONS_p2FzHXLCO5fwa=1zioS_9-7E1w5FQZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqNx6ADXAONS_p2FzHXLCO5fwa=1zioS_9-7E1w5FQZwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Grant Grundler <grundler@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Hyung Taek Ryoo <hryoo@nvidia.com>, Gwendal Grignou <gwendal@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Awesome! Thanks Ulf! :)

cheers
grant

On Mon, Oct 5, 2015 at 3:55 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 24 September 2015 at 03:30, Grant Grundler <grundler@chromium.org> wrote:
>> MMC_IOC_CMD and MMC_IOC_MULTI_CMD ioctl() code currently bails on
>> any eMMC errors. However, in case there is any resp[] data, we
>> should attempt to copy resp[] back to user space. The user app
>> can then determine which command(s) failed in the MMC_IOC_MULTI_CMD
>> case AND/OR report better diagnostics in both cases.
>>
>> Gwendal Grignou provided the idea and it was previously implemented
>> and tested on v3.18 ChromeOS kernel:
>>     https://chromium-review.googlesource.com/#/c/299956
>>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>> Reviewed-by: Hyung Taek Ryoo <hryoo@nvidia.com>
>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>> Tested-by: David Riley <davidriley@chromium.org>
>
> Thanks, applied for next!
>
> Kind regards
> Uffe
>
>> ---
>> I believe the patch applied correctly to Ulf's mmc.git on linaro.org.
>> I would have warm fuzzies if Jon or Hyung (Nvidia) could review/test this.
>>
>> I made one change from the chromium.org version:
>>   initialize err and ioc_err to zero in mmc_blk_ioctl_cmd()
>>
>>  drivers/mmc/card/block.c | 27 +++++++++------------------
>>  1 file changed, 9 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index f6acf0f..23b6c8e 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -595,7 +595,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>         struct mmc_blk_ioc_data *idata;
>>         struct mmc_blk_data *md;
>>         struct mmc_card *card;
>> -       int err;
>> +       int err = 0, ioc_err = 0;
>>
>>         idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
>>         if (IS_ERR(idata))
>> @@ -615,19 +615,18 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>
>>         mmc_get_card(card);
>>
>> -       err = __mmc_blk_ioctl_cmd(card, md, idata);
>> +       ioc_err = __mmc_blk_ioctl_cmd(card, md, idata);
>>
>>         mmc_put_card(card);
>>
>> -       if (!err)
>> -               err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
>> +       err = mmc_blk_ioctl_copy_to_user(ic_ptr, idata);
>>
>>  cmd_done:
>>         mmc_blk_put(md);
>>  cmd_err:
>>         kfree(idata->buf);
>>         kfree(idata);
>> -       return err;
>> +       return ioc_err ? ioc_err : err;
>>  }
>>
>>  static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>> @@ -637,7 +636,7 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>>         struct mmc_ioc_cmd __user *cmds = user->cmds;
>>         struct mmc_card *card;
>>         struct mmc_blk_data *md;
>> -       int i, err = -EFAULT;
>> +       int i, err = 0, ioc_err = 0;
>>         __u64 num_of_cmds;
>>
>>         if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
>> @@ -672,22 +671,14 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>>
>>         mmc_get_card(card);
>>
>> -       for (i = 0; i < num_of_cmds; i++) {
>> -               err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>> -               if (err) {
>> -                       mmc_put_card(card);
>> -                       goto cmd_done;
>> -               }
>> -       }
>> +       for (i = 0; i < num_of_cmds && !ioc_err; i++)
>> +               ioc_err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>>
>>         mmc_put_card(card);
>>
>>         /* copy to user if data and response */
>> -       for (i = 0; i < num_of_cmds; i++) {
>> +       for (i = 0; i < num_of_cmds && !err; i++)
>>                 err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
>> -               if (err)
>> -                       break;
>> -       }
>>
>>  cmd_done:
>>         mmc_blk_put(md);
>> @@ -697,7 +688,7 @@ cmd_err:
>>                 kfree(idata[i]);
>>         }
>>         kfree(idata);
>> -       return err;
>> +       return ioc_err ? ioc_err : err;
>>  }
>>
>>  static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>> --
>> 2.6.0.rc2.230.g3dd15c0
>>
