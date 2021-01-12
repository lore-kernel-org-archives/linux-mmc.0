Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A685C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F347F23121
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437011AbhALVh1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437115AbhALVKe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 16:10:34 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B15C061575
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jan 2021 13:09:53 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e28so2058609pfl.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jan 2021 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=DYH4KGGRLo58+wJXu6Zs0KHvvQ74z/iJErgpXt1oAZo=;
        b=uReNw/Keo7pZ5ELnr3PhQx2Py5XGiTlaa7btJuPcg1ocsJIj6YKiY6DXqtFLhDKMIF
         R1Dm2dABawlmIMOf/+fnyIAm63l1CDAnsysEQUNEB1M/r7eA/vZwnm3/SCMN5EiJo03j
         zxp+2GQEFhgXwpW+F7vG+vUuUGd7inv7C+ErH6mMAVqJPA6Yvh8IfbxOhLkukQ88iANZ
         KUmktcTIq9EifJIFAI8UF1x4cV/Qq9+Q/5qHjeEnKQlLweumHTOQeqigUHMdcyxPQ8o/
         CAcmO4qCi2AKhtIgamPyel+y/SlUSk0i6LDtlNseBU4bv3nDgsgc1zo/JzRb7EswyePC
         DjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=DYH4KGGRLo58+wJXu6Zs0KHvvQ74z/iJErgpXt1oAZo=;
        b=RwYrcs3yztXE9h9FBxyS46J2SHEhWGGGGlte4ZNa+92bGs9TngqCTz6RYVJkmr/Y0t
         1naK4rJhh+m72FxRfnuvH9ORd05uS/fsx7yu5wWgYysqwbPDNBqYRB7fio5RFNv7ebDz
         NN8g1oNrbXNi08x0XW5/tedKJsXoirkEqDcqTyuteOlKK94VRSi8ISRdXBfFMQPzJoaK
         2U/NFHf4URNvH/n5Zc/ElYvyr2Y8d8+pDjvXbnlMnMoQavqV3SttrX8RIYZrS6bLqVSM
         gUDbNa8eGSBY0aTmiVDFQW/sH+WivC9kn06m2HJkZXBNGMQRVP/G1Qq7FoXxVRuyCj1O
         Rpcg==
X-Gm-Message-State: AOAM533CMkJkwGQ/LYez3k2r4LQmyjIOUYIvgwTOoby3kN6qzxwovIg6
        uWdUHIgYHGAeiEs6NZBd2NPT0Qk=
X-Google-Smtp-Source: ABdhPJyUbIUFqJvnqbEtnF2GM+dp3za6uUWvNwxsyNUHMCzfHHHwXk0ZgnC607brm2xtZc07CdFzcPo=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a65:460d:: with SMTP id v13mr940156pgq.414.1610485793131;
 Tue, 12 Jan 2021 13:09:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:09:44 -0800
Message-Id: <20210112210944.605953-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] mmc: core: don't initialize block size from ext_csd if not present
From:   Peter Collingbourne <pcc@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peter Collingbourne <pcc@google.com>, linux-mmc@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If extended CSD was not available, the eMMC driver would incorrectly
set the block size to 0, as the data_sector_size field of ext_csd
was never initialized. This issue was exposed by commit 817046ecddbc
("block: Align max_hw_sectors to logical blocksize") which caused
max_sectors and max_hw_sectors to be set to 0 after setting the block
size to 0, resulting in a kernel panic in bio_split when attempting
to read from the device. Fix it by only reading the block size from
ext_csd if it is available.

Fixes: 817046ecddbc ("block: Align max_hw_sectors to logical blocksize")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
---
 drivers/mmc/core/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index de7cb0369c30..735cdbf1145c 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -20,6 +20,7 @@
 #include "core.h"
 #include "card.h"
 #include "host.h"
+#include "mmc_ops.h"
 
 #define MMC_DMA_MAP_MERGE_SEGMENTS	512
 
@@ -384,7 +385,7 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		     "merging was advertised but not possible");
 	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
-	if (mmc_card_mmc(card))
+	if (mmc_card_mmc(card) && mmc_can_ext_csd(card))
 		block_size = card->ext_csd.data_sector_size;
 
 	blk_queue_logical_block_size(mq->queue, block_size);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

