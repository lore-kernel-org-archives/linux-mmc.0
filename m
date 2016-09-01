From: alex lemberg <alex.lemberg@sandisk.com>
Subject: [PATCH 0/3] mmc: Check BKOPS Level On Runtime Suspend
Date: Thu, 1 Sep 2016 17:24:47 +0300
Message-ID: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:1632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932896AbcIAPB0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 11:01:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: avi.shchislowski@sandisk.com, alex lemberg <alex.lemberg@sandisk.com>

Flash based storage devices might need to perform the internal
Background Operations (BKOPS) in order to insure better performance
for the next coming IO.
Following the discussion in the mmc thread:
www.spinics.net/lists/linux-mmc/msg37779.html
To let the device complete its BKOPS during Runtime Suspend,
we suggest to check the BKOPS level.
In case the device need to complete its BKOPS, reschedule the Runtime
Suspend.

alex lemberg (3):
  mmc: replacing hardcoded value for runtime PM suspend
  mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
  mmc: Checking BKOPS status prior to Suspend

 drivers/mmc/card/block.c |  3 ++-
 drivers/mmc/core/mmc.c   | 36 +++++++++++++++++++++++++++++-------
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/host.h |  2 ++
 include/linux/mmc/mmc.h  |  2 ++
 5 files changed, 36 insertions(+), 8 deletions(-)

-- 
1.9.1

