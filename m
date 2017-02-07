From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/5] Some small cleanup for quirks
Date: Tue,  7 Feb 2017 16:27:20 +0800
Message-ID: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:38622 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdBGI3l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 03:29:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


I just see the we put them everywhere, so the legacy code
should be improved a bit for maintainability, especially for
the sdio quirks case. Just split them into small patches to be
better reviewed but I don't mind to squash them up. :)



Shawn Lin (5):
  mmc: core: change quirks.c to be a header file
  mmc: core: move some sdio IDs out of quirks file
  mmc: core: improve the quirks for sdio devices
  mmc: core: move all quirks together into quirks.h
  mmc: core: add mmc prefix for blk_fixups

 drivers/mmc/core/Makefile    |   2 +-
 drivers/mmc/core/block.c     |  77 +----------------------
 drivers/mmc/core/card.h      |   2 -
 drivers/mmc/core/mmc.c       |  12 +---
 drivers/mmc/core/quirks.c    |  85 -------------------------
 drivers/mmc/core/quirks.h    | 145 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio.c      |   3 +-
 include/linux/mmc/sdio_ids.h |   7 +++
 8 files changed, 158 insertions(+), 175 deletions(-)
 delete mode 100644 drivers/mmc/core/quirks.c
 create mode 100644 drivers/mmc/core/quirks.h

-- 
1.9.1


