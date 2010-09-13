From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/4] Intel MID support for SDHCI devices
Date: Mon, 13 Sep 2010 16:01:44 +0100
Message-ID: <20100913145805.23167.35463.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40723 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab0IMPrL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 11:47:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

The Intel MID platforms need various workarounda and helpers. This series of
patches introduces two things

- A set of overrides for basic operations (as opposed to yet more quirk flags)
- The supporting logic to propogate those new operations through the PCI sdhci
  code as far as is needed in each case.

Several of the other quirks could now be removed and rephrased using the hooks
more cleanly. I've not done so as I don't have all the relevant other embedded
platform hardware to test any such changes.

---

Alan Cox (3):
      mmc: serialization support
      sdhci: Allow the probe handler to override slots
      sdhci: Rework some of the quirk behaviour

Xiaochen Shen (1):
      sdhci: Intel Medfield support


 drivers/mmc/core/core.c            |   30 ++++++
 drivers/mmc/host/Kconfig           |   11 ++
 drivers/mmc/host/Makefile          |    1 
 drivers/mmc/host/sdhci-intel-mid.c |  170 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c       |  107 ++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c           |   73 +++++++++++++--
 drivers/mmc/host/sdhci.h           |   19 ++++
 include/linux/mmc/core.h           |    1 
 include/linux/mmc/host.h           |    3 +
 include/linux/pci_ids.h            |    7 +
 10 files changed, 403 insertions(+), 19 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-intel-mid.c

-- 
     "Knowledge has no value or use for the solitary owner: to be
      enjoyed it must be communicated" -- Charles Pratt, 1st Earl Camden

