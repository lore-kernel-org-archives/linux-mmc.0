From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/7] mmc: sdio: Drop powered-on re-init at runtime resume
 and HW reset
Date: Wed, 3 Jul 2019 17:01:46 -0700
Message-ID: <CAD=FV=X7P2F1k_zwHc0mbtfk55-rucTz_GoDH=PL6zWqKYcpuw@mail.gmail.com>
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-5-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190618153448.27145-5-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> To use the so called powered-on re-initialization of an SDIO card, the
> power to the card must obviously have stayed on. If not, the initialization
> will simply fail.
>
> In the runtime suspend case, the card is always powered off. Hence, let's
> drop the support for powered-on re-initialization during runtime resume, as
> it doesn't make sense.
>
> Moreover, during a HW reset, the point is to cut the power to the card and
> then do fresh re-initialization. Therefore drop the support for powered-on
> re-initialization during HW reset.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mmc/core/sdio.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

This has been on my list of things to test for a while but I never
quite got to it...

...and then, today, I spent time bisecting why the "reset"
functionality of miwfiex is broken on my 4.19 kernel [1].  AKA, this
is broken:

cd /sys/kernel/debug/mwifiex/mlan0
echo 1 > reset

I finally bisected the problem and tracked it down to commit
ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs
are enabled"), which embarrassingly has my Tested-by on it.  I guess I
never tested the Marvell reset call.  :-/

I dug a little and found that when the Marvell code did its reset we
ended up getting a call to dw_mci_enable_sdio_irq(enb=0) and never saw
a dw_mci_enable_sdio_irq(enb=1) after.  I tracked it down further and
found that specifically it was the call to mmc_signal_sdio_irq() in
mmc_sdio_power_restore() that was making the call.  The call stack
shown for the "enb=0" call:

[<c071a290>] (dw_mci_enable_sdio_irq) from [<c070a960>]
(mmc_sdio_power_restore+0x98/0xc0)
[<c070a960>] (mmc_sdio_power_restore) from [<c070a9b4>]
(mmc_sdio_reset+0x2c/0x30)
[<c070a9b4>] (mmc_signal_sdio_irq) from [<c06ff160>] (mmc_hw_reset+0xbc/0x138)
[<c06ff160>] (mmc_hw_reset) from [<bf1bbad8>]
(mwifiex_sdio_work+0x5d4/0x678 [mwifiex_sdio])
[<bf1bbad8>] (mwifiex_sdio_work [mwifiex_sdio]) from [<c0247cd0>]
(process_one_work+0x290/0x4b4)

I picked your patch here (which gets rid of the call to
mmc_signal_sdio_irq()) and magically the problem went away because
there is no more call to mmc_signal_sdio_irq().

I personally don't have lots of history about the whole
"powered_resume" code path.  I checked and mmc_card_keep_power() was 0
in my test case of getting called from hw_reset, so the rest of this
patch doesn't affect me at all.  This surprised me a little since I
saw "MMC_PM_KEEP_POWER" being set in mwifiex but then I realized that
it was only set for the duration of suspend and then cleared by the
core.  ;-)

I will also say that I don't have any test case or knowledge of how
SDIO runtime suspend/resume is supposed to work since on dw_mmc SDIO
cards are currently not allowed to runtime suspend anyway.  ;-)


So I guess the result of all that long-winded reply is that for on
rk3288-veyron-jerry:

Fixes: ca8971ca5753 ("mmc: dw_mmc: Prevent runtime PM suspend when
SDIO IRQs are enabled")
Tested-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>


One last note is that, though Marvell WiFi works after a reset after
this commit, Marvell Bluetooth (on the same SDIO module) doesn't.  I
guess next week it'll be another bisect...

[1] https://crbug.com/981113



-Doug
