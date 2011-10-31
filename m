From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] mmc: samsung-soc: support the second capability
Date: Mon, 31 Oct 2011 14:58:11 +0900
Message-ID: <4EAE38F3.4090400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17765 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab1JaF6O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2011 01:58:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>

This patch-set is added the platdata for the second capability.
At latest, added the cap2 for capability in mmc-core.
Samsung-SoC should use this field.

Jaehoon Chung (2):
  sdhci: support the second capability for hsmmc.
  sdhci-s3c: add platform data for the second capability

 arch/arm/plat-samsung/dev-hsmmc.c          |    2 ++
 arch/arm/plat-samsung/dev-hsmmc1.c         |    2 ++
 arch/arm/plat-samsung/dev-hsmmc2.c         |    2 ++
 arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
 arch/arm/plat-samsung/include/plat/sdhci.h |    1 +
 drivers/mmc/host/sdhci-s3c.c               |    2 ++
 6 files changed, 11 insertions(+), 0 deletions(-)
