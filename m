From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/6] mmc: core: Enable mmc hosts to specify support for eMMC DDR 3.3V
Date: Wed, 25 Jan 2017 16:12:17 +0100
Message-ID: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33368 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdAYPMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:32 -0500
Received: by mail-lf0-f54.google.com with SMTP id x1so43801431lff.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:31 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

It's been reported that some mmc hosts don't support a VCCQ (signal voltage) of
1.8V for eMMC DDR mode, but instead only 3.3V. According to the JEDEC spec, an
eMMC card must support both if any, which makes the mmc host being the
potential limitation. Therefore, let's invent a new mmc cap, MMC_CAP_3_3V_DDR,
and a new corresponding DT binding, which tells whether 3.3V is supported for
the VCCQ.

In the context of these changes, I took the opportunity to make some clean-ups
of some related code.

Ulf Hansson (6):
  mmc: core: Remove redundant code in mmc_set_signal_voltage()
  mmc: core: Clarify usage of mmc_set_signal_voltage()
  mmc: core: Rename __mmc_set_signal_voltage() to
    mmc_set_signal_voltage()
  mmc: core: Invent MMC_CAP_3_3V_DDR
  mmc: dt: Document binding for eMMC DDR 3.3V I/O voltage support
  mmc: core: Extend mmc_of_parse() to check for mmc-ddr-3_3v

 Documentation/devicetree/bindings/mmc/mmc.txt |  1 +
 drivers/mmc/core/core.c                       | 19 ++++++-------------
 drivers/mmc/core/core.h                       |  4 ++--
 drivers/mmc/core/host.c                       |  2 ++
 drivers/mmc/core/mmc.c                        | 27 +++++++++++++++------------
 drivers/mmc/core/sd.c                         |  3 +--
 drivers/mmc/core/sdio.c                       |  3 +--
 include/linux/mmc/host.h                      | 21 ++++++++++-----------
 8 files changed, 38 insertions(+), 42 deletions(-)

-- 
1.9.1

