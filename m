From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Tue,  4 Nov 2014 12:42:34 +0200
Message-ID: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbaKDKoV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:21 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here is V2 of the patches to add 64-bit ADMA support
to the SDHCI driver.  V2 fixes the warning:

drivers/mmc/host/sdhci.c: In function 'sdhci_adma_show_error':
drivers/mmc/host/sdhci.c:2314:10: warning: dereferencing 'void *' pointer
      attr = *desc;
             ^
drivers/mmc/host/sdhci.c:2314:8: error: void value not ignored as it ought to be
      attr = *desc;

that was found in:

	mmc: sdhci: Use 'void *' for not 'u8 *' for ADMA data

And adjusts:

	mmc: sdhci: Define ADMA descriptor structure

The result should be that the final tree is exactly the same.


Adrian Hunter (15):
      mmc: sdhci: Fix incorrect ADMA2 descriptor table size
      mmc: sdhci: Fix ADMA page boundary warnings
      mmc: sdhci: Fix ADMA table size warning
      mmc: sdhci: Rename two ADMA-related functions for consistency
      mmc: sdhci: Rename adma_desc to adma_table
      mmc: sdhci: Add sdhci_adma_mark_end()
      mmc: sdhci: Use 'void *' for not 'u8 *' for ADMA data
      mmc: sdhci: Parameterize ADMA sizes and alignment
      mmc: sdhci: Define maximum segments
      mmc: sdhci: Define ADMA constants
      mmc: sdhci: Define ADMA descriptor structure
      mmc: sdhci: Add 64-bit ADMA support
      mmc: sdhci-acpi: Add 64-bit DMA support
      mmc: sdhci-pci: Add 64-bit DMA support
      mmc: mmc_test: Extend "Badly aligned" tests for 8-byte alignment

 drivers/mmc/card/mmc_test.c   |  10 +-
 drivers/mmc/host/sdhci-acpi.c |  41 +++++---
 drivers/mmc/host/sdhci-pci.c  |  14 ++-
 drivers/mmc/host/sdhci.c      | 226 +++++++++++++++++++++++++++---------------
 drivers/mmc/host/sdhci.h      |  41 ++++++++
 include/linux/mmc/sdhci.h     |  14 ++-
 6 files changed, 241 insertions(+), 105 deletions(-)


Regards
Adrian
