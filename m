Return-Path: <SRS0=BwSF=5X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D27C2BA2B
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 14:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9252072A
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Apr 2020 14:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0EkQvBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgDGOjN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:39:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33834 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgDGOjN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Apr 2020 10:39:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so4033083ljn.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2020 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6FPcP9wCF9lbemCjzdObes0liRQcDYLDA7JXgfzHU8=;
        b=K0EkQvBseSNAZnXSPoBDXsWwFnCefw2469Vsn5MdviQD0EwQtHBK3xfI+p3BK+HRof
         /rgo1R5rvrqDCe30Fr1ldN7LLUzrb4WkSH2/RcqB5razJutC7W7rgZjiZ2fNgzDMjZcV
         a/SwNBlT4BiOfODTfu8heNHKPso0FPXvG0Q1Vj2B6Ob1+YFgjxURs67OKC4Yg3+6bRrn
         rtvWgq/tqd0INi/+Mayooul/EMvhJw0Q2twn6JjEpmJvrvPHv90I3YVvrnIRHV2EpyfQ
         OgZPntCnerpjt86rj1up2GBla2WAOETakfWvGZ0+gJyYPWNkul7I6AMxq1BnBdmsGY82
         8yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F6FPcP9wCF9lbemCjzdObes0liRQcDYLDA7JXgfzHU8=;
        b=n6L6gf9BEOeDkwjWfgJ1lw1q8vREHvXQmzQawvHE8Rm5alSRzVA0hflspeffD+Bpbl
         GCiQEVXaCgfL6VczoVQNarnYZE3YTKJ+g922SKXoJZkPukiX6YNXt7TNhe/xlRkpPmSY
         zRSwg6DmhzfGtkxKKStLizFbiU4dxq5LBzPwMGV1PNw0YjloqTbG22Bv51YLHR8Y7L/O
         0BQiuJOyXUz5drEiLhX4fYK96/P18pzePzR9WWsueVoJEoiaRMQwIlJl6nBugFBkaWww
         0amvmhJuOwzRsGdBSomgKUAAAzczEtymYC7L8Ofe7ckGvpmEBZypV2NsGRBaYXK8Z0c0
         z2xA==
X-Gm-Message-State: AGi0PuadyYntqhSrATLzmQcJgt6IOyULIY1pisPlmslji3JnKx5PfGnu
        i9qo8FNxC1dlfQw8pZL9HRBSaxzwDMo=
X-Google-Smtp-Source: APiQypIUdq4uWT93PKLlqfFoVnrilfjjNkV3KFoFxdwzdlhs9bq/HjbfYr1gHCaARcG678Of2NMQhQ==
X-Received: by 2002:a2e:9912:: with SMTP id v18mr1851732lji.199.1586270350418;
        Tue, 07 Apr 2020 07:39:10 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v21sm14585017lji.81.2020.04.07.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:39:09 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>
Subject: [PATCH] mmc: s3cmci: Drop redundant code in s3cmci_setup_data()
Date:   Tue,  7 Apr 2020 16:39:03 +0200
Message-Id: <20200407143903.22477-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The in-parameter struct mmc_data *data is never NULL, because the caller
always provides a valid pointer. Hence drop the corresponding redundant
code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/s3cmci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 1e616ae56b13..444b2769ae2c 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -958,13 +958,6 @@ static int s3cmci_setup_data(struct s3cmci_host *host, struct mmc_data *data)
 {
 	u32 dcon, imsk, stoptries = 3;
 
-	/* write DCON register */
-
-	if (!data) {
-		writel(0, host->base + S3C2410_SDIDCON);
-		return 0;
-	}
-
 	if ((data->blksz & 3) != 0) {
 		/* We cannot deal with unaligned blocks with more than
 		 * one block being transferred. */
-- 
2.20.1

