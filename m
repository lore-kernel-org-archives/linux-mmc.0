Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE5C4708F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Jun 2021 19:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A85F61009
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Jun 2021 19:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhFBTbA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:31:00 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:39933 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTbA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jun 2021 15:31:00 -0400
Received: by mail-pg1-f178.google.com with SMTP id v14so3097600pgi.6;
        Wed, 02 Jun 2021 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E8vUWtDMqWild8A9bhDL+wLNKgyTVijec3O63TtaCeQ=;
        b=lcRYqtVJnUHY3XGJzUhTrAMt6+htMorMfKLDgtbv7gFDaE7UOR0A6F8Sz+rkj/9cXz
         ZI8Qy6ex+BX4njn7BcGKpkZ6x0R/Huf9zI3SHHVp6EXb/fbcswxLdAIi+qXe5CMad45E
         IopNMdAERvpF750LZjepnuERSqxZf//Ax+yzy0idgWsxfN6HHezYIHbQXWw38N3SBiB9
         adpyA0hdbU1B1zlvEsx662kQhnYkNteAL6HnNZozpxeeMVzXe4EQ+btrJe0Zr7G5+BYb
         FnN1YFaJhhn7m9Y8tgfDdFfiqGpNX3Pvu041VcJHCOI1AU6BRBkpN5TC9PT9g+1O5RP9
         Ferg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E8vUWtDMqWild8A9bhDL+wLNKgyTVijec3O63TtaCeQ=;
        b=jrPFeLaUeP8EMMwN1yE/amRKptMLcz0IpAULrtoFCMtdqNb/aSseXXAgFDhqbUZmJP
         qetCmQVKZzLKdovUdTeamT8vrbASZXLolvjwP7yInoOLYp71D8FD5fWdUHUeSfdWilbn
         1Ntd5dz8WtRfZ32DbU/fgF0SC5X1c34vBgMfeG85t1SytNiI6W+D8wG2gnjz5TO9Gg3w
         fduGZrLeue1BKNem9a4Out/d7LnHHCdcsX2UIlPlDow+mxzbdTE9YmD7gJ03AFzcljuW
         TcJJLLi3a0ZaygkmsFw6pkub72Alj4sHPeTMOxgbUQ/a7hOMq0vRRF0CgV8a1N1Sfzp4
         jRPA==
X-Gm-Message-State: AOAM533k0gKNXE+6JHFo7pb9R5hCS9BvZvkzvNPAF7kOukG0R7H/98kO
        rbA5WdIGrdZtpAjvzswrrcT5hphM6pVHczU3
X-Google-Smtp-Source: ABdhPJxO+sxxmX4+zcVnKW/MU9yYAqFYdqQpz1Hm8ni98EnuVHOsLm3TI2xojKihsfJklMHX3tYQJQ==
X-Received: by 2002:a65:60da:: with SMTP id r26mr35519014pgv.133.1622662096547;
        Wed, 02 Jun 2021 12:28:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m134sm349882pfd.148.2021.06.02.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:28:15 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-iproc: Add brcm,bcm7211a0-sdhci
Date:   Wed,  2 Jun 2021 15:27:57 -0400
Message-Id: <20210602192758.38735-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible string for the legacy sdhci controller on the
BCM7211 family of SoC's.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
index 6f569fbfa134..2f63f2cdeb71 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -21,6 +21,7 @@ properties:
       - brcm,bcm2711-emmc2
       - brcm,sdhci-iproc-cygnus
       - brcm,sdhci-iproc
+      - brcm,bcm7211a0-sdhci
 
   reg:
     minItems: 1

base-commit: 97e5bf604b7a0d6e1b3e00fe31d5fd4b9bffeaae
-- 
2.17.1

