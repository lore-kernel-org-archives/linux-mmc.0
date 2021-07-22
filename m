Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E969C6379C
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D93B61285
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhGVDWO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhGVDWD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A483C0613D5;
        Wed, 21 Jul 2021 21:02:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v14so3003823plg.9;
        Wed, 21 Jul 2021 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGZxKn6tTfxIz1ElZzbrIszNdNKnNbkGgVXQIKRLvT0=;
        b=ZhTEaqtfZm3sbccYU5c+CRwB8y2BGZGPt5tfjUDkO8z+/JcaLtgGsstVejflUi26m+
         55uz6B0uKfNETJoU4AzgPq7ETjuN5zrXjgN4Y24SUB2t1QZxvqkX8MrwRULitmX23B5l
         S7s9/aA2++aGlaY8ukBumWyVe5HvjWBcpTMMQJoSjM20XGfrZ67nKB+91MkO4lXQbM2e
         8SOPV7b2T8RUxGjGckO65uj8Zm4WFhKQ2hlX8K6JDIKK95rOo65s1TbCobPZRynE056b
         sNCN5+a3KBb5oz65paUWrOlxgbJHwaIiRUYfU8N4YuVRXir+StPWLinyPa+53Gt2RnT5
         O1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGZxKn6tTfxIz1ElZzbrIszNdNKnNbkGgVXQIKRLvT0=;
        b=G4ePJjF2VGM0sMiTVtG71ORQfVYa8+UD03if6J5iGxGWJhmNye6f3OP18ZKXwMoDHK
         Y0gb6I4OmhGJ/C5m4egVLShYuG1pEdU3l7xkJYcMx+sYi/6nTJGQQ+dwqr5HbvE12q0T
         Gw3ADpzQfEvbljXP02E9uwuPyCob4iwpmm/oC5giDXhFxLRjhVgizAljvQ8m+aa6scHf
         m/44xkLgYaOQ4/aJ0WM7j7OAnOMfRL+OND6JVo+k8MkojbHF7eSf1MpUTbsh6K3Zc7+3
         gwOCfQZN1PMRmOPlNBTZAYCyIfCltLrhEKtG1AZSf8sOOeKtSx6vWi9GTCAU3SVP9jT7
         N0lg==
X-Gm-Message-State: AOAM533eQBSIjluYJRDLlZgumxDITIvxyIamWpbxhinJm/bWQpwZGwtx
        5R8dkpVxJn3Vz4rDyTE4ggc=
X-Google-Smtp-Source: ABdhPJz62PnRNpOKLtOez8IcxGXzTFYlQSoGC1XBzWIQYtdS07WAlXw5OEKAAwHE5JDxLMEijMvq4w==
X-Received: by 2002:a05:6a00:884:b029:346:8678:ce15 with SMTP id q4-20020a056a000884b02903468678ce15mr20428411pfj.75.1626926557614;
        Wed, 21 Jul 2021 21:02:37 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:37 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 24/29] mmc: core: add post-mmc_attach_sd hook
Date:   Thu, 22 Jul 2021 12:01:19 +0800
Message-Id: <20210722040124.7573-24-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
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
index 0a407ef1cfc0..f984d5a9301a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1417,6 +1417,12 @@ int mmc_attach_sd(struct mmc_host *host)
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
index 89a9e0e12f07..ef613b3c9af2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -199,6 +199,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 	void    (*uhs2_disable_clk)(struct mmc_host *host);
 	void    (*uhs2_enable_clk)(struct mmc_host *host);
+	void    (*uhs2_post_attach_sd)(struct mmc_host *host);
 };

 struct mmc_cqe_ops {
--
2.32.0

