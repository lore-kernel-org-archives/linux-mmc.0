From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3] mmc: core: Optimize the mmc erase size alignment
Date: Mon, 5 Sep 2016 16:27:35 +0800
Message-ID: <CAMz4kuJ81CnEL0cATxUsnnDEmxPw1-4pN4brsy0dZeQN6vVJUg@mail.gmail.com>
References: <9de99671750430d7d80a8f351c0ec7a7088c9b00.1472635587.git.baolin.wang@linaro.org>
 <CAPDyKFpzjEydLX94DmYhtMkKp8PTZia-wh1+Oy_ovP65s1=jYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:35218 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbcIEI1g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2016 04:27:36 -0400
Received: by mail-yb0-f169.google.com with SMTP id h3so58094786ybi.2
        for <linux-mmc@vger.kernel.org>; Mon, 05 Sep 2016 01:27:36 -0700 (PDT)
In-Reply-To: <CAPDyKFpzjEydLX94DmYhtMkKp8PTZia-wh1+Oy_ovP65s1=jYA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,


On 2 September 2016 at 17:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 31 August 2016 at 11:32, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Before issuing mmc_erase() function, users always have checked if it can
>> erase with mmc_can_erase/trim/discard() function, thus remove the redundant
>> erase checking in mmc_erase() function.
>>
>> This patch also optimizes the erase start/end sector alignment with
>> round_up()/round_down() function, when erase command is MMC_ERASE_ARG.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v2:
>>  - Add nr checking and other optimization in mmc_erase() function.
>>
>> Changes since v1:
>>  - Add the alignment if card->erase_size is not power of 2.
>> ---
>>  drivers/mmc/core/core.c |   82 ++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 53 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e55cde6..52156d4 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2202,6 +2202,51 @@ out:
>>         return err;
>>  }
>>
>> +static unsigned int mmc_align_erase_size(struct mmc_card *card,
>> +                                        unsigned int *from,
>> +                                        unsigned int *to,
>> +                                        unsigned int nr)
>> +{
>
> How about make one patch that starts by moving the existing code into
> a separate function, then on top as a new change, start playing with
> the optimizations!?
> That would be more easy to review.

Make sense. I'll do what you suggested in next version.

>
>> +       unsigned int from_new = *from, nr_new = nr, rem;
>> +
>> +       if (is_power_of_2(card->erase_size)) {
>
> I would like some comment in the code, to understand what/why we do this.

I think the erase_size is power of 2 in most cases, then the
round_up/down() is more efficient than '%' operation. I'll add some
comments to explain that.

>
>> +               unsigned int temp = from_new;
>> +
>> +               from_new = round_up(temp, card->erase_size);
>> +               rem = from_new - temp;
>> +
>> +               if (nr_new > rem)
>> +                       nr_new -= rem;
>> +               else
>> +                       return 0;
>> +
>> +               nr_new = round_down(nr_new, card->erase_size);
>> +       } else {
>
> Ditto.
>
>> +               rem = from_new % card->erase_size;
>> +               if (rem) {
>> +                       rem = card->erase_size - rem;
>> +                       from_new += rem;
>> +                       if (nr_new > rem)
>> +                               nr_new -= rem;
>> +                       else
>> +                               return 0;
>> +               }
>> +
>> +               rem = nr_new % card->erase_size;
>> +               if (rem)
>> +                       nr_new -= rem;
>> +       }
>> +
>> +       if (nr_new == 0)
>> +               return 0;
>> +
>> +       /* 'from' and 'to' are inclusive */
>> +       *to = from_new + nr_new - 1;
>> +       *from = from_new;
>> +
>> +       return nr_new;
>> +}
>> +
>>  /**
>>   * mmc_erase - erase sectors.
>>   * @card: card to erase
>> @@ -2217,13 +2262,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>>         unsigned int rem, to = from + nr;
>>         int err;
>>
>> -       if (!(card->host->caps & MMC_CAP_ERASE) ||
>> -           !(card->csd.cmdclass & CCC_ERASE))
>> -               return -EOPNOTSUPP;
>> -
>> -       if (!card->erase_size)
>> -               return -EOPNOTSUPP;
>> -
>
> I agree with Shawn here, please try to have one patch taking care of
> one thing. If we find out that things goes wrong later, then it's
> easier to drop/revert a change which causes the regression.

OK.

>
> Moreover, for the above particular change, I don't think you should
> remove these validations, as this is an API being exported. You may
> convert to use mmc_can_erase() though.

These validations are redundant, since we always have checked if it
can erase with mmc_can_erase/trim/discard() function before issuing
mmc_erase(). Another hand these validations should be moved into
mmc_can_erase() not in mmc_erase() function.

>
> Regarding all the mmc erase related exported APIs, there are certainly
> a need for some clean-ups. For example, I think too many APIs are
> being exported and we could probably also restructure the code a bit
> so it becomes more readable. Although, of course this deserves a
> standalone clean-up series. :-)

OK. I would like to do some clean up for erase function after this
optimization. Thanks for your comments.

>
>>         if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
>>                 return -EOPNOTSUPP;
>>
>> @@ -2240,31 +2278,17 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>>                         return -EINVAL;
>>         }
>>
>> -       if (arg == MMC_ERASE_ARG) {
>> -               rem = from % card->erase_size;
>> -               if (rem) {
>> -                       rem = card->erase_size - rem;
>> -                       from += rem;
>> -                       if (nr > rem)
>> -                               nr -= rem;
>> -                       else
>> -                               return 0;
>> -               }
>> -               rem = nr % card->erase_size;
>> -               if (rem)
>> -                       nr -= rem;
>> -       }
>> -
>>         if (nr == 0)
>>                 return 0;
>>
>> -       to = from + nr;
>> -
>> -       if (to <= from)
>> -               return -EINVAL;
>> -
>> -       /* 'from' and 'to' are inclusive */
>> -       to -= 1;
>> +       if (arg == MMC_ERASE_ARG) {
>> +               nr = mmc_align_erase_size(card, &from, &to, nr);
>> +               if (nr == 0)
>> +                       return 0;
>> +       } else {
>> +               /* 'from' and 'to' are inclusive */
>> +               to -= 1;
>> +       }
>>
>>         /*
>>          * Special case where only one erase-group fits in the timeout budget:
>> --
>> 1.7.9.5
>>
>
> Kind regards
> Uffe



-- 
Baolin.wang
Best Regards
