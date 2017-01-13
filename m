From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: eMMC boot problem: switch to bus width 8 ddr failed
Date: Fri, 13 Jan 2017 12:14:31 +0100
Message-ID: <CAPDyKFptBoADB-_aS0Uye1nqQ9PSyAzKnhpX9FJTGfj6wtFdHg@mail.gmail.com>
References: <20170106004114.GA22893@archie.localdomain> <1754f0ae-fe6f-00a2-a0d6-9fd55c2b866f@rock-chips.com>
 <20170106155618.GA10105@archie.localdomain> <CAPDyKFoUeYrE7nC2Ds8XHBYXtQpLHkRXKp_hFyD0m6fuuFM==w@mail.gmail.com>
 <103b3045-c17d-ef14-c843-471fcb6e537f@rock-chips.com> <AM4PR0401MB232420E07E9DA5FE18E8B38790780@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <CAA+hA=RgoMkZJxZpH=AaKpBuTnmdbr8J+ew2EwEP=XBf=a7-Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=RgoMkZJxZpH=AaKpBuTnmdbr8J+ew2EwEP=XBf=a7-Mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>, Bough Chen <haibo.chen@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "A.S. Dong" <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>> >
>>> > In the meantime, I will follow the process of Haibo Chen's debugging
>>> > around the voltage switch issue and look into what Dong's suggesting
>>> > around this may be.
>>> >
>>> > Just to be clear, I would definitely prefer a fix in the sdhci driver,
>>>
>>> yup, I prefer to fix the sdhci* either, and given that it's juct -rc3 now, we should
>>> still have some days for Haibo & Dong to help debug it.
>>> Once the fix is settled, we could drop the core fix from -next branch.

Seems like a fix in the sdhci driver isn't going to work. Well, we
could invent a specific mmc host cap, that tells the core to behave
differently - but at this moment I rather not.

>>>
>>
>> Hi Ulf and Shawn,
>>
>> Aisheng and I debug this issue these days, and we find the root cause. There are two things
>> to describe.
>>
>> 1) voltage switch issue.  The properity "no-1-8-v" do not work for  MMC_TIMING_MMC_DDR52.
>> This is another bug, we need to fix, but has no relation with the current bug.
>>
>> 2) root cause, in __mmc_switch, the process is   send CMD6 --> set DDR52 timing --> polling for busy.
>> For the DDR52 timing setting, we call set_ios(), in the set_ios, we first set DDR_EN to config sdhc in ddr mode,
>> and then config the sd clock again.   Here it is, after CMD6 complete, we find data0 still low, which means card
>> busy. At this time, if we set DDR_EN, there is a risk. For i.MX usdhc, DDR_EN setting becomes active only when
>> the DATA and CMD line are idle. So, at this time for HW, DDR_EN do not active, but software think DDR_EN already
>> active, and set the clock again to 49.5MHz, but actually the HW out put the clock as 198MHz. So there is clock glitch.
>> This is the root cause--set DDR_EN when card is still busy.
>>
>> The following method can fix this issue
>> a) change the HW behavior, DDR_EN setting becomes active at once no matter what the state of the DATA and
>> CMD line are.   This can fix this issue, but our IC guys do not prefer this, this method still not safe enough.
>>
>> b) add 1ms delay before DDR_EN to wait bus idle.  But we still not know whether the time 1ms is appropriate. Better
>> to poll for busy before set DDR_EN.
>>
>> c) set DDR52 timing after CMD6 and pull for busy. This is what Shawn's patch do.
>>
>> Hi Aisheng,
>> Correct me if anything wrong.
>>
>> My suggestion is that,  in __mmc_switch(), move the mmc_set_timing() after the function mmc_poll_for_busy().
>>

Yes. Agree!

>>
>
> Haibo, thx for the summary.
>
> I would try to simply things a bit based on Haibo's description!
>
> To be simple, i'd only talking IMX case of the issue that host without
> MMC_CAP_WAIT_WHILE_BUSY.
>
> The current process of mmc_select_hs_ddr handling is:
> Set card DDR52 timing (CMD6)->
> Set host DDR52 timing ->                  (IMX issue happens at this step)
> Polling switch done by card_busy()->
> CMD13 to re-check
>
> What the issue here is that IMX can't allow to change host timing(DDREN bit)
> when card is still busy on the switch process (CMD6).
> It's unsafe and may cause host unwork.
>
> Currently host timing change set_ios(TIMING_DDR52) will gate off host clock,
> change timing, re-enable clock.
>
> Two issue in this process:
> 1) In theory we seem should not gate off clock due to card reply on this lock
> to release the bus busy line.
> (Actually IMX HW can't support gate off clock when data line busy)
>
> 2) Can't guarantee host timing changes won't cause any issue when card is
> still busy.
>
> It looks to me according to spec, we probably should't change host timing
> before the card timing change done.
> Because normally with a good host supporting R1B CMD well,
> CMD6 won't finish before the card timing switch done.
>
> Then the correct process would simply be:
> Set card DDR52 timing (CMD6) ->
> CMD6 completed and busy done ->
> Set host DDR52 timing ->
> CMD13 to re-check
>
> We added a lot tricks to support host without MMC_CAP_WAIT_WHILE_BUSY,
> e.g. via ops->card_busy().
>
> If we want to follow above standard process to do the timing change .
> We could do as:
> Set card DDR52 timing (CMD6) ->
> card_busy() done ->
> Set host DDR52 timing ->
> CMD13 to re-check
>
> Below is the draft patch for above approach and simply test works.
>

Haibo, Dong,

I really appreciate the level of details in the information and thanks
for helping out!

>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index b11c345..3368b1a 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -451,7 +451,8 @@ int mmc_switch_status(struct mmc_card *card)
>  }
>
>  static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -                       bool send_status, bool retry_crc_err)
> +                       bool send_status, bool retry_crc_err,
> +                       unsigned char timing)
>  {
>         struct mmc_host *host = card->host;
>         int err;
> @@ -506,8 +507,11 @@ static int mmc_poll_for_busy(struct mmc_card
> *card, unsigned int timeout_ms,
>                 }
>         } while (busy);
>
> -       if (host->ops->card_busy && send_status)
> +       if (host->ops->card_busy && send_status) {
> +               if (timing)
> +                       mmc_set_timing(host, timing);
>                 return mmc_switch_status(card);
> +       }
>
>         return 0;
>  }
> @@ -577,8 +581,13 @@ int __mmc_switch(struct mmc_card *card, u8 set,
> u8 index, u8 value,
>         if (!use_busy_signal)
>                 goto out;
>
> -       /* Switch to new timing before poll and check switch status. */
> -       if (timing)
> +       /*
> +       * Switch to new timing before poll and check switch status.
> +       *
> +       * If host supports ops->card_busy(), we'd set timing later
> +       * after card busy is done, this can avoid potential glitch.
> +       */
> +       if (timing && !host->ops->card_busy)
>                 mmc_set_timing(host, timing);
>
>         /*If SPI or used HW busy detection above, then we don't need to poll. */
> @@ -590,7 +599,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
> index, u8 value,
>         }
>
>         /* Let's try to poll to find out when the command is completed. */
> -       err = mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err);
> +       err = mmc_poll_for_busy(card, timeout_ms, send_status,
> retry_crc_err, timing);
>
>  out_tim:
>         if (err && timing)
>
>
> However, if we want to make things simply, i'm also ok with Shawn's patch
> that make sure host timing is only changed after the card timing switch polling
> is done (although host was in old timing).
> Because usually host in low speed mode timing normally should work for card in
> new high speed mode timing in theory.
>
> Ulf, count on you!

I have been inspired by yours and Shawn Lin suggested changes for a
fix, however I decided to make a patch myself. Just posted it.

[PATCH] mmc: core: Restore parts of the polling policy when switch to HS/HS DDR

Please have a look and try it out.

[...]

Kind regards
Uffe
