Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49483C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 26 Dec 2021 14:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhLZOPj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 26 Dec 2021 09:15:39 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:60841 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhLZOPj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Dec 2021 09:15:39 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1UJFniO861UGB1UJFnONmF; Sun, 26 Dec 2021 15:15:38 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Dec 2021 15:15:38 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: pwrseq: Use bitmap_free() to free bitmap
Date:   Sun, 26 Dec 2021 15:15:36 +0100
Message-Id: <07a8e48db446888bd77f16b88568e80904f52103.1640528089.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

kfree() and bitmap_free() are the same. But using the later is more
consistent when freeing memory allocated with bitmap_alloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/core/pwrseq_simple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index ea4d3670560e..988467fbb621 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -54,7 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
 					       reset_gpios->info, values);
 
-		kfree(values);
+		bitmap_free(values);
 	}
 }
 
-- 
2.32.0

