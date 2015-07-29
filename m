From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 0/3] introduce driver for the Atmel SDMMC
Date: Wed, 29 Jul 2015 16:22:45 +0200
Message-ID: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:57879 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbG2OWk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jul 2015 10:22:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, pebolle@tiscali.nl, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches introduce a driver for the new Atmel SDMMC device avaible
on SAMA5D2 SoC.

There is also a resend of an old patch which has not been taken. Ulf asked
for some reviews since it could impact all sdhci devices but nobody did it...
This patch is not necessary for patch 2/3. It only fixes a special use case. If
there are objections about it, drop it, I don't want to delay the Atmel SDMMC
driver inclusion only for this patch.

Changes:
- from v1:
  - update license

Ludovic Desroches (3):
  mmc: sdhci: switch from programmable clock mode to divided one if
    needed
  mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC
  MAINTAINERS: add entry for Atmel sdhci-of-at91 driver

 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  21 +++
 MAINTAINERS                                        |   6 +
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-of-at91.c                   | 192 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  29 +++-
 6 files changed, 248 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
 create mode 100644 drivers/mmc/host/sdhci-of-at91.c

-- 
2.5.0

