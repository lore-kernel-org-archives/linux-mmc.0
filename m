From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 00/16] omap_hsmmc patches
Date: Fri,  6 May 2011 12:13:59 +0300
Message-ID: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:45633 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860Ab1EFJPc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 05:15:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

Hi

Here is V2 of some patches for omap_hsmmc.

Changes in V2:

	OMAP: sDMA: descriptor autoloading feature
		- removed the feature entirely as per Tony Lindgren

	mmc: omap_hsmmc: fix few bugs when set the clock divisor
		- added cpu_relax() as per Grazvydas Ignotas

	mmc: omap_hsmmc: fix missing mmc_release_host() in no_off case
		- removed {} as per Sergei Shtylyov

	OMAP: hsmmc: implement clock switcher
		- changed to >= threshold as per Grazvydas Ignotas


Adrian Hunter (6):
      mmc: omap_hsmmc: correct debug report error status mnemonics
      OMAP: board-rm680: set MMC nomux flag
      mmc: omap_hsmmc: ensure pbias configuration is always done
      mmc: omap_hsmmc: fix oops in omap_hsmmc_dma_cb
      OMAP: hsmmc: add platform data for eMMC hardware reset gpio
      mmc: omap_hsmmc: add a hardware reset before initialization

Andy Shevchenko (8):
      mmc: omap_hsmmc: move hardcoded frequency constants to definition block
      mmc: omap_hsmmc: reduce a bit the error handlers in probe()
      mmc: omap_hsmmc: split duplicate code to calc_divisor() function
      mmc: omap_hsmmc: introduce start_clock and re-use stop_clock
      mmc: omap_hsmmc: fix few bugs when set the clock divisor
      mmc: omap_hsmmc: split same pieces of code to separate functions
      OMAP: hsmmc: implement clock switcher
      mmc: omap_hsmmc: adjust host controller clock in regard to current OPP

Jarkko Lavinen (1):
      OMAP: hsmmc: Do not mux the slot if non default muxing is already done

Sudhir Bera (1):
      mmc: omap_hsmmc: fix missing mmc_release_host() in no_off case

 arch/arm/mach-omap2/board-rm680.c     |    1 +
 arch/arm/mach-omap2/hsmmc.c           |  188 +++++++++++++++++-
 arch/arm/mach-omap2/hsmmc.h           |    2 +
 arch/arm/plat-omap/include/plat/mmc.h |    9 +
 drivers/mmc/host/omap_hsmmc.c         |  353 ++++++++++++++++++++-------------
 5 files changed, 414 insertions(+), 139 deletions(-)
 
Regards
Adrian

