From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC 0/4] mmc: host: tmio: properly report status from autocmd12
Date: Tue,  7 Feb 2017 12:06:25 +0100
Message-ID: <20170207110629.2441-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

SDHI automatically sends CMD12 when the desired amount of data was transferred
after multi block commands. However, the response from that CMD12 was never
reported back to the mmc core, so that errors like ECC might go unnoticed. This
series aims to fix that and clean up minor issues on the way when dealing with
the autocmd12 feature. It is marked as RFC because, so far, I could only test
that the success case was reported back to the MMC core. An error case (like
ECC) could not be created yet. But people inside Renesas will try some SD
tester soon, and I also will keep writing GB to an 64MB cards until wear level
problems kick in (though, I have to admit, I am trying this for days now and my
trust in lifetimes of SD cards has significantly increased since). I wanted to
present the patches early in case other parties are interested in testing, too.

The patches are based on mmc-next. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-autocmd12-resp

Thanks and all the best,

   Wolfram


Wolfram Sang (4):
  mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
  mmc: host: tmio: fix minor typos in a comment
  mmc: host: tmio: don't BUG on unsupported stop commands
  mmc: host: tmio: fill in response from auto cmd12

 drivers/mmc/host/tmio_mmc.h     |  6 +++++-
 drivers/mmc/host/tmio_mmc_pio.c | 16 ++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.11.0
