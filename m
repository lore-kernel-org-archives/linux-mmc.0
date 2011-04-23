From: John Stultz <john.stultz@linaro.org>
Subject: [PATCH 0/6] Trivial MMC patches from Android
Date: Fri, 22 Apr 2011 18:01:36 -0700
Message-ID: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36482 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757065Ab1DWBBz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Apr 2011 21:01:55 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3N0pCIs003110
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 20:51:12 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p3N11sTX085162
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 21:01:54 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p3N11r8U010063
	for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2011 21:01:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Dima Zavin <dima@android.com>, Bentao Zou <bzou1@motorola.com>, David Ding <david.j.ding@motorola.com>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, Todd Poynor <toddpoynor@google.com>

I've recently spent some time looking through the Android tree,
and while there are some controversial interface changes, there
are also a number of patches which look to be simply fixes that
have not yet made it upstream. 

In order to make sure these fixes don't get overlooked, I'm trying
to filter out these small changes into narrowly scoped topic branches
then sending them out for review and comment.

Now, I'm not proposing that these changes be merged as-is. It
may very well be that, unknown to me, android developers have
already tried to submit these patches and they have been rejected
for good reason. Or some patches may very well be necessary hacks
to get thing shipping while deeper fixes are being worked on. If
that is the case, let me know and forgive me for the noise.

Authors: In many cases, the patches are lacking good commit
messages, so I cannot advocate for them very well. Your assistance
in answering questions that come up would be appreciated.

Maintainers: If you do find any of these patches distasteful,
that's fine, I'll be happy to drop them from my tree for now.
I really don't want to stir up another huge mail thread over these 
small patches, but I'd appreciate if you'd consider them as a
bug report illustrating an issue or a desired feature, and suggest 
what you see as a reasonable way to accomplish the desired
functionality presented in the patch.

The following patches are general MMC changes:

The first three look like fairly straightforward fixes.

The second three introduce a paranoid init option which retries
a few times on failure. The #ifdefs clearly need to be cleaned
up, but I wanted to send it out for comment on the basic
functionality.

You can also find the other trivial tree branches I'm working
on here (fair warning, I re-base this tree frequently): 
http://git.linaro.org/gitweb?p=people/jstultz/android-trivial.git;a=summary

thanks
-john

CC: Chris Ball <cjb@laptop.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Dima Zavin <dima@android.com>
CC: Bentao Zou <bzou1@motorola.com>
CC: David Ding <david.j.ding@motorola.com>
CC: San Mehat <san@google.com>
CC: Colin Cross <ccross@android.com>
CC: Todd Poynor <toddpoynor@google.com>


Colin Cross (1):
  mmc_block: Allow more than 8 partitions per card

David Ding (1):
  mmc: block: Resume multi-block reads after transient read errors.

San Mehat (3):
  mmc: sd: Add new CONFIG_MMC_PARANOID_SD_INIT for enabling retries
    during SD detection
  mmc: sd: When resuming, try a little harder to init the card
  mmc: sd: Add retries in re-detection

Todd Poynor (1):
  sdhci: Always pass clock request value zero to set_clock host op

 drivers/mmc/card/block.c |    9 ++---
 drivers/mmc/core/Kconfig |    9 +++++
 drivers/mmc/core/sd.c    |   84 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c |    2 +-
 4 files changed, 96 insertions(+), 8 deletions(-)

-- 
1.7.3.2.146.gca209

