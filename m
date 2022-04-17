Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB2AC433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Apr 2022 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiDQOrE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Apr 2022 10:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiDQOrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Apr 2022 10:47:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4BDF5E
        for <linux-mmc@vger.kernel.org>; Sun, 17 Apr 2022 07:44:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so20866853lfa.10
        for <linux-mmc@vger.kernel.org>; Sun, 17 Apr 2022 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnWct7vKYCF5Uv27r8WcT39f+hEMz2AIjexA1wHqeFc=;
        b=LHOJ6g/M4VpeXoLOayEmmb0o6z38hkflkA+ktwrpdh8zeBDjoT6EkxwwB+I84QuU2J
         FPIkXEegL4IGZim/0RkFUIf3JHlMkh+Qh8+6TxyvF0mz74O28eTP8AnNR0Q9CmHNvNwp
         5bPIQJZQrImHIjiV/qfsuIulBBkLDtwT+ai9rKWIPy7qX2xASAc1ztop69LHsJE7MKBF
         PXTlIGeCaztVwyA7/RozsFA2YQruyahmlsxbBWp6yDuRu5Ox4HWTGjjetvQIJnfcQLED
         qvZ1qVqaHud6cEC6oLX4VBk0m8lssakItPIXe0N3U65pR2J6id2OLglFf2s/GeRu9uYx
         18TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnWct7vKYCF5Uv27r8WcT39f+hEMz2AIjexA1wHqeFc=;
        b=KeStTeQOrMRjNJW+xg95q7motYLK1hOFMwccdBYr4GbDYQlsg9abYdtSd4JnJHHmod
         Usspio+Xas9Tg3PMef3GR/XO2KdlTZdys/8K7d0aoTai3AaN3eCToG57OZXNm3GPTkva
         oEqd8wsEaITWbvQ1t7kyIqTYFpPyNOHD4T0OSv9c3+OgcHY8Myr3TpNbVwko+Xr36VTt
         0fpiuMuaow5ZwPGmi5mTxkswtXgEReova98gJmE+gEzKdJR7KRqdTYEPNwljJLN7Ba0N
         siPsskrOZx+hNp/eO3cGBMKgDXFO1pPf5IYoDf0c+DkfNcaheEAdZvPWyURCOAkLkjvm
         E/gA==
X-Gm-Message-State: AOAM531LOaR2HedbkjbF9mJZg9b5ZgpWZMy61K8p9Wt2Vsfywdn+P+8V
        dlttyjyh4rd9dRLDV5UM+wxjBb1Nphy7aQ==
X-Google-Smtp-Source: ABdhPJwrV4qFcvi/BOh02dpNGBtnc1ORhfIQcNDibvJ5ZlDBtmOMbKmxmTcHyrYgUckPVSLtFL54oA==
X-Received: by 2002:a05:6512:cf:b0:46c:cb02:336d with SMTP id c15-20020a05651200cf00b0046ccb02336dmr5329688lfp.548.1650206666066;
        Sun, 17 Apr 2022 07:44:26 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b17-20020a196451000000b0046d86056d22sm961012lfj.179.2022.04.17.07.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 07:44:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Add small binding node on level shifters
Date:   Sun, 17 Apr 2022 16:42:23 +0200
Message-Id: <20220417144223.649201-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The VQMMC is often provided by a level shifter, so drop a small note
in the bindings that this can be the case and how that is done.
It is helpful information since this is pretty common.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 513f3c8758aa..ff5ce89e5111 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -298,7 +298,10 @@ properties:
 
   vqmmc-supply:
     description:
-      Supply for the bus IO line power
+      Supply for the bus IO line power, such as a level shifter.
+      If the level shifter is controlled by a GPIO line, this shall
+      be modeled as a "regulator-fixed" with a GPIO line for
+      switching the level shifter on/off.
 
   mmc-pwrseq:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.35.1

