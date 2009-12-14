From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [RFC PATCH v2 0/4] mmc: wii: sdhci controller support
Date: Mon, 14 Dec 2009 23:24:15 +0100
Message-ID: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp104.mail.ukl.yahoo.com ([77.238.184.36]:27049 "HELO
	smtp104.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932618AbZLNWY3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 17:24:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, Albert Herranz <albert_herranz@yahoo.es>

This patch set adds support for the SDHCI controllers found in the
"Hollywood" chipset of the Nintendo Wii video game console.

First, the existing sdhci-of driver is splitted into a core part and
a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
add-on to that, re-using common code.

Changes from v1:
- Separate the rename and the modification of sdhci-of.c to facilitate
  the review of the patch.
- Protect sdhci.h from multiple inclusion.
- Explicitly include sdhci.h in files. Suggestion by Anton Vorontsov.
- Remove unneeded empty line at the end of sdhci-of.h.
  Suggestion by Anton Vorontsov.

Albert Herranz (4):
  sdhci: protect header file against multi inclusion
  sdhci-of: rename main driver file prior to reorganization
  sdhci-of: reorganize driver to support additional hardware
  sdhci-of: add support for the wii sdhci controller

 drivers/mmc/host/Kconfig          |   37 ++++-
 drivers/mmc/host/Makefile         |    6 +-
 drivers/mmc/host/sdhci-of-core.c  |  231 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |  143 ++++++++++++++++
 drivers/mmc/host/sdhci-of-hlwd.c  |   65 +++++++
 drivers/mmc/host/sdhci-of.c       |  336 -------------------------------------
 drivers/mmc/host/sdhci-of.h       |   42 +++++
 drivers/mmc/host/sdhci.h          |    4 +
 8 files changed, 524 insertions(+), 340 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-core.c
 create mode 100644 drivers/mmc/host/sdhci-of-esdhc.c
 create mode 100644 drivers/mmc/host/sdhci-of-hlwd.c
 delete mode 100644 drivers/mmc/host/sdhci-of.c
 create mode 100644 drivers/mmc/host/sdhci-of.h

