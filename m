Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D347EB64D9
	for <linux-mmc@archiver.kernel.org>; Sat, 17 Jun 2023 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjFQUgl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 17 Jun 2023 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjFQUgk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Jun 2023 16:36:40 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADCB1723
        for <linux-mmc@vger.kernel.org>; Sat, 17 Jun 2023 13:36:38 -0700 (PDT)
Received: from localhost.localdomain (178.176.79.248) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sat, 17 Jun
 2023 23:36:29 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH v3 00/12] Fix deferred probing in the MMC/SD drivers
Date:   Sat, 17 Jun 2023 23:36:10 +0300
Message-ID: <20230617203622.6812-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [178.176.79.248]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 06/17/2023 20:23:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178086 [Jun 16 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_no_received}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.248 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: omp.ru:7.1.1;178.176.79.248:7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.248
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/17/2023 20:29:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/17/2023 5:34:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Here are 12 patches against the 'fixes' branch of Ulf Hansson's 'mmc.git' repo.

The affected MMC/SD drivers call platform_get_irq[_byname]() but override its
result in case of error which prevents the deferred probing from working. Some
of these patches logically depend on commit ce753ad1549c ("platform: finally
disallow IRQ0 in platform_get_irq() and its ilk")...

Sergey Shtylyov (12):
  mmc: bcm2835: fix deferred probing
  mmc: meson-gx: fix deferred probing
  mmc: mtk-sd: fix deferred probing
  mmc: mvsdio: fix deferred probing
  mmc: omap: fix deferred probing
  mmc: omap_hsmmc: fix deferred probing
  mmc: owl: fix deferred probing
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
 drivers/mmc/host/sdhci-acpi.c   | 2 +-
 drivers/mmc/host/sdhci-spear.c  | 4 ++--
 drivers/mmc/host/sh_mmcif.c     | 2 +-
 drivers/mmc/host/sunxi-mmc.c    | 4 ++--
 drivers/mmc/host/usdhi6rol0.c   | 6 ++++--
 12 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.26.3

