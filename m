From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/2] Avoid system abort by move pm domain's detach after devres_release_all
Date: Wed, 30 Aug 2017 09:34:25 +0800
Message-ID: <1504056867-199188-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


CONFIG_DEBUG_SHIRQ will fire extra irq action to call the registered
irq callback after driver is removed or failed to probe. In general,
the irq callback provided by driver should read its internal registers
to see who fires the irq. So this leads a situation that we access the
registers with a powered-off pm domain that the system abort. This is
a system-wide issue may break lots of drivers, IMHO.

dwmmc driver is one of them suffered from this, please see the commit
message of patch 2 for how that happened.

I haven't find a proper way to freeze the genpd_power_off_work_fn
and fire it again when finish devres_release_all indeed. And it
seems to me that device's pm domain detach is always called when
failing to probe or removing the driver. So I have to cook patch 1
to see if folks think this's the best way to fix that, otherwise we may
need to fix it everywhere for other drivers.


Changes in v3:
- fix the code path for consolidating the attach for both of driver
  and bus driver, and then move detach to the error path
- rework the changelog
- include a driver core change to fix the genpd issue.

Shawn Lin (2):
  driver core: detach device's pm_domain after devres_release_all
  mmc: dw_mmc: fix potential system abort if activating
    CONFIG_DEBUG_SHIRQ

 drivers/base/dd.c         | 16 ++++++++++++++++
 drivers/base/platform.c   | 18 ++----------------
 drivers/mmc/host/dw_mmc.c | 48 +++++++++++++++++++++++------------------------
 3 files changed, 41 insertions(+), 41 deletions(-)

-- 
1.9.1
