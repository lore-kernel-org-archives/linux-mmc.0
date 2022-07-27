Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A0FC19F2B
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Jul 2022 17:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiG0RNt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Jul 2022 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiG0RNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2022 13:13:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018B7646A
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2022 09:42:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q23so14705341lfr.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2022 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSPaxO046Ze33lKCriyBi8yHHhzQgKxgn//51vCRfws=;
        b=AbbhqBv9E178tMhwtsG5r7YM5oszCwrW9k1hW7z+DlAQTz6Lt/6jGLCEB0pJXBYqTb
         qGGCKjH1dHXi+rkpdvlJp4Gf41vcYJ/fDKD9Pb+DupvIZkF6xiEqz2EjjqyjJw5CxCea
         vcZYtGeykc+4WHvvwczUw+ZTAOJgAGMZxX75x8adytC0aQbpvCJuroAPPWboUeSG2JgP
         Sb/VvWX624MEMNeEhO7Kz1ZmX1fiEyXIg80rbAHqyvEy4stbPqAD3DjfypWtQb1h92b4
         nTxen8Y1UzzFj3pHKbdcwyIQiAjeXXsHqxdz4twV6JzQZoQ+J7ag9BannbCD1kKhcJnT
         idnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eSPaxO046Ze33lKCriyBi8yHHhzQgKxgn//51vCRfws=;
        b=ykRsY5Fb2VoJTQpIlI075pmi+AejBB6HgjfQyK2Dbt9yyJCvRUVg8gx85S1OAGUAem
         +da3+AV5YLzMfOtykH9fTsC73t4WDo+MOEqT32Kt5xCKWocxJrIeBBlE6H3Cr3Y1O4y7
         cPzzw78286zSadZHINnK4eM1yo1uj7COMcfUNgwWljPYcmidlwoDOS5JDWdd9nFpe2+j
         H3xjnGaSAc2hZ20GH2VqM44xLlbWgfVIyHli9Ozuk9vM/dkSURw26lGThJlFz0RwqJA3
         fBiMU+zyMx6ubRwrbfaGIMVasCo71zY+91ev4LAFgMJFcM6yU+rrg/iQypXdozyfgK01
         fMiw==
X-Gm-Message-State: AJIora+7dQvkscq9HuDG0NJJIa8OcVebppCQYJ2Q820b8151iQBp9xny
        2PPP8uWt59dP+GCXw9cSMm1X6g==
X-Google-Smtp-Source: AGRyM1uhBH6wuAdgpcLkgYgpaPQs3mxVcKJnj5iurbEFj6ZPkbZ2ibDfKFQvRyZPsqlhyOim+ut2cA==
X-Received: by 2002:ac2:4f06:0:b0:489:4a1b:ad7f with SMTP id k6-20020ac24f06000000b004894a1bad7fmr9274231lfr.311.1658940125963;
        Wed, 27 Jul 2022 09:42:05 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512238100b0048a706d9fe5sm3509260lfv.294.2022.07.27.09.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:42:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mmc: mmc-spi-slot: drop unneeded spi-max-frequency
Date:   Wed, 27 Jul 2022 18:42:02 +0200
Message-Id: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

spi-max-frequency comes from spi-peripheral-props.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
index c45b91099325..c0662ce9946d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
@@ -23,8 +23,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   interrupts:
     maxItems: 1
 
-- 
2.34.1

