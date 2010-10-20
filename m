From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 0/2] Add GPIO WP and HW bus-width caps when support i.MX51 BBG board
Date: Wed, 20 Oct 2010 18:00:26 +0800
Message-ID: <1287568828-22563-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:49959
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab0JTJ4V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2010 05:56:21 -0400
Received: from mail73-db3 (localhost.localdomain [127.0.0.1])	by
 mail73-db3-R.bigfish.com (Postfix) with ESMTP id CCB28D404D8	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 09:56:18 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.243])	by
 mail73-db3.bigfish.com (Postfix) with ESMTP id 341516F008D	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 09:55:37 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o9K9tXLn017167	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 02:55:33 -0700 (MST)
Received: from shlinux1.ap.freescale.net
 (R62363-04-010192225216.ap.freescale.net [10.192.225.216])	by
 de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o9KABwLZ017937	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 05:11:59 -0500 (CDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric@eukrea.com, w.sang@pengutronix.de
Cc: r65037@freescale.com

This serial patches are based on Wolfram and Eric's eSDHC driver patchs, and
add the GPIO Write Protection, and HW bus-width cpas supports on i.MX51
BBG boards.

[PATCH 1/2] Add the GPIO Write Protection Solution on i.MX51 BBG board
arch/arm/mach-mx5/board-mx51_babbage.c      |   16 ++++++++++++++--
arch/arm/plat-mxc/include/mach/iomux-mx51.h |    8 +++++---
2 files changed, 19 insertions(+), 5 deletions(-)

[PATCH 2/2] Add the HW board caps flag for MX51 BBG
arch/arm/mach-mx5/board-mx51_babbage.c |    3 +++
arch/arm/plat-mxc/include/mach/esdhc.h |    1 +
drivers/mmc/host/sdhci-esdhc-imx.c     |    1 +
drivers/mmc/host/sdhci.c               |    8 ++++++--
4 files changed, 11 insertions(+), 2 deletions(-)


