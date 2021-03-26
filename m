Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B0DC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Mar 2021 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5DA61A38
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Mar 2021 11:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCZLCk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:02:40 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34567 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCZLCZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Mar 2021 07:02:25 -0400
Received: by mail-pf1-f178.google.com with SMTP id y5so4659844pfn.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Mar 2021 04:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rumfRvhUhVyWj59sOnuaUTFipCqEyTwMs3xoCRgrClA=;
        b=KkkwIf6lF3sieHvNfsdYsHy4KympMHLZMTuHb+S9x5cl1wm4muiWhJ4+SVOKphKuDN
         m98VVTRTTX15d2Ma2ZFL4mCQZjeET8jk7JdYMDtbJq0fDIjZoR9HAxBi9JEadKVqg2/8
         tJyu9q+9k7uzrf9E/u18l5jfteg8DseszZxsom3bEuTDHf9Z2BIWnAV+cxIltYjAkbFM
         5SnZvLQLryJZ/kbKOHHR7m/G/A1h7KD2Fq+byMpW4s+7X2LboD9dLsEzFazBqm6ZOS6c
         CYD/RkmKji4o0urgmNT4nj+KsHA+Rvxj9hvmh/F4lT2APSIpcKYwZ+CBsmnf8vu5OWbA
         vwyw==
X-Gm-Message-State: AOAM533dtTmMAM391DX+P9B+d+cVp4HLH5bEfzHYOJNdmF/TJHcjiNKw
        PULOjjWadDwVALQ2azNlGzstTQ==
X-Google-Smtp-Source: ABdhPJz4hhWiURI73CG1edc9x87HhwvY+cn1dgGBvb7rky7Y5ER1ntb0nbUUWamBm5AB5rrCD56izg==
X-Received: by 2002:a63:7a07:: with SMTP id v7mr11429029pgc.26.1616756544679;
        Fri, 26 Mar 2021 04:02:24 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id i13sm8092521pgi.3.2021.03.26.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 04:02:24 -0700 (PDT)
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc-imx: separate 100/200 MHz pinctrl states check
Date:   Fri, 26 Mar 2021 19:02:14 +0800
Message-Id: <20210326110214.28416-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>

As indicated by function esdhc_change_pinstate(), SDR50 and DDR50
require pins_100mhz, while SDR104 and HS400 require pins_200mhz.  Some
system design may support SDR50 and DDR50 with 100mhz pin state only
(without 200mhz one).  Currently the combined 100/200 MHz pinctrl state
check prevents such system from running SDR50 and DDR50.  Separate the
check to support such system design.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a20459744d21..aa45901325b9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -434,10 +434,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			 * Do not advertise faster UHS modes if there are no
 			 * pinctrl states for 100MHz/200MHz.
 			 */
-			if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
-			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
-				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
-					 | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
+			if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
+				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+			if (IS_ERR_OR_NULL(imx_data->pins_200mhz))
+				val &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
 		}
 	}
 
-- 
2.17.1

