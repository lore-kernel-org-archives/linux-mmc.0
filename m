Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE47C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86AB61153
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbhI1IZa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:25:30 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52194
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239292AbhI1IZa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2021 04:25:30 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1CEA04019A
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2021 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632817430;
        bh=hCpkTZoM4n3uBZpcQB8z06X1QRNDpVNEm2rAShQKtzU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qyiiJxtf66z1YC8O+On/5QDQ4Gk2qP4USH5COhl2yTdWREofPufPZ5Gt53hHWwMQz
         twCQV2ucZDzDd5/aHyD0TEUJogTpWYwi/Zr1FYzPJG3PUwNHGOItPwrQuh+zY5dwnT
         y3+GUh5LGd/4nBzlFGO8cltvp+4He3nYJsMCJoZqdY5Or+hap/OP5ff4TDCK24RLTD
         D0M5SCOFLW61eR62BZMwyyVyhAEUnXh18sOrWwVNFjFOprgBiJOzZqMhEK6BaWZI9Y
         S3TqewUOzuAEdXoR2kxkFZgSlm2brHckZizFQ6D9w2ZfqkcmDAODRCSSjoSLtTgZz8
         fO6paGLBTaVDw==
Received: by mail-lf1-f72.google.com with SMTP id c6-20020a05651200c600b003fc6d39efa4so18591279lfp.12
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2021 01:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hCpkTZoM4n3uBZpcQB8z06X1QRNDpVNEm2rAShQKtzU=;
        b=2+mPqNuRnK1zIUYFfLse093RJiGUNSen9HcI/LhpWoilF/BENAEv6WBtKyve8F6hPf
         +UKR76YgkgoDfAaJya+mGFxDOGkP5ICMncm5Ut7Okh3/UcQ8YDBtzcXYcr5oH99UfD+V
         54keGzjVE2RcZkp+OwcDWAgSU4Ja6N9qoVJLGsgig1JKSBS6o4FCBOiG4Cn+Yr+lK9GX
         tVAhONOHY0ks6y/e1vkNoOMjdR9UN67DuBgWDgiEItosaxzUVCqFdXD+9+RzSaskKcNF
         TRSilbw2Q7YcC8doDyk2NWD5T329OWzP79IgbHaxncUphRpDcQvy72zJ7haJxG4hEg1p
         gSuA==
X-Gm-Message-State: AOAM532ysFKooqb+DNP1M5rOeH4sHlBdCeplhA5ZLbjazfsEOQYSW7th
        0oaR7zRbOhcdOspWm3eHZsjglq3fVq+ewC+bZ09T+0y8kSSyJd+P+dCBH1h/fXpUSOHT9yVPiT7
        fR2xKXDZjmkOqJZTQaxnKr2FFFVy89HKOf+5nbA==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr4623533lfd.496.1632817429550;
        Tue, 28 Sep 2021 01:23:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0kiQhvPEnXkPPjDKvzDmgWIBkyJznAjn8DmsrfGeFcE9vto/pgYlvsJ9re4+/35+AKYMcPQ==
X-Received: by 2002:a05:6512:3341:: with SMTP id y1mr4623518lfd.496.1632817429338;
        Tue, 28 Sep 2021 01:23:49 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y5sm1491271ljc.56.2021.09.28.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:23:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells dependency
Date:   Tue, 28 Sep 2021 10:23:46 +0200
Message-Id: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The meta-schema already defines dependency between clock-cells and
clock-output-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 23abb7e8b9d8..dd70431df0b7 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -158,10 +158,6 @@ properties:
     description:
       The MIO bank number in which the command and data lines are configured.
 
-dependencies:
-  clock-output-names: [ '#clock-cells' ]
-  '#clock-cells': [ clock-output-names ]
-
 required:
   - compatible
   - reg
-- 
2.30.2

