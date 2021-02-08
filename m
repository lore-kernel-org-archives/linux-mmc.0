Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E447C43381
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 02:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE1764E3F
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 02:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhBHC3H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Feb 2021 21:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBHC3G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Feb 2021 21:29:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7CBC061756
        for <linux-mmc@vger.kernel.org>; Sun,  7 Feb 2021 18:28:25 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t25so9260962pga.2
        for <linux-mmc@vger.kernel.org>; Sun, 07 Feb 2021 18:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PDj/eIWOe0dLmL5BneuH81q94Q7oGUVOjKWWtKL5xU=;
        b=bcGI9YRqXBlIsdHAvKVkBL1LYyj2lPEWyyaqkvznSZCQ9n2vswLFNNKi9FCnWqFGaC
         W3K1+ytZjNp94P44PrbbmhwTBiuyRI76/gybl9q1GYO3P0+xI+0cj37ctVVS6LESSMFd
         Kt7wbtmAqGdFCjLsGqn4C1nbU/9XlqAC+AFUhvmatGoewrOmfQYdP1t5LV49/9LJw6k3
         5loAWORUEhtH4dHzrlart2j3dGbpYEsFjC1je7DGUbupZytN86A8YSohRgprNS4IlmFq
         JL477CTcD4u64ruV2BVZhb4UysJAAedhs2joUmuG0wFvXKWYy3tBgM2pSeO4yBQITE9K
         v/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PDj/eIWOe0dLmL5BneuH81q94Q7oGUVOjKWWtKL5xU=;
        b=OiGN5fugLR14cpF81TkfI9AxyqNsRz7mwewGg6Bv8JWvAs24bH2qu/OLK+/8xNuu2U
         xLvArMLuoG9nreyQ6u4DGfUr3/5Q+TuWrxLBMNw6WKanL+Wd1Yr3/ub1VrrzrTEazdQ8
         a2Cslubd+D5I+YhdaFe2LftY7ZtckRJi+FmkXzIfRfaro5AWcVZ19rIecZtlRXBh0MY2
         nnPxcfovvsREUw8B4ZnveYhdr/XE/evB5G79fZPPciBzXKvTIHQBoerA++fBE2DblQgU
         UL/Y79wh8dg7Ejtxy1KrAuCe4as9NHGPWiuvrn52fWx3EySxCt537Y/hxmnxPquNtJl1
         chEw==
X-Gm-Message-State: AOAM533oQggBHGBKjG5BxP9EiQFkrWeNqULrZTsHizmfNoN8s9wz1gVM
        a5h+rnfVAmowix0s1MUQjZlXOyhEILJJgqH9
X-Google-Smtp-Source: ABdhPJz/mfYVEBZdKX+4WxiO7ofga/cjT+5yedkIiejQcVpXUTdNlVXacqRPENbK/kCOY78LDsAQcw==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr15208972pgc.423.1612751305369;
        Sun, 07 Feb 2021 18:28:25 -0800 (PST)
Received: from wuxy20.example.com (v-162-248-93-139.unman-vds.inap-la.nfoservers.com. [162.248.93.139])
        by smtp.gmail.com with ESMTPSA id hi15sm14356130pjb.19.2021.02.07.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 18:28:24 -0800 (PST)
From:   Xingyu Wu <wuxy20@gmail.com>
To:     chris@printf.net, jwerner@chromium.org, gwendal@chromium.org,
        linux-mmc@vger.kernel.org
Cc:     wuxy20@lenovo.com, Xingyu Wu <wuxy20@gmail.com>
Subject: [PATCH V2 1/1] mmc-utils: fix messy code printed
Date:   Mon,  8 Feb 2021 10:26:42 +0800
Message-Id: <20210208022642.7823-2-wuxy20@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208022642.7823-1-wuxy20@gmail.com>
References: <20210208022642.7823-1-wuxy20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some vendors of eMMC use different format to define the
Firmware name. If the Firmware name uses character and if
it exceeds the printable range of ASCII (0x20~0x7e),
mmc-utils will print messy code. This change can fix the
messy code issue, if the firmware name is not printable,
print it out as hexadecimal, this change was verified on
chromium project.

Signed-off-by: Xingyu Wu <wuxy20@gmail.com>
---
 mmc_cmds.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..d090a24 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -29,6 +29,7 @@
 #include <stdint.h>
 #include <assert.h>
 #include <linux/fs.h> /* for BLKGETSIZE */
+#include <ctype.h>
 
 #include "mmc.h"
 #include "mmc_cmds.h"
@@ -1758,8 +1759,16 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
-		printf("eMMC Firmware Version: %s\n",
-			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
+		printf("eMMC Firmware Version:");
+		for (int i = 0; i < 8; i++) {
+			char c = ext_csd[EXT_CSD_FIRMWARE_VERSION + i];
+
+			if (isprint(c))
+				printf("%c", c);
+			else if (c != 0)
+				printf("\\x%02x", c);
+		}
+		printf("\n");
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
-- 
2.25.1

