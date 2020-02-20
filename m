Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA4C5ACC4
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 01:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFFF2465D
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 01:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3zAGujK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgBTBbN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:31:13 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38616 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBbM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2020 20:31:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id j17so171654pjz.3;
        Wed, 19 Feb 2020 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VTYOKcE/BhJbY7nh/1sEEvvJdWdmjb089CmjgEwaVVQ=;
        b=H3zAGujKWvvvxdII6XS0AyI1/y7vJciF4QXwIvC/3Scp/7R54IOBVwxJ47vx32OET0
         JrxpgglF9lP4kFMoFAsuwhd3tdRCyvK3Z8VfGUVy89pdH1kGEyrGttdWjG0BgluZx+HZ
         wBf1kiNJBESw9UGIUSWxKwKweu9xM9l+0cXhz4+BL93C6oR19FGZxl0zBAE3c7L07lF7
         J6sKgAoGCqo4N8deJu2pUbERxDBkV8GR9ZVb5xOUt+jI9UwNYgIcfQLst4dPmFANuTRK
         O9dOEjNoZGEamt1sKfeNH4xag6IMLPPjgNzQmfq0+F9VHiNKVE9oCAj4AO5Gj02M6vIu
         c+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTYOKcE/BhJbY7nh/1sEEvvJdWdmjb089CmjgEwaVVQ=;
        b=mR/AGi1A23bKut4ZD0/gZxuquOOtG/GlUIGve9neVGI34ADK7VCt1t9cuTY1W/b96K
         +JltoK/qrGrg0Y3WRqmjFUwaFR3lJrHXcZVZMHXh4Z3FveG5Tjh8sh41TK/qwcniddOU
         HU80HvdH0g2yjdvLpJ7btZivTHXvLAcJR/chbOvhlL66TgewgPWkGLZYquSO9wVMXSfy
         dxtex/9bsza710MBL04Nn7ehfdRMN0ct+8B44LxWF6SV0rgvoVG/VrVghOQeNKSU6bmt
         cUvIToEg03p+NLxHkBmo8STL06KZ/GjYEGNeF2FQQcavVknUNlykJrG5IqeAdZiaJR/B
         b2ew==
X-Gm-Message-State: APjAAAUFwfJPLFWqjnak+vMrTUyVFLVrtOYIaLuEXIuyxPCXhM66bGCU
        6QNNGyTzxM7pTfPPJPvWVyJfDgBTbcw=
X-Google-Smtp-Source: APXvYqzUKd/8lgk9DC8R1lfU3As3UyIjFO8WLn5OvfEmCv4lHwU7uK0itLIPeAUDBlOEbyIOonWQhw==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr634692pjn.125.1582162272177;
        Wed, 19 Feb 2020 17:31:12 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w189sm843105pfw.157.2020.02.19.17.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 17:31:11 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     arnd@arndb.de, sfr@canb.auug.org.au, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: hsq: Add missing MODULE_LICENSE() and MODULE_DESCRIPTION()
Date:   Thu, 20 Feb 2020 09:30:01 +0800
Message-Id: <98ce471185f037fce57520763621590588766381.1582161803.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add missing MODULE_LICENSE() and MODULE_DESCRIPTION() in hsq driver to
fix below warning when compiling the hsq as a module.

"WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/mmc_hsq.o".

Fixes: eb1814dd49d5 ("mmc: Add MMC host software queue support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 2011988..59d2776 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -8,6 +8,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/module.h>
 
 #include "mmc_hsq.h"
 
@@ -341,3 +342,6 @@ int mmc_hsq_resume(struct mmc_host *mmc)
 	return mmc_hsq_enable(mmc, NULL);
 }
 EXPORT_SYMBOL_GPL(mmc_hsq_resume);
+
+MODULE_DESCRIPTION("MMC Host Software Queue support");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

