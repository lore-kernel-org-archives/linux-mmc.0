From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 0/3] mmc: Add new MMC_CAP2_NO_SDIO cap
Date: Wed, 25 Nov 2015 12:28:44 +0100
Message-ID: <1448450927-13682-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35629 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbKYL3S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 06:29:18 -0500
Received: by wmuu63 with SMTP id u63so133808677wmu.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 03:29:17 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, hdegoede@redhat.com, linux-mmc@vger.kernel.org, drake@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>

From: Carlo Caione <carlo@endlessm.com>

Small patchset to add a new MMC_CAP2_NO_SDIO cap used to tell the mmc core to
skip the SDIO commands.

Drivers fix will follow.

Carlo Caione (3):
  mmc: Rename mmc_is_io_op to mmc_is_rw_io_op
  mmc: Add a new mmc_is_io_op helper function
  mmc: core: Introduce MMC_CAP2_NO_SDIO cap

 drivers/mmc/core/core.c     | 9 ++++++++-
 drivers/mmc/core/sdio_ops.h | 7 ++++++-
 include/linux/mmc/host.h    | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.5.0

