From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/7] Intel MID SDHCI support (take two)
Date: Mon, 13 Sep 2010 18:38:32 +0100
Message-ID: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13473 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSXF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:23:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Please ignore the original submission I found a nasty bug in it while I
was submitting.

---

Alan Cox (6):
      sdhci: Tidy up sdhci.c
      sdhci_pci: Tidy this as well
      sdhci: Tidy up spaces in sdhci_intel_mid
      mmc: serialization support
      sdhci: Allow the probe handler to override slots
      sdhci: Rework some of the quirk behaviour

Xiaochen Shen (1):
      sdhci: Intel Medfield support


 drivers/mmc/core/core.c            |   30 ++++++
 drivers/mmc/host/Kconfig           |   11 ++
 drivers/mmc/host/Makefile          |    1 
 drivers/mmc/host/sdhci-intel-mid.c |  170 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c       |  153 ++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.c           |  118 +++++++++++++++++--------
 drivers/mmc/host/sdhci.h           |   21 ++++
 include/linux/mmc/core.h           |    1 
 include/linux/mmc/host.h           |    3 +
 include/linux/pci_ids.h            |    7 +
 10 files changed, 452 insertions(+), 63 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-intel-mid.c

-- 
	"Standards committees don't like hashing.  It looks complicated and
         insufficiently deterministic on an overhead projector."
			-Vern Schryver

