Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2F1C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 03:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B36C221FD
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 03:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbhAODqv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbhAODqv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 22:46:51 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CDC061575
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 19:46:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x126so4643068pfc.7
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 19:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAy90v32bF0Njb5HkTFPkRyYimy8P4BZEPuOr+6RNzc=;
        b=lnXDQRnQG0yeCy8kSarmexT1as3uOOw6Dc7JrxbBkCyXTxYaNmLAwbYEJGI8gnT0UP
         WW1Ya/mFB029UzGnHwlK21YgwyEj0AsPxnvFJ7U7xt2WV59SfIZAfDO0fDnJz/os20wR
         JNHlrE/GjCyoKYj9KHYyiChNr61LgQacm/IepEWUqTD0wcH7rw+y1pp4r6j9zp65pd7+
         vBP2VcNQTTdsytk/XnjeT4ctmioFL+x3f/K5C0dFf73HIxlLg/8BlNJbXFeEKg0DDxUP
         o05V+MnYJ0jbDjn2ElSiEwSMYj4+1TsFnM3mKs9o/UT8co9fLORga5a7AeHv+iyJxa2T
         Ad3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAy90v32bF0Njb5HkTFPkRyYimy8P4BZEPuOr+6RNzc=;
        b=ahinjoUzld5laWQ74KxQOj9WeURi+w2s42+W6+JyKYIFyQvneV66aOeF+o6Yg2CKg3
         DxF5u2QTTJsLSgGiROb5H7KZsShenSbgpic1SLW2qtCSZGnjU4DC1Da+vz8iTPK1mjqE
         fvkCGI5M25A3uH2HJ14vcRwhsvpOr1Q8GocMHPYtEXPu17bkkQaQ0qnkz8xLAXh5YURZ
         Bsin2Si+1dNWqqV8VzniR2RXV7pUkr+wga6Pwdzvt48TQ096mQ0/AyU+bIM8EI/YvnEv
         m5XsCLAYickVfMY7KNnVPbpcxdeUaLVA1OIVoTp5TBTFelukWJkjg6Zyxl/9n9//sIDe
         wPWw==
X-Gm-Message-State: AOAM5309qG/pQsOW8srwzg74y5OWtrPZ7H7yhg2hOb/cIByjnAroraYS
        5w9XM+zmWGsrwxbMk+5NRlsRrtittO/6ZQ==
X-Google-Smtp-Source: ABdhPJwngh9XoxgeTsxYH0cQmQsRMmpcDE+Or6J197rn5jSSSiEdbbXk29gYZDgQmwYQo0b4hEARxQ==
X-Received: by 2002:a62:445:0:b029:19c:162b:bbef with SMTP id 66-20020a6204450000b029019c162bbbefmr10663493pfe.40.1610682370567;
        Thu, 14 Jan 2021 19:46:10 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id z12sm6431389pfn.186.2021.01.14.19.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:46:09 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] mmc: core: remove redundant card null check to mmc_can_sleep()
Date:   Fri, 15 Jan 2021 11:45:06 +0800
Message-Id: <20210115034506.646-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Note that only _mmc_suspend() will call mmc_can_sleep(). And card is
checked before in mmc_can_poweroff_notify().

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ff3063c..49e5487 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1899,7 +1899,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 static int mmc_can_sleep(struct mmc_card *card)
 {
-	return (card && card->ext_csd.rev >= 3);
+	return card->ext_csd.rev >= 3;
 }
 
 static int mmc_sleep(struct mmc_host *host)
-- 
1.9.1

