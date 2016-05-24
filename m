From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 0/4] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 24 May 2016 11:43:13 +0900
Message-ID: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
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

This series enables UHS-I SDR-104 on the r8a7790/Lager where
UHS-I SDR-50 is already enabled.

It is based on a merge of:
* The next branch of the mmc tree
* The renesas-next-20160427v2-v4.6-rc1 tag of the renesas tree
* The sh-pfc-for-v4.7-tag1 tag of the renesas-drivers tree

The first two mmc driver patches are targeted at the next branch of the mmc
tree. The last DT patch is targeted at the devel branch of the renesas tree.

To aid review this series is provided in the _temporary_ topic/sdr104-v3 branch
of the renesas tree.


Changes since v1 and v2 are described in individual patches.


Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
results. Highlights follow:

* Currently I am seeing speeds of up to 48MB/s with these patches and
  30MB/s without using a SanDisk Extreme Pro 8Gb microSDHC UHS-1 card.
  I have not previously reported results for this card.

* I am also seeing 45MB/s with these patches and 34MB/s without using
  a SanDisk Ultra 64Gb microSDXC UHS-1 card.  In conjunction with v1 of
  this patchset I reported a speed of 39MB/s for this card with those patches.


Ai Kyuse (3):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add tuning support
  mmc: sh_mobile_sdhi: Add tuning support

Simon Horman (1):
  ARM: dts: r8a7790: lager: Enable UHS-I SDR-104

 arch/arm/boot/dts/r8a7790-lager.dts |   1 +
 drivers/mmc/host/sh_mobile_sdhi.c   | 203 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h         |   6 ++
 drivers/mmc/host/tmio_mmc_pio.c     | 100 ++++++++++++++++--
 4 files changed, 302 insertions(+), 8 deletions(-)

-- 
2.1.4
