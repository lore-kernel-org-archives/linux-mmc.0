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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764AC433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA0F6105A
	for <linux-mmc@archiver.kernel.org>; Thu, 20 May 2021 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhETLpX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 May 2021 07:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbhETLmO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 May 2021 07:42:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9534C061359;
        Thu, 20 May 2021 03:13:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so5165876pjp.4;
        Thu, 20 May 2021 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK4nPnSX0W1HYC8KLYnXHOTPgxtKRR+x442dLO+mDz0=;
        b=SP6USzDMW0tfeye1gzxbep8Sjz+YnXgKzNBNcVO60fn1x+joA2C9ngKgHh6qKa1bY5
         eTZ4LPL4fpCq8so6FGuNuswhI+OzNr+BqxeEU9w0bMoVVoE2aTtNdrZRCGyu/QU2FJO8
         eEz+aBy938X8NSFbKo+pl2fODYeqUFfFTchjpbFwjf40SY0ZndkEVWWp+5mDmDzFznly
         G0TdAj+j6YdgkEvzzDemTDHxqGT+2v5LMDfvDSW5uP3c+4EbMcTFaRyUxr8JwfM2eUMU
         mo0WvKN2bexznFAt0TymulA1n56azTg70QVRzvaCzKTJbwxyTNqB58coHJ2mwtdb+rX9
         TT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BK4nPnSX0W1HYC8KLYnXHOTPgxtKRR+x442dLO+mDz0=;
        b=PLbt9q1ngeM64IEkzz38RE+lwzCb4eTlC07a5rdtKr3ZEIyCuCPoJuZymMPETSrC6s
         ZBEwAJ9OxIKXHzfXyfMVQV+nORVW2xRz2r+SRYQxbZiNaljta5Y2O9J6A91MmNkPfJoS
         CMxjID4C5hwt7EofYgy7cD1sOsrJ/D6TWatk4Ndv5MGbCimWOK2IXLPu0RAdpXIZSjuy
         hvIEVu40xAk5Cw2kh6ep6bwdfhAeC0l+MnKvWuA84naQsgFS9OJCMSBCi5zC21O1kJox
         0MmN5HjN8IVpl9pF4viKbgVlFEWcNNS+LkkUADw4hPkAoomq9MWqQA3dDJCEkaoYtoIY
         0Ghg==
X-Gm-Message-State: AOAM532VLhyLqyXE5LCK+yj9HCalVR68wJW28WDGxbPWO4llnWJGfr+t
        BLSEWb+56J3aSdmhMwCmK8o=
X-Google-Smtp-Source: ABdhPJy79V1UJo4Nw4HJTmXdRZm9RJbB/fW+Yb8RpFtbB5Pw+HFgSZMu0Ue7KHGgM7CvJHFgJUEa2Q==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr4451120pja.107.1621505620415;
        Thu, 20 May 2021 03:13:40 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id g8sm6307878pju.6.2021.05.20.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 03:13:40 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] mmc: cqhci: fix typo
Date:   Thu, 20 May 2021 18:13:30 +0800
Message-Id: <20210520101330.2255-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

'descritors' -> 'descriptors'

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/host/cqhci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index e759e3b..c237b6e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -146,7 +146,7 @@ static void cqhci_dumpregs(struct cqhci_host *cq_host)
 }
 
 /*
- * The allocated descriptor table for task, link & transfer descritors
+ * The allocated descriptor table for task, link & transfer descriptors
  * looks like:
  * |----------|
  * |task desc |  |->|----------|
-- 
1.9.1

