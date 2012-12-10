From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] mmc: sdhci-acpi: enable runtime-pm for device HID INT33C6
Date: Mon, 10 Dec 2012 11:10:43 +0200
Message-ID: <1355130644-26065-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi

Here is a minor hardware ID addition to sdhci-acpi.

Please consider this for Linux 3.8, in which case it must go via
Rafael's linux-pm tree because that is where the new driver is.


Adrian Hunter (1):
      mmc: sdhci-acpi: enable runtime-pm for device HID INT33C6

 drivers/mmc/host/sdhci-acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)


Regards
Adrian Hunter
