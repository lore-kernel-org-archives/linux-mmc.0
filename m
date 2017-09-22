From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 0/4] use setup_timer() helper function.
Date: Fri, 22 Sep 2017 17:37:22 +0530
Message-ID: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38618 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdIVMHd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:07:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id m30so520632pgn.5
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 05:07:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

This series uses setup_timer() helper function. The series
addresses the files under drivers/mmc/host/*.


Allen Pais (4):
  mmc-host: wbsd: use setup_timer() helper.
  mmc-host: via: use setup_timer() helper.
  mmc-host: vub300: use setup_timer() helper.
  mmc-host: mxcmmc: use setup_timer() helper.

 drivers/mmc/host/mxcmmc.c    |  4 +---
 drivers/mmc/host/via-sdmmc.c |  4 +---
 drivers/mmc/host/vub300.c    | 10 ++++------
 drivers/mmc/host/wbsd.c      |  5 ++---
 4 files changed, 8 insertions(+), 15 deletions(-)

-- 
2.7.4

