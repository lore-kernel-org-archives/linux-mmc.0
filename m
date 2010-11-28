From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 0/3] SDIO suspend/resume optimizations
Date: Sun, 28 Nov 2010 07:21:27 +0200
Message-ID: <1290921690-6133-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57371 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0K1FTn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Nov 2010 00:19:43 -0500
Received: by fxm15 with SMTP id 15so1617040fxm.19
        for <linux-mmc@vger.kernel.org>; Sat, 27 Nov 2010 21:19:42 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Remove redundant power and card reinitialization cycles involved with
SDIO suspend/resume transitions, especially when interacting with SDIO
runtime PM.

As a result, suspend/resume latencies are reduced and battery life is
improved.

I have not done any latencies or power measurements, but I am pretty
certain the numbers will not be very big.

Having said that, common mobile platform (such as Android and OLPC) are
aggressively utilizing full system suspend in order to save as much energy
as possible.

In those systems, suspend/resume transitions happen very frequently,
and even small enhancements, as presented in this patchset, may eventually
deem substantial.

Please note that these changes should be completely safe on all environment.

Patches have passed overnight stress with the script mentioned at:
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg03923.html

PS - I'm going on a plane and will not have Internet access so apologies
for belated replies.

Ohad Ben-Cohen (3):
  mmc: skip detection of nonremovable cards on rescan
  mmc: sdio: don't reinitialize nonremovable powered-resumed cards
  mmc: sdio: don't power up cards on system suspend

 drivers/mmc/core/core.c     |   21 +++++++++++++++++++--
 drivers/mmc/core/sdio.c     |   16 ++++++++++++++--
 drivers/mmc/core/sdio_bus.c |   32 --------------------------------
 include/linux/mmc/host.h    |    5 +++++
 4 files changed, 38 insertions(+), 36 deletions(-)

