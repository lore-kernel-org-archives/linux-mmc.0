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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E9C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 11:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3320E20665
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 11:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwFSXB8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKYLBw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgKYLBw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 06:01:52 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC8C0613D4;
        Wed, 25 Nov 2020 03:01:33 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so1943058pfq.11;
        Wed, 25 Nov 2020 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoVpAWHYjS1Wg3JLaDQSuDFhZa8zGnm8PN6jt6kl1oY=;
        b=AwFSXB8UMOUzoQ89fUHMNhocwrNCH7yyrHVuEjkdDfcUSC6gVtmxxBYNeCpyV1iuP6
         YjN9MuNwyVeT8FEuOJW1dhJUBp3q5+AMY18qev8VRc73IU2KJ0Ye/zDC+YBNdt6p2ynP
         wY42CJ+HibFBpw4SFWcEdZZ7VjBBOXWO3kSpL/QeZvr2b9Ft4+7DsddHqK0Luzq+Pbms
         SFBUMHhHJeDS9J95bKRhc8WE1beXYxkcvFeZXzyapxZHbWqoFKDnIOMN841ivfSncjac
         u1yLcoclBn83f43/lYDri2cyvNAx7rRr3/Vld64U+UYKPglrd+Ruhv88S4eXJ3Piuou1
         XYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yoVpAWHYjS1Wg3JLaDQSuDFhZa8zGnm8PN6jt6kl1oY=;
        b=ToCCo90XuF0SYTrJJHshdnjBS6LVcJiXJP7Wdn8gqnM3rfTk379RfxZQUopqR4FV3K
         wEs5wpw2kfywedtRKnbApkD/TuxVXtlUkrLYhGkfkUMmCFrpoWELsqyW39XT6GnDsMme
         Gf7O8zWT0Yd6zM+i9v97tuWX8Q+f/PkQdaP1pJfAA+D0Lfu2xQ/scsDoeM4uW+WKUuGk
         WtvafCVwJkqR+4xnmrvRWWZeRJfPgpjdvlxOB1E5v3Ut+c/JxkA/ktvUY/ONkS3mJgEs
         93ozik3qb8vB0EXzgOuQHTBVi6PtF+V9qmW0KZXafUQqbmmIEre0DXxfIprTGWejOeV3
         Zhkg==
X-Gm-Message-State: AOAM531REuNnI4qZEhsfkyB6E26FF2Pz09UdByl7lxm5z325lf+o+1om
        jUkZN53NKyF5LcZIz6+C2Zc=
X-Google-Smtp-Source: ABdhPJzutxYbnWLVx0LnkXjj3R3AWLqTJXbi/VdRS1SAsv04zmKDCjlHcueXEx2PBviecsjFM3F2HQ==
X-Received: by 2002:a05:6a00:c8:b029:18b:b0e:e51 with SMTP id e8-20020a056a0000c8b029018b0b0e0e51mr2570993pfj.37.1606302093535;
        Wed, 25 Nov 2020 03:01:33 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id g5sm2643381pju.9.2020.11.25.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 03:01:33 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH,v2] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
Date:   Wed, 25 Nov 2020 19:01:45 +0800
Message-Id: <20201125110145.2824-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 9887485a4134..d45d7e529150 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -87,6 +87,9 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_MMC_CTRL  0x960
+#define   GLI_9763E_HS400_SLOW     BIT(3)
+
 #define SDHCI_GLI_9763E_CQE_BASE_ADDR	 0x200
 #define GLI_9763E_CQE_TRNS_MODE	   (SDHCI_TRNS_MULTI | \
 				    SDHCI_TRNS_BLK_CNT_EN | \
@@ -764,6 +767,10 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= GLI_9763E_SCR_AXI_REQ;
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
 
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, &value);
+	value &= ~GLI_9763E_HS400_SLOW;
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.29.2

