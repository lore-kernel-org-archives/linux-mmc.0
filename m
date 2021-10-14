Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3902EC4321E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D14610E7
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 13:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJNN2W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:28:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:28810 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhJNN2T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Oct 2021 09:28:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214838151"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="214838151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 06:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="626798350"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2021 06:26:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D82AF361; Thu, 14 Oct 2021 16:26:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v3 0/5]  mmc: sdhci-pci: Remove dead code and deduplicate
Date:   Thu, 14 Oct 2021 16:26:08 +0300
Message-Id: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It appears that one of the supported platform magically worked with
the custom IRQ handler (any hints how?) while having two PCB designs
with an opposite CD sense level. Quirking it out reveals the code
duplication and dead code.

Patch 1 is code deduplication to save few LOCs.
Patch 2-5 are dead code removals.

In v3:
- dropped the fix as it has been applied (Ulf)
- added tag (Adrian)
- elaborated commit IDs with their short descriptions in patch 3 (Adrian)
- corrected dependency in patch 5 (Adrian)

In v2:
- redone fix to use ->get_cd() instead of quirks (Adrian)
- due to above transformed previous clean up to the current patch 2
- added a new patch, i.e. patch 3
- added commit IDs to patch 4 (Adrian)
- mentioned dependencies on previous patches in patch 5 and 6 (Adrian)

Andy Shevchenko (5):
  mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
  mmc: sdhci: Remove unused prototype declaration in the header
  mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
  mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
  mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)

 drivers/mmc/host/Makefile          |   1 -
 drivers/mmc/host/sdhci-acpi.c      |  14 +--
 drivers/mmc/host/sdhci-pci-core.c  | 152 +----------------------------
 drivers/mmc/host/sdhci-pci-data.c  |   6 --
 drivers/mmc/host/sdhci-pci.h       |   5 -
 drivers/mmc/host/sdhci.c           |  19 ++++
 drivers/mmc/host/sdhci.h           |   2 +-
 include/linux/mmc/sdhci-pci-data.h |  18 ----
 8 files changed, 26 insertions(+), 191 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
 delete mode 100644 include/linux/mmc/sdhci-pci-data.h

-- 
2.33.0

