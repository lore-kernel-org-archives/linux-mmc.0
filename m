From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] mmc: Minimize resume time for sd/mmc
Date: Wed, 30 Nov 2011 16:55:32 +0100
Message-ID: <1322668534-10554-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:49774 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753992Ab1K3P4k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2011 10:56:40 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Typically an sd/mmc card takes around 200 - 1100 ms to
initialize when the power to the card has been cut, which
is what happens during a suspend/resume sequence.

All device's resume time adds up to the total kernel resume
time. Some use cases requires the kernel to be resumed fast,
to be able to meet deadlines. One use case example is WLAN
SOFT_AP, but there are certainly more.

This patch serie deferres the resume for mmc/sd cards into
a delayed work to be able to respond quickly on the suspend
request. Earlier the blkdev were issuing a set_blksize as a
part of the blkdev resume, which right now is removed since
it is not needed. In future, if other block sizes than 512
bytes is used, this needs to be re-implemented in a different
manner.

A deferred resume feature has been discussed on the mmc-list
previously but did not end up in a final patch/solution.

Ulf Hansson (2):
  mmc: block: Remove use of mmc_blk_set_blksize
  mmc: Minimize resume-time by deferring resume

 drivers/mmc/card/block.c |   35 +++++++++--------------------------
 drivers/mmc/core/core.c  |   36 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/host.c  |    1 +
 include/linux/mmc/host.h |   16 ++++++++++++++++
 5 files changed, 62 insertions(+), 27 deletions(-)

-- 
1.7.5.4

