Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B087BC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8862761154
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 06:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhEGGgh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEGGgg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 02:36:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719DC061574;
        Thu,  6 May 2021 23:35:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t2-20020a17090a0242b0290155433387beso4104793pje.1;
        Thu, 06 May 2021 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MdGUaPU7yibQsBCZ3hPrQEdEkgQ86Nbhm56382dzuoU=;
        b=dJiQFAc58DjdW1fucm+IV13MmhDemgVOqKGOhfkOEfrvYE/6AwnLUFg235fep+oRp0
         FHMAco0UiTfA4D/DWZtw0Sw9eSuNgFEuUfw8Hj//ED8Cn8nBFED6gmzImWCThsUV/H3Y
         nhIAV43e7uPBD+gFoUvTDtPTOvx3+MJDicT7SzHAQrqR56NUniHPr3CDHom69PtFHnbE
         jt0xEbbj+xMm6tUBAD+a1XF7wFwh+EsOTRuGno+lFlYdTa4ko4NBrgxkZzwDAk5AO4k4
         hnuU21nc0t8jc/Bm8UYUfqLDkGIKuPunG4VGAu4wf5Undhcg0Xp6pJvcq7tnqrUluchO
         8tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MdGUaPU7yibQsBCZ3hPrQEdEkgQ86Nbhm56382dzuoU=;
        b=id7lsPm8RHsxIu3qPGbhx//ELT4XFJPqIcT1grec45fwBN+DxFbxacXoFMBRuY6yOu
         75kUMKthwEGxjXOFH1gpI3orO/5zxuO6BR8r82+bPCaZLlfDTCr+iWpfMuZcydr8rMdC
         UzhUsR29pAdDjRoP7I9laxSX48oUIisQLYWfX+18fU+RWAVj8v53ajgwdrG6g+F1Bihg
         TD5o/yDfNGNn+7wmnmqvDqZdGMSWGwwcD3eBxvuifLTgaWtFYQ8Zw8o56hqRR2+5C1Le
         B1qwceDFVZicdJ1wyMLJgoGxtlffUiYQNc79J/spWOLfdgMcVqxL05Rihke5GEUK+MDg
         FoPA==
X-Gm-Message-State: AOAM533R6JX95TLVISIjEt9R4oNKwMRWheufz9qi8hSb4biKbhNxXzqX
        tRKaRczv7p7llaWA6g3TAWQ=
X-Google-Smtp-Source: ABdhPJxBE4d4rfTt3Dr7fLSPCjAux+Ys0sxqnNpHdK5merpu5Pu1nNdNavPa9IAmyLH0CRZadH9SVA==
X-Received: by 2002:a17:902:b616:b029:ee:c73b:163d with SMTP id b22-20020a170902b616b02900eec73b163dmr8764807pls.30.1620369336131;
        Thu, 06 May 2021 23:35:36 -0700 (PDT)
Received: from localhost ([157.45.101.202])
        by smtp.gmail.com with ESMTPSA id t12sm3449138pjw.51.2021.05.06.23.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 May 2021 23:35:35 -0700 (PDT)
Date:   Fri, 7 May 2021 12:05:28 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     maximlevitsky@gmail.com
Cc:     oakad@yahoo.com, ulf.hansson@linaro.org, colin.king@canonical.com,
        gustavoars@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: memstick: core:ms_block.c: Fix alignment of block
 comment
Message-ID: <20210507063528.tvlbu2cwnlczgbga@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A * has been added to subsequent lines of block comment
The closing */ has been shifted to a new line
A new line has been give after declaration
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/memstick/core/ms_block.c | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 8004dd64d09a..d971acd98236 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -129,7 +129,7 @@ static int msb_sg_compare_to_buffer(struct scatterlist *sg,
  * Each zone consists of 512 eraseblocks, out of which in first
  * zone 494 are used and 496 are for all following zones.
  * Therefore zone #0 hosts blocks 0-493, zone #1 blocks 494-988, etc...
-*/
+ */
 static int msb_get_zone_from_lba(int lba)
 {
 	if (lba < 494)
@@ -348,8 +348,9 @@ static int h_msb_read_page(struct memstick_dev *card,
 	switch (msb->state) {
 	case MSB_RP_SEND_BLOCK_ADDRESS:
 		/* msb_write_regs sometimes "fails" because it needs to update
-			the reg window, and thus it returns request for that.
-			Then we stay in this state and retry */
+		 * the reg window, and thus it returns request for that.
+		 * Then we stay in this state and retry
+		 */
 		if (!msb_write_regs(msb,
 			offsetof(struct ms_register, param),
 			sizeof(struct ms_param_register),
@@ -368,7 +369,8 @@ static int h_msb_read_page(struct memstick_dev *card,
 	case MSB_RP_SEND_INT_REQ:
 		msb->state = MSB_RP_RECEIVE_INT_REQ_RESULT;
 		/* If dont actually need to send the int read request (only in
-			serial mode), then just fall through */
+		 * serial mode), then just fall through
+		 */
 		if (msb_read_int_reg(msb, -1))
 			return 0;
 		fallthrough;
@@ -702,7 +704,8 @@ static int h_msb_parallel_switch(struct memstick_dev *card,
 
 	case MSB_PS_SWICH_HOST:
 		 /* Set parallel interface on our side + send a dummy request
-			to see if card responds */
+		  * to see if card responds
+		  */
 		host->set_param(host, MEMSTICK_INTERFACE, MEMSTICK_PAR4);
 		memstick_init_req(mrq, MS_TPC_GET_INT, NULL, 1);
 		msb->state = MSB_PS_CONFIRM;
@@ -821,6 +824,7 @@ static int msb_mark_page_bad(struct msb_data *msb, int pba, int page)
 static int msb_erase_block(struct msb_data *msb, u16 pba)
 {
 	int error, try;
+
 	if (msb->read_only)
 		return -EROFS;
 
@@ -997,6 +1001,7 @@ static int msb_write_block(struct msb_data *msb,
 			u16 pba, u32 lba, struct scatterlist *sg, int offset)
 {
 	int error, current_try = 1;
+
 	BUG_ON(sg->length < msb->page_size);
 
 	if (msb->read_only)
@@ -1045,11 +1050,12 @@ static int msb_write_block(struct msb_data *msb,
 		error = msb_run_state_machine(msb, h_msb_write_block);
 
 		/* Sector we just wrote to is assumed erased since its pba
-			was erased. If it wasn't erased, write will succeed
-			and will just clear the bits that were set in the block
-			thus test that what we have written,
-			matches what we expect.
-			We do trust the blocks that we erased */
+		 * was erased. If it wasn't erased, write will succeed
+		 * and will just clear the bits that were set in the block
+		 * thus test that what we have written,
+		 * matches what we expect.
+		 * We do trust the blocks that we erased
+		 */
 		if (!error && (verify_writes ||
 				!test_bit(pba, msb->erased_blocks_bitmap)))
 			error = msb_verify_block(msb, pba, sg, offset);
@@ -1493,6 +1499,7 @@ static int msb_ftl_scan(struct msb_data *msb)
 static void msb_cache_flush_timer(struct timer_list *t)
 {
 	struct msb_data *msb = from_timer(msb, t, cache_flush_timer);
+
 	msb->need_flush_cache = true;
 	queue_work(msb->io_queue, &msb->io_work);
 }
@@ -1673,7 +1680,8 @@ static int msb_cache_read(struct msb_data *msb, int lba,
  * This table content isn't that importaint,
  * One could put here different values, providing that they still
  * cover whole disk.
- * 64 MB entry is what windows reports for my 64M memstick */
+ * 64 MB entry is what windows reports for my 64M memstick
+ */
 
 static const struct chs_entry chs_table[] = {
 /*        size sectors cylynders  heads */
@@ -1706,8 +1714,9 @@ static int msb_init_card(struct memstick_dev *card)
 		return error;
 
 	/* Due to a bug in Jmicron driver written by Alex Dubov,
-	 its serial mode barely works,
-	 so we switch to parallel mode right away */
+	 * its serial mode barely works,
+	 * so we switch to parallel mode right away
+	 */
 	if (host->caps & MEMSTICK_CAP_PAR4)
 		msb_switch_to_parallel(msb);
 
@@ -2033,6 +2042,7 @@ static blk_status_t msb_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int msb_check_card(struct memstick_dev *card)
 {
 	struct msb_data *msb = memstick_get_drvdata(card);
+
 	return (msb->card_dead == 0);
 }
 
@@ -2333,6 +2343,7 @@ static struct memstick_driver msb_driver = {
 static int __init msb_init(void)
 {
 	int rc = memstick_register_driver(&msb_driver);
+
 	if (rc)
 		pr_err("failed to register memstick driver (error %d)\n", rc);
 
-- 
2.17.1

