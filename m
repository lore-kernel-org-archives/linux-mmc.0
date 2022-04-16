Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71245C433F5
	for <linux-mmc@archiver.kernel.org>; Sat, 16 Apr 2022 22:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiDPWu3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 Apr 2022 18:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDPWu3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2022 18:50:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86F3CFCB
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 15:47:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bn33so13071805ljb.6
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2022 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdMN3k0Sjf7cBpT9HSc70WSDqmmm9h4hh0kYHkQwaQc=;
        b=P2fw/flztEvlMJydzoAnU1R8oowS35EJUEOjItpuFquRKHOuxLdVzNgcwYsbryg/xy
         n50ZCNN+9JAB86MuQShX24+xi5q51olGRL8x82dGImjZxxvQtNfCYoeBXqO+NHYPqnOX
         N2WE9rFajc5ALo+4WUmLA6adtMEGX++toyTM9uZgJ98UnznarMex256UZyaCbcGyyT2P
         1E1+RrWXGxEI9S4HtyRZO1REydaaiAit9oUFIxYVzxDi5Md83ZAjIeii1H6v4fTDa9j6
         HsaAFzMP2RbtFxm4KJJyDwKg7CRwnctYENdsXbmkbmZgPMHMmhVytfOWct/W5fU2V2Dh
         mbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdMN3k0Sjf7cBpT9HSc70WSDqmmm9h4hh0kYHkQwaQc=;
        b=OHuXxr2E6hwnfahP2rOb7w7UBYOIq9yKiA/pIAdG7A+1AgYwlb3Ns6tUjAmmF5n4f3
         RHIdqt4pmlEtq4V8S7GxHvlJ+TLWUiRDjGEwutEhOinj7KcDQoudbURCN9/Eammg93BU
         NOdVEn29KeFIQo/j1lEvly/V+vzlko5vqgE73gUIQrZLeoocbyu1/2VyLwOBPuzHotjs
         Y/pf5JRdjwR6TARSSPVKN3pTI0cH0dnOOfouDmPe5S95q3/jQ7VZBUqruNF4vEojKKPj
         xva6Usd9/EDxLzMAbF0U4VQQRQ1xmbt+1Omfvty0S54VRpaO0axTebT5e0tmSsXWReHK
         oRag==
X-Gm-Message-State: AOAM532e26WSfMN/4+hGPMI/jZTUcyPcCm6z0IPcte38/NkljsyJ1MyK
        JmwjYH9rw6zsUyoxr76vaTg7UVrREnwnhw==
X-Google-Smtp-Source: ABdhPJxk8n3TREbst8mNkEvgl03nwTeVsrpCNrNUUPzZgVNi6EjHWioWeK/C5L62H8xw3/B2SnDa4g==
X-Received: by 2002:a2e:9c9:0:b0:24d:ab7d:808f with SMTP id 192-20020a2e09c9000000b0024dab7d808fmr3031088ljj.330.1650149273063;
        Sat, 16 Apr 2022 15:47:53 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d5-20020a056512320500b0046ed7bf92b7sm707015lfe.177.2022.04.16.15.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:47:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: mmci: Break IRQ status loop when all zero
Date:   Sun, 17 Apr 2022 00:45:49 +0200
Message-Id: <20220416224549.627623-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We iterate an extra time through the IRQ status handling
loop despite nothing had fired. Enabling the debug prints:

mmci-pl18x 80005000.mmc: op 01 arg 00000000 flags 000000e1
mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000001
mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000000
mmci-pl18x 80005000.mmc: op 01 arg 40ff8080 flags 000000e1
mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000001
mmci-pl18x 80005000.mmc: irq0 (data+cmd) 00000000

It is pointless to loop through the function when status
is zero. Just break the loop if the status is zero.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 45b8608c935c..f3cf3152a397 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1619,6 +1619,8 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 
 	do {
 		status = readl(host->base + MMCISTATUS);
+		if (!status)
+			break;
 
 		if (host->singleirq) {
 			if (status & host->mask1_reg)
-- 
2.35.1

