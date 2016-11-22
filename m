From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH v2 0/2] mmc: sdhci-pci: Use ACPI to set max frequency of sdio host controller
Date: Tue, 22 Nov 2016 15:53:20 -0600
Message-ID: <1479851602-19788-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

On some boards, max SDIO frequency is limited by trace lengths and other layout
choices. We would like a way to specify this limitation so the driver can
behave accordingly.

This patch set assumes that the limitation has been reported in an ACPI table
which the driver can check to get the max frequency.

The first patch creates a PCI ID and support for the Intel byt sdio where NI is
the subvendor.

If CONFIG_ACPI is set, the second patch uses the ACPI table to set f_max during
the new ni_byt_sdio_probe_slot.

rv2:
   * Use acpi_evaluate_integer() instead of
     acpi_get_handle()/acpi_evaluate_object()
pv1:
   * Removed redundant comment
   * Print info message if MXFQ not found in acpi table
pv2:
   * Changed info message to error message if MXFQ not found
   * Replaced ni_byt_sdio_probe_slot with one of two versions depending on
     whether CONFIG_ACPI is set.

Zach Brown (2):
  mmc: sdhci-pci: Add PCI ID for Intel byt sdio host controller
    sub-vended by NI
  mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio
    controller sub-vended by NI

 drivers/mmc/host/sdhci-pci-core.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--
2.7.4
