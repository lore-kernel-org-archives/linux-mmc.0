From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v2 3/3] mmc: core: Re-work HW reset for SDIO cards
Date: Wed, 20 Nov 2019 16:41:50 +0000
Message-ID: <0101016e89b106f8-d1e86a0a-db53-4ad2-a2bf-1f5e7b7a792a-000000@us-west-2.amazonses.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
 <20191109103046.26445-4-ulf.hansson@linaro.org>
 <CAD=FV=VHReD5qnvcQLHvfgKHnHLbfDLZHwXtY-LV5uy_VCYpPA@mail.gmail.com>
 <CAPDyKFrCyJBz2=RzKPxqn0FSEq500=dEDsTUWYZeoFKWvSRAdA@mail.gmail.com>
 <87zhgr5af6.fsf@codeaurora.org>
 <6e6b53b28581a8f1a2944ca0bc65311e@codeaurora.org>
 <0101016e87aeb8b6-761ad812-5da7-4b0d-8cae-c69633d90de0-000000@us-west-2.amazonses.com>
 <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoWxw9r=GZhvF=TxHxo=zRfKr0hknEeQNPdfwPx4ORxuQ@mail.gmail.com>
 (Ulf Hansson's message of "Wed, 20 Nov 2019 13:10:42 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/ath10k/>
List-Post: <mailto:ath10k@lists.infradead.org>
List-Help: <mailto:ath10k-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/ath10k>,
 <mailto:ath10k-request@lists.infradead.org?subject=subscribe>
Sender: "ath10k" <ath10k-bounces@lists.infradead.org>
Errors-To: ath10k-bounces+gldad-ath10k=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-wireless <linux-wireless@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, ath10k@lists.infradead.org, Doug Anderson <dianders@chromium.org>, Erik Stromdahl <erik.stromdahl@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Wen Gong <wgong@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 20 Nov 2019 at 08:20, Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> wgong@codeaurora.org writes:
>>
>> > On 2019-11-20 14:28, Kalle Valo wrote:
>> >> + wen, ath10k
>> >>
>> >> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> >>
>> >>> On Tue, 12 Nov 2019 at 01:33, Doug Anderson <dianders@chromium.org>
>> >>> wrote:
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> On Sat, Nov 9, 2019 at 2:31 AM Ulf Hansson
>> >>>> <ulf.hansson@linaro.org> wrote:
>> >>>> >
>> >>>> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >>>> > index 6f8342702c73..abf8f5eb0a1c 100644
>> >>>> > --- a/drivers/mmc/core/core.c
>> >>>> > +++ b/drivers/mmc/core/core.c
>> >>>> > @@ -1469,8 +1469,7 @@ void mmc_detach_bus(struct mmc_host *host)
>> >>>> >         mmc_bus_put(host);
>> >>>> >  }
>> >>>> >
>> >>>> > -static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>> >>>> > -                               bool cd_irq)
>> >>>> > +void _mmc_detect_change(struct mmc_host *host, unsigned long delay, bool cd_irq)
>> >>>> >  {
>> >>>> >         /*
>> >>>> >          * If the device is configured as wakeup, we prevent a new sleep for
>> >>>> > @@ -2129,7 +2128,7 @@ int mmc_hw_reset(struct mmc_host *host)
>> >>>> >         ret = host->bus_ops->hw_reset(host);
>> >>>> >         mmc_bus_put(host);
>> >>>> >
>> >>>> > -       if (ret)
>> >>>> > +       if (ret < 0)
>> >>>> >                 pr_warn("%s: tried to HW reset card, got error %d\n",
>> >>>> >                         mmc_hostname(host), ret);
>> >>>>
>> >>>> Other callers besides marvell need to be updated?  In theory only
>> >>>> SDIO
>> >>>> should have positive return values so I guess we don't care about the
>> >>>> caller in drivers/mmc/core/block.c, right?
>> >>>
>> >>> Correct, but maybe I should add some more information about that in a
>> >>> function header of mmc_hw_reset(). Let me consider doing that as a
>> >>> change on top.
>> >>>
>> >>>>  What about:
>> >>>>
>> >>>> drivers/net/wireless/ath/ath10k/sdio.c
>> >>>>
>> >>>> ...I guess I don't know if there is more than one function probed
>> >>>> there.  Maybe there's not and thus we're fine here too?
>> >>>
>> >>> Well, honestly I don't know.
>> >>>
>> >>> In any case, that would mean the driver is broken anyways and needs to
>> >>> be fixed. At least that's my approach to doing this change.
>> >>
>> >> Wen, does QCA6174 or QCA9377 SDIO devices have other SDIO functions,
>> >> for
>> >> example bluetooth? I'm just wondering how should we handle this in
>> >> ath10k.
>> >
>> > it does not have other SDIO functions for QCA6174 or QCA9377.
>>
>> Thanks, then I don't think we need to change anything in ath10k.
>>
>> --
>> Kalle Valo
>
> Kalle, Wen - thanks for looking into this and for the confirmation.
>
> One thing though, perhaps it's worth to add this as a comment in the
> code for ath10k, where mmc_hw_reset() is called. Just to make it
> clear.

Good point. Wen, can you send a patch, please?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
