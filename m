Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0148DC77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 16 May 2023 20:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjEPU1u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 May 2023 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPU1t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2023 16:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D51A5DE;
        Tue, 16 May 2023 13:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3759863823;
        Tue, 16 May 2023 20:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6572C433D2;
        Tue, 16 May 2023 20:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268839;
        bh=Pi3QwEAHjDQvPaoIXiWDZQeAw2CxTt+KeUV+52GtFc0=;
        h=From:To:Cc:Subject:Date:From;
        b=qBPOjc7dPDTZ3LakRVd5je3hHk3tTUNceLjlNO6D7hSR9kaMItl0W3hjmkI73I8+/
         4weSXi4sKIl2SlLRbRx86pXI9C7PbIpAmvw1Z86HBNJqnGo+/6cDYJ45dFhLvZnX/i
         YhoaycvFlxJmbnEc1zgvM+Yqw+yLGnUkwkYyYWmpYNyscf/DUmVTRreBRkaM9jrjH0
         Rq1eNi3nTVMnnSZgVv3j0e6wdGoIXCJUbFBdz4h3uYpFIDTeXAUldCX/EoVIhRfKKQ
         SEnb0aMwEAJHMKGXW4LB2WlybPPFhsd7O5+9V1fD4JTyZVem+H9zN/EXFNVRbSPqkl
         +HcpG1ka7/Mpg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zheng Wang <zyytlz.wz@163.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memstick r592: make memstick_debug_get_tpc_name() static
Date:   Tue, 16 May 2023 22:27:04 +0200
Message-Id: <20230516202714.560929-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are no other files referencing this function, apparently
it was left global to avoid an 'unused function' warning when
the only caller is left out. With a 'W=1' build, it causes
a 'missing prototype' warning though:

drivers/memstick/host/r592.c:47:13: error: no previous prototype for 'memstick_debug_get_tpc_name' [-Werror=missing-prototypes]

Annotate the function as 'static __maybe_unused' to avoid both
problems.

Fixes: 926341250102 ("memstick: add driver for Ricoh R5C592 card reader")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/memstick/host/r592.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 42bfc46842b8..461f5ffd02bc 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -44,12 +44,10 @@ static const char *tpc_names[] = {
  * memstick_debug_get_tpc_name - debug helper that returns string for
  * a TPC number
  */
-const char *memstick_debug_get_tpc_name(int tpc)
+static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
 {
 	return tpc_names[tpc-1];
 }
-EXPORT_SYMBOL(memstick_debug_get_tpc_name);
-
 
 /* Read a register*/
 static inline u32 r592_read_reg(struct r592_device *dev, int address)
-- 
2.39.2

