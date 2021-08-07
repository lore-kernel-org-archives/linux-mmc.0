Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A24AC43216
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA71B60C51
	for <linux-mmc@archiver.kernel.org>; Sat,  7 Aug 2021 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhHGLHt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 7 Aug 2021 07:07:49 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbhHGLHq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Aug 2021 07:07:46 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAOeB-1mIbhd344x-00BwOU; Sat, 07 Aug 2021 13:07:10 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 05/10] mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711
Date:   Sat,  7 Aug 2021 13:06:36 +0200
Message-Id: <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:u0dsEv9jFM+tW+Sg1Dp3uVwEizVQrVB28BJ35SkprIsS+lWZL+/
 QbkH8H57xvdZE34nPO+nJwt9cJP21qQUWf9Lc/tTJyZPLiu0U5Hukyps95nBDkhPrzIZeAD
 RLy8p9Be0C2k5HMQCDa50/mnBxZJFR4bYKQvrc/EIslGjFMfPrnOVXAl6n+2MIjTffERJt/
 /81T3awZ6H1FhMaL8Ielw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SKENu3phtEQ=:9NLKQGVRYLgrZ3PQ8+QXiy
 kfotEGl1sQEcA3qstF0HDGvz3Wdkc+xOaxVgyLenGayUnzVh/Scm+nn07evH5988ZmRJzMrzc
 GgLawXLjDa37UvDL5NcG7enhWwA29GDPZWLyk3aiKNR/B5cASF41lZCWfCPisJOuTWhv+CDoi
 2nxkMgPiF9WtSTyZip/xWUQUoa36py3KFHDkY2OJfw9tmuZNHtxXieUv8olRsOZycRUdHp3g8
 FK5wLXjCFgyOq/IX5cdUmAhDHXwUwxOLALJX/QeE5Ccw2nBdpUb/6feyLk4cm81rpai9TOM/s
 UyjiPwmuh5WzIM/dSerG7nsZR1Xd2aN/TMAqkWKRx5rNdSMxO//HsV05m0/FA8EFtxIIBARtN
 VrkXSbn0FcBRag01meD6ntB2GQi6jO+7VIErMw2BQRy72oDLJw5GvI3jPVvvyt5q9kkM63JdO
 IU1M3RPe8adcz8Kn2EFfs8dVX8oLiYokEk9uy+lm6ykaPnjPplkrZtu9Po3SSdBE9rtJ3nejU
 AlahHNZxlqR+kuHLj8zl+oxyd0uXbgbahksm4m0Pv7xwiQ40QR7QZnZ405+CfAECBmNwI+68H
 tlxC8XTICgN2XeMmwmKdJ96msjrBX6etIzGwWTJECGj+wmrJ1G6J26FKMTKh3itOuYQw+WJVL
 /kJFCEseOjgRvMlj/W0/09w/ciH9uYj2+cm7p/Fvnyp1RvrYEqEEgZjBpCdyz1kmlFo5rNeXa
 MoiW6Sz25svrklg6KcYn2m5eazlT+rjXiC8cfjQGdU5sKAPQJWqGU7nVkFO8y4kKVvqneoSK2
 OhduJAS/F3qbNhaBhv6cZsrvNOlrrzgtnIdCn3SlLKpaEbHBN9geLB9ZyMB77KFSp061oieKT
 nkyWRCOt8rziBz6VtvUQ==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenz@kernel.org>

The controller doesn't seem to pick-up on clock changes, so set the
SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag to query the clock frequency
directly from the clock.

Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 032bf85..e7565c6 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -295,7 +295,8 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
-	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.ops = &sdhci_iproc_bcm2711_ops,
 };
 
-- 
2.7.4

