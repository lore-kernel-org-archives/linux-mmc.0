Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5EC47089
	for <linux-mmc@archiver.kernel.org>; Thu, 27 May 2021 19:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC432613DD
	for <linux-mmc@archiver.kernel.org>; Thu, 27 May 2021 19:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhE0ToF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 May 2021 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhE0ToE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 May 2021 15:44:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B655C061760
        for <linux-mmc@vger.kernel.org>; Thu, 27 May 2021 12:42:30 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:751e:82a3:f2a2:3459])
        by baptiste.telenet-ops.be with bizsmtp
        id 9viU2500S20MPSF01viU9o; Thu, 27 May 2021 21:42:29 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lmLtk-00A5x2-1c; Thu, 27 May 2021 21:42:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lmLtj-0079ia-LJ; Thu, 27 May 2021 21:42:27 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Addy Ke <addy.ke@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: dw_mmc-pltfm: Remove unused <linux/clk.h>
Date:   Thu, 27 May 2021 21:42:26 +0200
Message-Id: <20210527194226.1705607-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As of commit 4cdc2ec1da322776 ("mmc: dw_mmc: move rockchip related code
to a separate file"), dw_mmc-pltfm.c no longer uses the clock API.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 73731cd3ba2315e3..9901208be7973f67 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -17,7 +17,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
-#include <linux/clk.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
-- 
2.25.1

