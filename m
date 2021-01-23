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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAD2C433E0
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Jan 2021 03:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D742923A79
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Jan 2021 03:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbhAWDdp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 22:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbhAWDd3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 22:33:29 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39357C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 19:32:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so5105550pfu.4
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 19:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbAzplVNNNzh0miZ25TAa0LbZOwvBqabfFEnB8Xom0Y=;
        b=sWCdJu5haKkHo9oJDx9fo3g2i7dCjTJOwdo9mpXZFeMCBuSSzoG6Gn8h6ldxVPnXlM
         I0kVVBOmNhkVyY1r5lC7vGRPGNRqpxqlvi3h62RydxDYK3RmiPT/pgERg3lNYkLW7RlS
         7VA8N20hq3zvrFWxtg1NJW/fUP0PBGg09l5gXNdQzVGb10LTB7iiwWdO3x4Nz80InUku
         8tDHgYPuxmLjZKlgv/XfXuxzuOTFbWjJZDwTxrnCRHUUu4f8hfHDKincUivc3/rJUAgu
         CpsKjXhfalOCWOOfLqEYiYgeuJShl+ZaQf3Cwn/8eui6xqJ3Fr6w+9cbb19QukbVYm6Y
         dGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbAzplVNNNzh0miZ25TAa0LbZOwvBqabfFEnB8Xom0Y=;
        b=PJ1iQmjLgob6SRUutXiUwtAY6L+zCZq2hngF8VPJhorlhYTsX1pmFWJxNqaZrhbcji
         7zRaIxG7FQ3CsvDX8LhpzjG33r5FuEbiR7AQU7nmmFvvB+DWoX/XzV2GW5jU6+pTKJt1
         otG3lD0MI7dCgfyAHeRmjkPXHZed9KwCCGmj1CQa01bNWlP3Mk2UgjVjt+S14tAA5TIx
         h5UIxjssO4CEuJF4bJPeXqxw6nmPNRZqiTLG6Hc80nkItWS/02nJC+gWmL/hVi1ddeqp
         otNwZGZA4+WlbDManHDRcHerMgBOvy/j55hAfnU0j6CNtEycmm0cFINjGoG/F+91C8Jq
         Dapw==
X-Gm-Message-State: AOAM533OeqJ8Sums+EKpsss4mYwEnYBVSI3RnRPcF9Jaxob65xIBTtX8
        sKO9uU/DcIwrumD2llYx07bQlOOoFi/FFA==
X-Google-Smtp-Source: ABdhPJyU88YCmI4vRwZJJ2hHyqLPEtBFGej6QC0b5Ll0132QpU5L3bL5jPmA4S0jtHHQvAmkKoCVsg==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr6583162pgr.327.1611372764764;
        Fri, 22 Jan 2021 19:32:44 -0800 (PST)
Received: from localhost.localdomain ([210.0.158.164])
        by smtp.googlemail.com with ESMTPSA id ne6sm10330864pjb.44.2021.01.22.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:32:44 -0800 (PST)
From:   Fengnan Chang <fengnanchang@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, Fengnan Chang <fengnanchang@gmail.com>
Subject: [PATCH v3] mmc: limit the number of retries when analyse tuples failed
Date:   Sat, 23 Jan 2021 11:32:31 +0800
Message-Id: <20210123033230.36442-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

when analyse tuples failed, may enter an endless loop，so limit the time of retries.

Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
---
 drivers/mmc/core/sdio_cis.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index dcb3dee59fa5..b8d8b6df9961 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -24,6 +24,8 @@
 #include "sdio_cis.h"
 #include "sdio_ops.h"

+#define SDIO_READ_CIS_TIMEOUT_MS  (10 * 1000) /* 10s */
+
 static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 			 const unsigned char *buf, unsigned size)
 {
@@ -266,6 +268,8 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)

 	do {
 		unsigned char tpl_code, tpl_link;
+		unsigned long timeout = jiffies +
+			msecs_to_jiffies(SDIO_READ_CIS_TIMEOUT_MS);

 		ret = mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_code);
 		if (ret)
@@ -318,6 +322,8 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 			prev = &this->next;

 			if (ret == -ENOENT) {
+				if (time_after(jiffies, timeout))
+					break;
 				/* warn about unknown tuples */
 				pr_warn_ratelimited("%s: queuing unknown"
 				       " CIS tuple 0x%02x (%u bytes)\n",
-- 
2.25.1

