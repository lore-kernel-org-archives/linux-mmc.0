From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v3 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Fri,  1 May 2015 10:24:09 +0530
Message-ID: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:42697 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753014AbbEAEzj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 00:55:39 -0400
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

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (3):
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
  mmc: host: arasan: Add the support for sdhci-arasan4.9a in
    sdhci-of-arasan.c
  Documentation: mmc: Update Arasan SDHC documentation to support 4.9a
    version of     Arasan SDHC controller.

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  5 ++-
 arch/arm64/boot/dts/apm-mustang.dts                |  4 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 | 44 ++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c                 |  7 ++++
 4 files changed, 58 insertions(+), 2 deletions(-)

--
1.8.2.1

