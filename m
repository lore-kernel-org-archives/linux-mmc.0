Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18FC63798
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 03:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A58822228
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 03:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392360AbgK0Dnd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 22:43:33 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:48766 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgK0Dnd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 22:43:33 -0500
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2020 22:43:33 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id DD2602015B9C;
        Fri, 27 Nov 2020 11:35:32 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VgSgMziShfar; Fri, 27 Nov 2020 11:35:32 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id C2A312015B8C;
        Fri, 27 Nov 2020 11:35:32 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id BBD0EC01F81;
        Fri, 27 Nov 2020 11:35:32 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id B9185200756; Fri, 27 Nov 2020 11:35:32 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Seungwon Jeon <tgih.jun@samsung.com>,
        Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: core: MMC_CAP2_HS200_1_8V_SDR with mmc-hs400-1_8v
Date:   Fri, 27 Nov 2020 11:35:21 +0800
Message-Id: <20201127033527.407-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch remove the MMC_CAP2_HS200_1_8V_SDR capacity from
host->cap2 when the dt property mmc-hs400-1v8 set. It cause
error and occasionally hang on boot and reboot.
Board with this issue: rk3399 with SanDisk DG4008 eMMC.

This patch did not change the mmc-hs400-1_2v host->cap2
added the MMC_CAP2_HS200_1_2V_SDR.

Log shows a boot process with a HS400 5.1 capable SanDisk 8G
with mmc-hs400-1_8v dt property and the MMC_CAP2_HS200_1_8V_SDR
append to the host->cap2.

[    1.775721] mmc1: CQHCI version 5.10
[    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    2.007581] mmc1: mmc_select_hs200 failed, error -110
[    2.007589] mmc1: error -110 whilst initialising MMC card
[    2.413559] mmc1: mmc_select_hs200 failed, error -110
[    2.413562] mmc1: error -110 whilst initialising MMC card
[    3.183343] mmc1: Command Queue Engine enabled
[    3.183355] mmc1: new HS400 MMC card at address 0001
[    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB
[    3.197256] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
[    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
[    3.197479] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)

after patch applied
[    1.746691] mmc1: CQHCI version 5.10
[    1.773316] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    1.858410] mmc1: Command Queue Engine enabled
[    1.858418] mmc1: new HS400 MMC card at address 0001
[    1.858897] mmcblk1: mmc1:0001 DG4008 7.28 GiB
[    1.859002] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
[    1.859097] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
[    1.859182] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)

Fixes: c373eb489b27b mmc: core: add DT bindings for eMMC HS400 1.8/1.2V

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 96b2ca1f1b06..f55113e24c68 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -295,7 +295,7 @@ int mmc_of_parse(struct mmc_host *host)
 	if (device_property_read_bool(dev, "mmc-hs200-1_2v"))
 		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
 	if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
-		host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
+		host->caps2 |= MMC_CAP2_HS400_1_8V;
 	if (device_property_read_bool(dev, "mmc-hs400-1_2v"))
 		host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
 	if (device_property_read_bool(dev, "mmc-hs400-enhanced-strobe"))
--
2.20.1

