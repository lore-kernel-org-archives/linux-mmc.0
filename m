From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v7 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 13 Sep 2016 12:56:09 +0200
Message-ID: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
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

It is based on a merge of the next branches of the mmc tree.

To aid review the following git branch is provided:
* https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-driver-v7

Overview of changes since v6:
* Address review by Ulf
  - Detailed in per-patch changelogs
* Move integration (arm/arm64 dt) patches to separate patchset

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
