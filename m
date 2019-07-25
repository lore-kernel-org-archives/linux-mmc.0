From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug() API to reset
Date: Thu, 25 Jul 2019 08:56:35 +0300
Message-ID: <87imrqzmgc.fsf@kamboji.qca.qualcomm.com>
References: <20190722193939.125578-3-dianders@chromium.org>
        <20190724113508.47A356021C@smtp.codeaurora.org>
        <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
        (Doug Anderson's message of "Wed, 24 Jul 2019 13:22:22 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ganapathi Bhat <gbhat@marvell.com>, linux-wireless <linux-wireless@vger.kernel.org>, Andreas Fenkart <afenkart@gmail.com>, Brian Norris <briannorris@chromium.org>, Amitkumar Karwar <amitkarwar@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Nishant Sarmukadam <nishants@marvell.com>, netdev <netdev@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>, Linux MMC List <linux-mmc@vger.kernel.org>, David Miller <davem@davemloft.net>, Xinming Hu <huxinming820@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Wed, Jul 24, 2019 at 4:35 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Douglas Anderson <dianders@chromium.org> wrote:
>>
>> > As described in the patch ("mmc: core: Add sdio_trigger_replug()
>> > API"), the current mwifiex_sdio_card_reset() is broken in the cases
>> > where we're running Bluetooth on a second SDIO func on the same card
>> > as WiFi.  The problem goes away if we just use the
>> > sdio_trigger_replug() API call.
>> >
>> > NOTE: Even though with this new solution there is less of a reason to
>> > do our work from a workqueue (the unplug / plug mechanism we're using
>> > is possible for a human to perform at any time so the stack is
>> > supposed to handle it without it needing to be called from a special
>> > context), we still need a workqueue because the Marvell reset function
>> > could called from a context where sleeping is invalid and thus we
>> > can't claim the host.  One example is Marvell's wakeup_timer_fn().
>> >
>> > Cc: Andreas Fenkart <afenkart@gmail.com>
>> > Cc: Brian Norris <briannorris@chromium.org>
>> > Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> > Reviewed-by: Brian Norris <briannorris@chromium.org>
>>
>> I assume this is going via some other tree so I'm dropping this from my
>> queue. If I should apply this please resend once the dependency is in
>> wireless-drivers-next.
>>
>> Patch set to Not Applicable.
>
> Thanks.  For now I'll assume that Ulf will pick it up if/when he is
> happy with patch #1 in this series.  Would you be willing to provide
> your Ack on this patch to make it clear to Ulf you're OK with that?

Sure, I was planning to do that already in my previous email but forgot.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
