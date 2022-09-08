Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2BC38145
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Sep 2022 13:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIHNNt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiIHNNc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Sep 2022 09:13:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F173CD418E;
        Thu,  8 Sep 2022 06:12:58 -0700 (PDT)
X-QQ-mid: bizesmtp71t1662642752t5e18e81
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:12:31 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: G46xFj+wOV8sI+FK+NqXHOWXK0+SIrMvWYb0Uu+uYk9KoArmwQsARkOTGOiN1
        xy48FexZCTK8Yet4hObjFHzrEuHtJBsZQavBXeYQKxgYxLj74uzWsgtsVSZC07l0+UhdEz1
        F5hje2Av2AvqX9bRGpWKb6S20OlWyV+tJbrbzxl0KhdL6PvkjB4dq1NdGOKGSmPmAmB2UfG
        XXkmYCCzXKU4IdGu0or3ewq8I1yi2JEExIleDpg2vWQuZmjnxmeEescLD7eYOAIX011jx8r
        tZx5WKRboyLSMCTpB3c9x5Xvia1perbDVoPfoYNoIeKnxCKdiEze20jDgCsyGG5GQfwvwhN
        /tfFkFNG/2ecwXEZjrIkWTY5Djs80rdCCsKjFdS15PkPCNMBJU6vEDGRsPX2Q==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/core: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:12:24 +0800
Message-Id: <20220908131224.37721-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b89dca1f15e9..5457c8aeeea1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(mmc_of_parse_clk_phase);
  * @host: host whose properties should be parsed.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
- * used to to instantiate and configure this host instance or not, we
+ * used to instantiate and configure this host instance or not, we
  * parse the properties and set respective generic mmc-host flags and
  * parameters.
  */
-- 
2.36.1

