Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC4C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 09:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiGSJw1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSJw0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 05:52:26 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30EED55B4
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qtuWz
        fYXdNmS2pAoRs13wnqDxu76zXli7AufO2gvSYs=; b=Wro8qj5VZupZgJmO+eMoJ
        ILAzibx7xLmchlLRYrG9Qm1b0FiiLHBGqOe8FD7m/03xOnZw6zIruCtsFoEz2z5o
        QUE2nogsEbiZWxm2VC0zmiwJWsbvQ1IGJdU39EoPPOlTerE69vmh6jPCY3DwIOAS
        9mj/68Bd3ZxtEoexRjcqpM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgDXuF3RftZinYuJIA--.1515S2;
        Tue, 19 Jul 2022 17:52:18 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     rric@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        windhl@126.com
Subject: [PATCH 1/2] mmc: cavium-octeon: Add of_node_put() when breaking out of loop
Date:   Tue, 19 Jul 2022 17:52:15 +0800
Message-Id: <20220719095216.1241601-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDXuF3RftZinYuJIA--.1515S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4DArWxCryxXFykXr17Awb_yoW3KFb_uF
        47XF9xXF4xAFW2q3Z3Kr4Sv34IkwnY9r18XF18trWFqFy5Zw15Xas3ZryDJr1Uu3yDZFZ8
        Cwn3Kr47AayfCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKFApDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBJDF2JVkbjuvgAAsw
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In octeon_mmc_probe(), we should call of_node_put() when breaking
out of for_each_child_of_node() which has increased and decreased
the refcount during each iteration.

Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/mmc/host/cavium-octeon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 2c4b2df52adb..12dca91a8ef6 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -277,6 +277,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "Error populating slots\n");
 			octeon_mmc_set_shared_power(host, 0);
+			of_node_put(cn);
 			goto error;
 		}
 		i++;
-- 
2.25.1

