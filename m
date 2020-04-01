Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539C6C2D0F0
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2920520678
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSJDrZBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbgDAWPX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:15:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39404 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733230AbgDAWPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 18:15:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id g32so828878pgb.6
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2020 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+ihzztAtgevX2pVbVqkrTO5PlBAc8v+4lemqFm3pKA=;
        b=dSJDrZBZu0KQdaASk83WjI/+C4PCoL2zeb/76ZMwgdbAElXlJH3pjA6V0ZF7Jq5W2R
         8aFHWyFfC6c09UrkC1BJg/bqDciS7nJ+PgJQ4IzSqMqgwHwXPjEbnkMWbYkN5xtYRMA5
         zEWYOidzhNIeC0mWSG5Xcq3VACduUj75w/Z6RFP2EYCHHxaMu6JLhp6QhoRQPtMqJ/4G
         vOV5duxkRy/prmU3PHMguntpEhlKhp/OJt6fC9o0MXwtlPsgoEu21UGoU+Je+j+g/X3Z
         EaxDGCyCXLExJHkb4cyy76333E1wEQi5aKP6nOEB1E1JYROzqMYBQiY1KmUHm2lhw73j
         uRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+ihzztAtgevX2pVbVqkrTO5PlBAc8v+4lemqFm3pKA=;
        b=SloGP59A0ad3hV7ohC0Zk2c35hl6S4A6sKtQhG9CJ3QKvB3PwXwmaOg3oID4qbErir
         tqun0im4nWjmxnZQbpcGS5SyqxjkBFLBS6V/ZS+h7HrgQJ34VDe+MHPefejNVwmUEOL1
         J2LiyPmHeNW8suVXlmKcHWo7mCfVU8+q25QCfIGcZ6qU8CixCK9Lldt2n1QbtVY2adOo
         At2vG0S7nAmhRoK+aY/5c0wrpyIg/eCHa/38nxI5+QY30Z3taRUgGngR5i2t7xS1FCMt
         lx/M+w2Wff6RG/n1R2iHC+aYFE666lW1P9iF7L5Y4dXMa/ImtewTQo2i1ApSOLgomHzX
         FJig==
X-Gm-Message-State: AGi0PuZKUnriLl33/0vqQJF5dM68LSNh7w8laalq0qsKF4e7YfdAKhz5
        SkztbpdL/RzrG+zio+fcHLnkdoI7
X-Google-Smtp-Source: APiQypKQ2mV9F9MqUntcVtvDk8k6OOwm3uvaqEJ6y/AToAKPeFQGnIKNn2uvBsacegPygKjIfWeQLA==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr327956pge.27.1585779319388;
        Wed, 01 Apr 2020 15:15:19 -0700 (PDT)
Received: from gtr.motec.com.au (motec5.motec.com.au. [115.70.189.242])
        by smtp.gmail.com with ESMTPSA id e9sm2296436pfl.179.2020.04.01.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 15:15:18 -0700 (PDT)
From:   patrick.oppenlander@gmail.com
To:     linux-mmc@vger.kernel.org
Cc:     chris@printf.net,
        Patrick Oppenlander <patrick.oppenlander@gmail.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Fix scaling of cache size
Date:   Thu,  2 Apr 2020 09:14:53 +1100
Message-Id: <20200401221453.267360-1-patrick.oppenlander@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CAPDyKFrW6tXMVa_P=iAPk4FurH9+MGOvJiT7m8B72kz7p0-BnQ@mail.gmail.com>
References: <CAPDyKFrW6tXMVa_P=iAPk4FurH9+MGOvJiT7m8B72kz7p0-BnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Patrick Oppenlander <patrick.oppenlander@gmail.com>

Resend requested by Uffe.

===8<===

JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
indicated as multiple of kilobits". This is also supported by Table 39,
"e.MMC internal sizes and related Units / Granularities" which lists
"32Kb (=4KB)" as the cache size granularity for 4KiB native devices.

Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index fb37189..a1b1d75 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1419,8 +1419,8 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("Power off notification [POWER_OFF_LONG_TIME: 0x%02x]\n",
 			ext_csd[247]);
 		printf("Cache Size [CACHE_SIZE] is %d KiB\n",
-			ext_csd[249] << 0 | (ext_csd[250] << 8) |
-			(ext_csd[251] << 16) | (ext_csd[252] << 24));
+			(ext_csd[249] << 0 | (ext_csd[250] << 8) |
+			(ext_csd[251] << 16) | (ext_csd[252] << 24)) / 8);
 	}
 
 	/* A441: Reserved [501:247]
-- 
2.26.0

