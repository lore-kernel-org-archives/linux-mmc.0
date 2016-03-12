From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 00/10] r8a7790: add UHS-I (SDR50) support to Lager
Date: Sat, 12 Mar 2016 10:15:02 +0100
Message-ID: <1457774112-16958-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48779 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbcCLJPa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Mar 2016 04:15:30 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@gmail.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>

So, here is finally the series adding SDR50 support to the Renesas Lager board.
The previous series worked fine with my Transcend card, but failed to switch
voltages on a SanDisk and Samsung card. This bug hunting resulted in patches
5-7 newly added: The clock really has to be disabled on ios->clock == 0,
setting frequency to 0Hz doesn't work. I wonder if this isn't true for some
more controllers?

Changes since RFC are described in the individual patches. I think I addressed
all comments, either by code changes or by replying in the RFC thread why I
chose to decline the suggestion :)

My "copy-large-files-around"-setup showed now 30MB/s while it had 19MB/s
without SDR50. Frankly, I hoped for a little more, but let's start with this
initial support and do the tuning incrementally I'd say.

Patch 1 should go via Geert. Patches 2-8 should go via Ulf. They don't depend
on each other. After those patches went in, Simon can take 9+10 to tie it all
together. I'd say this is 4.7 material.

Please comment, test, apply...

Thanks,

   Wolfram


Ben Hutchings (4):
  mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to clk_{enable,disable} ops
  mmc: tmio, sh_mobile_sdhi: Add support for variable input clock frequency
  ARM: shmobile: r8a7790: Set maximum frequencies for SDHI clocks
  ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50

Wolfram Sang (6):
  pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
  mmc: tmio: Add UHS-I mode support
  mmc: tmio: always start clock after frequency calculation
  mmc: tmio: stop clock when 0Hz is requested
  mmc: host: add note that set_ios needs to handle 0Hz properly
  mmc: sh_mobile_sdhi: Add UHS-I mode support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   3 +
 arch/arm/boot/dts/r8a7790-lager.dts                |  22 +++-
 arch/arm/boot/dts/r8a7790.dtsi                     |   4 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 115 +++++++++++++++++++--
 drivers/mmc/host/tmio_mmc.h                        |   8 +-
 drivers/mmc/host/tmio_mmc_pio.c                    | 110 +++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |  54 +++++++++-
 include/linux/mmc/host.h                           |  31 ++++--
 include/linux/mmc/tmio.h                           |   2 +
 9 files changed, 279 insertions(+), 70 deletions(-)

-- 
2.7.0

