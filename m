From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] brcmfmac: sdio: Deal better w/ transmission errors waking from sleep
Date: Fri, 17 May 2019 15:54:17 -0700
Message-ID: <20190517225420.176893-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Douglas Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, brcm80211-dev-list@cypress.com, YueHaibing <yuehaibing@huawei.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Martin Hicks <mort@bork.org>, Ritesh Harjani <riteshh@codeaurora.org>, Michael Trimarchi <michael@amarulasolutions.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Franky Lin <franky.lin@broadcom.com>, Jiong Wu <lohengrin1024@gmail.com>, brcm80211-dev-list.pdl@broadcom.com, "David S. Miller" <davem@>
List-Id: linux-mmc@vger.kernel.org

This series attempts to deal better with the expected transmission
errors that we get when waking up the SDIO-based WiFi on
rk3288-veyron-minnie, rk3288-veyron-speedy, and rk3288-veyron-mickey.

Some details about those errors can be found in
<https://crbug.com/960222>, but to summarize it here: if we try to
send the wakeup command to the WiFi card at the same time it has
decided to wake up itself then it will behave badly on the SDIO bus.
This can cause timeouts or CRC errors.

When I tested on 4.19 and 4.20 these CRC errors can be seen to cause
re-tuning.  Since I am currently developing on 4.19 this was the
original problem I attempted to solve.

On mainline it turns out that you don't see the retuning errors but
you see tons of spam about timeouts trying to wakeup from sleep.  I
tracked down the commit that was causing that and have partially
reverted it here.  I have no real knowledge about Broadcom WiFi, but
the commit that was causing problems sounds (from the descriptioin) to
be a hack commit penalizing all Broadcom WiFi users because of a bug
in a Cypress SD controller.  I will let others comment if this is
truly the case and, if so, what the right solution should be.


Douglas Anderson (3):
  brcmfmac: re-enable command decode in sdio_aos for BRCM 4354
  mmc: core: API for temporarily disabling auto-retuning due to errors
  brcmfmac: sdio: Disable auto-tuning around commands expected to fail

 drivers/mmc/core/core.c                       | 27 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/sdio.c        |  6 +++--
 include/linux/mmc/core.h                      |  2 ++
 include/linux/mmc/host.h                      |  1 +
 4 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
