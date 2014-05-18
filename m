From: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 0/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI driver
Date: Sun, 18 May 2014 01:41:55 -0600
Message-ID: <1400398918-1502-1-git-send-email-lho@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds support for the APM X-Gene SoC SDHC controller to Arasan
SDHCI driver.

Signed-off-by: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
---
Loc Ho (3):
  Documentation: Update Arasan SDHC documentation for the APM X-Gene
    SoC SDHC DTS binding
  mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI
    driver
  arm64: Add APM X-Gene SoC SDHC controller DTS entry

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |    9 +-
 arch/arm64/boot/dts/apm-storm.dtsi                 |    8 ++
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  126 ++++++++++++++++++--
 4 files changed, 134 insertions(+), 13 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
