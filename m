From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] SDHCI-S3C updates
Date: Wed, 28 Jul 2010 16:19:53 +0200
Message-ID: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-mmc@vger.kernel.org

Hello,

This patch series includes various updates to sdhci-s3c driver. The
patches has been rebased onto latest -mm kernel tree from
git://zen-kernel.org/kernel/mmotm.git (2010-07-27-14-56 snapshot).

Some patches has been already accepted by Andrew Morton, but they became
incompatible after threaded_irq changes in sdhci driver, so they have
been dropped. I've adapted them to new driver base, see the change log
in each patch.

All required platform changes has been already merged by Kukjin Kim and
are available in linux-next kernel tree - see commit:
848a3aeee01c8c805f8dad4ae2963473975410d1 from 
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-next branch.

A complete list of patches:

[PATCHv2 1/4] sdhci-s3c: add support for the non standard minimal clock value
[PATCH 2/4] sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk
[PATCHv5 3/4] sdhci-s3c: add support for new card detection methods (driver part)
[PATCH 4/4] sdhci-s3c: add regulator support

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
