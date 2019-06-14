From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: core: Prevent processing SDIO IRQs when the card is suspended
Date: Fri, 14 Jun 2019 08:41:58 -0700
Message-ID: <CAD=FV=Ujb=_jEFMdxLPW6tYwb9DZo5-RZ8BVuyq5DdFQ5jJbQw@mail.gmail.com>
References: <20190611123221.11580-1-ulf.hansson@linaro.org>
 <CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com>
 <CAPDyKFqR-xSKdYZYBTK5kKOt1dk7dx_BjedHiDOKs7-X4od=dg@mail.gmail.com>
 <CAD=FV=WODbZa1fBrLbJBsd77xn5ekHWjks-ydxOSzjdBK83Rmg@mail.gmail.com> <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpqk4ZcVTqifnbnW1WgNfx9ZNebCttUPcK_e9KWqpDMjQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Guenter Roeck <groeck@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Kalle Valo <kvalo@codeaurora.org>, linux-wireless <linux-wireless@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Jun 14, 2019 at 4:56 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > I was more worried about the safety of mmc_card_set_suspended()
> > itself.  That is:
> >
> > #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
> >
> > ...so it's doing a read-modify-write of "state".  Is that safe to do
> > without any type of locking?
>
> In this case, yes I think so.
>
> The point is, it really doesn't matter if the reader (work or thread),
> reads a non-updated value, because the synchronization is managed by
> the later mmc_claim_host() and the cancel_delayed_work_sync().

If this were just an "int" then perhaps, but this is a bitfield.  So
if someone else updates the bitfield at the same time then we can
fully clobber their modification or they can clobber ours, right?

task 1: load "state" from memory into CPU register on cpu0
task 2: load "state" from memory into CPU register on cpu1
task 1: OR in MMC_CARD_REMOVED
task 1: write "state" from CPU register on cpu0
task 2: OR in MMC_STATE_SUSPENDED
task 2: write "state" from CPU register on cpu1

...so now we've clobbered MMC_CARD_REMOVED.  ...or am I just being
paranoid here and everything else in "state" is somehow guaranteed to
not be touched at the same time this function is running?


-Doug
