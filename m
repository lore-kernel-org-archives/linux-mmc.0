From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/3] Add SDHCI ACPI driver
Date: Thu, 22 Nov 2012 10:43:47 +0200
Message-ID: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi

Here is SDHCI ACPI driver.  It is dependent on new ACPI Platform support
so I suggest Rafael takes the patches with Chris' Ack.

Please note that I would prefer this to be queued for 3.8


Adrian Hunter (3):
      PNPACPI: exclude SDHCI devices
      ACPI: add SDHCI to ACPI platform devices
      mmc: sdhci-acpi: add SDHCI ACPI driver

 drivers/acpi/scan.c           |   2 +
 drivers/mmc/host/Kconfig      |  12 ++
 drivers/mmc/host/Makefile     |   1 +
 drivers/mmc/host/sdhci-acpi.c | 304 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/pnpacpi/core.c    |   1 +
 5 files changed, 320 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-acpi.c


Regards
Adrian Hunter
