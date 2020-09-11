Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49268C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 05:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0973321D81
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 05:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCLVR08K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKFY0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 01:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFYY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Sep 2020 01:24:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B1C061573;
        Thu, 10 Sep 2020 22:24:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so2146970pjb.0;
        Thu, 10 Sep 2020 22:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLYlz5zLcstFedwvUClCeYbR/tSrAZj+4PU7wzkVOas=;
        b=fCLVR08KDBVeiJJu3p2i6wWsugA8HUdtUDks1LreChxEVx9bdI3uJILexCMPEUYXww
         pjlyzp3KmFmz3Xnpoo/3d++yKfsFtsBCajGceY3oAJIP1XV/Uh0xOT45JcLhj6+62gF3
         P/0UvESSsVtXq7wmMCY4QsaT6wVA9+wKqeD2Na8qlekBcmoLwDZqW/gKbseGoXflIFpR
         0TbKO1pCdYSZv78HEvB1Xx6YEoWGWJ2e+cy9+Djkuw7pheFSTpBgb3Hikb3CYK8xMb7V
         gIF15KzuPYpeYvWUvkMWpRPmhsB8bqiU6/NNR8AHSHfwJCagKSKn6MT3zuz5DDXaa2oF
         iyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLYlz5zLcstFedwvUClCeYbR/tSrAZj+4PU7wzkVOas=;
        b=l86g/WRpP9CltIuy9b3fxFk9y3xZ+wr43dUMJVZkrBodEJAjvS36DNKRtck0IxoHyP
         zxBM8ZF47kc12Gq5ajnIgKDSm5mAO6oyjuiEhxAk7GXoREh0W95bVJBnlJGp9Di+sUVC
         l++80++CNrHXNwOsBfEIWA4f0+1A5ANqPuojwKtIBXnLxeRMMFBbCDrDsTdJCFkabvDE
         waxH0PGgiOg96KxCi2VKx7tt+zZcfXfaBkOXdPgsRf0d2WlU6SSorblT/DtIxqr2Mjpd
         zP7DWmKVaQgo+l6mWscLWcbVEAmXpxEF8KDZvQ1bfHC72lmn7VIWQqdpPUw21gdMHk3k
         LsXA==
X-Gm-Message-State: AOAM5332VIYTAfEz2BrygqV/GS6UK2zrdmlXdqTEUQZe4XvQNspdjoqn
        xVoywAWOM6FBPpyjjf5ED2Q=
X-Google-Smtp-Source: ABdhPJyceqivRMTy4mDYSvkVL8mFz/VM9onT7wXxfOJXuYJzbh0iUprANZyNqhDqO8yi8ts8gFWXBg==
X-Received: by 2002:a17:90a:ebd7:: with SMTP id cf23mr674812pjb.126.1599801863606;
        Thu, 10 Sep 2020 22:24:23 -0700 (PDT)
Received: from amit-ThinkPad-X230.domain.name ([106.215.94.244])
        by smtp.gmail.com with ESMTPSA id ga3sm698886pjb.18.2020.09.10.22.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 22:24:22 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 08/10] dt-bindings: mmc: owl: add compatible string actions,s700-mmc
Date:   Fri, 11 Sep 2020 10:54:09 +0530
Message-Id: <1599801849-6071-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-9-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-9-git-send-email-amittomer25@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The commit adds a new SoC specific compatible string "actions,s700-mmc"
in combination with more generic string "actions,owl-mmc".

Placement order of these strings should abide by the principle of
"from most specific to most general".

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * Added Rob's Reviewed-by tag
---
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
index 1380501fb8f0..5eab25ccf7ae 100644
--- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
@@ -14,7 +14,11 @@ maintainers:
 
 properties:
   compatible:
-    const: actions,owl-mmc
+    oneOf:
+      - const: actions,owl-mmc
+      - items:
+          - const: actions,s700-mmc
+          - const: actions,owl-mmc
 
   reg:
     maxItems: 1
-- 
2.7.4

