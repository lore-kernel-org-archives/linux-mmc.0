From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 0/2] arm: omap4: hsmmc: pbias fixes
Date: Mon, 3 Oct 2011 17:52:49 +0530
Message-ID: <1317644571-25175-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab1JCMWK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Oct 2011 08:22:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com, Balaji T K <balajitk@ti.com>

MMC1 pbias and speed control fix for SDMMC1 extended I/O cell
Rebase to git://github.com/tmlind/linux.git fixes
	commit 122a98589349fe3388ffb7b996b54614951c934a
	Author: Tapani Utriainen <tapani@technexion.com>
	Date:   Fri Sep 30 11:05:56 2011 -0700

	    ARM: OMAP: irq: loop counter fix in omap_init_irq()


Balaji T K (2):
  arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
  arm: omap4: hsmmc: configure SDMMC1_DR0 properly

 arch/arm/mach-omap2/hsmmc.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

