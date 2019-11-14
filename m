From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mwifiex: Re-work support for SDIO HW reset
Date: Thu, 14 Nov 2019 16:20:44 +0100
Message-ID: <CAPDyKFrjEcsGKOwtRtns4a3dWExTvpbe2_16Gp9rwwxGbxynAg@mail.gmail.com>
References: <20191112124021.8718-1-ulf.hansson@linaro.org> <20191112124021.8718-2-ulf.hansson@linaro.org>
 <87zhgybids.fsf@tynnyri.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87zhgybids.fsf-R2sXevljlEEH1xkMTmwrwqxOck334EZe@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 14 Nov 2019 at 16:13, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
> > The SDIO HW reset procedure in mwifiex_sdio_card_reset_work() is broken,
> > when the SDIO card is shared with another SDIO func driver. This is the
> > case when the Bluetooth btmrvl driver is being used in combination with
> > mwifiex. More precisely, when mwifiex_sdio_card_reset_work() runs to resets
> > the SDIO card, the btmrvl driver doesn't get notified about it. Beyond that
> > point, the btmrvl driver will fail to communicate with the SDIO card.
> >
> > This is a generic problem for SDIO func drivers sharing an SDIO card, which
> > are about to be addressed in subsequent changes to the mmc core and the
> > mmc_hw_reset() interface. In principle, these changes means the
> > mmc_hw_reset() interface starts to return 1 if the are multiple drivers for
> > the SDIO card, as to indicate to the caller that the reset needed to be
> > scheduled asynchronously through a hotplug mechanism of the SDIO card.
> >
> > Let's prepare the mwifiex driver to support the upcoming new behaviour of
> > mmc_hw_reset(), which means extending the mwifiex_sdio_card_reset_work() to
> > support the asynchronous SDIO HW reset path. This also means, we need to
> > allow the ->remove() callback to run, without waiting for the FW to be
> > loaded. Additionally, during system suspend, mwifiex_sdio_suspend() may be
> > called when a reset has been scheduled, but waiting to be executed. In this
> > scenario let's simply return -EBUSY to abort the suspend process, as to
> > allow the reset to be completed first.
> >
> > Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Look good to me. Ulf, I assume you are going to take this so here's my
> ack:
>
> Acked-by: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Thanks, I have queued it via my tree this time.

Kind regards
Uffe
