From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 0/3] mmc: Fixup HW reset for SDIO cards
Date: Tue, 12 Nov 2019 13:40:18 +0100
Message-ID: <20191112124021.8718-1-ulf.hansson@linaro.org>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Wen Gong <wgong-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Erik Stromdahl <erik.stromdahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Changes in v3:
	- Added tags.
	- Drop unnecessary initialization of variable.
	- Rename adapter->is_adapter_up to adapter->is_up in the mwifiex driver.

Changes in v2:
	- Add adaptations to the mwifiex driver.
	- Keep existing synchronous reset behaviour if the SDIO card has a
	single func driver.

The cover-letter from v2:

It has turned out that it's not a good idea to try to power cycle and to
re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
because there may be multiple SDIO funcs attached to the same SDIO card and
some of the others that didn't execute the call to mmc_hw_reset(), may then
simply experience an undefined behaviour.

The following patches in this series attempts to address this problem, by
reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
mwifiex driver to these changes.

Note that, I don't have the HW at hand so the the code has only compile tested.
Test on HW is greatly appreciated!


Ulf Hansson (3):
  mwifiex: Re-work support for SDIO HW reset
  mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
  mmc: core: Re-work HW reset for SDIO cards

 drivers/mmc/core/core.c                     | 12 +++-----
 drivers/mmc/core/core.h                     |  2 ++
 drivers/mmc/core/sdio.c                     | 28 ++++++++++++++++-
 drivers/mmc/core/sdio_bus.c                 |  9 +++++-
 drivers/net/wireless/marvell/mwifiex/main.c |  5 +++-
 drivers/net/wireless/marvell/mwifiex/main.h |  1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c | 33 ++++++++++++++-------
 include/linux/mmc/card.h                    |  1 +
 8 files changed, 69 insertions(+), 22 deletions(-)

-- 
2.17.1
