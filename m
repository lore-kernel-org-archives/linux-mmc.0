From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 00/12] add support for sd host controller v3.00
Date: Tue, 15 Feb 2011 15:04:58 +0530
Message-ID: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58882 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab1BOJgE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 04:36:04 -0500
Received: by iyj8 with SMTP id 8so5729218iyj.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 01:36:04 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

The patches below add support for Host Controller v3.00 as per the
spec v3.00. It also adds support for UHS-I cards as per Physical
Layer Specification v3.01.

Thanks for review.

Regards,
Arindam

Arindam Nath (12):
  [PATCH 01/12] mmc: sdhci: add support for auto CMD23
  [PATCH 02/12] mmc: sd: add support for signal voltage switch procedure
  [PATCH 03/12] mmc: sd: query function modes for uhs cards
  [PATCH 04/12] mmc: sd: add support for driver type selection
  [PATCH 05/12] mmc: sdhci: reset sdclk before setting high speed enable
  [PATCH 06/12] mmc: sd: add support for uhs bus speed mode selection
  [PATCH 07/12] mmc: sd: set current limit for uhs cards
  [PATCH 08/12] mmc: sd: report correct speed and capacity of uhs cards
  [PATCH 09/12] mmc: sd: add support for tuning during uhs initialization
  [PATCH 10/12] mmc: sdhci: enable preset value after uhs initialization
  [PATCH 11/12] mmc: sdhci: add support for programmable clock mode
  [PATCH 12/12] mmc: sdhci: add support for retuning mode 1

 drivers/mmc/core/bus.c    |   11 +-
 drivers/mmc/core/core.c   |    9 +
 drivers/mmc/core/core.h   |    1 +
 drivers/mmc/core/sd.c     |  420 +++++++++++++++++++++++++---
 drivers/mmc/core/sd.h     |    3 +-
 drivers/mmc/core/sd_ops.c |   25 ++
 drivers/mmc/core/sd_ops.h |    1 +
 drivers/mmc/core/sdio.c   |    3 +-
 drivers/mmc/host/sdhci.c  |  692 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h  |   45 +++-
 include/linux/mmc/card.h  |   43 +++
 include/linux/mmc/host.h  |   24 ++
 include/linux/mmc/mmc.h   |    1 +
 include/linux/mmc/sd.h    |    3 +-
 include/linux/mmc/sdhci.h |   11 +
 15 files changed, 1200 insertions(+), 92 deletions(-)

