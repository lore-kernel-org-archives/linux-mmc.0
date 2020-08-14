Return-Path: <SRS0=tY5E=BY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B0DC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FB420791
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Aug 2020 19:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHNTKG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:10:06 -0400
Received: from mail.manjaro.org ([176.9.38.148]:52426 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgHNTKG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Aug 2020 15:10:06 -0400
X-Greylist: delayed 1171 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2020 15:10:06 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 922D7E1446;
        Fri, 14 Aug 2020 20:50:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XD5iMQt1uVXx; Fri, 14 Aug 2020 20:50:31 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] mmc: mmc_spi: fix timeout calculation
Date:   Fri, 14 Aug 2020 20:50:11 +0200
Message-Id: <20200814185011.3252020-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Previously the cycle timeout was converted to a microsecond value but
then incorrectly treated as a nanosecond timeout. This patch changes
the code to convert both the nanosecond timeout and the cycle timeout
to a microsecond value and use that directly.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/mmc/host/mmc_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 39bb1e30c2d7..f85e0ad896a9 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -882,9 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 	else
 		clock_rate = spi->max_speed_hz;
 
-	timeout = data->timeout_ns +
+	timeout = data->timeout_ns / 1000 +
 		  data->timeout_clks * 1000000 / clock_rate;
-	timeout = usecs_to_jiffies((unsigned int)(timeout / 1000)) + 1;
+	timeout = usecs_to_jiffies((unsigned int)timeout) + 1;
 
 	/* Handle scatterlist segments one at a time, with synch for
 	 * each 512-byte block
-- 
2.28.0

