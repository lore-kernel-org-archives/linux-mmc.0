Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4779FC43603
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C5F2080D
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 18:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="FDe0UB5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLIShL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:37:11 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:45724 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfLIShL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Dec 2019 13:37:11 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47WsL41VqKzCS;
        Mon,  9 Dec 2019 19:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575916476; bh=or7Oj6xnUL/WDCELdOhIBVwh1AdCpOT9i9SKDT6ot5Y=;
        h=Date:From:Subject:To:Cc:From;
        b=FDe0UB5ceT51Pl4PG1WYMSGUL+PxNPgip6WXgT9/QRzRRYsdvHXw4n5/BTpKF0t+N
         Aux17mYjRjlxjEBkXKeFqp2gBGKu6u+CyDX+9bk+c3c/0mz57OsqRWuFn01lmbVHL1
         IEyyJ1ZcWCluRdTjLJtuY5iGdAesv2o0AKGIsUNxfPlOEMxg5AsiLkSXBLDJaKQwRw
         2We52qw2vr0UO+YQ27mp+ngA5CJj3pojIQgZaAWd3DrO2h4YJegAxJiY6ENZHrjpLJ
         7t9SqeQCbnXauSoWSiV0OGrYa3jt1k6Q89EwEW+r2z4dUgZsp7UvpF/S4yTKIExqQg
         oASz5B8UKIDrA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 09 Dec 2019 19:37:05 +0100
Message-Id: <3f12c2deaae9e77a5e7ab8415db7751a27bc3b98.1575916477.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] mmc: sdhci-s3c: remove unused ext_cd_gpio field
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-s3c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 51e096f27388..8b15945dd499 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -117,7 +117,6 @@ struct sdhci_s3c {
 	struct s3c_sdhci_platdata *pdata;
 	int			cur_clk;
 	int			ext_cd_irq;
-	int			ext_cd_gpio;
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
@@ -512,7 +511,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 			goto err_pdata_io_clk;
 	} else {
 		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
-		sc->ext_cd_gpio = -1; /* invalid gpio number */
 	}
 
 	drv_data = sdhci_s3c_get_driver_data(pdev);
-- 
2.20.1

