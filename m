From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/7] mmc: sdio: Various fixes/improvements for SDIO PM
Date: Tue, 18 Jun 2019 17:34:41 +0200
Message-ID: <20190618153448.27145-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arend Van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The power management support implemented via system suspend/resume and runtime
suspend/resume for SDIO cards is rather messy, but also fragile.

This series makes some improvement to this code. In particular the so called
powered-on re-initialization of SDIO card is quite questionable, I suspect
it may never really worked well. Therefore this series removes this code, which
helps to prepare for additional improvements on top in a later series.

So far the series has only been compile tested, so any help in testing on HW for
regressions is greatly appreciated.

Kind regards
Uffe

Ulf Hansson (7):
  mmc: sdio: Turn sdio_run_irqs() into static
  mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
  mmc: sdio: Move comment about re-initialization to
    mmc_sdio_reinit_card()
  mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
  mmc: sdio: Don't re-initialize powered-on removable SDIO cards at
    resume
  mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
  mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()

 drivers/mmc/core/sdio.c     | 92 +++++++++++++++----------------------
 drivers/mmc/core/sdio_irq.c |  3 +-
 include/linux/mmc/host.h    |  1 -
 3 files changed, 38 insertions(+), 58 deletions(-)

-- 
2.17.1
