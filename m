From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Mon, 15 Dec 2014 22:31:05 +0530
Message-ID: <1418662867-9210-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Due to the fact that the existing of-arasan driver works with 32-bit platforms.
This patch tweaks existing of-arasan driver to work with 64-bit X-Gene
platform using IOMMU translation.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---

Suman Tripathi (2):
  mmc: host: arasan: Add addition of-arasan quirks and add IOMMU
    support.
  arm64: dts: Add  APM X-Gene SDHCI DTS node.

 arch/arm64/boot/dts/apm-storm.dtsi | 43 ++++++++++++++++++++++++++++++
 drivers/mmc/host/Kconfig           |  1 +
 drivers/mmc/host/sdhci-of-arasan.c | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     | 12 +++++++++
 4 files changed, 110 insertions(+)

--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
