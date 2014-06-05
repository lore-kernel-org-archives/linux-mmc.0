From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] randconfig fixes for mmc
Date: Thu,  5 Jun 2014 23:14:37 +0200
Message-ID: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52305 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaFEVPa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 17:15:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi Chris, Ulf,

These are small fixes from my randconfig testing, almost all for
older bugs, please apply to a tree you see appropriate.

	Arnd

Arnd Bergmann (4):
  mmc: atmel-mci: incude asm/cacheclush.h
  mmc: mvsdio: avoid compiler warning
  mmc: omap: don't select TPS65010
  mmc: simplify SDHCI Kconfig dependencies

 drivers/mmc/host/Kconfig     | 10 ++++------
 drivers/mmc/host/atmel-mci.c |  1 +
 drivers/mmc/host/mvsdio.c    |  2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
1.8.3.2

Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <chris@printf.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
