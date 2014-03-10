From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/6] mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14
Date: Mon, 10 Mar 2014 15:02:38 +0200
Message-ID: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbaCJNEG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Mar 2014 09:04:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi

Here are some patches that fix broken card detect for ACPI HID
80860F14.  To do that the card detect GPIO API needed to be
extended to support the new GPIO descriptor API.

There are also 2 unrelated but self-explanatory patches
appended:
	mmc: sdhci-acpi: Add device id 80860F16
	mmc: sdhci: Allow for irq being shared.


Adrian Hunter (6):
      mmc: slot-gpio: Record GPIO descriptors instead of GPIO numbers
      mmc: slot-gpio: Split out CD IRQ request into a separate function
      mmc: slot-gpio: Add GPIO descriptor based CD GPIO API
      mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14 SD cards
      mmc: sdhci-acpi: Add device id 80860F16
      mmc: sdhci: Allow for irq being shared.


Regards
Adrian
