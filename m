Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1815C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EE12077D
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMFxSBlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBRbY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRbY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2020 13:31:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B4EC05BD1E;
        Tue,  2 Jun 2020 10:31:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3474529pfc.5;
        Tue, 02 Jun 2020 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hz4jQfWJs2mXgo3sZ8VjyyMoe3ziiZLtSTR4Xn/Dm7o=;
        b=fMFxSBlZML7o7dA9zev+6fTkdk+z9x6+2VS/XwTzQNL+6Fs0Y1G81rWz+1BN4eKoxc
         bOHTckoLkm1sP6TxSuIrfiFFozO8lPuI7XNpuxq4phvs32d0oFHCCBewqrf8BaDwStDf
         CjX+/8XYCXSq7oNBfXc1hTbSLnIv4BsM2QX0Vu6ASJZsFJwgO9dxzzefDT8PZLgLQ2aP
         uLG808RoyxO1H4fnBc8RHOuLAqjPuTpDBeuFdiFBJLLaDNx8xTyfHzyabGtkogDIHwbe
         Xnl7MHvEZN2sUp8dQ7Pp+6Jkgfn+4uInmpcsZG37KdvVBJwc/CKzcIxRppCtcxYUdfwD
         3MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hz4jQfWJs2mXgo3sZ8VjyyMoe3ziiZLtSTR4Xn/Dm7o=;
        b=JSC/g4iiaDtVTLIh/QiW1c4j8UDPFnPKnJF9PvRtuLU4yeNfjNhN2v0DyPhN/crnwF
         b/YCBFDyB+HxeXsxPDgx38yxe8cs9aagVGYO7EjfgM+JOWff8KePPkNyldQFLQCDhBob
         OXUUHiHKNzppaBtyIXfHpjDhxD8SLGSqbpzD+5FxAUHIW2iDvYQa9jakrydp+yp8489n
         sUey6E+OIWtegVg+MN0JZ+CiwZjy2xBQt6TIoGRbfY54SYhxO4UIUp0WBMAb1vQVg0mn
         kb9U5rZnoZNmmXpTjFZmH6Jlk12BabZq15euD/8nPj9N/Jonkmw08e5UX7SadxgP81aI
         t7Sw==
X-Gm-Message-State: AOAM532UGUFR5Eyz6yCNVva5SGEay12BgH67NLjRO7DLSUplzoKJYe3h
        0ey86V4lKb4sHhtrsIdNOOI=
X-Google-Smtp-Source: ABdhPJw7NYe90VXEYZ3eipIwK6YJAJriV8SF5AH1NIYqJuC7yjcyiawJsWEzsvOgwBFukZRyyr8eFg==
X-Received: by 2002:aa7:9aca:: with SMTP id x10mr7558347pfp.146.1591119083241;
        Tue, 02 Jun 2020 10:31:23 -0700 (PDT)
Received: from localhost ([176.122.135.123])
        by smtp.gmail.com with ESMTPSA id y14sm2978435pjr.31.2020.06.02.10.31.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 10:31:22 -0700 (PDT)
From:   Corey Gao <gaoce123@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gaoce123@gmail.com
Subject: [PATCH] mmc: core: Add error check to avoid kernel panic caused by NULL pointer
Date:   Wed,  3 Jun 2020 01:29:57 +0800
Message-Id: <20200602172957.13592-1-gaoce123@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If __mmc_start_req(host, mrq) fails with error, the mrq->cmd->mrq will
be NULL. This will cause kernel panic in the following
mmc_wait_for_req_done(host, mrq). Add error check to cancle unnecessary
mmc_wait_for_req_done(host, mrq) if __mmc_start_req(host, mrq) fails.

Signed-off-by: Corey Gao <gaoce123@gmail.com>
---
 drivers/mmc/core/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2553d903a82b..b13b484e64aa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -734,9 +734,11 @@ EXPORT_SYMBOL(mmc_start_req);
  */
 void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
 {
-	__mmc_start_req(host, mrq);
+	int err;
 
-	if (!mrq->cap_cmd_during_tfr)
+	err = __mmc_start_req(host, mrq);
+
+	if (!mrq->cap_cmd_during_tfr && !err)
 		mmc_wait_for_req_done(host, mrq);
 }
 EXPORT_SYMBOL(mmc_wait_for_req);
-- 
2.17.1

