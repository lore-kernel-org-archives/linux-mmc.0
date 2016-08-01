From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Optimize the mmc erase size alignment
Date: Mon, 1 Aug 2016 15:28:14 +0800
Message-ID: <CAMz4ku+uXXhme2DhQVGjkfzSTxAnF5LOK_NE-6SrG3-2dhBA7Q@mail.gmail.com>
References: <5117da51a7f11a16a8d10af060e2123f0d0a3ae8.1469603653.git.baolin.wang@linaro.org>
 <dabf9f48-9b27-eb3f-1892-a1d416ed1d3b@rock-chips.com> <CAMz4kuK449QstQgrqq_cX1-LyTKscemtS+EkevXkgzeV3=ceQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuK449QstQgrqq_cX1-LyTKscemtS+EkevXkgzeV3=ceQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf and Shawn,

On 27 July 2016 at 18:02, Baolin Wang <baolin.wang@linaro.org> wrote:
> On 27 July 2016 at 17:59, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> On 2016/7/27 15:17, Baolin Wang wrote:
>>>
>>> Before issuing mmc_erase() function, users always have checked if it can
>>> erase with mmc_can_erase/trim/discard() function, thus remove the
>>> redundant
>>> erase checking in mmc_erase() function.
>>>
>>> This patch also optimizes the erase start/end sector alignment with
>>> round_up()/round_down() function, when erase command is MMC_ERASE_ARG.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>> Changes since v1:
>>>  - Add the alignment if card->erase_size is not power of 2.
>>> ---
>>>  drivers/mmc/core/core.c |   78
>>> +++++++++++++++++++++++++++++------------------
>>>  1 file changed, 48 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index b4c08d1a..303a917 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2195,6 +2195,51 @@ out:
>>>         return err;
>>>  }
>>>
>>> +static unsigned int mmc_align_erase_size(struct mmc_card *card,
>>> +                                        unsigned int *from,
>>> +                                        unsigned int *to,
>>> +                                        unsigned int nr)
>>> +{
>>> +       unsigned int from_new = *from, nr_new = nr, rem;
>>> +
>>> +       if (is_power_of_2(card->erase_size)) {
>>> +               unsigned int temp = from_new;
>>> +
>>> +               from_new = round_up(temp, card->erase_size);
>>> +               rem = from_new - temp;
>>> +
>>> +               if (nr_new > rem)
>>> +                       nr_new -= rem;
>>> +               else
>>> +                       return 0;
>>> +
>>> +               nr_new = round_down(nr_new, card->erase_size);
>>> +       } else {
>>> +               rem = from_new % card->erase_size;
>>> +               if (rem) {
>>> +                       rem = card->erase_size - rem;
>>> +                       from_new += rem;
>>> +                       if (nr_new > rem)
>>> +                               nr_new -= rem;
>>> +                       else
>>> +                               return 0;
>>> +               }
>>> +
>>> +               rem = nr_new % card->erase_size;
>>> +               if (rem)
>>> +                       nr_new -= rem;
>>> +       }
>>> +
>>> +       if (nr_new == 0)
>>> +               return 0;
>>> +
>>> +       /* 'from' and 'to' are inclusive */
>>> +       *to = from_new + nr_new - 1;
>>> +       *from = from_new;
>>> +
>>> +       return nr_new;
>>> +}
>>> +
>>>  /**
>>>   * mmc_erase - erase sectors.
>>>   * @card: card to erase
>>> @@ -2210,13 +2255,6 @@ int mmc_erase(struct mmc_card *card, unsigned int
>>> from, unsigned int nr,
>>>         unsigned int rem, to = from + nr;
>>>         int err;
>>>
>>> -       if (!(card->host->caps & MMC_CAP_ERASE) ||
>>> -           !(card->csd.cmdclass & CCC_ERASE))
>>
>>
>> Why remove the check , "!(card->csd.cmdclass & CCC_ERASE))"?
>
> Cause we always issue mmc_can_erase() function before strating to do
> mmc erase, so these looks like redundant.

Do you have any other comments about this patch? Thanks.

>
>>> -               return -EOPNOTSUPP;
>>> -
>>> -       if (!card->erase_size)
>>> -               return -EOPNOTSUPP;
>>> -
>>>         if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
>>>                 return -EOPNOTSUPP;
>>>
>>> @@ -2234,31 +2272,11 @@ int mmc_erase(struct mmc_card *card, unsigned int
>>> from, unsigned int nr,
>>>         }
>>>
>>>         if (arg == MMC_ERASE_ARG) {
>>> -               rem = from % card->erase_size;
>>> -               if (rem) {
>>> -                       rem = card->erase_size - rem;
>>> -                       from += rem;
>>> -                       if (nr > rem)
>>> -                               nr -= rem;
>>> -                       else
>>> -                               return 0;
>>> -               }
>>> -               rem = nr % card->erase_size;
>>> -               if (rem)
>>> -                       nr -= rem;
>>> +               rem = mmc_align_erase_size(card, &from, &to, nr);
>>> +               if (rem == 0)
>>> +                       return 0;
>>>         }
>>>
>>> -       if (nr == 0)
>>> -               return 0;
>>> -
>>> -       to = from + nr;
>>> -
>>> -       if (to <= from)
>>> -               return -EINVAL;
>>> -
>>> -       /* 'from' and 'to' are inclusive */
>>> -       to -= 1;
>>> -
>>>         /*
>>>          * Special case where only one erase-group fits in the timeout
>>> budget:
>>>          * If the region crosses an erase-group boundary on this
>>> particular
>>>
>>
>>
>> --
>> Best Regards
>> Shawn Lin
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Baolin.wang
> Best Regards



-- 
Baolin.wang
Best Regards
