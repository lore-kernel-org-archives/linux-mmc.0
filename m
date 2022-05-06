Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D27C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  6 May 2022 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390154AbiEFIcl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 May 2022 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390148AbiEFIck (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2022 04:32:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06E6830C
        for <linux-mmc@vger.kernel.org>; Fri,  6 May 2022 01:28:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v4so8405974ljd.10
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2022 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRU9ZfTLvaeu1l6OycIwWmRfxaT4qvyVX3AvZD3bbCs=;
        b=VdaEvsguqGMZLvSGNkpVJW6dNmLfttQ/6ZGsAFw8xNs7XtBWWfMuTO/Zmgc8eeLmSN
         ARfeaogAhxTh8IJ9IVkW+D1oTlDNwMqvsPqf+WgNX+qRG2Ikp27YlCXuWQHcRzNwJ7DA
         H3ferraot5GLXi5QqMhac+/CbVcuFzxZTg2nppjlgxi3XdA5avmx7SRQLN4J7htRCErx
         S7hpQAOxUWovM/NONCwIYFDbP5xFiez9Al8ZEGK1EV1FJT37UZlJMDHda/TRAwSqgxz7
         +9IMpCnshdxsJ1FVWYoRSCDBeRLQl87vUCVFxP1WKlcIhiSt+Mb6wWJLqshGY+VYSxGe
         mvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRU9ZfTLvaeu1l6OycIwWmRfxaT4qvyVX3AvZD3bbCs=;
        b=yHqTjY7Behu2dFXIZA0igP6irqN42Wkxus6UAxG1KzRiNb56Bep6YG8SsQbvdQxur4
         3UrpL3r5G0EPB9Du0u0qXXeVRJu11TWU7r58G6LDAQW3m9H5aStfx5J+fMNm3sT3ww4D
         LsLPHepnpGD60FneieY822EfFCoHbdt5s314ifttF5EGrk4D9h2Gf65WLs6UOM9XQvTW
         KNsY67Z5a4OE7fHFTpla+fQQckVlM3tCNpS+0h17+C4QffYiaaEPp4zaRigpXxrsx6ll
         YKwOtse/fCxmGYvcbR8WF47e5DGgcLOR8Ol8hRN9+VjBpzP/sWulIBN4uV+Z1+6HASfA
         X/dw==
X-Gm-Message-State: AOAM531KrCzlXUGINe3tJ21BB4AjBRULhyTw2YokDljL+5MeMjfAaM3K
        4agYo8g+yhfr9m9YZeMftEapoNbUcMeXCA==
X-Google-Smtp-Source: ABdhPJzYkuy99EVVMWFPD+rrzB0ofFxY/iQxilEXhBnGxrDK7PQNLfBf+kIYombG14A4Vb36cTsOFw==
X-Received: by 2002:a2e:b537:0:b0:24f:9dc:28a6 with SMTP id z23-20020a2eb537000000b0024f09dc28a6mr1308817ljm.509.1651825736434;
        Fri, 06 May 2022 01:28:56 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z10-20020a056512308a00b0047255d2115bsm585109lfd.138.2022.05.06.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:28:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: sdhci-brcmstb: Fix compiler warning
Date:   Fri,  6 May 2022 10:28:05 +0200
Message-Id: <20220506082805.273909-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the compiler warning triggered by -Wmissing-prototypes for
brcmstb_reset() by making it static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 683d0c685748..8eb57de48e0c 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -48,7 +48,7 @@ static inline void enable_clock_gating(struct sdhci_host *host)
 	sdhci_writel(host, reg, SDHCI_VENDOR);
 }
 
-void brcmstb_reset(struct sdhci_host *host, u8 mask)
+static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
-- 
2.25.1

