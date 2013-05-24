From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 0/8] sdhci: Move real work out of an atomic context
Date: Fri, 24 May 2013 18:00:34 +0200
Message-ID: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35665 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755292Ab3EXQBc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>

Hi all,

Currently the sdhci driver does everything in the atomic context.
And what is worse, PIO transfers are made from the IRQ handler.

Some patches were already submitted to solve this issue. But there were 
rejected because they involved new issues.

This set of patches is an evolution of an old patch from Anton Vorontsov.
I tried to fix all the problems involved by the patches. I tested it for 
several time now with SD cards and SDIO.

So, this patch set reworks sdhci code to avoid atomic context,
almost completely.

Thanks,

Jeremie Samuel

Jeremie Samuel (8):
  sdhci: Turn timeout timer into delayed work
  sdhci: Turn tuning timeout timer into delayed work
  sdhci: Use work structs instead of tasklets
  sdhci: Use threaded IRQ handler
  sdhci: Delay led blinking
  sdhci: Turn host->lock into a mutex
  sdhci: Get rid of mdelay()s where it is safe and makes sense
  sdhci: Use jiffies instead of a timeout counter

 drivers/mmc/host/sdhci.c  |  327 ++++++++++++++++++++++-----------------------
 include/linux/mmc/sdhci.h |   13 +-
 2 files changed, 168 insertions(+), 172 deletions(-)

-- 
1.7.10.4

