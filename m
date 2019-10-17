From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] mmc: core: Fixup HW reset for SDIO cards
Date: Thu, 17 Oct 2019 15:57:37 +0200
Message-ID: <20191017135739.1315-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following two patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO.

Note that, the code has only compile tested, so any test on HW is greatly
appreciated.

Kind regards
Uffe


Ulf Hansson (2):
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c | 10 +++-------
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sdio.c | 11 +++++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.17.1
