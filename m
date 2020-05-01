Return-Path: <SRS0=yrb8=6P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE51C47253
	for <linux-mmc@archiver.kernel.org>; Fri,  1 May 2020 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6BD208DB
	for <linux-mmc@archiver.kernel.org>; Fri,  1 May 2020 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuOK1jGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgEAQAi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 May 2020 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2020 12:00:37 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E78FC061A0C;
        Fri,  1 May 2020 09:00:36 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id b18so4856285ilf.2;
        Fri, 01 May 2020 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2rqwM/jaHLwWYBPHidJQKqx4ERtMrKkzfEBH0ILAPwE=;
        b=fuOK1jGF0lRA3iT4ovkVfORwHC2PAR0HIe5lF90ULNX8AAvof2micXgDnKMHc8NzuO
         SpcPOF+fzPereacA+ei27icKneZH05k2Do/37NmY6Zk5E+s4JjyYy4xUW+3rrwxWfs3F
         BN31nf2lbDMmxvmONm+tRMRPgn5OCT+3eOc7whAYh1QdXySyeNGwKZ5HmcGsfAcsp8bT
         1MP3kdvliY2umH/Kgspsnu6VPZx3ES4gz8DFOiU3G/6pgGHWEJah91nMsKm3UCakFF1V
         vPNatAG1cwz9hkaU2gY5jVoQxBsq7UHxWZsjv5tNTbBxtPPEVD2O8goW6BkpKyyuzaQW
         iKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2rqwM/jaHLwWYBPHidJQKqx4ERtMrKkzfEBH0ILAPwE=;
        b=Ip9dV+CU7xv23A0UqZ8YDNNUUF5D7DhSb/s1/DT5FNphWSjelNKLJrAfSl09/if2+M
         a/tSt/AUskprTAWGObg38zH+mrBDseFWa+yXCZNLayJH6p1E494WkGysfJ/bqC4308fZ
         pjnCI5bCW/6KUgy7B9GCbmB42gq5oWutlvIaNhw+5IgwWQyVFP19Noi/WZMOjjRe8eER
         zuCGmE3nFj4W8gW1LneQec94Be2GuGzMefDq2VEFgkxqkedh2del8XoCMu4m38ATHK3j
         tOhXtPSCU2rqEL2CcgGSIiV6szfVo1YT9IoNq4EVcmSJoIHRFd4gyZ4/Ykf6rUEyDIIk
         L35A==
X-Gm-Message-State: AGi0PuYSx8Uhk3ML6I39eWxmLGHPFdb6tPkA6ZSyCJVa734zudsm8x6X
        7iHgTSvj4AzBKqkUC0aHWyY=
X-Google-Smtp-Source: APiQypJd608dA49hiBrjuMzpYfVrLQ7WelwHpb/Osh1TbYWQXAuu0kDv5e4KyLJN7gK1B1+GsSsEqw==
X-Received: by 2002:a92:49c7:: with SMTP id k68mr4031412ilg.252.1588348835504;
        Fri, 01 May 2020 09:00:35 -0700 (PDT)
Received: from localhost.localdomain ([183.157.11.115])
        by smtp.gmail.com with ESMTPSA id e89sm1416020ill.26.2020.05.01.09.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 09:00:34 -0700 (PDT)
From:   yanxiaoyong5 <yanxiaoyong5@gmail.com>
To:     ulf.hansson@linaro.org, rrangel@chromium.org, avri.altman@wdc.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanxiaoyong5 <yanxiaoyong5@gmail.com>
Subject: [PATCH] mmc/core:fix mmc_sd_hw_reset oops mmc_sd_hw_reset function may be oops if the ejection of sd and the reset of sd simultaneously occur
Date:   Fri,  1 May 2020 08:59:54 -0700
Message-Id: <1588348794-4511-1-git-send-email-yanxiaoyong5@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: yanxiaoyong5 <yanxiaoyong5@gmail.com>
---
 drivers/mmc/core/sd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fe914ff..73a1e68 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1247,8 +1247,13 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 
 static int mmc_sd_hw_reset(struct mmc_host *host)
 {
-	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sd_init_card(host, host->card->ocr, host->card);
+	struct mmc_card *card;
+
+	card = host->card;
+	if (!card)
+		return -EINVAL;
+	mmc_power_cycle(host, card->ocr);
+	return mmc_sd_init_card(host, card->ocr, host->card);
 }
 
 static const struct mmc_bus_ops mmc_sd_ops = {
-- 
2.7.4

