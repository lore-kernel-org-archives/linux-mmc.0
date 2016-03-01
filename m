From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/2] mmc: sdhci: Set DMA mask if specified
Date: Tue, 1 Mar 2016 13:32:42 +0900
Message-ID: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17067 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcCAEmQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Feb 2016 23:42:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

Allow host drivers to set the sdhci_host's dma_mask in order to specify the
supported DMA range of a device. Without this, devices that are capable of
64-bit addressing might end up using bounce buffers because the default DMA mask
is 32-bit.

Changes since v1:
- Set the DMA mask in the common code
- Set the capabilities of the various Tegra controllers

Alexandre Courbot (2):
  mmc: sdhci: Set DMA mask
  mmc: sdhci-tegra: Specify valid DMA mask

 drivers/mmc/host/sdhci-tegra.c | 8 ++++++++
 drivers/mmc/host/sdhci.c       | 8 +++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.7.2

