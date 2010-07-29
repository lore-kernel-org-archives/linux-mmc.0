From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] SDHCI-S3C updates
Date: Thu, 29 Jul 2010 14:34:31 +0200
Message-ID: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-mmc@vger.kernel.org

Hello,

This is an updated version of the patches I've sent yesterday. I've
fixed issues reported by Maurus Cuelenaere and Ben Dooks.

This patch series includes various updates to sdhci-s3c driver. The
patches has been rebased onto latest -mm kernel tree from
git://zen-kernel.org/kernel/mmotm.git (2010-07-27-14-56 snapshot).

All required platform changes has been already merged by Kukjin Kim and
are available in linux-next kernel tree - see commit:
848a3aeee01c8c805f8dad4ae2963473975410d1 from
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-next branch.

A complete list of patches:

[PATCHv3 1/4] sdhci-s3c: add support for the non standard minimal clock value
[PATCH 2/4] sdhci-s3c: enable SDHCI_QUIRK_NO_HISPD_BIT quirk
[PATCHv6 3/4] sdhci-s3c: add support for new card detection methods
[PATCHv2 4/4] sdhci: add regulator support

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
