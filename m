From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [PATCH v2 0/2] Auto BKOPS PM suspend
Date: Sun, 22 Jan 2017 11:15:33 +0200
Message-ID: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:18979
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751080AbdAVJbN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 22 Jan 2017 04:31:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, alex.lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

Resubmitting three patches for approval, originally submitted by Alex Lemberg <alex.lemberg@sandisk.com>
[1/3] mmc: replacing hardcoded value for runtime PM suspend(removed)
[2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support(changed)
[3/3] mmc: Checking BKOPS status prior to Suspend(changed)

Uri Yanai (2):
  mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
  mmc: Checking BKOPS status prior to Suspend

 drivers/mmc/core/mmc.c   | 37 +++++++++++++++++++++++++++++++------
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/mmc.h  |  1 +
 3 files changed, 33 insertions(+), 6 deletions(-)

-- 
1.9.1

