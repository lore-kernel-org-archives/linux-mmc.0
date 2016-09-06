From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 1/3] mmc: core: Remove some redundant validations in
 mmc_erase() function
Date: Tue, 6 Sep 2016 20:35:54 +0800
Message-ID: <CAMz4kuK3cPWi3zHUcd+M+8X=C89myFrGfCv=Rjafas3KmemLQQ@mail.gmail.com>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
 <CAPDyKFotQk5XYU1WkTJruWfrRy=Td2ARNdbSj5-2fQBOx9dUsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFotQk5XYU1WkTJruWfrRy=Td2ARNdbSj5-2fQBOx9dUsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, David Jander <david@protonic.nl>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 6 September 2016 at 20:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 September 2016 at 04:55, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Before issuing mmc_erase() function, users always have checked if it can
>> erase with mmc_can_erase/trim/discard() function, thus remove the redundant
>> erase checking in mmc_erase() function.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>> Changes since v3:
>>  - Split into 3 separate patches.
>>  - Add test tag by Shawn.
>>
>> Changes since v2:
>>  - Add nr checking and other optimization in mmc_erase() function.
>>
>> Changes since v1:
>>  - Add the alignment if card->erase_size is not power of 2.
>> ---
>>  drivers/mmc/core/core.c |    7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e55cde6..7d7209d 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -2217,13 +2217,6 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
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
> Could we postpone this until after a clean-up-series of the mmc erase functions?
>
> Until the function remains an exported API, I think it should keep
> doing this validations.

OK. That's reasonable.

>
>>         if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
>>                 return -EOPNOTSUPP;
>>
>> --
>> 1.7.9.5
>>
>
> Kind regards
> Uffe



-- 
Baolin.wang
Best Regards
