From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 0/7] r8a7790: add UHS-I (SDR50) support to Lager
Date: Fri, 19 Feb 2016 21:16:36 +0100
Message-ID: <1455913003-6140-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40781 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1949378AbcBSURJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Feb 2016 15:17:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

So, I rebased and updated the series from Ben to latest renesas-driver and made
it run on my Lager board. I verified that the voltage switching was done. The
transfer speed of my UHS-I card went from 10 MB/s up to 29 MB/s which is the
upper limit of this card. Will try a faster one next week.

The SDHI patches only needed slight modifications due to the rebase. The PFC
patch needed some more rework, but luckily things have gotten easier since back
then, because we can reuse new macros added for bias support. There is one
question regarding this patch, see the comment there. This question is the
reason why the series is RFC because I'd like to hear your opinions there.

Regarding the MMC subsystem, I'd like to ask if it is okay to name the second
pinctrl binding (for uhs) simply "1v8". Is this name driver specific or shall
we aim for a generic name which is used amongst all drivers?

Thanks and happy hacking,

   Wolfram


Ben Hutchings (6):
  mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to clk_{enable,disable} ops
  mmc: tmio, sh_mobile_sdhi: Add support for variable input clock frequency
  mmc: tmio: Add UHS-I mode support
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
  ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50

Wolfram Sang (1):
  pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI

 arch/arm/boot/dts/r8a7790-lager.dts  |  22 ++++++-
 arch/arm/boot/dts/r8a7790.dtsi       |   4 ++
 drivers/mmc/host/sh_mobile_sdhi.c    | 123 ++++++++++++++++++++++++++++++++---
 drivers/mmc/host/tmio_mmc.h          |   9 ++-
 drivers/mmc/host/tmio_mmc_pio.c      |  57 +++++++++++-----
 drivers/pinctrl/sh-pfc/core.c        |   2 +-
 drivers/pinctrl/sh-pfc/core.h        |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  60 ++++++++++++++++-
 8 files changed, 249 insertions(+), 29 deletions(-)

-- 
2.7.0

