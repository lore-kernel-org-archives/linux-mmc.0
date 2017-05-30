From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 0/5] mmc: tmio, renesas-sdhi: cleanups
Date: Tue, 30 May 2017 14:50:49 +0200
Message-ID: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55977 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdE3MvH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2017 08:51:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this short series provides some cleanups to the tmio and renesas-sdhi
drivers.

* Update files listed in MAINTAINERS
* Consistently use EXPORT_SYMBOL_GPL
* Update Renesas related copyrights
* Improve checkpatch cleanness

Simon Horman (5):
  MAINTAINERS: Update files for TMIO/SDHI MMC driver
  mmc: tmio: use EXPORT_SYMBOL_GPL
  mmc: tmio, renesas-sdhi: update Renesas related copyrights
  mmc: tmio: improve checkpatch cleanness
  mmc: renesas-sdhi: improve checkpatch cleanness

 MAINTAINERS                              |   2 +-
 drivers/mmc/host/renesas_sdhi.h          |   4 +-
 drivers/mmc/host/renesas_sdhi_core.c     |  53 +++++++-----
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  28 ++++---
 drivers/mmc/host/tmio_mmc.c              |  10 ++-
 drivers/mmc/host/tmio_mmc.h              |  22 +++--
 drivers/mmc/host/tmio_mmc_core.c         | 139 ++++++++++++++++++-------------
 include/linux/mfd/tmio.h                 |  33 ++++----
 8 files changed, 167 insertions(+), 124 deletions(-)

-- 
2.1.4

