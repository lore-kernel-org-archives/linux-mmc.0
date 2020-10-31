Return-Path: <SRS0=eM5z=EG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D85C388F7
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 15:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E313B22277
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBvtVl+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgJaP1U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 31 Oct 2020 11:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgJaP1T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Oct 2020 11:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604158038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=qCvPcYJMYe/YC12xdcjZu7zLl7oGmMt2L3Rdu5ytYE4=;
        b=XBvtVl+dL6mnslHWYP5F4Vwrq5gBiiovQ1BQh1SxQSRZyKYIq1egK0LHxGEGfPeuDFNCo0
        eGtht8q8mAemwoHGMdFkAnxlzGK/02NBzM53XFhLcPMzNBZn9YKqYE1Au5a+6WbBAR3Rmp
        E3x6RDAxk7TJDqWqPpIZ92uIyy+5Zfo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-qf8ddyyIOtqyXEZpUmViBA-1; Sat, 31 Oct 2020 11:27:15 -0400
X-MC-Unique: qf8ddyyIOtqyXEZpUmViBA-1
Received: by mail-ot1-f70.google.com with SMTP id v7so3881567ots.19
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qCvPcYJMYe/YC12xdcjZu7zLl7oGmMt2L3Rdu5ytYE4=;
        b=omIOQOh+1b0R4oQwr+Ch2n/L+HlJyF8u4MpTSNvK1XMdvwolLKlM+e9nIsOHoPWkKz
         UxZ9qsNc9H+AkHwW7soY89fjK8CJLuUGvTcZQ3ruUNr5/8zmA88JHVTbhtHwOoZed8j/
         EkW9c//JeEAlSL2rB+ZB2E0Xfx/PflpqZyEBL4LZ8GNfWPkgCOdy4RJtDO7mtzHIn6AE
         osaw/EFHhd69me3tVkaY/9HnIISIHkB6UW3WM2Q5VbHXeqFAsKJXzcZ7E4dJkmy3C4jz
         KVlzP28bEYc6JvRGikF4lrn9fdSOH/15sG3O/laIjBDIdw128yNM8B+ilk5F6THbkbwA
         t66w==
X-Gm-Message-State: AOAM532VMotdMq2cyvQikJAA2SaMTyUR+fYA+R4j4wH16ywsrn7zMIj3
        pqLN0b68zTq3RLYZFMLP7bTsByaqroSOizGcayJUqJ6VE7E0swpZxieR3laoh7kABKLLaHewTs9
        QILeij2A3GMOG+eJ7c1xO
X-Received: by 2002:a05:6808:57c:: with SMTP id j28mr4898827oig.63.1604158034319;
        Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL0KyGC8s/0/4hyz3KjpuX5EYAblzdMoedM6xdT6woIB/4tDjZgpbipZCN5rJQFo8fPWn8JA==
X-Received: by 2002:a05:6808:57c:: with SMTP id j28mr4898817oig.63.1604158034180;
        Sat, 31 Oct 2020 08:27:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i18sm2254038oik.7.2020.10.31.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 08:27:13 -0700 (PDT)
From:   trix@redhat.com
To:     ulf.hansson@linaro.org, krzk@kernel.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        gustavoars@kernel.org, mirq-linux@rere.qmqm.pl
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mmc: davinci: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 08:27:08 -0700
Message-Id: <20201031152708.2146690-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 90cd179625fc..2a757c88f9d2 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -290,7 +290,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 		default:
 			s = ", (R? response)";
 			break;
-		}; s; }));
+		} s; }));
 	host->cmd = cmd;
 
 	switch (mmc_resp_type(cmd)) {
-- 
2.18.1

