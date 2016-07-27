From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v4 0/4] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Wed, 27 Jul 2016 13:13:19 +0900
Message-ID: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41249 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcG0ENn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 00:13:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org


Hi,

this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
SDR-50 support to the same driver.

This series enables UHS-I SDR-104 on the r8a7790/Lager where
UHS-I SDR-50 is already enabled.

It is based on the next branch of the mmc tree

The first three mmc driver patches are targeted at the next branch of the mmc
tree. The last DT patch is targeted at the devel branch of the renesas tree.

To aid review this series is provided in the temporary topic/sdr104-v4 branch
of the renesas tree.

Changes since previous versions are described in individual patches.

In this patchset I have attempted to address all review received
for the v3 patch-set. I also believe that I have resolved a problem
where tuning would timeout under some circumstances: this seems to
have been due to several bugs introduced between v1 and v3.


Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
results. Highlights follow:

* Currently I am seeing speeds of up to 48MB/s with these patches and
  30MB/s without using a SanDisk Extreme Pro 8Gb microSDHC UHS-1 card.

* I am also seeing 45MB/s with these patches and 34MB/s without using
  a SanDisk Ultra 64Gb microSDXC UHS-1 card.

The above results are the same as previously reported for v2 and v3 of
this patchset.

Ai Kyuse (2):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add tuning support

Simon Horman (2):
  mmc: sh_mobile_sdhi: Add tuning support
  ARM: dts: r8a7790: lager: Enable UHS-I SDR-104

 arch/arm/boot/dts/r8a7790-lager.dts |   1 +
 drivers/mmc/host/sh_mobile_sdhi.c   | 264 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h         |   7 +
 drivers/mmc/host/tmio_mmc_pio.c     |  92 ++++++++++++-
 4 files changed, 357 insertions(+), 7 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344

