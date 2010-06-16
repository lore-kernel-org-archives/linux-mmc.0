From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] SDHCI-S3C fixes and enhancements (platform specific code)
Date: Wed, 16 Jun 2010 08:49:12 +0200
Message-ID: <1276670954-17652-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hello,

This series includes various fixes to sdhci-s3c driver as well as a
major feature enhancement. This patch series is prepared to get complete
sdhci support on Samsung Aquila board.

A quick overview on the patches:

#1 - add support for various methods of notifying the host driver about
     the card insertion/removal (should be compatible with existing code)
#2 - add sdhci driver platform data for all hsmmc controllers on Samsung
     Aquila board

Changes to the sdhci-s3c driver itself will be posted in a separate
patch series for easier merging, please refer to the "[PATCH] SDHCI-S3C
fixes and enhancements (driver specific code)" thread.

Changes since V1:
- added support for external gpio interrupt based card detect method
  directly to sdhci-s3c driver
- removed s3c64xx compilation fix patch from the series

A complete list of patches:

[PATCH 1/2] Samsung: sdhci-s3c: add support for new card detection methods
[PATCH 2/2] s5pv210: Aquila: add definitions for sdhci devices

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
