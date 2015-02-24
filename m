From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/4] Switch to 1-bit mode SDIO before disabling clocks.
Date: Tue, 24 Feb 2015 13:42:23 +1100
Message-ID: <20150224024023.22719.32436.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58527 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbbBXCnV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Feb 2015 21:43:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

This is a reworking of this code that I promised at the end of
January.

SDIO interrupt in 4-bit mode require the clock to be running.  So we
need to switch to 1-bit mode before turning off the clock.

This series provides infrastructure in mmc-core, and adds the
functionality to omap_hsmmc.

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

