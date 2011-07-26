From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v2 0/2] set_ios handle vmmc
Date: Tue, 26 Jul 2011 15:06:11 +0800
Message-ID: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:39826 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1GZHGS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2011 03:06:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.o
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

v2: reuse vmmc

vmmc is controled inside set_ios according to mmc_power_up/down
Brownstone add support of sdio device 8787

Zhangfei Gao (2):
  mmc: sdhci move vmmc to set_ios
  ARM: mmp2: support sdio device 8787

 arch/arm/mach-mmp/brownstone.c |   60 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c       |   27 ++++++++++--------
 include/linux/mmc/sdhci.h      |    1 +
 3 files changed, 74 insertions(+), 14 deletions(-)

