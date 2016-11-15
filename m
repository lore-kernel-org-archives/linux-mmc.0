From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v2 0/2] mmc: sdhci-pci: Use ACPI to set max frequency of sdio host controller
Date: Tue, 15 Nov 2016 10:32:19 -0600
Message-ID: <1479227541-21201-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:46713 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752200AbcKOQcZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Nov 2016 11:32:25 -0500
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

v2:
  * Use acpi_evaluate_integer() instead of
    acpi_get_handle()/acpi_evaluate_object()


Zach Brown (2):
  mmc: sdhci-pci: Add PCI ID for Intel byt sdio host controller
    sub-vended by NI
  mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio    
    controller sub-vended by NI

 drivers/mmc/host/sdhci-pci-core.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

-- 
2.7.4

