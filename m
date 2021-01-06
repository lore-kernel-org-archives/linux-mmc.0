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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6D5C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24A72310A
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 08:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhAFIyi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFIyi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jan 2021 03:54:38 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB12C06134C;
        Wed,  6 Jan 2021 00:53:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i5so1810372pgo.1;
        Wed, 06 Jan 2021 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8n/mDppQN/+rC6TXnhHYuqYVHdIMuqXKUEFt8ctLXQ=;
        b=g+X3dHyr4s4V/Ptl8bLW7gd0BdYFoXyX6+5JMovjo74VQVyLpu4crFx5YC5IOzR1id
         QpXu5mpN8g+4r/JwcOPQNj4BVTl7C2o45knNSCuMk5yFSlRifKrkck0rk8IkEjCn2ig/
         pnOVTo+h/Ftt3zadMznUc8svUalT9V9lDEpBcDF++TrAgyLuvXgXExENr4p/9vEWreQ6
         G2kgHnhj6CwIIoqLBPs41NPp/QLalyZQCy3wEyFRIgoAmFCliUclrbWVnoJbQhfqPYvX
         M4af8vU6TdtYjoLAkYlHPdEpK8PgL5kW2MAK1rMlWDBYkrErwzzSbwXwFZGk1ZV3PeQB
         FVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8n/mDppQN/+rC6TXnhHYuqYVHdIMuqXKUEFt8ctLXQ=;
        b=CFJeM7CivrBBZu4OZbqO1QNI52dxLH80OL9Pj96oGAcYe15blk/0OAMn/nGcr9jNLM
         ZANeQRFhGWMr/rrnDtaMQEisP0Hyof+G91WPc4MyFv3uuZJ1e6siK7L18O5GHqu5PQO2
         UILUFWWn7iG/D7q+aVO+O/Pim06mHxhwb2eSEz2mSFJzqdiuvW7tkLS73UX3wxwOvm2U
         NK2ovQbb0vggkr77/MUQuCCoFkFkgmR5og6HXH/Dg7oIpSH9JhhA7l+YdpsYiLL0x/SJ
         FpRWrpf8j1gj74lo//2vmHq2ugUrHgcHIfdj7dHBghr9A1xMYUsMWYEyflRyF2OEHwtB
         4qCw==
X-Gm-Message-State: AOAM530fesA7w0w51DZBh3h0EzVOJAuPEOZs3t3BNjSG33Y5koCCkGSU
        CxBONfm6tdZWMjm1PaoF7nQ=
X-Google-Smtp-Source: ABdhPJxRsGbPn7fB91Z8bm5aWqbISXgDXCNUFBC2SU9PpEFs102S0WPYceFOxBtb3hRogNEpjH94MQ==
X-Received: by 2002:a63:5416:: with SMTP id i22mr3461995pgb.43.1609923237457;
        Wed, 06 Jan 2021 00:53:57 -0800 (PST)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id y189sm1739191pfb.155.2021.01.06.00.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:53:56 -0800 (PST)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Add a switch to enable/disable CQHCI support
Date:   Wed,  6 Jan 2021 16:53:32 +0800
Message-Id: <20210106085332.5494-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a vendor-specific bit named GLI_9763E_MB_ERP_ON at the bit7 of
register 888h to decide whether to enhance random R/W performance
of GL9763E. CQHCI support will be enabled if and only if the bit is
set and the GLI_9763E_MB_CMQ_OFF bit is not set.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b85edd62e7f0..c6a107d7c742 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -84,6 +84,7 @@
 #define   GLI_9763E_VHS_REV_W      0x2
 #define PCIE_GLI_9763E_MB	 0x888
 #define   GLI_9763E_MB_CMDQ_OFF	   BIT(19)
+#define   GLI_9763E_MB_ERP_ON      BIT(7)
 #define PCIE_GLI_9763E_SCR	 0x8E0
 #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
 
@@ -814,7 +815,8 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_MB, &value);
 	if (!(value & GLI_9763E_MB_CMDQ_OFF))
-		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+		if (value & GLI_9763E_MB_ERP_ON)
+			host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
 
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
-- 
2.27.0

