From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: reduce nesting and join error strings into one line
Date: Fri, 15 Apr 2016 11:26:03 +0200
Message-ID: <CAPDyKFqV4bwrqsGOsEnWWYrYmC5Z9-PvH9faBXuWsnJNQck6Ag@mail.gmail.com>
References: <1455018191-8545-1-git-send-email-yamada.masahiro@socionext.com>
	<CAK7LNARfTbN2ZO5APHtM7gY1cmqyCQV4FuSHx5h_D+PkfjxOAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARfTbN2ZO5APHtM7gY1cmqyCQV4FuSHx5h_D+PkfjxOAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 15 April 2016 at 11:01, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Ulf,
>
> No interest in this clean-up?
>

Well, no.

Don't get me wrong, I am interested in clean-ups, but this doesn't
improve code quality that much.

Kind regards
Uffe

>
> 2016-02-09 20:43 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> No reason to use the double "if" nesting.  This fix allows to move
>> the nested block to the left and tidy up the error message without
>> 80-col overflow.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  drivers/mmc/core/mmc.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index bf49e44..3789a50 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -345,14 +345,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>
>>         /* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
>>         card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
>> -       if (card->csd.structure == 3) {
>> -               if (card->ext_csd.raw_ext_csd_structure > 2) {
>> -                       pr_err("%s: unrecognised EXT_CSD structure "
>> -                               "version %d\n", mmc_hostname(card->host),
>> -                                       card->ext_csd.raw_ext_csd_structure);
>> -                       err = -EINVAL;
>> -                       goto out;
>> -               }
>> +
>> +       if (card->csd.structure == 3 &&
>> +           card->ext_csd.raw_ext_csd_structure > 2) {
>> +               pr_err("%s: unrecognised EXT_CSD structure version %d\n",
>> +                      mmc_hostname(card->host),
>> +                      card->ext_csd.raw_ext_csd_structure);
>> +               err = -EINVAL;
>> +               goto out;
>>         }
>>
>>         np = mmc_of_find_child_device(card->host, 0);
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada
