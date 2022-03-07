Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C69AC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Mar 2022 02:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiCGCfa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Mar 2022 21:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiCGCf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2022 21:35:29 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF85D5D5
        for <linux-mmc@vger.kernel.org>; Sun,  6 Mar 2022 18:34:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id w4so2149230ply.13
        for <linux-mmc@vger.kernel.org>; Sun, 06 Mar 2022 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DT2hhYn9lV6WmInHsKJzaKXBltpdZxLRrUSHgsDgo/k=;
        b=nDzqQb+xH0vSwJMM8tiV5YpXdxPLIMMKS3IIaXD5kHdRoizdC2jBvv9OoPY35LzeZV
         XQZRb319ZfNIywDuojKsWwyZOEgaL6M7vdSRrZIzPM1UlJGTdyLcoKpLGZpKToa97VmC
         gf0AhuFgHSByIqo+2hUa9dvbm+RFgIkIWHOsrqD4apmngxvDIv5bnxt7GmNYdGS01TlZ
         AlZD505bAv/jhU5pWVNO4RNCycUk+/NvvG8TPQmMKTUylfzwDliHLMsSCGn97LfeFe83
         m8/7OE7lQ9tvdOIGEJvrjrVvTTZ2zgNLcY/jRKQ3gTDSe7bLbCVNO401jmGyXXUN2iSz
         lbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DT2hhYn9lV6WmInHsKJzaKXBltpdZxLRrUSHgsDgo/k=;
        b=h37ZUcnLWFMZ1HxfV+Df4Cd+15yxfyxOmJshvrgKW+BKGA4rr6xofruGuGgS4xKdk8
         tIzTk2Upw0mhHjiHIfYp2yPJJtBTG0kmI2n3yV2yHoBCJgnRPB18R5Fq9HCbjzic7ySv
         jZK0u/rhNhIFWesLBrxS3C9LdkaPYYnoKGCAj4ETA/4hUmKi2bhqjDW03rlb2UqnAesJ
         jbrWc/Jfs/HeVB8kUqhiXF1V0SQQKfmDXsGbxfzY4AbUH2nzoym4J5d0lWILtZ6S+1xr
         Tg8DaEyZ4jZE/BlKCaJ72s++osNE6egGa05DOjZnBamZ1rnYKe4PwZSLAAwKtWQlHKIx
         ytXQ==
X-Gm-Message-State: AOAM531jCiRs9C5wsgZbvO5OChN9c/4tjmowKw14GsVbNvkaJa/zt1An
        8ryqtAHe6h9q2gRWID+Jyf3onAjddG9BULV7
X-Google-Smtp-Source: ABdhPJy3GAhp0eybL0wE5mR/Ry/gfwqgghVSSkySDH++43OjsSZb/O62nKknGlSH2rsbi6qlwzLThw==
X-Received: by 2002:a17:90a:ba10:b0:1bf:6900:2c5d with SMTP id s16-20020a17090aba1000b001bf69002c5dmr2280475pjr.36.1646620475992;
        Sun, 06 Mar 2022 18:34:35 -0800 (PST)
Received: from xm8048pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id r19-20020a17090aa09300b001bc5fb5886asm16675548pjp.5.2022.03.06.18.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Mar 2022 18:34:35 -0800 (PST)
From:   Zhenxiong Lai <lzx.stg@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, zhixin.huang@unisoc.com,
        yuelin.tang@unisoc.com, zhenxiong.lai@unisoc.com,
        lzx.stg@gmail.com, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, gengcixi@gmail.com
Subject: [PATCH] mmc/host: Re-enable card en only after UHS mode changed for spreadtrum chipset.
Date:   Mon,  7 Mar 2022 10:34:25 +0800
Message-Id: <20220307023425.8687-1-lzx.stg@gmail.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>

DLL locked status probably couldn't come out in a certain time on
Sharkl3 platform sometimes.
It can be workaround if re-anable card en bit only
rather than calling ->set_clock() after UHS timing changed.

Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07c6da1f2f0f..c415d00304fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2396,7 +2396,12 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		/* Re-enable SD Clock */
-		host->ops->set_clock(host, host->clock);
+		if (host->quirks2 & SDHCI_QUIRK2_RE_ENABLE_CARD_EN) {
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk |= SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		} else
+			host->ops->set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d7929d725730..3d4ab68f133f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -477,6 +477,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* controller only need to enable card en again after UHS timing was changed */
+#define SDHCI_QUIRK2_RE_ENABLE_CARD_EN			(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.0

