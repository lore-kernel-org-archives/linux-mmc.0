From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v2 0/2] mmc: tmio, renesas-sdhi: cleanups
Date: Thu, 15 Jun 2017 21:00:12 +0200
Message-ID: <1497553214-12914-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37137 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdFOTAZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 15:00:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this short series provides some cleanups to the tmio and renesas-sdhi
drivers to improve their checkpatch cleanness.

Changes since v1:
* Drop patches now present in mmc/next
* Address review - details noted in changelogs of each patch

Simon Horman (2):
  mmc: tmio: improve checkpatch cleanness
  mmc: renesas-sdhi: improve checkpatch cleanness

 drivers/mmc/host/renesas_sdhi.h          |  4 +-
 drivers/mmc/host/renesas_sdhi_core.c     | 43 +++++++--------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 25 +++++----
 drivers/mmc/host/tmio_mmc.c              |  8 +--
 drivers/mmc/host/tmio_mmc.h              | 17 +++---
 drivers/mmc/host/tmio_mmc_core.c         | 90 ++++++++++++++++++--------------
 include/linux/mfd/tmio.h                 | 33 ++++++------
 7 files changed, 120 insertions(+), 100 deletions(-)

-- 
2.1.4

