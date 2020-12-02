Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC64E7C
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 13:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CC4221FC
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 13:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLBNRW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLBNRW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 08:17:22 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F84C0613D4
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 05:16:41 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id d17so4171331ejy.9
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YFuryNq+yiJ8h6eDBZHjVfvzohLImj8dR6NtOH9iUac=;
        b=NZSWOxK5OUukxA2dIEAUSf1X7dtSajYgAfv2g5wvGXQVYekjzrn3BS0M/z5IxCrabL
         evreeX3+1IkKQQ1w+3WNl63UwSOkzwN3NqCMemtB7M6rmQ0RRmksel4vdye0E/cD7BLI
         gkOoilJ1MhlEtuzQx9EGBTpfAYENT5gDpPX2V3nWjNJXvjvaAUQYTii+nPoKmx4gnWns
         IDxnp4FrgHEdVs8V8IjX/SXJBx0NnetHaxoOF0q/5ndv1ezdklqFCPH50dgGSLs4nsvM
         DulI4KxMAipBZv9VBxZcPVjDRQW90Va35hImCBYJ1Fxx+3U3eqElF+Qtd4DBAcedQ/nu
         +bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YFuryNq+yiJ8h6eDBZHjVfvzohLImj8dR6NtOH9iUac=;
        b=npF3ZSgd9HevPVcGIf1sNQ/bR1pbK8Ijca5MCFtgQ8iO70tFuwraGSZzkXEZlYYmCx
         gmFIKnAErpxmN6mI8DYgfCxWGVLh4P465YnbDfckyQj1h1lCACh98ULGb4vrhYDqFViB
         9k0RdgOjCmS+auvQ6PmX7p+BHRyTUeSpPxjpY5FCHNyEIe1bO2bcvIvyHE/+H0KzH675
         zqc69+k1nBljcyyz2JV/Ech5K7xJ6ffRLC5HBSoQNOfX/fRLD5ss2+tHvAvcQt2FYZiu
         4+lxtTmYkj/wAT70Z74wNCruul7u/PcNUAfdxCHsWsLAAvxszbpTSUIoGaguw2aFFWUc
         agKA==
X-Gm-Message-State: AOAM532HjjFyzpVhE05OhNDM9j6mSHmblHMFgOePGidNb81Cp1E554uM
        sFAfltq5S8cwgNJDkbGrnM8qog==
X-Google-Smtp-Source: ABdhPJwE+atf1tpH4BTLQ+cRxpcWVgmERHoNhVDJ5MZkiLBvIJY1ZNQYZH2JNR5h/8hKr40P2/biQA==
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr2239188ejb.513.1606915000192;
        Wed, 02 Dec 2020 05:16:40 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a20sm1376061edj.81.2020.12.02.05.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 05:16:39 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Fix xlnx,mio-bank property values for arasan driver
Date:   Wed,  2 Dec 2020 14:16:31 +0100
Message-Id: <5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Xilinx ZynqMP has 3 mio banks and all of them are valid. That's why also
list the first one which is missing. Property is enumeration not range.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 58fe9d02a781..8958e54e522d 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -147,7 +147,7 @@ properties:
 
   xlnx,mio-bank:
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 2]
+    enum: [0, 1, 2]
     default: 0
     description:
       The MIO bank number in which the command and data lines are configured.
-- 
2.29.2

