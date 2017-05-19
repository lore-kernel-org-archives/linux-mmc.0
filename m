From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/6] tmio/sdhi: add cmd23 support
Date: Fri, 19 May 2017 15:31:49 +0200
Message-ID: <20170519133155.22945-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46662 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755574AbdESNcE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 May 2017 09:32:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

This series adds CMD23 support to SDHI. It was tested on H2 (Gen2, Lager) and
M3W (Gen3, Salvator-X). The test procedure can be found here:

http://elinux.org/Tests:SDHI-CMD23

Patches are based on mmc/next from today. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-cmd23

Changes since RFC:

* rebased on top of Simon's DMA rework now in mmc/next
* added Geerts tags
* cosmetic change in patch 6, put new capability in a separate line

Thanks,

   Wolfram


Wolfram Sang (6):
  mmc: tmio: make tmio_mmc_request function more readable
  mmc: tmio: refactor handling mrq
  mmc: tmio: remove outdated comment
  mmc: tmio: move finish_request function further down
  mmc: tmio: add CMD23 support
  mmc: sdhi: add CMD23 support to R-Car Gen2 & Gen3

 drivers/mmc/host/renesas_sdhi_sys_dmac.c |   6 +-
 drivers/mmc/host/tmio_mmc_core.c         | 135 ++++++++++++++++++-------------
 2 files changed, 82 insertions(+), 59 deletions(-)

-- 
2.11.0

