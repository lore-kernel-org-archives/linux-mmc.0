Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B5C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D3761452
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 13:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhDUNwz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237781AbhDUNwz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Apr 2021 09:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C18DD6144C;
        Wed, 21 Apr 2021 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013142;
        bh=dc0EvbcvLLQuVCGRqItZSLQQVJEGn+D0uyY4r76gb2A=;
        h=From:To:Cc:Subject:Date:From;
        b=htVAWSN7dcGz2UGfywUQaAVdE0Da+7Wp8BV4DCRzCjAvswhx4/0oGPRXZHvfHsgV7
         uCdnGNv0IIJZVqjbrTjLi+awk/OIMY+tpk3CAquMVf+mlmkp7GV3+l5QGN4tQPSzsj
         xq5dZt7Flga0/D3vo37WOycHjhPK3QvQiUl1iiv2V0xy20UKZDKy5OpX7qTfty2QOB
         XifDmdNZordN6XPSFLT34ZEgwvSndA9WK7NeiiEG4T/jnrMaJI+6TfXEj7DYvy9LkU
         5EX/+V/7abhfr0/COe3xOfawL0E8Ji9N1HwjjD+b215e9aeFppomfniLGPksFgC6oC
         ahGthUnexyGOA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] memstick: r592: ignore kfifo_out() return code again
Date:   Wed, 21 Apr 2021 15:51:58 +0200
Message-Id: <20210421135215.3414589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A minor cleanup to address a clang warning removed an assigned
but unused local variable, but this now caused a gcc warning as
kfifo_out() is annotated to require checking its return code:

In file included from drivers/memstick/host/r592.h:13,
                 from drivers/memstick/host/r592.c:21:
drivers/memstick/host/r592.c: In function 'r592_flush_fifo_write':
include/linux/kfifo.h:588:1: error: ignoring return value of '__kfifo_uint_must_check_helper' declared with attribute 'warn_unused_result' [-Werror=unused-result]
  588 | __kfifo_uint_must_check_helper( \
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  589 | ({ \
      | ~~~~
  590 |         typeof((fifo) + 1) __tmp = (fifo); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  591 |         typeof(__tmp->ptr) __buf = (buf); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  592 |         unsigned long __n = (n); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~
  593 |         const size_t __recsize = sizeof(*__tmp->rectype); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  594 |         struct __kfifo *__kfifo = &__tmp->kfifo; \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  595 |         (__recsize) ?\
      |         ~~~~~~~~~~~~~~
  596 |         __kfifo_out_r(__kfifo, __buf, __n, __recsize) : \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  597 |         __kfifo_out(__kfifo, __buf, __n); \
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  598 | }) \
      | ~~~~
  599 | )
      | ~
drivers/memstick/host/r592.c:367:9: note: in expansion of macro 'kfifo_out'
  367 |         kfifo_out(&dev->pio_fifo, buffer, 4);
      |         ^~~~~~~~~

The value was never checked here, and the purpose of the function
is only to flush the contents, so restore the old behavior but
add a cast to void and a comment, which hopefully warns with neither
gcc nor clang now.

If anyone has an idea for how to fix it without ignoring the return
code, that is probably better.

Fixes: 4b00ed3c5072 ("memstick: r592: remove unused variable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memstick/host/r592.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 026fadaa1d5d..615a83782e55 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -359,12 +359,15 @@ static void r592_write_fifo_pio(struct r592_device *dev,
 /* Flushes the temporary FIFO used to make aligned DWORD writes */
 static void r592_flush_fifo_write(struct r592_device *dev)
 {
+	int ret;
 	u8 buffer[4] = { 0 };
 
 	if (kfifo_is_empty(&dev->pio_fifo))
 		return;
 
-	kfifo_out(&dev->pio_fifo, buffer, 4);
+	ret = kfifo_out(&dev->pio_fifo, buffer, 4);
+	/* intentionally ignore __must_check return code */
+	(void)ret;
 	r592_write_reg_raw_be(dev, R592_FIFO_PIO, *(u32 *)buffer);
 }
 
-- 
2.29.2

