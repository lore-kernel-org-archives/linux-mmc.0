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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD7C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 08:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EB922A85
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 08:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbhAKIXj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbhAKIXj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 03:23:39 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324EC061795;
        Mon, 11 Jan 2021 00:22:59 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p18so12066170pgm.11;
        Mon, 11 Jan 2021 00:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xrb/D3i6SruyYFj7QytbStPBixbUgHaTDT5U+xxajek=;
        b=MRJ0IUjLohdlGWduBbcmJ+1qxJt4zQzGCYnG2RWS/m4Qsk1czDsAM6hGMebHRMFDt+
         90VFyJ+TMV/sAM6evjzWjOR7W1KftqL+VCVEQ732Inttj08jMZ9jmouUumCt2+m/ff0W
         q5eleEWTtmtlkjb8m4nfAq9siRu21TnoBFWYOglRW7ShZLlPMUigIJC5a70m0UefZswF
         TJtrSdB/ck2nJJT/MOa+Nm6kaFFVwBqrmW0pCp/hEPywpvOMg6a7EFJxC8w4brF629Ts
         pg75L3XPycBa4Z1xqSHQ3HF/0h2M+Ovuq+ZYjDfsCya4VZn2GQt44daNjqOr9ZNFCWmu
         O+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xrb/D3i6SruyYFj7QytbStPBixbUgHaTDT5U+xxajek=;
        b=L3/kUJhHN5qs2DqMLF/BDRiKnyyvnSIGtG7dMra98Pu38kSGNkvE6xaTdgrkMP+qYb
         kCIiQ9e1qGBubIcLXMTZIxDpVHDHdsc2gwh03qPriFQkmbWzz/bW7+vXjzcORx6TDNrQ
         E5YHndenEmbnQOsvvO3cbPudPb1jdMZp4Tv/2ziRnvvG6Y5kU3e+fbrJmOCiR4ZsBQIO
         43UKApmIvnedIlhswfbbHaJUdpuhqh+pTVgjwPzKg9ea59m0o/TmUzjPysEV5judlAKN
         S0/vuLMwRGxfJvK2HGu1wVBjT+gj+TAb/9NHyWvqIzqr8mwfp4cEvtDvpVb9fQLCk7Yv
         mp2w==
X-Gm-Message-State: AOAM531oKuH+66BpK5qBcoGiVyIbOn01Hb/+AGAAikLo7CxgvyaBvnKF
        RrT/m4Yv4Fg3iJ3k+sYukk0=
X-Google-Smtp-Source: ABdhPJya+X5O2f9pp4LhpqXdN3kAZFNw3ht+j7sX4B8AC8fDp863jwa2ta9DhcIirZCsgJUc+yWZLQ==
X-Received: by 2002:a62:1a56:0:b029:19d:b6eb:291a with SMTP id a83-20020a621a560000b029019db6eb291amr15537377pfa.10.1610353378619;
        Mon, 11 Jan 2021 00:22:58 -0800 (PST)
Received: from gli-System-Product-Name.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id h18sm18456264pfo.172.2021.01.11.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 00:22:58 -0800 (PST)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Finetune HS400 RX delay for GL9763E
Date:   Mon, 11 Jan 2021 16:22:49 +0800
Message-Id: <20210111082249.17092-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To improve the compatibility of GL9763E with HS400 eMMC cards,
finetune the RX delay of HS400 mode.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 2d13bfcbcacf..14d9154f3af1 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -95,6 +95,10 @@
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
 
+#define PCIE_GLI_9763E_CLKRXDLY  0x934
+#define   GLI_9763E_HS400_RXDLY    GENMASK(31, 28)
+#define   GLI_9763E_HS400_RXDLY_5  0x5
+
 #define SDHCI_GLI_9763E_CQE_BASE_ADDR	 0x200
 #define GLI_9763E_CQE_TRNS_MODE	   (SDHCI_TRNS_MULTI | \
 				    SDHCI_TRNS_BLK_CNT_EN | \
@@ -801,6 +805,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
+	pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
+	value &= ~GLI_9763E_HS400_RXDLY;
+	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
+	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.27.0

