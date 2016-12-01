From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH v2 0/2] mmc: sdhci: one expansion for SDHCI base code and add Cadence SDHCI driver
Date: Thu,  1 Dec 2016 12:36:04 +0900
Message-ID: <1480563366-7259-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Andrei Pistirica <andrei.pistirica-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

1/2 tweaks sdhci_execute_tuning(), which I want to use for 2/2.

2/2 adds a new driver for Cadence's controller IP.


Changes in v2:
  - Remove unnecessary "select MMC_SDHCI_IO_ACCESSORS"

Masahiro Yamada (2):
  mmc: sdhci: continue normal tuning if unsupported by platform tuning
  mmc: sdhci-cadence: add Cadence SD4HC support

 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  31 +++
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 279 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   4 +-
 5 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
 create mode 100644 drivers/mmc/host/sdhci-cadence.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
