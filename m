Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CAC47080
	for <linux-mmc@archiver.kernel.org>; Sun, 23 May 2021 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2995F61244
	for <linux-mmc@archiver.kernel.org>; Sun, 23 May 2021 16:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhEWQBw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 May 2021 12:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhEWQBw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 May 2021 12:01:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03198C061574;
        Sun, 23 May 2021 09:00:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b7so9222179plg.0;
        Sun, 23 May 2021 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC5or6EpgtPu4x49zJiMjr/Omc2prcbu5PDvMBZoEIA=;
        b=jJuwepxuS8nZyB26SWi2G2vhP0j0BaHbWmGQ5ymJhAo5TnPQcQZeIVmPMRkhBLeB6y
         Qw6i6qHsCQdRf6xsdHyseqqOqa39Dl+KosFWJJDKhcZ05768VdR4CK/baAofg5HwcuKz
         i/0U3ZP+yono1JRqgzGZaD5/T6TDxcOIc8nMcwxbz6S3ULdutW9Duzyp0Kye/bPzopPW
         4PpkkynIkbRCQ6k7+7nhAU5GQ1/qSrKHCIh/PCr5113q4fCS9Zr1c8FhKD1DqpHvaKYI
         DV8wOXSRDp/wUKRw86r4DjeA82aNQW5Za0mgy+hfcSiRugRIpTNc/balTODoUFqZfRcl
         icaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC5or6EpgtPu4x49zJiMjr/Omc2prcbu5PDvMBZoEIA=;
        b=obYIVSwHYBaAypRtuDerdEIhK/nWo9VWABWhIyOg8hM9RDWClYrJDmMBBKr8rV6VcX
         UtTqnfXOxoAEb9vei0K1cGblD13gWxlEIdDx83OQb+NTSaMW04EqmE4UeRiNDfGtOemA
         tdr/7DZM6w8p28cME+iuLibbGDzQ7DtKVTPagkATBWhnWtJ+hutPpaUGcR5CJcD+3QkE
         IhEKdW94HKuim7d/NqvubOW9aZLEonZ9KKztDgy0le5s1LrZ1BDU+ZFGaRRKbHDoZ22M
         idHSFc+SityfvC2wHLQ960NMblXHw28rOlLxcVfFg8/is1jmW/KzRuj52GzmsBNe7XZz
         Ur8Q==
X-Gm-Message-State: AOAM531UmDcOr7Pql+mxZzp55a6F/A8YAW/UqiRq0kpfuvlnhyM20ppo
        UT8lWB6aBGlHDFmZlsOvGH+YmxahknCmButK
X-Google-Smtp-Source: ABdhPJxwadCDZro6DUvfxY6FnUXQ2Ra8rRYKiU7+oqwa1IGjRsWjveG4muEEQaKHNAiqWq8eOjt1Eg==
X-Received: by 2002:a17:902:9001:b029:ee:f24a:7e7d with SMTP id a1-20020a1709029001b02900eef24a7e7dmr21221610plp.42.1621785624317;
        Sun, 23 May 2021 09:00:24 -0700 (PDT)
Received: from localhost.localdomain ([139.167.199.48])
        by smtp.gmail.com with ESMTPSA id p17sm8192940pjg.54.2021.05.23.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 09:00:23 -0700 (PDT)
From:   Aviral Gupta <shiv14112001@gmail.com>
To:     ulf.hansson@linaro.org, axboe@kernel.dk, adrian.hunter@intel.com,
        zliua@micron.com, avri.altman@wdc.com, beanhuo@micron.com,
        porzio@gmail.com, ebiggers@google.com
Cc:     Aviral Gupta <shiv14112001@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] This commit fixes the Error or Warning  about missing or incorrect SPDX license headers.
Date:   Sun, 23 May 2021 21:29:15 +0530
Message-Id: <20210523155914.5200-1-shiv14112001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

By adding missing SPDX-License-Identifier tag line in drivers/mmc/core/block.c this issue is fixed.


Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
---
 drivers/mmc/core/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..266d62f9dbc8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block driver for media (i.e., flash cards)
  *
-- 
2.25.1

