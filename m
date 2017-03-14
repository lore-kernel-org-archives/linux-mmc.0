From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/4] mmc: tmio: properly report status from autocmd12
Date: Tue, 14 Mar 2017 11:09:15 +0100
Message-ID: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56238 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdCNKQB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Mar 2017 06:16:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

New in V3:

* rebased to v4.11-rc2 and retested
* added one more tag from Simon

New in V2:
* Fix some more comments in patch 2.
* Add Simon's tags

SDHI automatically sends CMD12 when the desired amount of data was transferred
after multi block commands. However, the response from that CMD12 was never
reported back to the mmc core, so that errors like ECC might go unnoticed. This
series aims to fix that and clean up minor issues on the way when dealing with
the autocmd12 feature. Testing documentation can be found here [1] and thanks
must go to Shimoda-san for additional testing. Actually handling the ECC errors
in the core is a seperate issue and I'll post a patch for it right after this.

The patches are based on mmc-next as of today. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-autocmd12-resp-v3

Thanks and all the best,

   Wolfram

[1] http://elinux.org/Tests:SDHI-autocmd12-responses

Wolfram Sang (4):
  mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
  mmc: host: tmio: fix minor typos in comments
  mmc: host: tmio: don't BUG on unsupported stop commands
  mmc: host: tmio: fill in response from auto cmd12

 drivers/mmc/host/tmio_mmc.h     | 10 +++++++---
 drivers/mmc/host/tmio_mmc_pio.c | 16 ++++++++++------
 2 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.11.0

