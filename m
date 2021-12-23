Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA892C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 17:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbhLWRMJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:12:09 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:34928 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbhLWRMG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 12:12:06 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 2215B20326BE
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 0/13] Fix deferred probing in the MMC/SD drivers
Date:   Thu, 23 Dec 2021 20:11:49 +0300
Message-ID: <20211223171202.8224-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Here are 13 patches against the 'fixes' branch of Ulf Hansson's 'usb.git' repo.
The affected MMC/SD drivers call platform_get_irq() but override its result
in case of error which prevents the deferred probing from working. Some of
these patches logically depend on the previously posted (and yet unmerged)
patch:

https://marc.info/?l=linux-kernel&m=163623041902285

Because of that dependency the patches are marked as RFC.

Sergey Shtylyov (13):
  mmc: bcm2835: fix deferred probing
  mmc: meson-gx: fix deferred probing
  mmc: mtk-sd: fix deferred probing
  mmc: mvsdio: fix deferred probing
  mmc: omap: fix deferred probing
  mmc: omap_hsmmc: fix deferred probing
  mmc: owl: fix deferred probing
  mmc: s3mci: fix deferred probing
  mmc: sdhci-acpi: fix deferred probing
  mmc: sdhci-spear: fix deferred probing
  mmc: sh_mmcif: fix deferred probing
  mmc: sunxi: fix deferred probing
  mmc: usdhi60rol0: fix deferred probing

 drivers/mmc/host/bcm2835.c      | 4 ++--
 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 drivers/mmc/host/mtk-sd.c       | 2 +-
 drivers/mmc/host/mvsdio.c       | 2 +-
 drivers/mmc/host/omap.c         | 2 +-
 drivers/mmc/host/omap_hsmmc.c   | 6 ++++--
 drivers/mmc/host/owl-mmc.c      | 2 +-
 drivers/mmc/host/s3cmci.c       | 4 ++--
 drivers/mmc/host/sdhci-acpi.c   | 2 +-
 drivers/mmc/host/sdhci-spear.c  | 4 ++--
 drivers/mmc/host/sh_mmcif.c     | 2 +-
 drivers/mmc/host/sunxi-mmc.c    | 4 ++--
 drivers/mmc/host/usdhi6rol0.c   | 6 ++++--
 13 files changed, 24 insertions(+), 20 deletions(-)

-- 
2.26.3

