From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: core: not need to check timeout for SDHC
Date: Thu, 3 Aug 2017 21:06:01 +0800
Message-ID: <cff52f49-204e-6b82-2924-b9df3201fdcb@rock-chips.com>
References: <1501643563-16094-1-git-send-email-shawn.lin@rock-chips.com>
 <1501643563-16094-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFrRvmRN41cMHwnWjMUdGwcMJtru2k-8AEHgaiFYEo59Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:52118 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdHCNGR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 09:06:17 -0400
In-Reply-To: <CAPDyKFrRvmRN41cMHwnWjMUdGwcMJtru2k-8AEHgaiFYEo59Nw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2017/8/3 18:51, Ulf Hansson wrote:
> On 2 August 2017 at 05:12, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Per the SD physical layer simplified specification V4.10,
>> section 4.6.2, the taac and nasc for SDHC are always fixed and
>> the software should use the recommended value for timeout.
>> When parsing the CSD, we sanely set them to zero for SDHC, the
>> additional check of SDHC in mmc_set_data_timeout is bogus since
>> all the calculation for timeout_ns and timeout_clk is zero as well,
>> so the we could safely remove it and let the following check to
>> cover it.
>
> For SD cards with CSD structure version set to 0 (old cards) we are
> using the taac/nasc values. Perhaps you can clarify that in the above
> changelog.
>

Sure.

>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/core/core.c | 10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 6177eb0..bcd72b4 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -761,14 +761,10 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>>                         limit_us = 100000;
>>
>>                 /*
>> -                * SDHC cards always use these fixed values.
>> +                * Assign limit value if invalid. Note that for the SDHC case,
>> +                * we set taac and nasc to zero when parsing CSD, so it's safe
>> +                * to fall through here.
>>                  */
>> -               if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
>
> I think the mmc_card_blockaddr() here is what make this a bit strange.
> Because as you are saying, in those cases the taac/nasc are set to
> zero.
>
> So in principle we should at least be able to remove the check for the
> mmc_card_blockaddr(), but don't you think we need to keep the other
> check for "timeout_us > limit_us", to still cope with legacy cards?
>

yes, will fix that.

>> -                       data->timeout_ns = limit_us * 1000;
>> -                       data->timeout_clks = 0;
>> -               }
>> -
>> -               /* assign limit value if invalid */
>>                 if (timeout_us == 0)
>>                         data->timeout_ns = limit_us * 1000;
>>         }
>> --
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

