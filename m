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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68554C6379F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5F5608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGVDWQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhGVDWG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:22:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B0C061796;
        Wed, 21 Jul 2021 21:02:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c15so2995796pls.13;
        Wed, 21 Jul 2021 21:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIp7At3Tr1YQgF3wIFdAFZiItKmHc+GAgVZKUS+gZoU=;
        b=kWBkFNsy8cspdW9Oc3Lted3toBUQ0n3ZXd4eqIKmICJq3zfuvyWwmCLxl3HgcNyIMa
         7vw9Kz7sG1wUTav3u63ftCM8jk6ZIfGSNXzyfRhUtJfPm3mh2JOM8pkVgvNSTSpnYgA5
         Qya6jH5vj51xGz5u62STW9QKm11/q2fg0NFcfJTvPHGFZ9DUCNrI2+3uvAx4b8w1dDy3
         aRUis4eOoMzhS0ftXn1u+Sy7M9ckS48Bo9SVKdG7CH25VPfD6UIMZAdK2vofa1QO4IAd
         vuwzfUj+kj75MuusQldLHTKDdK4FB8J5HAwyXi0itb1qaMVz05N04ddgz6kZvhG4rC0K
         I2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIp7At3Tr1YQgF3wIFdAFZiItKmHc+GAgVZKUS+gZoU=;
        b=ZTPl/v39d5YhE24XemByvm/DQxt2oNl/+XyvMRADMarSB6JHFuBCIhfR9Rz9v81bIz
         MBDEmy9BrPY0VWzAmlWsHqU4WzXm1HQ8teQMfU0+2u0vFVx5qjy3oAwwAKSxFWKFyPe+
         nP/x9jrCjAFl54e9Laolq+XOzOFcyeH9Uuhbqrzc7oivFdkJokcdVqppZ3I+WYkl9l+Z
         4KFOvC5HibvsGZMzjEsiY63M6+3mUM1OHuLU9ZeIO4ZJrPvVAeKAlUQ5oiTbLrhw1CLy
         nWUJWXFyYqv4S+ck8dTRZ6fF6uwnmr5x79xerF9ttcWIUzLgyQLlqa9lKmyboAsLJgAG
         GjPw==
X-Gm-Message-State: AOAM533XjbCc5VvboMDyzAYm0f4ANqQddEXnrYxFGgrUpQ5Okx0a7kPH
        p4b8OVXYwTamZIZEm11QBXq+i968Caql8Q==
X-Google-Smtp-Source: ABdhPJw8suLMvs6Dzo4erCtOfqXW0iYv7kilTXt9+3NzG8Qnwpx9yaJj8GYoLYYi5eQk3p91YAPHZQ==
X-Received: by 2002:a17:902:b941:b029:12b:81c3:6919 with SMTP id h1-20020a170902b941b029012b81c36919mr17965563pls.7.1626926561230;
        Wed, 21 Jul 2021 21:02:41 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:41 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 26/29] mmc: sdhci-pci: add UHS-II support framework
Date:   Thu, 22 Jul 2021 12:01:21 +0800
Message-Id: <20210722040124.7573-26-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch prepares for adding UHS-II support at a specific UHS-II
capable sdhci-pci controller, GL9755 for now.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 16 +++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index be19785227fe..ac2dc51c8628 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -39,6 +39,7 @@

 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-uhs2.h"

 static void sdhci_pci_hw_reset(struct sdhci_host *host);

@@ -2253,7 +2254,10 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (scratch == (u32)-1)
 		dead = 1;

-	sdhci_remove_host(slot->host, dead);
+	if (slot->chip->fixes && slot->chip->fixes->remove_host)
+		slot->chip->fixes->remove_host(slot, dead);
+	else
+		sdhci_remove_host(slot->host, dead);

 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
@@ -2264,6 +2268,16 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	sdhci_free_host(slot->host);
 }

+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot)
+{
+	return sdhci_uhs2_add_host(slot->host);
+}
+
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead)
+{
+	sdhci_uhs2_remove_host(slot->host, dead);
+}
+
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
 	pm_suspend_ignore_children(dev, 1);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 8f90c4163bb5..9082a7e9c10f 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -139,6 +139,7 @@ struct sdhci_pci_fixes {
 	int			(*probe_slot) (struct sdhci_pci_slot *);
 	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+	void			(*remove_host) (struct sdhci_pci_slot *, int);

 #ifdef CONFIG_PM_SLEEP
 	int			(*suspend) (struct sdhci_pci_chip *);
@@ -188,6 +189,8 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 	return (void *)slot->private;
 }

+int sdhci_pci_uhs2_add_host(struct sdhci_pci_slot *slot);
+void sdhci_pci_uhs2_remove_host(struct sdhci_pci_slot *slot, int dead);
 #ifdef CONFIG_PM_SLEEP
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
--
2.32.0

