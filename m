Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17C5C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD4760F70
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 09:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhI0JrD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233680AbhI0JrC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Sep 2021 05:47:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E597461157;
        Mon, 27 Sep 2021 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632735924;
        bh=gFGitQYEbKU+ll1qJ4OCqESVHY1IMF80+p0Jqsb7qYE=;
        h=From:To:Cc:Subject:Date:From;
        b=o6PSo81tkdTwK2YP2LSaneKqFnF7Ou7RHR44P7NLtHNmh9aGGhJ+XPQSxGi7gfxjj
         QDh/V2gXj4WWHOMI2J22bBciYlwxSrH0/q25j/mViAP9yg0vAcWoxMKb4tWWJ+lY4e
         IwrtDqS4CLTH1b0VH05ynKY+uwD+E+7Jr9EElnKZdBh1obUEOJKFm4fJWtB3gm7SzW
         M9bqm6EwZhifWOwPZwYQoSkvs/O5IKYtbuC7TE6Qc63v/Q7ggIJBDqxPs8aEoOB47j
         4m1zB/FMn4NUuUI6fEItZ1t+3U4rPtw5b8Qhg0z+xDjmD1pJ1GiNz4+977X0v9fDu3
         NfBV/yZQG8tDw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] memstick: avoid out-of-range warning
Date:   Mon, 27 Sep 2021 11:44:47 +0200
Message-Id: <20210927094520.696665-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-14 complains about a sanity check that always passes when the
page size is 64KB or larger:

drivers/memstick/core/ms_block.c:1739:21: error: result of comparison of constant 65536 with expression of type 'unsigned short' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (msb->page_size > PAGE_SIZE) {
            ~~~~~~~~~~~~~~ ^ ~~~~~~~~~

This is fine, it will still work on all architectures, so just shut
up that warning with a cast.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index acf36676e388..487e4cc2951e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1736,7 +1736,7 @@ static int msb_init_card(struct memstick_dev *card)
 	msb->pages_in_block = boot_block->attr.block_size * 2;
 	msb->block_size = msb->page_size * msb->pages_in_block;
 
-	if (msb->page_size > PAGE_SIZE) {
+	if ((size_t)msb->page_size > PAGE_SIZE) {
 		/* this isn't supported by linux at all, anyway*/
 		dbg("device page %d size isn't supported", msb->page_size);
 		return -EINVAL;
-- 
2.29.2

