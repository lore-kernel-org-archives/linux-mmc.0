From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v8 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Fri, 19 Jun 2015 17:30:25 +0530
Message-ID: <1434715227-27399-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:52602 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752531AbbFSMBr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2015 08:01:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com, ulf.hansson@linaro.org, khilman@deeprootsystems.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, arm@kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

v2 change:
 * Drop the IOMMU support and switching to PIO mode for arasan.
   controller integrated inside APM X-Gene SoC.

v3 change:
 * Change the sdhci-of-arasan.c to support arasan4.9a.
 * Add quirks for arasan4.9a.

v4 change:
 * Cleanup the Documentation and dts.

v5 change:
 * Rebase the dts files.
 * Drop patch 2 and 3 as it is applied.

v6 change:
 * Clean the unrequired properties from dts.
 * Rename sdhc to sdhci.
 * support to disable timming using capability register read.

v7 change:
 * Rename sdhci nodes to mmc.

v8 change:
 * Drop the support to disable timming using capability register read.
 * Add SDHCI_QUIRK2_NO_1_8_V for 4.9a version of arasan.

Suman Tripathi (2):
  arm64: dts: Add the arasan mmc nodes in apm-storm.dtsi
  mmc: host: sdhci: Disable 1.8V signaling for arasan 4.9a version of
    SDHCI controller.

 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c      |  3 ++-
 3 files changed, 49 insertions(+), 1 deletion(-)

--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
