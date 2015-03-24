From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request via PM QoS
Date: Tue, 24 Mar 2015 15:40:36 +0200
Message-ID: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32710 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbbCXNmo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 09:42:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

Here are some patches to address an issue with SDHCI
in Intel Baytrail. Intel Baytrail has been observed
sometimes to hang if host controllers are using DMA
while deep C-states are used. Workaround that by
specifying a maximum DMA latency that will prevent
deep C-states.

The first patch adds a new PM QOS function so that
the SDHCI driver can do a "lazy" cancel of the QoS
request from within its "finish" tasklet.

The second patch adds support to SDHCI for specifying a
maximum DMA latency.

The third and fourth patches take that facility into
use for Baytrail.

Ad hoc testing with Lenovo Thinkpad 10 showed a stress
test could run for at least 24 hours with the patches,
compared to less than an hour without.

These patches are on top of my driver strength patches
which are on top of my re-tuning patches.


Adrian Hunter (4):
      PM / QoS: Add pm_qos_cancel_request_lazy() that doesn't sleep
      mmc: sdhci: Support maximum DMA latency request via PM QOS
      mmc: sdhci-acpi: Fix device hang on Intel BayTrail
      mmc: sdhci-pci: Fix device hang on Intel BayTrail

 drivers/mmc/host/sdhci-acpi.c | 32 ++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.c  | 13 +++++++++++
 drivers/mmc/host/sdhci.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  7 ++++++
 include/linux/pm_qos.h        |  2 ++
 kernel/power/qos.c            | 20 +++++++++++++++++
 6 files changed, 126 insertions(+)


Regards
Adrian
