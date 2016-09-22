From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
 selecting hs400es
Date: Thu, 22 Sep 2016 18:06:52 +0800
Message-ID: <62a8d622-39d2-db7d-042d-5425a3efba58@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
 <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoHxSpFurgV9swN3MCTWUinPFNUHSzxgyKj+K3iqkGSbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:35275 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756854AbcIVKHC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 06:07:02 -0400
In-Reply-To: <CAPDyKFoHxSpFurgV9swN3MCTWUinPFNUHSzxgyKj+K3iqkGSbA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi ulf,

在 2016/9/22 17:38, Ulf Hansson 写道:
> On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Per JESD84-B51 P69, Host need to change frequency to <=52MHz after
>> setting HS_TIMING to 0x1, and host may changes frequency to <= 200MHz
>> after setting HS_TIMING to 0x3. It seems there is no difference if
>> we don't change frequency to <= 52MHz as f_init is already less than
>> 52MHz. But actually it does make difference. When doing compatibility
>> test we see failures for some eMMC devices without changing the
>> frequency to hs_max_dtr. And let's read the spec again, we could see
>> that "Host may changes frequency to 200MHz" implies that it's not
>> mandatory. But the "Host need to change frequency to <= 52MHz" implies
>> that we should do this.
>
> I don't get this. Are you saying that f_init > 52 MHz? That should not
> be impossible, right!?

nope, I was saying that the spec implies we to set clock after
setting HS_TIMING to 0x1 when doing hs400es selection.

I thought there is no difference because the spec says "Host need to
change frequency to <= 52MHz", and the f_init(<=400k) is <= 52MHz,
right? So I didn't set clock to hs_max_dtr. But I think I misunderstood
the spec, so this patch will fix this.


>
> So either the core has changed the clock rate by mistake at some other
> execution path, or the host driver didn't set the correct clock rate
> the first time when invoked via mmc_power_up()?
>
> Kind regards
> Uffe
>
>>
>> Reported-by: Xiao Yao <xiaoyao@rock-chips.com>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/core/mmc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 3163bb9..989d37e 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1282,6 +1282,8 @@ static int mmc_select_hs400es(struct mmc_card *card)
>>         if (err)
>>                 goto out_err;
>>
>> +       mmc_set_clock(host, card->ext_csd.hs_max_dtr);
>> +
>>         err = mmc_switch_status(card);
>>         if (err)
>>                 goto out_err;
>> --
>> 2.3.7
>>
>>
>
>
>


-- 
Best Regards
Shawn Lin

