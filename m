Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A2C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696012077D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjzbtFfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJLJw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLJv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:09:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9E1C08C5CE;
        Fri, 10 Jul 2020 04:09:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so2472867pjb.1;
        Fri, 10 Jul 2020 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXSanc4gimjYlUQVCO8YZAntIkVCDxhB7ClBTFnZorw=;
        b=JjzbtFfd0S1t2JHxMXH1vT3ZeUndEh+jspq5zoDSJ8cp4TLYqUJxdkA0MOsdcRGieG
         DKhW+1Unk9xcAqCbc7UYTcyfmdzzD9P7DBJhUP8Gc4ZR16FiubtfODz4RREbEXovvMQe
         bG9imrqQpFhFle+JCcvi0AMkgkRS1fCRH83O/J2fDdVk9L5qn2QsnhLHa8rk87brxWbs
         oyBKc3fv+KYlG45JhgP/6XzB6TlSnOrlNFN2fF27dOCq1aoWHoRbWn387HDK/Z5RsHKk
         Gr9t6+vnIw7Qd253wqhukcS+lqH83Up3db+uojDVF9a2xlXLLN++mAvkfg/FCV5Qxr2S
         zDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PXSanc4gimjYlUQVCO8YZAntIkVCDxhB7ClBTFnZorw=;
        b=bZOqj+wcGueKQZNqsYb7h7RRz+2yby70QhlSoGQ2gvpII19/kAJM4nrRvfWKabw9p2
         wKBT5bKFuN4s/q+xYCVCeXacRa6Ceg/1dEMSpheJfipiPv3ZaX2AExntSHBWykAGSao2
         Wym6puBMJLR+/HPhUMPUMCjtq1olJuaxLsxuL1W1Itzw5DkEZ2/MoFo9h4YZGv82DSEl
         u3YxhqKYyXDG1FCAeLNl0I8P1ETRu8MKp6RiERh3JIkekEoj/GrTNUnLIf21xqxD+dOU
         7vDueb91zmBKPD6Oyf+8SVQ32RVhGLi3zx5txApz/C3gSZXoMLtxSaqRmZas2nC+Q5KJ
         2U0w==
X-Gm-Message-State: AOAM532jxREmjB1pBCXUYc9Bb/VdILn3ED3eVV1fm/0PDaVqEsYmyMKh
        qaihp0Y3btwoWZ2wxzfoNEA=
X-Google-Smtp-Source: ABdhPJz6NVHLu0FfmzD2WI/1w5266CSAJ4wTlZf2lvMvF2WEIqfMcJgXC26WssCLV6no267l9DXpHw==
X-Received: by 2002:a17:90b:188d:: with SMTP id mn13mr5227812pjb.229.1594379391202;
        Fri, 10 Jul 2020 04:09:51 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id b4sm5619415pfo.137.2020.07.10.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:09:50 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 10/21] mmc: sdhci: UHS-II support, dump UHS-II registers
Date:   Fri, 10 Jul 2020 19:10:34 +0800
Message-Id: <20200710111034.29456-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 37b1158c1c0c..c2f6923d296c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -111,6 +111,30 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+	    host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
+		SDHCI_DUMP("==================== UHS2 ==================\n");
+		SDHCI_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			   sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+		SDHCI_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_COMMAND),
+			   sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+		SDHCI_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			   sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+		SDHCI_DUMP("Dev Int Code:  0x%08x\n",
+			   sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+		SDHCI_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			   sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			   sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+		SDHCI_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
+		SDHCI_DUMP("ErrSigEn:  0x%08x\n",
+			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
+	}
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);
 
-- 
2.27.0

