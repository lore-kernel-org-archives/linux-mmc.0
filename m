From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 00/15] mmc: sdhci: Add 64-bit ADMA support
Date: Tue, 21 Oct 2014 12:26:10 +0300
Message-ID: <1413883585-16299-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbaJUJ1x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Oct 2014 05:27:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi

Here are patches to add 64-bit ADMA support to the SDHCI driver.

The patchset starts with 3 minor fixes related to SDHCI ADMA,
then there are 8 preparatory patches, then 3 main patches, then
the mmc_test "Badly aligned" tests are extended slightly.


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
