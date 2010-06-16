From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] SDHCI-S3C fixes and enhancements (driver specific code)
Date: Wed, 16 Jun 2010 08:49:53 +0200
Message-ID: <1276670996-17729-1-git-send-email-m.szyprowski@samsung.com>
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

#1 - add missing sdhci_s3c_driver_remove() function
#2 - introduce new sdhci quirk to get rid of anoying runtime warning and
     possible problems with slow mmc/sd cards
#3 - add support for various methods of notifying the host driver about
     the card insertion/removal (should be compatible with existing code)

Last patch requires changes to the Samsung platform setup code, which
has been posted in a separate patch series for easier merging, please
refer to the "[PATCH v2] SDHCI-S3C fixes and enhancements (platform
specific code)" thread.

Changes since V1:
- added support for gpio external interrupt card based detect method
  directly to sdhci-s3c driver
- removed duplicate Kconfig patch
- removed timeout patch (not really needed)

A complete list of patches:

[PATCH 1/3] sdhci-s3c: add missing remove function
[PATCH 2/3] sdhci-s3c: add support for the non standard minimal clock value
[PATCH 3/3] sdhci-s3c: add support for new card detection methods

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
