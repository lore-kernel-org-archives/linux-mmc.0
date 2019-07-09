From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/7] mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
Date: Tue, 9 Jul 2019 14:25:43 -0700
Message-ID: <CAD=FV=UjXT0UG=JZtvNL4EtHofcuC_HhTe4grWBNJ8+8jVFhYg@mail.gmail.com>
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-3-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-3-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> The function mmc_sdio_power_restore() is called either from
> mmc_sdio_runtime_resume() or from mmc_sdio_hw_reset(). Both callers either
> claims/releases the host or require its callers to do so. Therefore let's
> drop the redundant calls to mmc_claim|release_host() in
> mmc_sdio_power_restore().
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/core/sdio.c | 4 ----
>  1 file changed, 4 deletions(-)

Without being an expert, I looked through the code and as far as I can
tell this is fine.  Specifically:

* I agree there are two calls and mmc_sdio_runtime_resume() clearly claims.

* The only call to mmc_sdio_hw_reset() looks to be mmc_hw_reset();
looking through calls to mmc_hw_reset() I see the claims.  It's super
obvious in the 3 cases in "drivers/net" and I decided that I didn't
need to look at block.c because that shouldn't be a codepath that
affects SDIO.

Thus:

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>


I also don't see this patch causing any problems on the rk3288-veyron
boards I tested it on.  Thus:

Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
