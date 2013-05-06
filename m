From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] mmc: sdhci: support runtime PM for BYT SD cards
Date: Mon,  6 May 2013 12:17:31 +0300
Message-ID: <1367831854-31952-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33871 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364Ab3EFJMi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 May 2013 05:12:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi

Here are 3 patches to support runtime PM for BYT SD cards

Please note that these patches are dependent upon 2 gpio patches
that are in linux-next and linux-gpio but not the mmc tree.
Those patches are:

	author	Mika Westerberg <mika.westerberg@linux.intel.com>	2013-04-03 10:56:54 (GMT)
	committer	Linus Walleij <linus.walleij@linaro.org>	2013-04-11 22:31:18 (GMT)
	commit	12028d2d216220618f76284af5f8ed510b11da55 (patch)
	gpiolib-acpi: introduce acpi_get_gpio_by_index() helper

	author	Rafael J. Wysocki <rafael.j.wysocki@intel.com>	2013-04-09 13:57:25 (GMT)
	committer	Linus Walleij <linus.walleij@linaro.org>	2013-04-10 21:41:17 (GMT)
	commit	7fc7acb9a0b0ff3ffdf21818fe0735ebaf4fecb8 (patch)
	gpio / ACPI: Handle ACPI events in accordance with the spec

I think those patches are queued for 3.10.

cc: Linus Walleij <linus.walleij@linaro.org>


Adrian Hunter (3):
      mmc: sdhci: add ability to stay runtime-resumed if the card is powered up
      mmc: sdhci-acpi: support runtime PM for ACPI HID 80860F14 SD cards
      mmc: sdhci-pci: support runtime PM for BYT SD cards

 drivers/mmc/host/sdhci-acpi.c | 64 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.c  |  2 ++
 drivers/mmc/host/sdhci.c      | 35 ++++++++++++++++++++++-
 include/linux/mmc/sdhci.h     |  2 ++
 4 files changed, 101 insertions(+), 2 deletions(-)


Regards
Adrian Hunter
