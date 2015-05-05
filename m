From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v5 0/1] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Tue,  5 May 2015 14:47:05 +0530
Message-ID: <1430817426-5241-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:48396 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753275AbbEEJSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 05:18:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

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
 * Drop patch 2 and 3 as it is applied

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (1):
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.

 arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
 arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--
1.8.2.1

