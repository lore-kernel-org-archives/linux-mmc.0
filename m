From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu,  3 Nov 2016 15:15:58 +0100
Message-ID: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
SDR-50 support to the same driver.

It is based on the next branch of the mmc tree.

To aid review the following git branch is provided:
* https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-driver-v8

Overview of changes since v7:
* Correct inverted logic in sh_mobile_sdhi_hw_reset
* Correct value of SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN

Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
results.


Ai Kyuse (3):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add hw reset support
  mmc: tmio: Add tuning support

Simon Horman (3):
  mmc: core: Add helper to see if a host can be retuned
  mmc: tmio: document mandatory and optional callbacks
  mmc: sh_mobile_sdhi: Add tuning support

 drivers/mmc/host/sh_mobile_sdhi.c | 265 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h       |  18 ++-
 drivers/mmc/host/tmio_mmc_pio.c   |  87 ++++++++++++-
 include/linux/mmc/host.h          |   5 +
 4 files changed, 367 insertions(+), 8 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
