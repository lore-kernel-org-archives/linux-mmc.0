From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/4] mmc: host: tmio: properly report status from autocmd12
Date: Mon, 13 Feb 2017 19:03:38 +0100
Message-ID: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53470 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751472AbdBMSDv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Feb 2017 13:03:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

New in V2:
* Fix some more comments in patch 2.
* Add Simon's tags

SDHI automatically sends CMD12 when the desired amount of data was transferred
after multi block commands. However, the response from that CMD12 was never
reported back to the mmc core, so that errors like ECC might go unnoticed. This
series aims to fix that and clean up minor issues on the way when dealing with
the autocmd12 feature. So far, I could only test that the success case was
reported back to the MMC core [1]. An error case (like ECC) could not be
created yet, but I will keep on trying. However, the initial flaw of the CMD12
response not reported back is fixed with this series as the success case
demonstrates. If an ECC error is not properly handled, it is a seperate issue
anyway. So, I think this series could go in now. No pressure for 4.11, though.
But would be nice, of course ;)

The patches are based on mmc-next as of today. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-autocmd12-resp

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

