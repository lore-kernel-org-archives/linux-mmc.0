From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v3 0/2] mmc add vsdio to dynamically control sdio power
Date: Thu, 25 Aug 2011 14:26:13 +0800
Message-ID: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:33179 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532Ab1HYG0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 02:26:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.o
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

v2->v3, change vmmc to vsdio
In v2, vmmc is reused, however, sd may be impacted if move vmmc to set_ios.
When no card inserted, CD is high, vmmc will be disabled when detect fail, CD will pull low accordingly, controller may treat as card inserted and re-detect.

Zhangfei Gao (2):
  mmc: sdio add regulator vsdio
  ARM: mmp2: support sdio with regulator vsdio

 arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c       |   22 ++++++++++++++
 include/linux/mmc/sdhci.h      |    2 +
 3 files changed, 82 insertions(+), 2 deletions(-)

