From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 0/4] power management support for SDIO cards
Date: Wed, 02 Sep 2009 14:37:22 -0400
Message-ID: <1251916646-3537-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:47934 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZIBSie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2009 14:38:34 -0400
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPC0068ZX3NZH50@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 02 Sep 2009 14:38:11 -0400 (EDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This series is the core changes needed to support suspend/resume with
SDIO cards, and allow for special power management features needed to
implement things like the equivalent of wake-on-land for SDIO wireless
cards.  Further patches will eventually be posted for the SDHCI driver
and for the Libertas driver.

[PATCH 1/4] [MMC] core SDIO suspend/resume support
[PATCH 2/4] [MMC] propagate error codes back from bus drivers' suspend/resume methods
[PATCH 3/4] [MMC] make SDIO device/driver struct accessors public
[PATCH 4/4] [MMC] introduce API for special power management features


 drivers/mmc/core/core.c       |   45 +++++-
 drivers/mmc/core/core.h       |    4 +-
 drivers/mmc/core/mmc.c        |   15 +--
 drivers/mmc/core/sd.c         |   15 +--
 drivers/mmc/core/sdio.c       |  278 ++++++++++++++++++++++++-----------
 drivers/mmc/core/sdio_bus.c   |    3 -
 drivers/mmc/core/sdio_io.c    |   49 ++++++
 include/linux/mmc/host.h      |    5 +
 include/linux/mmc/pm.h        |   30 ++++
 include/linux/mmc/sdio_func.h |    8 +
 10 files changed, 329 insertions(+), 123 deletions(-)


Nicolas

