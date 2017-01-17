From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [PATCH 0/3] Auto BKOPS PM suspend
Date: Tue, 17 Jan 2017 14:15:34 +0200
Message-ID: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:59424
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750967AbdAQMPx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Jan 2017 07:15:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, chris@printf.net, alex.lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>

Hi Ulf
Resubmitting three patches for approval, originally submitted by Alex Lemberg <alex.lemberg@sandisk.com>
[1/3] mmc: replacing hardcoded value for runtime PM suspend  		Message ID:<1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
[2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support		Message ID:<1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
[3/3] mmc: Checking BKOPS status prior to Suspend 			Message ID:<1472739890-3384-4-git-send-email-alex.lemberg@sandisk.com>

Thanks
Uri Yanai

Uri Yanai (3):
  mmc: replacing hardcoded value for runtime PM suspend
  mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
  mmc: Checking BKOPS status prior to Suspend

 drivers/mmc/core/block.c |  3 ++-
 drivers/mmc/core/mmc.c   | 45 ++++++++++++++++++++++++++++++++++++---------
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/host.h |  2 ++
 include/linux/mmc/mmc.h  |  3 +++
 5 files changed, 44 insertions(+), 10 deletions(-)

-- 
1.9.1

