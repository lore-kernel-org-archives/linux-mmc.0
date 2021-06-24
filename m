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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF3C48BC2
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 02:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79640613AA
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 02:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhFXCTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 22:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhFXCTL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2021 22:19:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E30C061574;
        Wed, 23 Jun 2021 19:16:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id n12so3397688pgs.13;
        Wed, 23 Jun 2021 19:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8BjcwU8RuYcSDssG95FGdDIkS7+nA+sQUBByLWGNG4=;
        b=QTjJ0PHb0XfM3um70pjfej+BMT7hzzy+l6oyKB9VHv1yuK7EEbnPJ5HyX/UrMzRWzp
         ETJyje8dwe2dSpv68zq1H/q60Pv4woXhkUWNI4JqAaFiDOE+P5hJTZxUQuo2fKLkDnGN
         U7LGfPz/dqMa8BXc+jZCdbutlI+BEgx2w+p34zNBgHsnSOShsxmPfLQJYjaZ0dgsYxki
         9cX09qR4tsp/vqiu6shO4A4dhCpTvc5K0yjpjB829nFiSpkDRulJ4btkCUx2I63Cpf1i
         vkaWC+08V3j4tOBgxo7Gj8iXuu7VwI2koEPmcdu68D/QFK8v2QCrYRYSi0vg3hJD6Plo
         4exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8BjcwU8RuYcSDssG95FGdDIkS7+nA+sQUBByLWGNG4=;
        b=O046G1Li/hjmKHDdI00ky098+bCqOU5jKTLf35t5ySB6Zq9UM+rhyYb33JxqSxjCKt
         pjqGLDV7z022PK9TQJYR8AvwJ1+QT8y7XGbwx9eW3benGJuhxd3xCGZOoqH5TErkNzAO
         vl2sXKhkNq5wgSiBPvxbiSkrwIi6Fy/0keN9KrRuWKvAJ2OKZRC5U81r9gf8486r2pEL
         1B2zFApz7AoLwWfaZUQdKxMPgLKRxh8rpjwMlRl9VZfdngRgWLI/JyEpPBamdu2bOF5K
         pA9mX4s5FrygB34hQDoiEqWiCU1C9MC0rs3NbUtk3JB3gfgvVhXQXdG2/ei0gzz4Hrx/
         aAqA==
X-Gm-Message-State: AOAM531clobNMoC7fYiETxquC5MPV+9ulDSKsR0S6d9P7paq6eDU4C4I
        ESMmq08Qc6CLsqo/1VyI22L2DH51P2JQZQ==
X-Google-Smtp-Source: ABdhPJxkHe8Gdy4DGLjJ5ufvI3fLz9EaGvdWutVooqHfCPReTEGzkVYLYtedVN+cFlFsqJb1U65ISQ==
X-Received: by 2002:a62:14c8:0:b029:2fb:3d9e:bc35 with SMTP id 191-20020a6214c80000b02902fb3d9ebc35mr2657145pfu.40.1624501013338;
        Wed, 23 Jun 2021 19:16:53 -0700 (PDT)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id m4sm6228794pjv.41.2021.06.23.19.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:16:52 -0700 (PDT)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Improve Random 4K Read Performance of GL9763E
Date:   Thu, 24 Jun 2021 10:16:48 +0800
Message-Id: <20210624021648.101033-1-reniuschengl@gmail.com>
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
index 7ba0fd601696..26df8ec5d67c 100644
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
 #define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
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

