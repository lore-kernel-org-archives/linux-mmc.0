From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 5/7] mmc: sdio: Don't re-initialize powered-on removable
 SDIO cards at resume
Date: Tue, 9 Jul 2019 14:26:06 -0700
Message-ID: <CAD=FV=Uss6B2nHPz_pQJFCXm2G=f_rpfqK6xVG1SCDHYb12jmw@mail.gmail.com>
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-6-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> It looks like the original idea behind always doing a re-initialization of
> a removable SDIO card during system resume in mmc_sdio_resume(), is to try
> to play safe to detect whether the card has been removed.
>
> However, this seems like a really a bad idea as it will most likely screw
> things up, especially when the card is expected to remain powered on during
> system suspend by the SDIO func driver.
>
> Let's fix this, simply by trusting that the detect work checks if the card
> is alive and inserted, which is being scheduled at the PM_POST_SUSPEND
> notification anyway.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/core/sdio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I'm not sure if it's even worth mentioning since the device I tested
was rk3288-veyron (both WiFi variants) and we have a non-removable,
powered-in-suspend, wakeup-disabled card.  That means it isn't
affected at all by your change.  ...but I suppose I can at least
confirm that your change didn't break me if that's worth anything.
:-P

Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

I would also say that, though I don't have any history here, your
patch seems reasonable to me.  So you can add a:

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
