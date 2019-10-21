From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
Date: Mon, 21 Oct 2019 15:13:39 -0700
Message-ID: <CAD=FV=Wh3bnvNu-_1cXf1xT44-EwomoZEWDt88PZzhUVCn9PcQ@mail.gmail.com>
References: <20191017135739.1315-1-ulf.hansson@linaro.org> <20191017135739.1315-2-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20191017135739.1315-2-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 17, 2019 at 6:57 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> Upfront in mmc_rescan() we use the host->rescan_entered flag, to allow
> scanning only once for non-removable cards. Therefore, it's also not
> possible that we can have bus attached, when we are scanning non-removable
> cards. For this reason, let' drop the check for mmc_card_is_removable() as
> it's redundant.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 221127324709..6f8342702c73 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2297,11 +2297,8 @@ void mmc_rescan(struct work_struct *work)
>
>         mmc_bus_get(host);
>
> -       /*
> -        * if there is a _removable_ card registered, check whether it is
> -        * still present
> -        */
> -       if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
> +       /* Verify a registered card to be functional, else remove it. */
> +       if (host->bus_ops && !host->bus_dead)
>                 host->bus_ops->detect(host);

At first I thought this was a bit more of a change than your
description makes it sound like.  Specifically it seemed like
non-removable cards used to never call host->bus_ops->detect() here
(even during the first call to mmc_rescan) but now they would call it
the first time through.

...so I put in a bunch of printouts.  It appears that the first time
through mmc_rescan() host->bus_ops is NULL.

...ah, and this is what that sentence in your description means about
having a bus attached.  Now I get it!  :-)

...so, right, this looks fine.

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
