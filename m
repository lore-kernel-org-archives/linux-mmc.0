Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D92C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B1761624
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhF3MXa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234444AbhF3MXa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 08:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91B8E61622;
        Wed, 30 Jun 2021 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625055661;
        bh=urERl5tO5goZ6TLzzaZEftHjA9owertzkVYQiHZYC24=;
        h=From:To:Cc:Subject:Date:From;
        b=OHbUhu85T7wIqIbKJ59ahiYZeAhW53VDukQrN+MVx14r3o8Ymtkbk89qd+Z4Yso9X
         yt7337ycHuf0hyCooJTQxYhQWhTxDWTVuNR/Ew71HQvjAEnENFigbZs2JO3zWQ6HTz
         GjuLEZXpqUFTf9L0Y2niSZEM/iwsJWQnQ90/wKenMfGh4v5hrpOJ2A3bGOQkS5Yryk
         Mu5TVxhZuWQ6LKv/hfffzIXFK5D+uMVE/la5BYd0Cs6+YjeBIRjV4PvEVcIAqHKqt5
         h3D1q330Simm5KK6RNHjqw/5RE2sXJxkkp9IJQEUiVZgaXmUAlWNvYvnUPdkV0kAZl
         oxJETBz+fJk7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: warn for invalid SDIO data buffers
Date:   Wed, 30 Jun 2021 14:20:53 +0200
Message-Id: <20210630122057.2795882-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Jernej Skrabec reported a problem with the cw1200 driver failing on
arm64 systems with CONFIG_VMAP_STACK=y.

The driver in this case passes a pointer to a stack variable (in vmalloc
space) into the sdio layer, which gets translated into an invalid DMA
address.

Even without CONFIG_VMAP_STACK, the driver is still unreliable, as
cache invalidations on the DMA buffer may cause random data corruption
in adjacent stack slots.

This could be worked around in the SDIO core, but in the discussion we
decided that passing a stack variable into SDIO should always be considered
a bug, as it is for USB drivers.

Change the sdio core to produce a one-time warning for any on-stack
(both with and without CONFIG_VMAP_STACK) as well as any vmalloc
or module-local address that would have the same translation problem.

Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://lore.kernel.org/lkml/20210622202345.795578-1-jernej.skrabec@gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/sdio_ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
index 4c229dd2b6e5..14e983faf223 100644
--- a/drivers/mmc/core/sdio_ops.c
+++ b/drivers/mmc/core/sdio_ops.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/scatterlist.h>
+#include <linux/sched/task_stack.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -124,6 +125,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
 	int err;
 
 	WARN_ON(blksz == 0);
+	WARN_ON_ONCE(is_vmalloc_or_module_addr(buf) || object_is_on_stack(buf));
 
 	/* sanity check */
 	if (addr & ~0x1FFFF)
-- 
2.29.2

