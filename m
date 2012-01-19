From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] Improve handling of card removal
Date: Thu, 19 Jan 2012 17:39:49 +0100
Message-ID: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:55775 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755323Ab2ASQkY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 11:40:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

These patches is based upon the patch recently pushed to the mmc mailing list:
mmc: core: Force a "detect" to handle non-properly removed cards

According to Adrian Hunters comment about adding a CAP2 flag to enable
this feature has been done.

Patch 2 depends on patch 1; but patch 1 can also be discussed separately.

Ulf Hansson (2):
  mmc: core: Prevent I/O as soon as possible at card removal
  mmc: core: Detect card removal on I/O error

 drivers/mmc/core/core.c  |   19 ++++++++++++++++---
 include/linux/mmc/host.h |    1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.5.4

