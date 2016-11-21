From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: Use ACPI to set max frequency of sdio host
Date: Mon, 21 Nov 2016 17:04:04 -0600
Message-ID: <1479769446-8490-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:57386 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754711AbcKUXEJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Nov 2016 18:04:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

On some boards, max SDIO frequency is limited by trace lengths and other layout
choices. We would like a way to specify this limitation so the driver can
behave accordingly.

This patch set assumes that the limitation has been reported in an ACPI table
which the driver can check to get the max frequency.

The first patch creates a PCI ID and support for the Intel byt sdio where NI is
the subvendor.

The second patch uses the ACPI table to set f_max during the new
ni_byt_sdio_probe_slot.


Zach Brown (2):
  mmc: sdhci-pci: Add PCI ID for Intel byt sdio host controller
    sub-vended by NI
  mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio    
    controller sub-vended by NI

 drivers/mmc/host/sdhci-pci-core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
2.7.4

