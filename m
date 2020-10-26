Return-Path: <SRS0=obPU=EB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0798FC4363A
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBF522400
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Oct 2020 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603726830;
	bh=pOt9wtKPKqangfuHUH6+tRCLKSUEff4N/khEnNsCMzg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aQEcqIwM0rVORiIhBKFWJmoENgIh6pAURcXWjHiBwW2kx4OqjeZzAcD8Bhmd9zEkB
	 UiBD0Aa9Jbbuikhr7zf8obkYQsPq14lfbkrgtTb41rVShu2alH2SHWDKUXVW+pSCl3
	 KBb/qx5OjVCteiD+kPHH9Z2PNOjxJ7kp2SHq7Zwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773323AbgJZPka (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Oct 2020 11:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773322AbgJZPka (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Oct 2020 11:40:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A457822404;
        Mon, 26 Oct 2020 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726829;
        bh=pOt9wtKPKqangfuHUH6+tRCLKSUEff4N/khEnNsCMzg=;
        h=From:To:Cc:Subject:Date:From;
        b=uuV65gouyxRylexjetz28pKjdEX6gLb73pkSDShdZ4fFDhmZj0zIXbqxYJZf1cNeo
         U0Q/l1+LWFMjri44+WegQlxHWep/ZnodLKegr0SDiOv0e0Gsrlt4B/M8i4cWL/r/wD
         0bPMP4UJsWujRLFYkc23FZdR1LAvozZ4ZiRjIKO0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] mmc: s3cmci: include GPIO descriptor consumer header
Date:   Mon, 26 Oct 2020 16:38:08 +0100
Message-Id: <20201026153810.89512-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver uses GPIO Descriptor Consumer Interface so include proper
header to fix compile test errors like:

    drivers/mmc/host/s3cmci.c: In function ‘s3cmci_check_sdio_irq’:
    drivers/mmc/host/s3cmci.c:304:7: error:
        implicit declaration of function ‘gpiod_get_value’; did you mean ‘gpio_get_value’? [-Werror=implicit-function-declaration]

    drivers/mmc/host/s3cmci.c: In function ‘s3cmci_probe_pdata’:
    drivers/mmc/host/s3cmci.c:1451:19: error:
        implicit declaration of function ‘devm_gpiod_get_index’ [-Werror=implicit-function-declaration]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 643d54eceef6..a33a7823c265 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -17,7 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-- 
2.25.1

