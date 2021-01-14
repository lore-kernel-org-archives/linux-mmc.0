Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91BC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C489F23976
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhANUO4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhANUO4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 15:14:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B251DC061575
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 12:14:15 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id n13so5737971qkn.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=e66+6f5Ooob60+bUgoVWv7yZUs3P9lZVZESwc0Aq0pY=;
        b=sA8HzFA5tky1SaZLwHvJLO9v+S2LIh56boezG7Dzggcp+ji+LCgQ2yaRrTxH/sA2LY
         4tl4kOIQjkGba6PVEm4OiQDxX65PqqClezRVX1AWwMeWTs36BYhAKodjgzPkez0qSoqE
         +Voi3ybEJxC0N9y+Wt7mu2WNM6H825wae1dErzo9oSih182w0fmBMcgVqAZTMWOXlLH4
         zKbSVBcjG7FzFtVu1ibre9fjqbikZ1r3nVZBCglXvklkhr6r5t+zQnqE3Opx+vACKwh3
         OB3Pzo1W94z05GpokNccgnCMdnimri5FO1L6KO4q2FXitkh9vKeidoofyhEUTf490ZEp
         ovFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=e66+6f5Ooob60+bUgoVWv7yZUs3P9lZVZESwc0Aq0pY=;
        b=GiuTKT9jB41oReJHlnvSS7Tb1kyeehaIW24uMm+G1D7YgQx1O3YUkMOwaup0PQSY8u
         TFd20udBpbr67mVqFmbGLGnCpZInnEXd0PuS/eTu+SAkDWhb9JDuRsz3LsFF+kEz7S3A
         2kK5+F9pSd74sTCEWsKI2ehCIZOyfqVPccxpSOuZW1eAFdsH5o9qe198SC2PoyZa4Yyp
         z4EHGyaARNVdPz/PbNAeiZggs3OLWAEjJmzT7H8F2Hc5DlfHfhBdOgiQmtZ+oAdDwwCP
         /NtGsRPjUDTCOwk/ARFZWFTSjjo1MbZfkMgy+RcNX8v52I9bvsrevmDYj7rcHL3xx9rw
         i+Vw==
X-Gm-Message-State: AOAM531nT2t3Q9ce9PZPd9pmsnFdk3TYzRs/zY6m+fil2dkaKShS0DFo
        OE4RjNzuDbSnMNoKO6H/g/jGM9o=
X-Google-Smtp-Source: ABdhPJzoSj6O9Gz5IJ+BRvlg0PsI0nUJD+KbXCrn50DVCKN7Z+eRP2spbOpPTopa8htfxJse/vcE8Cg=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a0c:8e85:: with SMTP id x5mr8933145qvb.11.1610655254834;
 Thu, 14 Jan 2021 12:14:14 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:14:05 -0800
Message-Id: <20210114201405.2934886-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2] mmc: core: don't initialize block size from ext_csd if not present
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

Fixes: a5075eb94837 ("mmc: block: Allow disabling 512B sector size emulation")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Link: https://linux-review.googlesource.com/id/If244d178da4d86b52034459438fec295b02d6e60
---
 drivers/mmc/core/queue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index de7cb0369c30..002426e3cf76 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -384,8 +384,10 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 		     "merging was advertised but not possible");
 	blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
 
-	if (mmc_card_mmc(card))
+	if (mmc_card_mmc(card) && card->ext_csd.data_sector_size) {
 		block_size = card->ext_csd.data_sector_size;
+		WARN_ON(block_size != 512 && block_size != 4096);
+	}
 
 	blk_queue_logical_block_size(mq->queue, block_size);
 	/*
-- 
2.30.0.284.gd98b1dd5eaa7-goog

