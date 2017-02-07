From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [v3 0/3] Auto BKOPS PM suspend
Date: Tue, 7 Feb 2017 17:59:59 +0200
Message-ID: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:18411 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbdBGQBC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 11:01:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

Flash based storage devices might need to perform the internal
Background Operations (BKOPS) in order to insure better performance
for the next coming IO.
Following the discussion in the mmc thread:
www.spinics.net/lists/linux-mmc/msg37779.html
To let the device complete its BKOPS during Runtime Suspend,
we suggest to check the BKOPS level.
In case the device need to complete its BKOPS, reschedule the Runtime
Suspend.

This patches replaces original patches submitted by Alex Lemberg <alex.lemberg@sandisk.com>
[1/3] mmc: replacing hardcoded value for runtime PM suspend(patch removed)
[2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support(made changes)
[3/3] mmc: Checking BKOPS status prior to Suspend(made changes)

Uri Yanai (3):
  mmc: MAN_BKOPS_EN inverse debug message logic
  mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
  mmc: Checking BKOPS status prior to Suspend

 drivers/mmc/core/mmc.c   | 40 +++++++++++++++++++++++++++++++++-------
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/mmc.h  |  1 +
 3 files changed, 35 insertions(+), 7 deletions(-)

-- 
1.9.1

