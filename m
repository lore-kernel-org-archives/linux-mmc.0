From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v2 0/4] eMMC DDR support
Date: Fri, 13 May 2011 11:17:14 +0530
Message-ID: <1305265638-1572-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64349 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab1EMFsA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 01:48:00 -0400
Received: by pvg12 with SMTP id 12so1016801pvg.19
        for <linux-mmc@vger.kernel.org>; Thu, 12 May 2011 22:48:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, zhangfei.gao@gmail.com, Arindam Nath <arindam.nath@amd.com>

V2
----
[PATCH 1/4]: Fixed tabbing for comment.
[PATCH 2/4]: Use switch-case instead of if-else.
[PATCH 3/4]: Use bool type for argument *cmd11* instead of int.

Philip Rakity (4):
  [PATCH 1/4]: sdhci add hooks for UHS setting by platform specific code
  [PATCH 2/4]: sdhci-pxa add platform specific code for UHS signaling
  [PATCH 3/4]: mmc eMMC signal voltage does not use CMD11
  [PATCH 4/4]: mmc add support for eMMC Dual Data Rate

 drivers/mmc/core/core.c      |   19 +++++--------------
 drivers/mmc/core/core.h      |    5 ++---
 drivers/mmc/core/mmc.c       |   35 ++++++++++++++++++++++++++++++-----
 drivers/mmc/core/sd.c        |    5 +++--
 drivers/mmc/host/sdhci-pxa.c |   41 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |   33 ++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h     |    2 ++
 include/linux/mmc/host.h     |    1 +
 8 files changed, 102 insertions(+), 39 deletions(-)

