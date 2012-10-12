From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/4] MMC: some omap_hsmmc fixes
Date: Fri, 12 Oct 2012 12:58:11 +0200
Message-ID: <1350039495-360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32888 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab2JLK6s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 06:58:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>

Here are some assorted patches for the omap_hsmmc driver that I need on
top Linus' current development branch to make it work on a AM33xx board.

1/4 and 2/4 qualify as bug fixes and I'm puzzled that these didn't hit
anyone else yet.


Daniel Mack (4):
  MMC: omap_hsmmc: set platform data after probe from DT node
  MMC: omap_hsmmc: fix DMA config block
  MMC: omap_hsmmc: claim pinctrl at probe time
  MMC: omap_hsmmc: add DT property for max bus frequency

 drivers/mmc/host/omap_hsmmc.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
1.7.11.4

