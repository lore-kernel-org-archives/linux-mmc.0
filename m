Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB7C18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D83F20578
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 15:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGdazkWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCJPdz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:33:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36802 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJPdy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 11:33:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so2351630ljj.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2020 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ91NJmSAV4APRs3KHb2zhKlTLEt52ygW4o1xrxv0Yc=;
        b=cGdazkWPAfKhtnRnEI2GJzFwuVajaBOS4BQ8hqRTuAgc81uzqNxFrUtq6heoNaKsSU
         OZWF59ABGCQQRm43Ezooj5qClm98b4lC2ETvbslgeg1zcRIOc1kNWoBa9yfyTCd2hDTH
         g7XZ7EGusHb2yPm3G2Etafv9bDdPlhF9oBgHUNy3s4ZUJINM88zPILHB7p8b/0UVKxmc
         IFspfNsRKQ8Agq6u/MYR+v+NA5Mak11gbH6sJsz2yh6pgaq8E7bcQ3eCzFnIaBXBvZjy
         hlzn9nd296Q6BaA2E20i1LCYf4xImX9mORB10ES0NGu3Fa5+zE4k/uCtDB7PsEWR4gPc
         SdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ91NJmSAV4APRs3KHb2zhKlTLEt52ygW4o1xrxv0Yc=;
        b=WWTurJWggEimXaCNv57Fg3U68n9F+3Nbd8Ah879usqoAfhUyEbj0MkNYsL8YcqWroF
         RfEowW8Pk3RFL0b5istRYJuBHTvmdZ88M4OuaDdrM3vlRO6FBQgmslKP0F01plDVSe3B
         e42tLEBoXuyAaZjJrGhEiuYRUmt2RkolL+Ud9oDWqzKFiGhiiDYF5AiKgTNybyMgadRS
         FsAVg0iZElN4VKgU3vPWDmttRHHIw8wLdfWVo/Sr93UtDGx8nofsOCDHGC0fxWJLwhly
         p9VvpB62ODDaOIYU90lMUpesylfpxDo9itGkGU76//NJeld2CTuf+uOj+QqemuFrSAn3
         9k3Q==
X-Gm-Message-State: ANhLgQ1Mh/b62rLa6JLWkNaLZZ4tMrBEWuKjgRbC0uqlZJI7PkRo9yqA
        WW3fxYXDxqHljyTpo5GwE74Jak0vVBA=
X-Google-Smtp-Source: ADFU+vsIvho5Opw/cggl/Q7zZCuGRhCYRY6r8tou4/ZEGVeYx3TZIfDapQeyl9aT5hVka/YBRvw9Jw==
X-Received: by 2002:a2e:a419:: with SMTP id p25mr3027492ljn.206.1583854432037;
        Tue, 10 Mar 2020 08:33:52 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id c22sm17283776lfi.41.2020.03.10.08.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:33:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl,
        Bitan Biswas <bbiswas@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH 3/4] mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 10 Mar 2020 16:33:39 +0100
Message-Id: <20200310153340.5593-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310153340.5593-1-ulf.hansson@linaro.org>
References: <20200310153340.5593-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that the sdhci-omap controller requires the R1B response,
for commands that has this response associated with them. So, converting
from an R1B to an R1 response for a CMD6 for example, leads to problems
with the HW busy detection support.

Fix this by informing the mmc core about the requirement, via setting the
host cap, MMC_CAP_NEED_RSP_BUSY.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 882053151a47..c4978177ef88 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1192,6 +1192,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	if (of_find_property(dev->of_node, "dmas", NULL))
 		sdhci_switch_external_dma(host, true);
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.20.1

