From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v6 0/9] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Fri,  2 Sep 2016 13:17:29 +0200
Message-ID: <1472815058-11562-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39239 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbcIBLRz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 07:17:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
SDR-50 support to the same driver.

This series enables:
* UHS-I SDR-104 on the r8a7790/Lager where UHS-I SDR-50 is already enabled.
* Both UHS-1 SDR-50 and SDR-104 on the r8a7796/Salvator-X

It is based on a merge of the next branches of the mmc and renesas trees.

The "mmc:" patches are targeted at the next branch of the mmc
tree. The "ARM:" and "arm64:" patches are targeted at the next branch of
the renesas tree.

To aid review the following git branches are provided:
* https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-v6
  This patch set
* https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-v6+sdhi-dma-v3
  This patch set merged with a rebase of prototype DMA support for SDHI on
  R-Car Gen 3

Overview of changes since v5:
* Drop retune handling from tmio suspend handler: it hs handled by MMC core
* Allow restoration of saved tuning parameters on resume

Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
results.

Ai Kyuse (3):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add hw reset support
  mmc: tmio: Add tuning support

Simon Horman (5):
  mmc: core: Add helper to see if a host can be retuned
  mmc: tmio: document mandatory and optional callbacks
  mmc: sh_mobile_sdhi: Add tuning support
  ARM: dts: lager: Enable UHS-I SDR-104
  arm64: dts: r8a7795: salvator-x: Enable UHS-I SDR-104

Wolfram Sang (1):
  arm64: dts: r8a7795: salvator-x: enable UHS for SDHI 0 & 3

 arch/arm/boot/dts/r8a7790-lager.dts                |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  24 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 265 ++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h                        |  18 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |  93 +++++++-
 include/linux/mmc/host.h                           |   5 +
 6 files changed, 396 insertions(+), 10 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344

