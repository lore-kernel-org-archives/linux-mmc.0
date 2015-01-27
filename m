From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v1 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Tue, 27 Jan 2015 22:50:58 +0530
Message-ID: <1422379260-10139-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:48566 "EHLO
	denmail01.apm.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755617AbbA0RWM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 12:22:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

Due to the fact that the existing of-arasan driver works with 32-bit platforms.
This patch tweaks existing of-arasan driver to work with 64-bit X-Gene
platform using IOMMU translation.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (2):
  mmc: host: arasan: Add addition of-arasan quirks and IOMMU support for
    arasan SDHCI driver.
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.

 arch/arm64/boot/dts/apm-storm.dtsi  | 43 +++++++++++++++++++++++++++
 drivers/mmc/host/Makefile           |  2 ++
 drivers/mmc/host/sdhci-ahbc-xgene.c | 58 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-ahbc-xgene.h | 49 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c  | 11 +++++++
 drivers/mmc/host/sdhci-pltfm.c      | 12 ++++++++
 6 files changed, 175 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.c
 create mode 100644 drivers/mmc/host/sdhci-ahbc-xgene.h

--
1.8.2.1

