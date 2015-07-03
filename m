From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] introduce driver for the Atmel SDMMC
Date: Fri, 3 Jul 2015 16:17:14 +0200
Message-ID: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

This set of patches introduce a driver for the new Atmel SDMMC device avaible
on SAMA5D2 SoC.

There is also a resend of an old patch which has not been taken. Ulf asked
for some reviews since it could impact all sdhci devices but nobody did it...


Regards

Ludovic Desroches (3):
  mmc: sdhci: switch from programmable clock mode to divided one if
    needed
  mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC
  MAINTAINERS: add entry for Atmel sdhci-of-at91 driver

 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  21 +++
 MAINTAINERS                                        |   6 +
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-of-at91.c                   | 188 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  29 +++-
 6 files changed, 244 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
 create mode 100644 drivers/mmc/host/sdhci-of-at91.c

-- 
2.2.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
