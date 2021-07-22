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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DE4C63797
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD62861362
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGVDWO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhGVDWE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EAC0613D3;
        Wed, 21 Jul 2021 21:02:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id my10so4367014pjb.1;
        Wed, 21 Jul 2021 21:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1VEGFGIDPzjreHKP+UYCuwcYMr/QZ5cwNJBhn6wCoA=;
        b=T7MI+SJPMEdYZ1Q+3zj70fiQZn6hUyBZY708CioD5GaBeMSn6bGY4Lm1WCTQq0afX2
         lXIMOCtzszqqBe8gPRJwlfrzffk/MImeUQLLBj2fNLJ15XHkrO6KL79jc6r0FCSNhANu
         oDQ0J5+VNG/ZVjPvzStZzLCxvPkbi8ebGH6At6vduEQto9tIy8NRMzTVnkknfSeG+cVh
         M3dVEjo2dqcSuZoqD08az3wZALhJXSO0nJftL+d5UYlrKEwXKnPmNcQ47hxN6RV5elhQ
         by7C/VC5glGVRhuixewG65SpobBshBwQq8wF2Br6PI2XVs7osHI+qR7clSsgfOwsqADd
         +M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1VEGFGIDPzjreHKP+UYCuwcYMr/QZ5cwNJBhn6wCoA=;
        b=G3OVUoSYPgYsUfbncxeC/g9bcQmb/VMt71184xoZ4oMw9L7gYW1VmfrIWaK6jPt1bO
         SeWLQvIuiEUfpmzZx5kR1kX+FQ3pUrwlVDONFRGCZRsqnh6KBExz+EIIkViZMNRPDaah
         9HiLuS02kLhG5EUNkt2TUlqZqNe6TM9HyDTMe7A5BGi2IYneAXr4m1jwlGEEStvToe/7
         rTbb7ma2AkbzoBD0Mjnq0m9deqXsLs7nuqpfZ+mtp+m1ccKjDfQKPQS4/uBzrHDfzYKV
         snJ6xQr9HybRIk9YAqHxnr+ti7qaPsmT9uesXc/8JvGFuEbLFGyicv38PtL+jyr6vy9P
         s4+g==
X-Gm-Message-State: AOAM531PPRPzSa0CU2ciHvgrB9amDYmWGiQinpjgHfu2hjSZoa8RDtGZ
        PaNiMSwZSACDcZBq7ymWvUY=
X-Google-Smtp-Source: ABdhPJzGs28Jahhiwuk7antILHsHYULeO03MKfwve+syhDbCwPR5AsMigp1XDKCblj6vctG+56Nmdg==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr30217449plt.16.1626926559417;
        Wed, 21 Jul 2021 21:02:39 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:39 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 25/29] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Thu, 22 Jul 2021 12:01:20 +0800
Message-Id: <20210722040124.7573-25-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4e2cb73a63bd..b85d9d077c61 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
2.32.0

