From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] mmc: core: Extend runtime PM support for sd/mmc
Date: Fri, 11 Oct 2013 14:28:14 +0200
Message-ID: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:44918 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab3JKM2f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2013 08:28:35 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so3280593lab.40
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2013 05:28:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

This patchset is step by step improving support for runtime PM in the mmc core
layer for sd and mmc. The sequence for how to handle suspend/resume while using
MMC_CAP_AGGRESSIVE_PM is now optimized to only perform actions when needed and
thus improving especially the suspend time. 

The two first patches has been sent earlier to the mmc-list, but for convenience
I have decided to fold them in here instead. The old versions of these can be
dropped.

The final patch is adding a new host cap, MMC_CAP_RUNTIME_RESUME, which means
the resume is moved to be finalized at the runtime_resume. Using this feature
will have great impact on the total resume time for the platform.

Patches has been tested on ux500, using a various of combination of
MMC_CAP_RUNTIME_RESUME, MMC_CAP_AGGRESSIVE_PM and MMC_CAP_NONREMOVABLE. The
needed CONFIG_MMC_UNSAFE_RESUME has also been set.

Ulf Hansson (4):
  mmc: Don't force card to active state when entering suspend/shutdown
  mmc: core: Remove redundant mmc_power_up|off at runtime callbacks
  mmc: core: Improve runtime PM support during suspend/resume for
    sd/mmc
  mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume

 drivers/mmc/card/block.c |    2 -
 drivers/mmc/core/mmc.c   |   94 ++++++++++++++++++++++++++++++++--------------
 drivers/mmc/core/sd.c    |   79 ++++++++++++++++++++++++++------------
 include/linux/mmc/card.h |    4 ++
 include/linux/mmc/host.h |    1 +
 5 files changed, 125 insertions(+), 55 deletions(-)

-- 
1.7.9.5

