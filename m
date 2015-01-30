From: NeilBrown <neilb@suse.de>
Subject: [PATCH-v2 0/4] mmc: switch to 1-bit mode which stopping clocks.
Date: Sat, 31 Jan 2015 06:05:37 +1100
Message-ID: <20150130185742.20910.52715.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38676 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbbA3Wbp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Jan 2015 17:31:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

This is a new version which moves most of the code into
mmc/core so it is available to all drivers.

I was wrong about not being able to sleep in pm_runtime callbacks.
There are spinlocks, but not the ones I thought they were...

Anyway, I tried switching to 1-bit mode from within the
runtime_suspend callback and hit a different problem.
The sequence to switch to 1-bit involves calling set_ios
which, for omap_hsmmc at least, calls pm_runtime_get_sync().

Calling pm_runtime_get_sync from the runtime_suspend callback
deadlocks.

It would be possible to remove the pm_runtime_get_sync call
from set_ios() functions, and instead call host->enable(),
host->disable() around those mmc_set_ios() calls which don't
have the host claimed.  However that seems a bit fragile to me.

So for now I'm persisting with doing the width change from
a work-queue.  This set of patches does that.

If you think calling host->enable/disable around mmc_set_ios() calls
does make sense, I can post my other patch for review.

Thanks,
NeilBrown


---

NeilBrown (4):
      mmc: core: fold mmc_set_bus_width calls into sdio_enable_4bit_bus.
      mmc: core: allow non-blocking form of mmc_claim_host
      mmc: sdio: support switching to 1-bit before turning off clocks
      mmc: omap_hsmmc: switch to 1-bit before stopping clocks.


 drivers/mmc/core/core.c       |   21 +++++++++---
 drivers/mmc/core/sdio.c       |   74 +++++++++++++++++++++++++++++------------
 drivers/mmc/host/omap_hsmmc.c |   13 ++++++-
 include/linux/mmc/core.h      |    2 +
 include/linux/mmc/host.h      |    2 +
 5 files changed, 83 insertions(+), 29 deletions(-)

--
Signature

