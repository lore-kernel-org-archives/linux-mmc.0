Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54C7C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 09:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiGSJw3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGSJw2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 05:52:28 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A37B55B4
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0oT95
        6jqtnm5daxYu+PVgmXmnNLYvx8AxjjhOf4nbMw=; b=g40MQlqhD1Ul9dpC1a6xT
        EJp12DlZ1tRw5YPZq641OhJCUyuK1s3UU9jOa8P7LXitdOXU+VqaTZU87mcKplUj
        sP1Cl3cShQR3+h8z4yuNi0pSgEAPd8HEVLdt4fF5YOxRn2JeJjkwNXVidIYVWLSN
        ybvgzCz/jfMaN55GiGXtDM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgDXuF3RftZinYuJIA--.1515S3;
        Tue, 19 Jul 2022 17:52:19 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     rric@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        windhl@126.com
Subject: [PATCH 2/2] mmc: cavium-thunderx: Add of_node_put() when breaking out of loop
Date:   Tue, 19 Jul 2022 17:52:16 +0800
Message-Id: <20220719095216.1241601-2-windhl@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719095216.1241601-1-windhl@126.com>
References: <20220719095216.1241601-1-windhl@126.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDXuF3RftZinYuJIA--.1515S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4DArWxCryxXFyDZFW7CFg_yoWfXFbE93
        ZxXF9rJr17Jry29wn7Kr4Sq34rtwsY9r4xGryktr45Wa18Arn8WayvvFykJw1UZrWDuF9x
        CrnIyr4xArWYyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREb183UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7RJDF1pEAbSqsQABsa
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In thunder_mmc_probe(), we should call of_node_put() when breaking
out of for_each_child_of_node() which has increased and decreased
the refcount during each iteration.

Fixes: 166bac38c3c5 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/mmc/host/cavium-thunderx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index 76013bbbcff3..202b1d6da678 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -142,8 +142,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 				continue;
 
 			ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
-			if (ret)
+			if (ret) {
+				of_node_put(child_node);
 				goto error;
+			}
 		}
 		i++;
 	}
-- 
2.25.1

