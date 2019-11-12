From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
Date: Tue, 12 Nov 2019 13:23:17 +0100
Message-ID: <CAPDyKFq03X0hd5B6h6fuNht5OjSEWe6Ap4hH4a+0nVZsS4r3hw@mail.gmail.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org> <20191111220812.GX43123@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191111220812.GX43123-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 11 Nov 2019 at 23:08, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi,
>
> * Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [191109 10:31]:
> > Changes in v2:
> >       - Add adaptations to the mwifiex driver.
> >       - Keep existing syncronous reset behaviour if the SDIO card has a single
> >       func driver.
> >
> > It has turned out that it's not a good idea to try to power cycle and to
> > re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> > because there may be multiple SDIO funcs attached to the same SDIO card and
> > some of the others that didn't execute the call to mmc_hw_reset(), may then
> > simply experience an undefined behaviour.
> >
> > The following patches in this series attempts to address this problem, by
> > reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> > mwifiex driver to these changes.
> >
> > Note that, I don't have the HW at hand so the the code has only compile tested.
> > Test on HW is greatly appreciated!
>
> Looks good to me. I tried testing this, but looks like at least on duovero
> mwifiex_sdio is broken in v5.4-rc7:
>
> # dmesg | grep mwifi
> mwifiex_sdio mmc1:0001:1: poll card status failed, tries = 100
> mwifiex_sdio mmc1:0001:1: FW download with helper:       poll status timeout @ 0
> mwifiex_sdio mmc1:0001:1: prog_fw failed ret=0xffffffff
> mwifiex_sdio mmc1:0001:1: info: _mwifiex_fw_dpc: unregister device
>
> No idea when it broke and what might be the issue this time around.
> Any ideas?

Sorry, no good idea.

Perhaps something on the mmc host level that has changed?

Kind regards
Uffe
