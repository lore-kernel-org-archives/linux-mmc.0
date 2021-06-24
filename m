Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683EC48BC2
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 03:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5780A610C7
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 03:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFXD2O (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 23:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFXD2O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2021 23:28:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80A8C061574;
        Wed, 23 Jun 2021 20:25:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b3so2224275plg.2;
        Wed, 23 Jun 2021 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55IvFqcJa09LRNYHXcgNlk2bKn9LkJhjqCoMCI2+os8=;
        b=NZWnLr8jcto7FwMiL4jyI5wDUjCTtFw8vrJTinQkjSdOSNJ3o1fN+PAHP4kVJ6bRnz
         AUP1NkSguM8Hu8ux4znm7Tx7f9ZiqwwLV1Lc1s3BJe9CNqTNaLHj/9vVriemygcZiGVy
         CXuYf/ao+NZ6hkhw5ICgWpuaVwuGFJ7+W8iLKax2m2LzUypbYTTVrNN947XkCWh2Cift
         6XVy7/wxiLuCmAmN1jRcjCrmXOjmq3Rmf2nRvRjGKkFORALYCBa4pqnl1PGHtS74OQs0
         CbIx2pAUS6tq8gldReYq+K0o9gCibtxaW9/zTaPrCo+3iglBkqvc4hdd41vtwTJZYFuH
         78IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55IvFqcJa09LRNYHXcgNlk2bKn9LkJhjqCoMCI2+os8=;
        b=bY2uPCPrzC/49x/17sVZJlndHUqHj6NahNyCVppuCsgEWLNSWApao1X/11hDO7F29C
         mY17KtjbGGhZ9/m7dbohJQkigZshC5s/Pa+Yb7MZuF8KnA1qUzgrojRmiFqh3AuH/6LM
         jAr0MzCDKa0zqNo2Nb1uV3BNR8/opCVhnhHX5Hxr606YcU4EM74csUvjcBcBaDk9Iq0w
         OiPnkFr8HwJDEDaNwMqRpZLhpQ1wWywRn8SCHpLX6fU81EgpCRWt1vFueoiaie15ryQS
         6ULefe5+q/yRjpA1lnbWDnUaeW3klK5hoYp/RANXVVB2L6Bu+5WcNVTGodqcJwkpLyaU
         duGg==
X-Gm-Message-State: AOAM530fHR18uL3RhNF42DqKqPeWZghQY0L6BgPkAAUGRSvbz6+Qvkp/
        pZPeEziGL9zU9Gi7CjPhRKQ=
X-Google-Smtp-Source: ABdhPJyPdJyMThorJ/b+J+lQbEgRFJwkzf6iPGnEcFoqpAnW7jBET8/fF1am96HE7XUi/Ry60HDDRg==
X-Received: by 2002:a17:90a:448d:: with SMTP id t13mr3055731pjg.116.1624505154300;
        Wed, 23 Jun 2021 20:25:54 -0700 (PDT)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id z15sm535607pgu.71.2021.06.23.20.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 20:25:53 -0700 (PDT)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Thu, 24 Jun 2021 11:25:43 +0800
Message-Id: <20210624032543.101861-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

During a sequence of random 4K read operations, the performance will be
reduced due to spending much time on entering/exiting the low power state
between requests. We disable the low power state negotiation of GL9763E
during a sequence of random 4K read operations to improve the performance
and enable it again after the operations have finished.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 86 ++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 302a7579a9b3..0105f728ccc4 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -88,6 +88,9 @@
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
+#define PCIE_GLI_9763E_CFG       0x8A0
+#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
+
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
 #define   GLI_9763E_CFG2_L1DLY_MID 0x54
@@ -691,6 +694,86 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
 	sdhci_dumpregs(mmc_priv(mmc));
 }
 
+static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+	static bool start_4k_r;
+	static int  continuous_4k_r;
+
+	cmd = (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23)) ? mrq->sbc : mrq->cmd;
+
+	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
+		if (cmd->data->blocks == 8) {
+			continuous_4k_r++;
+
+			if ((!start_4k_r) && (continuous_4k_r >= 3)) {
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+				value &= ~GLI_9763E_VHS_REV;
+				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+				value |= GLI_9763E_CFG_LPSN_DIS;
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+				value &= ~GLI_9763E_VHS_REV;
+				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+				start_4k_r = true;
+			}
+		} else {
+			continuous_4k_r = 0;
+
+			if (start_4k_r) {
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+				value &= ~GLI_9763E_VHS_REV;
+				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+				value &= ~GLI_9763E_CFG_LPSN_DIS;
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+				value &= ~GLI_9763E_VHS_REV;
+				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+				start_4k_r = false;
+			}
+		}
+	} else {
+		continuous_4k_r = 0;
+
+		if (start_4k_r)	{
+			pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+			value &= ~GLI_9763E_VHS_REV;
+			value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
+			pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+			pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
+			value &= ~GLI_9763E_CFG_LPSN_DIS;
+			pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
+
+			pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
+			value &= ~GLI_9763E_VHS_REV;
+			value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
+			pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
+
+			start_4k_r = false;
+		}
+	}
+
+	sdhci_request(mmc, mrq);
+}
+
+
 static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
@@ -848,6 +931,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
+
+	host->mmc_host_ops.request = gl9763e_request;
+
 	gli_set_gl9763e(slot);
 	sdhci_enable_v4_mode(host);
 
-- 
2.27.0

