Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E4C5517A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A9A20782
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZb4Z9QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKFC3N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgKFC3L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:29:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C89C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:29:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 72so2930475pfv.7
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VO4alIYzWpT/RwVpJHrL0FuhDDCUQBDuaOz3l1c8Zvg=;
        b=RZb4Z9QTABVXxV5JwDIA8O9KK6r/7ZbyZdiLePOrnMaBNmhNTZG43oWpib94I5Koh/
         Jsqffw5hBp3XloN0cqqMhkvkL4vDJgnma75Bpngzc0hqYe/63+RsFCa8CB9koBJFGe1N
         BAEKkM9HfDGpgfNPx0U7G/BmavcxYjhEFLpQAF4HdkTXxBd3JoVEF5/U833dKhJWI0DJ
         MbvHCVY99JFEdHa53jWt2uapnfrNAEFQw9pU8ipBZtbXESm8KYAhokRrH+0j6Lx8bsDb
         nDxMB0XzLvabJxgTXX2/meMB/J8qPsavu+ly4Ty8nvu8NI74BvtoiJv0WVYCOCTlKOt8
         pqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VO4alIYzWpT/RwVpJHrL0FuhDDCUQBDuaOz3l1c8Zvg=;
        b=D2h1ecxJULWzZkQOpr/M9zXmR4nLkRivHuTHpdNHLuHqvzPJJfUUa6w7d5VZR9G7CQ
         UO4BF+0WPAwzW+z7NEZOXNwqT2Ac5nGNK6kLqWVmaDGFKt/xRvqPu3f3CcsKVo63nD1Q
         aI924Q78LlUbEJsfQ5K5BFUOsF3yvSoRieXOEiaVAFMx58mABUrumQc15EkpbvYnHAn4
         Rlz0oprczxiN0soiDn1hrITExhM+8RxHGSMTNbbx4e+gDuE0u4REiUtSrxHkrwcHH98A
         7q3mDoVKGdWTx1THCBYgObzAA1BppcXy0QDCcpQRbtge94U/kjJvC8DpDC89+umg1ztJ
         fmIQ==
X-Gm-Message-State: AOAM532Rxe4q2sMQA+HI3omKYd0+9qHiWYqelubRd6zdqLTyrwB7IvIg
        kDtI5gb+EcX7BoEeyxb8Sh//KQ==
X-Google-Smtp-Source: ABdhPJxyUhzSrs60GH/XttMxHZWHngc9fR6hhqUeDkRR7HD8qwlpNDHHkNLwNOHAJR1BveB8/CqD3g==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr18893pjk.60.1604629751085;
        Thu, 05 Nov 2020 18:29:11 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:29:10 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 24/27] mmc: core: add post-mmc_attach_sd hook
Date:   Fri,  6 Nov 2020 11:27:23 +0900
Message-Id: <20201106022726.19831-25-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This "post" hook for mmc_attach_sd() will be required to enable UHS-II
support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd.c    | 6 ++++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 54e155ff44ff..9e0a5abe9be1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1411,6 +1411,12 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	/* TODO: Is this the right place? */
+	if ((host->flags & MMC_UHS2_INITIALIZED) &&
+	    host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 19a265190ad3..03131e4504ad 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -181,6 +181,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 	void    (*uhs2_disable_clk)(struct mmc_host *host);
 	void    (*uhs2_enable_clk)(struct mmc_host *host);
+	void    (*uhs2_post_attach_sd)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
-- 
2.28.0

