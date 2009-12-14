From: Albert Herranz <albert_herranz@yahoo.es>
Subject: [RFC PATCH 0/2] mmc: wii: sdhci controller support
Date: Mon, 14 Dec 2009 20:33:24 +0100
Message-ID: <1260819206-30074-1-git-send-email-albert_herranz@yahoo.es>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp141.mail.ukl.yahoo.com ([77.238.184.72]:46161 "HELO
	smtp141.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752721AbZLNTkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 14:40:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, Albert Herranz <albert_herranz@yahoo.es>

This patch set adds support for the SDHCI controllers found in the
"Hollywood" chipset of the Nintendo Wii video game console.

First, the existing sdhci-of driver is splitted into a core part and
a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
add-on to that, re-using common code.

Albert Herranz (2):
  sdhci-of: reorganize driver to support additional hardware
  sdhci-of: add support for the wii sdhci controller

 drivers/mmc/host/Kconfig          |   37 ++++-
 drivers/mmc/host/Makefile         |    6 +-
 drivers/mmc/host/sdhci-of-core.c  |  230 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c |  142 ++++++++++++++++
 drivers/mmc/host/sdhci-of-hlwd.c  |   64 +++++++
 drivers/mmc/host/sdhci-of.c       |  336 -------------------------------------
 drivers/mmc/host/sdhci-of.h       |   43 +++++
 7 files changed, 518 insertions(+), 340 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-core.c
 create mode 100644 drivers/mmc/host/sdhci-of-esdhc.c
 create mode 100644 drivers/mmc/host/sdhci-of-hlwd.c
 delete mode 100644 drivers/mmc/host/sdhci-of.c
 create mode 100644 drivers/mmc/host/sdhci-of.h

