Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C0DC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C38361106
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbhIGPNW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbhIGPNW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2021 11:13:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7830C061575;
        Tue,  7 Sep 2021 08:12:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s24so1523000wmh.4;
        Tue, 07 Sep 2021 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40vuyTLs9GsD9/24gMroXWpZP0Vcfq4cgGXZKh1hpHk=;
        b=MQMpRlxNCCGnV6Ti/A5OzvFeuyekbDDK2MzTh00VPaKgRamOGxxIN7qDaQoyDVTyWg
         7BUJ4cEZCYpUSxKqb1RTJyvmez3Koc4yaAchhYjV1Wd/JtehJvMiEHM5q/vd3KiYQEJ/
         /GxvmYTEZJqf+7s5hWm3NufaBfpnQlnuTIJFM0vwjROdaLMEhGYwTag6YLaQhQMqxXvF
         xAIZsRRQHhNg5Adxf/TIh8RaswwcZJrxXIy0OYu/qtqw7W3VcYHoQmVvMEPvxmq37Exd
         zen/+umcg6ohq1iKJYzTSi0HEhqnVAmxKNsITmknSvf/wjHY4jxAXl0QFJ4GS7/EFtFz
         miMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40vuyTLs9GsD9/24gMroXWpZP0Vcfq4cgGXZKh1hpHk=;
        b=niCYiha93+vf20v61VQ6pTddVW2wQZCtwI+NbEhBF8PMrbzf3RK9C6HiqrZ2UBaY6R
         BfhU8957WJ7ocYnautRwjW8Tbczxcq+u19dwHwqfQ7Q7q7ZTo7AWMTVpcx5DwLea97lO
         ata9K6RN3M44ZcH2tWGR1kfOr88JFrwJRRh96mV24spNpjHfK7Z2lcoAaf4n2CNgIMX5
         2WEe9lThinGkr++/I+dtEJbAb/oU21JRFghnWZzCELc2ZPD/hA6hQGo8HDQDCJEytBMB
         V7I9lCKgTqjAOtk3TQ0auo/O6CQUh/5gBjGVAxiPmjPqb7pwAAMdbJC2k9FNUwiK7xX0
         nl3g==
X-Gm-Message-State: AOAM532x7SH54Azsmg9BJc8vtq6b1HejGpydXCSy4+Y4rfEJHVqL1SfP
        fZrCPwPj+GYw80CUCxppV/E=
X-Google-Smtp-Source: ABdhPJxVB4c/p4fQYmkQJ0azAktMcWqnafI3im0VhdnJ/Vtc8C+qKHrUBM9xNHk0gvJkdyP+uDZuMA==
X-Received: by 2002:a1c:218b:: with SMTP id h133mr4485638wmh.83.1631027534286;
        Tue, 07 Sep 2021 08:12:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b9a6:8ece:d93e:2093:39d0:bcfd])
        by smtp.gmail.com with ESMTPSA id h16sm11271138wre.52.2021.09.07.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:12:14 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 1/2] mmc: cqhci: Print out qcnt in case of timeout
Date:   Tue,  7 Sep 2021 17:12:03 +0200
Message-Id: <20210907151204.118861-2-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907151204.118861-1-huobean@gmail.com>
References: <20210907151204.118861-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Print task count that has not been completed, this is for the
purpose of debugging.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/mmc/host/cqhci-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 38559a956330..ca8329d55f43 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -899,8 +899,8 @@ static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
 	spin_unlock_irqrestore(&cq_host->lock, flags);
 
 	if (timed_out) {
-		pr_err("%s: cqhci: timeout for tag %d\n",
-		       mmc_hostname(mmc), tag);
+		pr_err("%s: cqhci: timeout for tag %d, qcnt %d\n",
+		       mmc_hostname(mmc), tag, cq_host->qcnt);
 		cqhci_dumpregs(cq_host);
 	}
 
-- 
2.25.1

