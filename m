From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug()
 API to reset
Date: Wed, 24 Jul 2019 13:22:22 -0700
Message-ID: <CAD=FV=WAsrBV9PzUz1qPzQru+AkOYZ5hsaWdhNYRTNqUfDeOmQ@mail.gmail.com>
References: <20190722193939.125578-3-dianders@chromium.org> <20190724113508.47A356021C@smtp.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190724113508.47A356021C-4h6buKAYkuurB/BPivuO70B+6BGkLq7r@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ganapathi Bhat <gbhat-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andreas Fenkart <afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Amitkumar Karwar <amitkarwar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Nishant Sarmukadam <nishants-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Avri Altman <avri.altman-Sjgp3cTcYWE@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Xinming Hu <huxinming820-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 24, 2019 at 4:35 AM Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> > As described in the patch ("mmc: core: Add sdio_trigger_replug()
> > API"), the current mwifiex_sdio_card_reset() is broken in the cases
> > where we're running Bluetooth on a second SDIO func on the same card
> > as WiFi.  The problem goes away if we just use the
> > sdio_trigger_replug() API call.
> >
> > NOTE: Even though with this new solution there is less of a reason to
> > do our work from a workqueue (the unplug / plug mechanism we're using
> > is possible for a human to perform at any time so the stack is
> > supposed to handle it without it needing to be called from a special
> > context), we still need a workqueue because the Marvell reset function
> > could called from a context where sleeping is invalid and thus we
> > can't claim the host.  One example is Marvell's wakeup_timer_fn().
> >
> > Cc: Andreas Fenkart <afenkart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
> > Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> I assume this is going via some other tree so I'm dropping this from my
> queue. If I should apply this please resend once the dependency is in
> wireless-drivers-next.
>
> Patch set to Not Applicable.

Thanks.  For now I'll assume that Ulf will pick it up if/when he is
happy with patch #1 in this series.  Would you be willing to provide
your Ack on this patch to make it clear to Ulf you're OK with that?

-Doug
