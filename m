Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A7C5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1244C206B7
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp+wUJkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKYKAE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKYKAD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:00:03 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A20C0613D4;
        Wed, 25 Nov 2020 01:59:53 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id l11so870229plt.1;
        Wed, 25 Nov 2020 01:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IaqsdwaWWl1Yc0/ljKeIV10dw7aVi/wXUYW4bfFDoo=;
        b=Bp+wUJkON9CbolW7/hHUHJbCphFSIov+mz2difSvA+snT+NR3PLQHSYEJBQLQwiVqW
         gKrYkRjw3ggrN/O4r3J5uoHBXI4hzuvQ+4skbksy9SER2kG4xNEdg0OjtRlNo1n6q6JN
         p+4cd+HhxlejhIYd+UP9XObnL97Q1/yXhOysaMMkO4Gi9kewiVyQiKe/qrRB9QVXAYIK
         0S8UAUiTl+Yr4mZieJ4SasbWMS9dVKZqUxp+6V0ol8AzjPAuUVaZv+x4eEup/NBHi0yh
         GtcnINVMNLJY6iCGjLCEDZ/sRO9m0R/M394Ze6naQomjbnRm9SkUTJvHtjknn9pF73xV
         /2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IaqsdwaWWl1Yc0/ljKeIV10dw7aVi/wXUYW4bfFDoo=;
        b=cz5aCtkU+NeF3dSAnbjwl5WcGnWBGrfguSYQyDJGyeh9JSd2+uQW2rXBh2XKv/W9Kj
         W9kHF+49xOyzvLY1ueVTcF+HDE60Yg3/21o7lzdisW1MkIid0HsQC78KLErK2wWlPKP9
         T57i2TNcN17f/okkFxwj9R4nfmTZ5LOlURI7Z0xarqArRbLqEPP/V1E52UB872o0/zCI
         LsekSyLCTrRInpLcDVhHPwCc0l6UnwOGjCNA6JOiAyLR3gpO521941pqhpP/RTkMnmTX
         +rldV7FMTPmkWFs6LuBgyncWgSiRjkzkFwSbmcncM8+GrXi+J1FKwYTX5TVw092NLojp
         Eqbg==
X-Gm-Message-State: AOAM530h8pkeNCtVeSytQrznKsKGubi9pZAEympey7ZK2kBlJ/3G5sdT
        qZgZMJaYsTj3sCNccAQyrZQw0yw8M5XNTA==
X-Google-Smtp-Source: ABdhPJyTPHCnaIWIK2frUkUEDqTR301JWkLli+GF71A3C8SGYiGRJBMwtq7pc9os/9loP4V1KaYCUw==
X-Received: by 2002:a17:902:c281:b029:d7:ce5d:6406 with SMTP id i1-20020a170902c281b02900d7ce5d6406mr2393406pld.35.1606298393569;
        Wed, 25 Nov 2020 01:59:53 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id g4sm1837884pgu.81.2020.11.25.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:59:52 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
Date:   Wed, 25 Nov 2020 18:00:04 +0800
Message-Id: <20201125100004.1288-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.

Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
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

