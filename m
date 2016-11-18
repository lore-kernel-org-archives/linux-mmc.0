From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] More MMC block core cleanup
Date: Fri, 18 Nov 2016 13:36:13 +0100
Message-ID: <1479472576-2687-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35294 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKRMgZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 07:36:25 -0500
Received: by mail-wm0-f51.google.com with SMTP id a197so35531178wmd.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 04:36:24 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

The more I dig the more I find. These are pretty straight-forward
and should be possible to merge right off.

Linus Walleij (3):
  mmc: block: use mmc_req_is_special()
  mmc: block: rename data to blkdata
  mmc: block: move packed command struct init

 drivers/mmc/card/block.c | 67 ++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/card/queue.c | 43 -------------------------------
 drivers/mmc/card/queue.h |  6 ++---
 3 files changed, 56 insertions(+), 60 deletions(-)

-- 
2.7.4

