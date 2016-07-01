From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/3] Expose new mmc caps to DT
Date: Fri,  1 Jul 2016 15:45:27 +0800
Message-ID: <1467359130-11409-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


I sent a RFC patchset[0] to invent new caps for improving the initialization
of mmc core. And Ulf merged MMC_CAP2_NO_SD and improved it for the latest
patchset of sh_mmcif[1].

So we could continue to add MMC_CAP2_NO_MMC for a sd or a sdio slot not to
send MMC command during initialization if failing to probe the device.
Also I'm exposing these new caps to DT for the specific board to improve
the initialization.

>From the test, we can save nearly 2ms for attaching emmc against the
original 8ms. And we gain more than 30us improvement for sd card for
each insert.

[0]: http://thread.gmane.org/gmane.linux.kernel.mmc/37933
[1]: https://patchwork.kernel.org/patch/9190529/



Shawn Lin (3):
  mmc: core: Allow hosts to specify non-support for MMC commands
  mmc: core: expose MMC_CAP2_NO_* to dt
  Documentation: mmc: add description for new no-sd* and no-mmc

 Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
 drivers/mmc/core/core.c                       | 5 +++--
 drivers/mmc/core/host.c                       | 6 ++++++
 include/linux/mmc/host.h                      | 1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.3.7
