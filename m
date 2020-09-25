Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6AC4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684DD235F8
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601018764;
	bh=wGB5w4gO/unnniGON8j7h/PiBcLOT5xCHGPMg1d6iH0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wWQpSN0hXhJ5EvbCFx6A1y33oAeYXCFqv8zElbB3ZPL4UUZcxZCdMqB55qqyH/uz7
	 u+jcbUx3Gs18rSmw/2bBqAmK8X5xj+IwAwoZ9hmoWXv/e+pVGh2x1WqXYJwmy2fquC
	 YX9/dzlUSevWjPuqRt0qhh3SDyCbNexjeUiafVfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgIYH0D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYH0A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 25 Sep 2020 03:26:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BE42086A;
        Fri, 25 Sep 2020 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601018759;
        bh=wGB5w4gO/unnniGON8j7h/PiBcLOT5xCHGPMg1d6iH0=;
        h=From:To:Cc:Subject:Date:From;
        b=WmJ/GoaN55ZSvsvckkVBJJNmo/L6RFQiBmJRqEmESCvP59fLC00NKfvwIzmn7nNuk
         nMaqGPuPKHtm0t7LuI4WgSHj6IAl9fKMOSO9u+a/uew6Dbts08SB1hd8WM/8Ubf05U
         /IPnSzlf8+POs1Pd+tugoEQs1hb0FZ4cPkZjuM8E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: sdhci-s3c: hide forward declaration of of_device_id behind CONFIG_OF
Date:   Fri, 25 Sep 2020 09:25:32 +0200
Message-Id: <20200925072532.10272-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The struct of_device_id is not defined with !CONFIG_OF so its forward
declaration should be hidden to as well.  This should address clang
compile warning:

  drivers/mmc/host/sdhci-s3c.c:464:34: warning: tentative array definition assumed to have one element

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-s3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cb5f87be7535..f48a788a9d3d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -461,7 +461,9 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_OF
 static const struct of_device_id sdhci_s3c_dt_match[];
+#endif
 
 static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
-- 
2.17.1

