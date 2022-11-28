Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4BC43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK1Cov (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1Cov (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791CA11478
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1696050pje.5
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h52LC2fcwXDHkqty7e4d/orwaU1LTOLaC2O9W0blfKw=;
        b=dUil7Im7K9hDFEl6/RqJQ3C1or9z9wnS+K+BCw8nkXpcE7Rz5toyfAsfBGwJTAxbbz
         dhrVb2nyvwnatHp/t1Xd9kgtKVZkHOhImPyo2l5lA38sO0S2+AG1UduIbKxTdk/u6gzh
         ps7eAoOz4t4A9lTyFQ1jrnVWF2Bkl2RAo4/Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h52LC2fcwXDHkqty7e4d/orwaU1LTOLaC2O9W0blfKw=;
        b=N1DsUw7g+uIYdCRSJgz1Hb0ef/fBeg/lmAYFLFHJGPHbh3y/WDO5F8lf4IRvlP2rMM
         H5WVq1iRwcb9rt3IfSgFYe45CKAixBNSm0pYR+BW03uyQDlFlpzxGk8QHuNXXnwbZBoM
         N8g6ZR4KYle0IRn0yyZgBGz7qE6prYjoLoLHYk6nGHjkV1m5xoovYCKbkS45INk8L+aZ
         vp4ZaVqjCW3bMyzNVlfNJcQ1YwD2XtwyQWbbA9BEZG0F+gYkR8RF+TG6xlKZylsQh6XL
         0xB7ExfbELpz5lTbVCzGjuRoxp/cziQ3GGPBhi6eFtPq+JfbRW9hsnlG9sejEVHlg4lp
         Hfnw==
X-Gm-Message-State: ANoB5pl2dsMCTip9w+80+UfsKdSBT6bzmcWQd7LuVeUhwNFgfH1WKzHJ
        1lF1ksmCrFVHGr2fFNv8CIJ6SA==
X-Google-Smtp-Source: AA0mqf6jSTk+LA+IeG/Mo4dhpMkPCsh+cCqAcVq9KbtzplY2gFQRos89PHoCPbLa+dhO6dckTa0kgg==
X-Received: by 2002:a17:90a:7003:b0:212:f169:140e with SMTP id f3-20020a17090a700300b00212f169140emr50593366pjk.215.1669603489882;
        Sun, 27 Nov 2022 18:44:49 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:49 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 3/8] mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
Date:   Sun, 27 Nov 2022 18:44:02 -0800
Message-Id: <20221128024407.224393-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128024407.224393-1-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 has a documented silicon bug that results in a data abort
exception when accessing the SDHCI_HOST_VERSION register on SDH2 and
SDH4 through a 16-bit read. Implement the workaround described in the
errata, which performs a 32-bit read from a lower address instead. This
is safe to use on all four SDH peripherals.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 2f9fa0ecbddd..d76131b8986b 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -80,6 +80,18 @@ static void pxav2_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static inline u16 pxav1_readw(struct sdhci_host *host, int reg)
+{
+	u32 temp;
+	/* Workaround for data abort exception on SDH2 and SDH4 on PXA168 */
+	if (reg == SDHCI_HOST_VERSION) {
+		temp = readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;
+		return temp & 0xffff;
+	}
+
+	return readw(host->ioaddr + reg);
+}
+
 static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -102,6 +114,7 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 }
 
 static const struct sdhci_ops pxav1_sdhci_ops = {
+	.read_w        = pxav1_readw,
 	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
-- 
2.34.1

