From: "Chen, Alvin" <alvin.chen@intel.com>
Subject: [PATCH v2] mmc: sdhci-pci: Add support for Intel Quark X1000 SDIO host controller
Date: Tue, 24 Jun 2014 06:56:35 -0700
Message-ID: <1403618196-7366-1-git-send-email-alvin.chen@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56158 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbaFXGBz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Jun 2014 02:01:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Boon Leong Ong <boon.leong.ong@intel.com>

From: "Alvin (Weike) Chen" <alvin.chen@intel.com>

Hi,
Intel Quark X1000 consists of one SDIO host controller which can be PCI enumerated. 
SDHCI-PCI layer doesn't support it. Thus, we add support for Intel Quark X1000 SDIO as well.

Derek Browne (1):
  Quark SDIO host controller

 drivers/mmc/host/sdhci-pci.c |   12 ++++++++++++
 drivers/mmc/host/sdhci-pci.h |    1 +
 2 files changed, 13 insertions(+)

-- 
1.7.9.5

