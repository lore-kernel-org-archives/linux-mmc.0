From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/4] tmio/sdhi: use max sd_buf size & clean header file before
Date: Fri, 30 Jun 2017 12:56:45 +0200
Message-ID: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34630 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdF3K5O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Jun 2017 06:57:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa@the-dreams.de>

The main patch is patch 4 which uses the maximum sd_buf size, i.e. 32 bit on
Gen2 and 64 bit on Gen3. Instead of a new flag, we use the bus_shift
information we already have. See the patch description for details.

Before fixing this, I wanted to remove a magic value in that function which is
done in patch 3.

When adding the new define, I noticed that some description is missing in the
header which is fixed with patch 2.

When adding the description, I noticed this meanwhile obsolete define which
gets removed in patch 1.

That's the way it went :)

Tested on Salvator-X/M3-W and Lager/H2.

Regards,

   Wolfram

Wolfram Sang (4):
  mmc: tmio: remove obsolete TMIO_BBS
  mmc: tmio: add references to bit defines in the header
  mmc: tmio: no magic values when enabling DMA
  mmc: sdhi: use maximum width for the sdbuf register

 drivers/mmc/host/renesas_sdhi_core.c | 5 ++---
 drivers/mmc/host/tmio_mmc.h          | 7 +++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.11.0

