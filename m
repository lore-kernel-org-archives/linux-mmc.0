From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/5] Fix indirect inclusion to <mach/hardware.h>
Date: Mon, 17 Oct 2011 14:15:05 +0800
Message-ID: <1318832110-29289-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50215 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab1JQGLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 02:11:18 -0400
Received: by yxp4 with SMTP id 4so3355095yxp.5
        for <linux-mmc@vger.kernel.org>; Sun, 16 Oct 2011 23:11:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, patches@linaro.org

With rmk's mach/gpio.h cleanup series merged into arm-soc/imx tree,
plat-mxc/include/mach/gpio.h will become an empty file waiting for 
a global removal of mach/gpio.h.

Currently, this mach/gpio.h includes mach/hardware.h.  Once mach/gpio.h
becomes an empty file, we will hit a number of imx build errors caused
by the indirect inclusion to mach/hardware.h.  This series is trying to
address these errors before above two trees gets merged, which will
happen pretty soon, I believe.

Shawn Guo (5):
      arm/imx: remove mx31_setup_weimcs() from mx31.h
      arm/imx: explicitly includes mach/hardware.h in mach-kzm_arm11_01.c
      arm/imx: remove mx27_setup_weimcs() from mx27.h
      arm/imx: explicitly includes mach/hardware.h in pm-imx27.c
      mmc: mxcmmc: explicitly includes mach/hardware.h

 arch/arm/mach-imx/mach-kzm_arm11_01.c |    1 +
 arch/arm/mach-imx/mach-pcm038.c       |    4 +++-
 arch/arm/mach-imx/mach-qong.c         |    5 ++++-
 arch/arm/mach-imx/pm-imx27.c          |    2 +-
 arch/arm/plat-mxc/include/mach/mx27.h |   14 --------------
 arch/arm/plat-mxc/include/mach/mx31.h |   14 --------------
 drivers/mmc/host/mxcmmc.c             |    1 +
 7 files changed, 10 insertions(+), 31 deletions(-)
