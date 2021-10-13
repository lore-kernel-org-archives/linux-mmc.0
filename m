Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A02C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 20:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C8C6101D
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 20:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhJMUT1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:19:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:34362 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJMUT1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 Oct 2021 16:19:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227482130"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227482130"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 13:17:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="442422954"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Oct 2021 13:17:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20D1E107; Wed, 13 Oct 2021 23:17:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
Date:   Wed, 13 Oct 2021 23:17:17 +0300
Message-Id: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It appears that one of the supported platform magically worked with the
custom IRQ handler (any hints how?) while having two PCB designs with
an opposite CD sense level. Here is an attempt to fix it by quirking out
CD GPIO.

Patch 1 is an actual fix for the mentioned platform.
Patch 2 is code deduplication to save few LOCs.
Patch 3-6 are dead code removals.

In v2:
- redone fix to use ->get_cd() instead of quirks (Adrian)
- due to above transformed previous clean up to the current patch 2
- added a new patch, i.e. patch 3
- added commit IDs to patch 4 (Adrian)
- mentioned dependencies on previous patches in patch 5 and 6 (Adrian)

Andy Shevchenko (6):
  mmc: sdhci-pci: Read card detect from ACPI for Intel Merrifield
  mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
  mmc: sdhci: Remove unused prototype declaration in the header
  mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
  mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
  mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)

 drivers/mmc/host/Makefile          |   1 -
 drivers/mmc/host/sdhci-acpi.c      |  14 +--
 drivers/mmc/host/sdhci-pci-core.c  | 159 ++++-------------------------
 drivers/mmc/host/sdhci-pci-data.c  |   6 --
 drivers/mmc/host/sdhci-pci.h       |   5 -
 drivers/mmc/host/sdhci.c           |  19 ++++
 drivers/mmc/host/sdhci.h           |   2 +-
 include/linux/mmc/sdhci-pci-data.h |  18 ----
 8 files changed, 39 insertions(+), 185 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
 delete mode 100644 include/linux/mmc/sdhci-pci-data.h

-- 
2.33.0

