From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v2 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Mon, 30 Mar 2015 20:16:06 +0530
Message-ID: <1427726768-17233-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:53883 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752839AbbC3Orf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:47:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

v2 change:
 * Drop the IOMMU support and switching to PIO mode for arasan 
   controller integrated inside APM X-Gene SoC.

Signed-off-by: Suman Tripathi <stripathi@apm.com>

Suman Tripathi (2):
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
  mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c

 arch/arm64/boot/dts/apm-storm.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     | 15 +++++++++++++
 2 files changed, 59 insertions(+)

-- 
1.8.2.1

